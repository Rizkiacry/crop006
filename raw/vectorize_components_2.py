import cv2
import numpy as np
import os
import glob
import re
import subprocess

def regularize_polygon(points):
    # points: list of (x, y)
    n = len(points)
    if n < 3: return points

    # 1. Calculate angles and snap
    # We store (angle, [points])
    segments = []
    
    for i in range(n):
        p1 = points[i]
        p2 = points[(i + 1) % n]
        
        dx = p2[0] - p1[0]
        dy = p2[1] - p1[1]
        
        angle_deg = np.degrees(np.arctan2(dy, dx))
        # Snap to nearest 45
        snapped_angle = round(angle_deg / 45.0) * 45.0
        
        # Normalize to -180, 180
        if snapped_angle > 180: snapped_angle -= 360
        if snapped_angle <= -180: snapped_angle += 360
        
        segments.append({'angle': snapped_angle, 'points': [p1, p2]})

    # 2. Merge collinear segments
    merged_lines = []
    if not segments: return points
    
    current_angle = segments[0]['angle']
    current_points = segments[0]['points']
    
    # We need to handle wrapping (if last matches first). 
    # Easiest: Merge linearly, then check first/last.
    
    # Rotate list so we don't start in the middle of a segment?
    # Check if last matches first
    if segments[-1]['angle'] == segments[0]['angle']:
        # Rotate logic is tricky. Let's just do standard merge then check ends.
        pass

    final_groups = []
    
    current_group = {'angle': segments[0]['angle'], 'points': list(segments[0]['points'])}
    
    for i in range(1, n):
        s = segments[i]
        if s['angle'] == current_group['angle']:
            # Extend
            current_group['points'].extend(s['points'])
        else:
            final_groups.append(current_group)
            current_group = {'angle': s['angle'], 'points': list(s['points'])}
            
    final_groups.append(current_group)
    
    # Check wrap-around
    if len(final_groups) > 1 and final_groups[0]['angle'] == final_groups[-1]['angle']:
        final_groups[0]['points'].extend(final_groups[-1]['points'])
        final_groups.pop()
        
    if len(final_groups) < 3:
        # Collapsed to 1 or 2 lines? Cannot form polygon. Return original.
        return points

    # 3. Fit lines and find intersections
    fitted_lines = []
    for g in final_groups:
        theta = np.radians(g['angle'])
        vx = np.cos(theta)
        vy = np.sin(theta)
        
        # Normal
        nx = -vy
        ny = vx
        
        # Centroid of points
        pts = np.array(g['points'])
        cx = np.mean(pts[:, 0])
        cy = np.mean(pts[:, 1])
        
        # c = nx*x + ny*y
        c = nx * cx + ny * cy
        
        fitted_lines.append({'nx': nx, 'ny': ny, 'c': c})
        
    # 4. Intersect
    new_poly = []
    m = len(fitted_lines)
    for i in range(m):
        l1 = fitted_lines[i]
        l2 = fitted_lines[(i + 1) % m]
        
        det = l1['nx'] * l2['ny'] - l2['nx'] * l1['ny']
        
        if abs(det) < 1e-5:
            # Parallel lines after merging? Should not happen unless shape is degenerate
            # (e.g. U-shape where top-left and top-right are parallel but separated)
            # If separated, they shouldn't have been merged.
            # But here we are intersecting line i and i+1.
            # If they are parallel, they don't meet.
            # Fallback to original.
            return points
            
        x = (l2['ny'] * l1['c'] - l1['ny'] * l2['c']) / det
        y = (l1['nx'] * l2['c'] - l2['nx'] * l1['c']) / det
        
        new_poly.append((x, y))
        
    return np.array(new_poly)

def is_geometric_polygon(points):
    # Check if the polygon segments are mostly aligned to a specific rotation of the 45-degree grid
    n = len(points)
    if n < 3: return False
    
    deviations = []
    for i in range(n):
        p1 = points[i]
        p2 = points[(i + 1) % n]
        
        dx = p2[0] - p1[0]
        dy = p2[1] - p1[1]
        
        angle_deg = np.degrees(np.arctan2(dy, dx))
        
        # Deviation from nearest 45
        # We Map to [0, 45) space to check clustering
        # angle 0 -> 0. angle 10 -> 10. angle 44 -> 44.
        # But angle 46 -> 1.
        # We want to see if they cluster in a 20-degree window.
        mod_angle = angle_deg % 45.0
        deviations.append(mod_angle)
            
    deviations.sort()
    
    # Sliding window on circle [0, 45) with size 20.
    # Append list to itself to handle wrap-around (e.g. cluster at 44 and 1)
    extended = deviations + [d + 45.0 for d in deviations]
    
    max_c = 0
    # Optimization: Two pointers
    right = 0
    for left in range(len(deviations)):
        while right < len(extended) and extended[right] - extended[left] <= 20.0 + 1e-5:
            right += 1
        max_c = max(max_c, right - left)
        
    return (max_c / n) > 0.8

def png_to_svg(image_path, output_svg_path):
    img = cv2.imread(image_path, cv2.IMREAD_UNCHANGED)
    if img is None: return False
    
    # 1. Extract Mask
    if img.shape[2] >= 4:
        mask = img[:, :, 3]
    else:
        mask = cv2.cvtColor(img[:, :, :3], cv2.COLOR_BGR2GRAY)
        
    # Check content
    _, thresh_raw = cv2.threshold(mask, 10, 255, cv2.THRESH_BINARY)
    if cv2.countNonZero(thresh_raw) < 5: return False

    # Get Color
    mean_color = cv2.mean(img[:, :, :3], mask=thresh_raw)
    color_hex = "#{:02x}{:02x}{:02x}".format(int(mean_color[2]), int(mean_color[1]), int(mean_color[0]))

    # 2. Upscale and Smooth
    scale_factor = 10.0
    h_orig, w_orig = mask.shape[:2]
    new_dims = (int(w_orig * scale_factor), int(h_orig * scale_factor))
    
    mask_upscaled = cv2.resize(mask, new_dims, interpolation=cv2.INTER_CUBIC)
    
    mask_blurred = cv2.GaussianBlur(mask_upscaled, (3, 3), 0)
    _, thresh_final = cv2.threshold(mask_blurred, 127, 255, cv2.THRESH_BINARY)
    
    # 3. Shape Analysis
    contours, _ = cv2.findContours(thresh_final, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    if not contours: return False
    
    cnt = max(contours, key=cv2.contourArea)
    area = cv2.contourArea(cnt)
    perimeter = cv2.arcLength(cnt, True)
    
    if perimeter == 0: return False
    
    circularity = 4 * np.pi * area / (perimeter * perimeter)
    
    # Approx Polygon
    epsilon = 0.015 * perimeter
    approx = cv2.approxPolyDP(cnt, epsilon, True)
    vertices = len(approx)
    
    svg_generated = False
    
    # Case A: Circle
    if circularity > 0.88:
        (x, y), radius = cv2.minEnclosingCircle(cnt)
        cx, cy, r = x / scale_factor, y / scale_factor, radius / scale_factor
        
        svg_content = f'''<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg width="{w_orig}pt" height="{h_orig}pt" viewBox="0 0 {w_orig} {h_orig}" version="1.1" xmlns="http://www.w3.org/2000/svg">
    <circle cx="{cx:.3f}" cy="{cy:.3f}" r="{r:.3f}" fill="{color_hex}" stroke="none" />
</svg>'''
        with open(output_svg_path, 'w') as f: f.write(svg_content)
        svg_generated = True

    # Case B: Geometric Polygon
    # Must be low vertex count AND mostly aligned to 45-degree grid
    elif vertices <= 15:
        points_input = [p[0] for p in approx]
        if is_geometric_polygon(points_input):
            reg_points = regularize_polygon(points_input)
            
            points_str = ""
            for p in reg_points:
                px = p[0] / scale_factor
                py = p[1] / scale_factor
                points_str += f"{px:.3f},{py:.3f} "
                
            svg_content = f'''<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg width="{w_orig}pt" height="{h_orig}pt" viewBox="0 0 {w_orig} {h_orig}" version="1.1" xmlns="http://www.w3.org/2000/svg">
    <polygon points="{points_str.strip()}" fill="{color_hex}" stroke="none" />
</svg>'''
            with open(output_svg_path, 'w') as f: f.write(svg_content)
            svg_generated = True
        
    # Case C: Fallback to Potrace
    if not svg_generated:
        potrace_input = cv2.bitwise_not(thresh_final)
        temp_bmp = image_path + ".temp.bmp"
        cv2.imwrite(temp_bmp, potrace_input)

        try:
            subprocess.run([
                "potrace",
                "-s",
                "--color", color_hex,
                "-t", "100", 
                "--alphamax", "1.0", # Default 1.0 often best for mix
                "-o", output_svg_path,
                temp_bmp
            ], check=True, capture_output=True)
            
            # Post-process SVG to fix scaling
            if os.path.exists(output_svg_path):
                with open(output_svg_path, 'r') as f: svg_text = f.read()
                
                # Replace width/height with original dims
                # Regex for width="..." and height="..."
                # Note: Potrace output might be width="4920pt"
                svg_text = re.sub(r'width="[^"]+"', f'width="{w_orig}pt"', svg_text, count=1)
                svg_text = re.sub(r'height="[^"]+"', f'height="{h_orig}pt"', svg_text, count=1)
                
                with open(output_svg_path, 'w') as f: f.write(svg_text)
                
        except Exception as e:
            print(f"Potrace failed for {image_path}: {e}")
        finally:
            if os.path.exists(temp_bmp): os.remove(temp_bmp)
            
    return True

def process_group(color_name):
    print(f"Processing group: {color_name}...")
    typ_source = f"{color_name}.typ"
    if not os.path.exists(typ_source): return
    with open(typ_source, "r") as f: lines = f.readlines()
    
    new_lines = []
    if lines and lines[0].startswith("#set page"): new_lines.append(lines[0].strip())
    
    place_pattern = re.compile(r'#place\(top \+ left, dx: (\d+)pt, dy: (\d+)pt, \{')
    image_pattern = re.compile(r'image\("([^\"]+)", width: (\d+)pt\)')
    
    cur_x = cur_y = 0
    for line in lines:
        line = line.strip()
        m_p = place_pattern.search(line)
        if m_p: cur_x, cur_y = m_p.groups()
        m_i = image_pattern.search(line)
        if m_i:
            png_fn, width_pt = m_i.groups()
            svg_fn = png_fn.replace(".png", ".svg")
            if png_to_svg(png_fn, svg_fn):
                obj_id = png_fn.split('_')[-1].split('.')[0]
                new_lines.append(f'''
#place(top + left, dx: {cur_x}pt, dy: {cur_y}pt, {{
  box(stroke: 2pt + red, image("{svg_fn}", width: {width_pt}pt))
  place(center + horizon, text(fill: red, size: 20pt, weight: "bold", "{obj_id}"))
}})
''')

    with open(f"{color_name}_svg.typ", "w") as f:
        f.write("\n".join(new_lines))

if __name__ == "__main__":
    for c in ["yellow_light", "yellow_dark", "blue_light", "blue_dark", "white"]:
        process_group(c)