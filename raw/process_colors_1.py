import cv2
import numpy as np
import os
import shutil

def hex_to_bgr(hex_color):
    hex_color = hex_color.lstrip('#')
    rgb = tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))
    return (rgb[2], rgb[1], rgb[0]) # BGR

def process_image(image_path, output_base_dir):
    # Define target colors (Hex)
    target_colors_hex = ['#1f3a99', '#66aaff', '#b3d8ff', '#ffffff']
    
    # Load image
    img = cv2.imread(image_path, cv2.IMREAD_UNCHANGED)
    if img is None:
        print(f"Error: Could not load {image_path}")
        return

    # If image has no alpha, add one (all opaque initially)
    if img.shape[2] == 3:
        b, g, r = cv2.split(img)
        alpha = np.ones_like(b) * 255
        img = cv2.merge((b, g, r, alpha))

    img_h, img_w = img.shape[:2]
    
    # Prepare output directory
    if os.path.exists(output_base_dir):
        shutil.rmtree(output_base_dir)
    os.makedirs(output_base_dir)

    typst_lines = []
    
    # Iterate through colors
    # Pre-calculate masks using Nearest Neighbor to ensure no color is lost
    # and to handle "not exact" values better.
    
    # Flatten image to (N, 3) for vectorized distance calc
    # Work with float32 for accurate distance
    img_data = img[:, :, :3].astype(np.float32)
    h, w, _ = img_data.shape
    
    # Target colors in BGR
    targets_bgr = [hex_to_bgr(c) for c in target_colors_hex]
    
    # We need to assign every pixel to the nearest target.
    # Distances: (H, W, 4)
    distances = np.zeros((h, w, len(targets_bgr)), dtype=np.float32)
    
    for i, target in enumerate(targets_bgr):
        # Euclidean distance in RGB space
        # dist = sqrt(sum((px - target)^2))
        # We can avoid sqrt for comparison
        diff = img_data - np.array(target, dtype=np.float32)
        dist_sq = np.sum(diff**2, axis=2)
        distances[:, :, i] = dist_sq
        
    # Get index of nearest color
    nearest_labels = np.argmin(distances, axis=2) # (H, W)
    
    # Handle transparency if alpha exists
    # If alpha is low, ignore (treat as background/none)
    if img.shape[2] == 4:
        alpha_mask = img[:, :, 3] > 10
    else:
        alpha_mask = np.ones((h, w), dtype=bool)

    for page_idx, hex_code in enumerate(target_colors_hex):
        bgr_target = hex_to_bgr(hex_code)
        
        # Create a directory for this color/page
        page_dir_name = f"page_{page_idx + 1}_{hex_code.lstrip('#')}"
        page_dir_path = os.path.join(output_base_dir, page_dir_name)
        if not os.path.exists(page_dir_path):
            os.makedirs(page_dir_path)
        
        print(f"Processing color {hex_code}...")

        # Create mask based on nearest label
        # Mask is True where label == page_idx AND alpha is valid
        mask = (nearest_labels == page_idx) & alpha_mask
        mask = mask.astype(np.uint8) * 255
        
        # Apply Morphological Closing to merge nearby fragments
        # This addresses "too many objects"
        kernel_size = 3 # Can adjust if still too fragmented
        kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (kernel_size, kernel_size))
        mask = cv2.morphologyEx(mask, cv2.MORPH_CLOSE, kernel)

        # Create isolated image for cropping
        isolated = np.zeros_like(img)
        # Fill with exact target color where mask is valid (mask == 255)
        # We need to broadcast bgr_target to the shape of the masked area
        # isolated has shape (H, W, 4). 
        # We can just set the RGB channels for the masked region.
        
        # Create a full image of the target color
        full_color = np.full((img_h, img_w, 3), bgr_target, dtype=np.uint8)
        
        # Apply where mask is active
        isolated[:, :, :3] = full_color
        # Mask zero areas out (they are already 0 from np.zeros_like, but we need to ensure color is only where mask is)
        # Actually, simpler:
        # isolated[mask == 255, :3] = bgr_target # This works in numpy if broadcasting is handled or if using boolean indexing correctly
        
        # Boolean indexing for assignment:
        # mask is (H, W).
        # isolated[mask == 255] selects pixels (N, 4).
        # We want to set the first 3 components.
        
        # Safe way:
        isolated[:, :, 0] = np.where(mask == 255, bgr_target[0], 0)
        isolated[:, :, 1] = np.where(mask == 255, bgr_target[1], 0)
        isolated[:, :, 2] = np.where(mask == 255, bgr_target[2], 0)
        isolated[:, :, 3] = mask 

        # Find contours on the processed mask
        contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        
        # Typst page setup
        if page_idx > 0:
            typst_lines.append("#pagebreak()")
        typst_lines.append(f"// Page {page_idx + 1}: Color {hex_code}")
        typst_lines.append(f"#set page(width: {img_w}pt, height: {img_h}pt, margin: 0pt, fill: gray)")
        
        object_count = 0
        for i, cnt in enumerate(contours):
            x, y, w, h = cv2.boundingRect(cnt)
            
            # Filter tiny noise
            if w < 2 or h < 2:
                continue
                
            crop = isolated[y : y + h, x : x + w]
            filename = f"obj_{i:03d}.png"
            file_path = os.path.join(page_dir_path, filename)
            
            cv2.imwrite(file_path, crop)
            
            # Add to Typst
            # Relative path from the main.typ file
            rel_path = f"{page_dir_name}/{filename}"
            # Add border (box stroke) and number (text)
            typst_lines.append(f'#place(top + left, dx: {x}pt, dy: {y}pt, box(stroke: 0.25pt + red, inset: 0pt)[#image("{rel_path}", width: {w}pt)#place(center + horizon, text(size: 3pt, fill: red, "{object_count + 1}"))])')
            object_count += 1
            
        print(f"  Found {object_count} objects for {hex_code}")

    # Write Typst file
    typst_path = os.path.join(output_base_dir, "main.typ")
    with open(typst_path, "w") as f:
        f.write("\n".join(typst_lines))
    print(f"Generated {typst_path}")

    # Generate Overlay Typst file (All on one page, gray background)
    overlay_lines = []
    overlay_lines.append(f"#set page(width: {img_w}pt, height: {img_h}pt, margin: 0pt, fill: gray)")
    
    # We need to re-iterate or store the placement commands. 
    # Since we didn't store them separately in a structured way, let's extract them from the generated files
    # or better, let's just re-generate the placement logic by walking the output directories.
    
    # Actually, simpler approach: Use the `typst_lines` we already built, but filter out pagebreaks and page setup, 
    # and just concatenate all placements.
    
    for line in typst_lines:
        if line.startswith("#place"):
            overlay_lines.append(line)
            
    overlay_path = os.path.join(output_base_dir, "overlay.typ")
    with open(overlay_path, "w") as f:
        f.write("\n".join(overlay_lines))
    print(f"Generated {overlay_path}")
    
    print(f"Done. Output in {output_base_dir}/")

if __name__ == "__main__":
    process_image("top001.png", "output_colors")
