from PIL import Image
import numpy as np

def remove_white_thresholded(input_path, output_path, high_thresh=230, low_thresh=50):
    print(f"Processing {input_path} with thresholded luminance...")
    img = Image.open(input_path).convert("RGBA")
    data = np.array(img)
    
    # Get grayscale luminance
    # Y = 0.299R + 0.587G + 0.114B
    rgb = data[:,:,:3]
    luma = 0.299 * rgb[:,:,0] + 0.587 * rgb[:,:,1] + 0.114 * rgb[:,:,2]
    
    # Create alpha channel
    # Map high_thresh..255 to 0 alpha
    # Map 0..low_thresh to 255 alpha
    alpha = np.zeros_like(luma)
    
    # Background (light) -> transparent
    mask_bg = luma >= high_thresh
    alpha[mask_bg] = 0
    
    # Lines (dark) -> opaque
    mask_lines = luma <= low_thresh
    alpha[mask_lines] = 255
    
    # Gradual (anti-aliasing)
    mask_grad = (luma > low_thresh) & (luma < high_thresh)
    # Scale: low -> 255, high -> 0
    alpha[mask_grad] = 255 * (high_thresh - luma[mask_grad]) / (high_thresh - low_thresh)
    
    data[:,:,3] = alpha.astype(np.uint8)
    
    # If the lines were meant to be BLACK (as suggested by top001_linealpha)
    # Let's ensure the RGB part is black for the lines?
    # No, keep original colors but set alpha.
    
    result = Image.fromarray(data)
    result.save(output_path, "PNG")
    print(f"Done! Saved to {output_path}")

if __name__ == "__main__":
    target = "assets/side001_linewhite_original.png"
    output = "assets/side001_linewhite.png"
    remove_white_thresholded(target, output)
