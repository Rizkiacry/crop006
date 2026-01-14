from PIL import Image
import PIL.ImageOps

def make_white_lines_transparent_bg(input_path, output_path):
    print(f"Converting {input_path} to white lines on transparent bg...")
    img = Image.open(input_path).convert("L")
    
    # Invert so that lines (dark) become light (255) and bg (light) becomes dark (0)
    lines = PIL.ImageOps.invert(img)
    
    # Create a new RGBA image, all white
    white_img = Image.new("RGBA", img.size, (255, 255, 255, 255))
    
    # Use the 'lines' image as the alpha channel
    # Light pixels in 'lines' (the original dark lines) will be opaque
    # Dark pixels in 'lines' (the original white bg) will be transparent
    white_img.putalpha(lines)
    
    white_img.save(output_path, "PNG")
    print(f"Done! Saved to {output_path}")

if __name__ == "__main__":
    target = "assets/side001_linewhite_original.png"
    output = "assets/side001_linewhite.png"
    make_white_lines_transparent_bg(target, output)
