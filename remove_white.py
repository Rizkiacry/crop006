from PIL import Image
import PIL.ImageOps

def remove_white_luminance(input_path, output_path):
    print(f"Processing {input_path} using luminance alpha...")
    img = Image.open(input_path).convert("RGBA")
    
    # Create a grayscale version for the mask
    # We want white (255) to be transparent (0) and black (0) to be opaque (255)
    # So we invert the grayscale version
    gray = img.convert("L")
    mask = PIL.ImageOps.invert(gray)
    
    # Set the mask as the alpha channel
    img.putalpha(mask)
    
    # Optionally, if the lines were dark, we might want to keep them dark.
    # If the user wanted WHITE lines on transparency, they would have said so.
    # But the filename is linewhite. If the original had white lines on black,
    # then my previous analysis was wrong.
    # However, my analysis showed 3.9M pixels were > 250. 
    # That means the background was white.
    
    img.save(output_path, "PNG")
    print(f"Done! Saved to {output_path}")

if __name__ == "__main__":
    target = "assets/side001_linewhite_original.png"
    output = "assets/side001_linewhite.png"
    remove_white_luminance(target, output)