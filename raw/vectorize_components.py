import cv2
import numpy as np
import os
import glob

def png_to_svg(image_path, output_svg_path):
    img = cv2.imread(image_path, cv2.IMREAD_UNCHANGED)
    if img is None:
        return False, 0, 0, None

    h, w = img.shape[:2]

    if img.shape[2] < 4:
        # If no alpha, assume simple threshold on grayscale
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        _, thresh = cv2.threshold(gray, 1, 255, cv2.THRESH_BINARY)
        # Default color
        color_hex = "#000000"
    else:
        alpha = img[:, :, 3]
        # Use a slightly more inclusive threshold for the shape
        _, thresh = cv2.threshold(alpha, 10, 255, cv2.THRESH_BINARY)
        
        # Get color from area that is definitely part of the object
        _, color_mask = cv2.threshold(alpha, 127, 255, cv2.THRESH_BINARY)
        if cv2.countNonZero(color_mask) == 0:
            color_mask = thresh # Fallback
            
        mean_color = cv2.mean(img, mask=color_mask)
        color_hex = "#{:02x}{:02x}{:02x}".format(int(mean_color[2]), int(mean_color[1]), int(mean_color[0]))

    if cv2.countNonZero(thresh) == 0:
        return False, 0, 0, None

    # Use potrace for better vectorization
    bmp_path = image_path + ".tmp.bmp"
    # Potrace traces black (0) on white (255)
    inverted_thresh = cv2.bitwise_not(thresh)
    cv2.imwrite(bmp_path, inverted_thresh)
    
    import subprocess
    try:
        # -s: SVG output
        subprocess.run(["potrace", "-s", bmp_path, "-o", output_svg_path], check=True, capture_output=True)
        
        with open(output_svg_path, 'r') as f:
            svg_data = f.read()
            
        # Replace black with actual color
        svg_data = svg_data.replace('fill="#000000"', f'fill="{color_hex}"')
        
        with open(output_svg_path, 'w') as f:
            f.write(svg_data)
            
    except Exception as e:
        print(f"Error running potrace on {image_path}: {e}")
        return False, 0, 0, None
    finally:
        if os.path.exists(bmp_path):
            os.remove(bmp_path)
            
    return True, w, h, color_hex

def process_group(color_name):
    print(f"Processing group: {color_name}...")
    
    # Find all object pngs for this color
    pattern = f"{color_name}_object_*.png"
    files = sorted(glob.glob(pattern))
    
    if not files:
        print(f"No files found for {pattern}")
        return

    # We need the original positions. 
    # Option A: Parse the existing .typ file (e.g. yellow_light.typ) to get coordinates.
    # Option B: Re-calculate from crop_all_colors.py logic (requires ref image).
    # Option C: Assume the file naming convention preserves index and we rely on crop_all_colors having run recently.
    # But wait, the previous script `crop_all_colors.py` ALREADY generated the pngs. 
    # It didn't save the metadata (x, y) anywhere except in the .typ file.
    # So I should parse the .typ file to get the coordinates back!
    
    typ_source = f"{color_name}.typ"
    if not os.path.exists(typ_source):
        print(f"Source typ file {typ_source} not found. Cannot reconstruct layout.")
        return
        
    with open(typ_source, 'r') as f:
        lines = f.readlines()
        
    # We will build a new typ file content
    new_lines = []
    
    # Extract page setup
    if lines and lines[0].startswith("#set page"):
        new_lines.append(lines[0].strip())
        
    # Regex might be overkill, let's just loop and find #place commands
    import re
    # #place(top + left, dx: 1774pt, dy: 1694pt, { 
    place_pattern = re.compile(r'#place\(top \+ left, dx: (\d+)pt, dy: (\d+)pt, \{')
    # box(stroke: 2pt + red, image("yellow_light_object_03.png", width: 147pt))
    image_pattern = re.compile(r'image\("([^"]+)", width: (\d+)pt\)')
    
    current_x = 0
    current_y = 0
    
    skip_mode = False
    
    for line in lines:
        line = line.strip()
        
        m_place = place_pattern.search(line)
        if m_place:
            current_x = m_place.group(1)
            current_y = m_place.group(2)
            
        m_img = image_pattern.search(line)
        if m_img:
            png_filename = m_img.group(1)
            width_pt = m_img.group(2)
            
            # Convert this PNG to SVG
            svg_filename = png_filename.replace(".png", ".svg")
            
            # Check if we should convert (or if it exists)
            # We convert regardless to ensure fresh SVG
            success, w, h, color = png_to_svg(png_filename, svg_filename)
            
            if success:
                print(f"Vectorized {png_filename} -> {svg_filename}")
                
                # Write to new typ structure
                # We replicate the structure but point to SVG
                # And maybe remove the border if the user just wanted 'vector' 
                # but they said "put in yellow_light_svg.typ" implying similar layout.
                # I'll keep the border/number format as requested in previous turn ("also do it...").
                
                new_lines.append(f'''
#place(top + left, dx: {current_x}pt, dy: {current_y}pt, {{
  box(stroke: 2pt + red, image("{svg_filename}", width: {width_pt}pt))
  place(center + horizon, text(fill: red, size: 20pt, weight: "bold", "{png_filename.split('_')[-1].split('.')[0]}"))
}})
''')
            else:
                print(f"Failed to vectorize {png_filename}")
    
    output_typ = f"{color_name}_svg.typ"
    with open(output_typ, 'w') as f:
        f.write("\n".join(new_lines))
    print(f"Created {output_typ}")

if __name__ == "__main__":
    colors = ["yellow_light", "yellow_dark", "blue_light", "blue_dark", "white"]
    for c in colors:
        process_group(c)
