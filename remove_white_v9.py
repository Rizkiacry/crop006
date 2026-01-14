from PIL import Image
import numpy as np

def make_clean_black_lines(input_path, output_path):
    print(f"Creating clean black lines on transparency for {input_path}...")
    img = Image.open(input_path).convert("RGB")
    data = np.array(img).astype(float)
    
    r, g, b = data[:,:,0], data[:,:,1], data[:,:,2]
    
    # Use max deviation from white as alpha (standard Color to Alpha White)
    a_r = (255.0 - r) / 255.0
    a_g = (255.0 - g) / 255.0
    a_b = (255.0 - b) / 255.0
    alpha = np.maximum(a_r, np.maximum(a_g, a_b))
    
    # We want BLACK lines (0, 0, 0)
    # The alpha channel already captures the "ink density"
    new_data = np.zeros((data.shape[0], data.shape[1], 4))
    new_data[:,:,3] = alpha * 255.0
    
    # Cast to uint8
    new_data = np.clip(new_data, 0, 255).astype(np.uint8)
    
    result = Image.fromarray(new_data)
    result.save(output_path, "PNG")
    print(f"Done! Saved to {output_path}")

if __name__ == "__main__":
    target = "assets/side001_linewhite_original.png"
    output = "assets/side001_linewhite.png"
    make_clean_black_lines(target, output)
