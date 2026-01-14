import cv2
import numpy as np
import os

def crop_and_generate_typst(image_path, output_dir):
    # Load the image including the Alpha channel
    img = cv2.imread(image_path, cv2.IMREAD_UNCHANGED)
    
    if img is None:
        print(f"Error: Could not load image {image_path}")
        return

    # Check if image has an alpha channel
    if img.shape[2] < 4:
        print("Error: Image does not have an alpha channel for transparency detection.")
        return

    img_h, img_w = img.shape[:2]
    
    # Extract the alpha channel
    alpha = img[:, :, 3]

    # Threshold the alpha channel to create a binary mask
    _, thresh = cv2.threshold(alpha, 10, 255, cv2.THRESH_BINARY)

    # Find contours
    contours, _ = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    print(f"Found {len(contours)} objects.")
    
    typst_lines = []
    # Set page dimensions to match image dimensions (1px = 1pt for simplicity)
    typst_lines.append(f"#set page(width: {img_w}pt, height: {img_h}pt, margin: 0pt)")
    
    generated_files = []

    for i, cnt in enumerate(contours):
        x, y, w, h = cv2.boundingRect(cnt)
        
        if w < 5 or h < 5:
            continue

        crop = img[y:y+h, x:x+w]
        filename = f"object_{i+1:02d}.png"
        output_path = os.path.join(output_dir, filename)
        
        cv2.imwrite(output_path, crop)
        generated_files.append(filename)
        
        # Add Typst placement command
        # using dx/dy to position exactly where it was found
        typst_lines.append(f'#place(top + left, dx: {x}pt, dy: {y}pt, image("{filename}", width: {w}pt))')
        
        print(f"Processed {filename} at ({x}, {y})")

    typst_content = "\n".join(typst_lines)
    typst_path = os.path.join(output_dir, "main.typ")
    
    with open(typst_path, "w") as f:
        f.write(typst_content)
    
    print(f"Generated {typst_path} with {len(generated_files)} objects.")

if __name__ == "__main__":
    current_dir = os.path.dirname(os.path.abspath(__file__))
    img_name = "top001.png"
    img_path = os.path.join(current_dir, img_name)
    
    crop_and_generate_typst(img_path, current_dir)
