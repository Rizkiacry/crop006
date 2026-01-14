from PIL import Image
import numpy as np

def color_to_alpha_white(input_path, output_path):
    print(f"Applying aggressive Color to Alpha (White) on {input_path}...")
    img = Image.open(input_path).convert("RGB")
    data = np.array(img).astype(float)
    
    r, g, b = data[:,:,0], data[:,:,1], data[:,:,2]
    
    # Alpha is the deviation from white (255, 255, 255)
    # The more white it is, the more transparent it becomes.
    # a = max( (255-R)/255, (255-G)/255, (255-B)/255 )
    a_r = (255.0 - r) / 255.0
    a_g = (255.0 - g) / 255.0
    a_b = (255.0 - b) / 255.0
    
    alpha = np.maximum(a_r, np.maximum(a_g, a_b))
    
    # Resulting color: if we assume we are removing white, 
    # the original color C = alpha * Result + (1-alpha) * White
    # Result = (C - (1-alpha) * 255) / alpha
    
    # Protect against alpha=0 (pure white)
    alpha_safe = np.where(alpha == 0, 1.0, alpha)
    
    new_r = (r - 255.0 * (1.0 - alpha)) / alpha_safe
    new_g = (g - 255.0 * (1.0 - alpha)) / alpha_safe
    new_b = (b - 255.0 * (1.0 - alpha)) / alpha_safe
    
    # Create RGBA array
    new_data = np.stack([new_r, new_g, new_b, alpha * 255.0], axis=2)
    new_data = np.clip(new_data, 0, 255).astype(np.uint8)
    
    # If the user wants WHITE lines, we could invert the RGB here.
    # But let's first try just removing the white properly.
    
    result = Image.fromarray(new_data)
    result.save(output_path, "PNG")
    print(f"Done! Saved to {output_path}")

if __name__ == "__main__":
    target = "assets/side001_linewhite_original.png"
    output = "assets/side001_linewhite.png"
    color_to_alpha_white(target, output)
