import cv2
import numpy as np
import os
import glob
import re

def png_to_svg(image_path, output_svg_path):
    img = cv2.imread(image_path, cv2.IMREAD_UNCHANGED)
    if img is None: return False
    h_orig, w_orig = img.shape[:2]
    
    if img.shape[2] >= 4:
        mask = img[:, :, 3]
    else:
        mask = cv2.cvtColor(img[:, :, :3], cv2.COLOR_BGR2GRAY)
    
    _, thresh = cv2.threshold(mask, 127, 255, cv2.THRESH_BINARY)
    if cv2.countNonZero(thresh) < 5: return False

    # Get a "clean" color sampling mask by eroding slightly
    kernel_small = np.ones((3,3), np.uint8)
    color_mask = cv2.erode(thresh, kernel_small, iterations=1)
    if cv2.countNonZero(color_mask) == 0: color_mask = thresh
    
    mean_color = cv2.mean(img[:, :, :3], mask=color_mask)
    color_hex = "#{:02x}{:02x}{:02x}".format(int(mean_color[2]), int(mean_color[1]), int(mean_color[0]))

    # Vectorization: Faithful Polygon approach
    scale = 4
    # INTER_CUBIC creates smooth ramps for better corner detection
    upscaled = cv2.resize(thresh, (w_orig * scale, h_orig * scale), interpolation=cv2.INTER_CUBIC)
    _, thresh_up = cv2.threshold(upscaled, 127, 255, cv2.THRESH_BINARY)
    
    # Use CCOMP to get external and internal contours
    contours, hierarchy = cv2.findContours(thresh_up, cv2.RETR_CCOMP, cv2.CHAIN_APPROX_SIMPLE)
    if not contours: return False
    
    path_data = []
    for i in range(len(contours)):
        cnt = contours[i]
        if cv2.contourArea(cnt) < 5 * (scale**2): continue
        
        # Use a tight fixed epsilon for high fidelity
        # 1.0 in upscaled space = 0.25 pixels in original
        epsilon = 1.0
        approx = cv2.approxPolyDP(cnt, epsilon, True)
        if len(approx) < 3: continue
        
        pts = approx.reshape(-1, 2).astype(float) / scale
        d = "M " + " L ".join([f"{p[0]:.2f} {p[1]:.2f}" for p in pts]) + " Z"
        path_data.append(d)
        
    if not path_data: return False
    
    svg_content = f'''<svg width="{w_orig}" height="{h_orig}" viewBox="0 0 {w_orig} {h_orig}" xmlns="http://www.w3.org/2000/svg">
  <path d="{" ".join(path_data)}" fill="{color_hex}" stroke="none" fill-rule="evenodd" />
</svg>'''
    
    with open(output_svg_path, "w") as f:
        f.write(svg_content)
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
                new_lines.append(f'''\
#place(top + left, dx: {cur_x}pt, dy: {cur_y}pt, {{
  box(stroke: 2pt + red, image("{svg_fn}", width: {width_pt}pt))
  place(center + horizon, text(fill: red, size: 20pt, weight: "bold", "{obj_id}"))
}})''')

    with open(f"{color_name}_svg.typ", "w") as f:
        f.write("\n".join(new_lines))

if __name__ == "__main__":
    for c in ["yellow_light", "yellow_dark", "blue_light", "blue_dark", "white"]:
        process_group(c)
