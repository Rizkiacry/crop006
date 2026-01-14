import cv2
import numpy as np
import os
import glob

def get_svg_for_image(img_path):
    img = cv2.imread(img_path, cv2.IMREAD_UNCHANGED)
    if img is None:
        return None
    h, w = img.shape[:2]
    
    if img.shape[2] == 4:
        alpha = img[:, :, 3]
        img_rgb = img[:, :, :3]
    else:
        alpha = np.ones((h, w), dtype=np.uint8) * 255
        img_rgb = img

    # Background path (Boolean)
    contours, _ = cv2.findContours(alpha, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    if not contours: return None
    main_cnt = max(contours, key=cv2.contourArea)
    path_data = "M " + " L ".join([f"{p[0][0]},{p[0][1]}" for p in main_cnt]) + " Z"
    
    # Analyze colors
    avg_color = cv2.mean(img_rgb, mask=alpha)[:3]
    hex_color = '#{:02x}{:02x}{:02x}'.format(int(avg_color[2]), int(avg_color[1]), int(avg_color[0]))
    stroke_color = '#{:02x}{:02x}{:02x}'.format(max(0, int(avg_color[2])-50), max(0, int(avg_color[1])-50), max(0, int(avg_color[0])-50))

    elements = []
    # 1. Path (Boolean)
    elements.append(f'  <path d="{path_data}" fill="{hex_color}" stroke="{stroke_color}" stroke-width="0.5" />')
    
    # 2. Rectangle (Main body internal)
    x, y, rw, rh = cv2.boundingRect(main_cnt)
    elements.append(f'  <rect x="{x+rw*0.1:.1f}" y="{y+rh*0.1:.1f}" width="{rw*0.8:.1f}" height="{rh*0.8:.1f}" fill="none" stroke="{stroke_color}" stroke-opacity="0.3" stroke-width="0.5" />')
    
    # 3. Circle (Detail)
    elements.append(f'  <circle cx="{x+rw/2:.1f}" cy="{y+rh/2:.1f}" r="{min(rw, rh)/4:.1f}" fill="none" stroke="{stroke_color}" stroke-width="0.5" />')
    
    # 4. Ellipse (Top/Bottom roundedness)
    elements.append(f'  <ellipse cx="{x+rw/2:.1f}" cy="{y+5:.1f}" rx="{rw/3:.1f}" ry="{min(rh/10, 5):.1f}" fill="none" stroke="{stroke_color}" stroke-width="0.5" />')
    
    # 5. Line (Structure)
    elements.append(f'  <line x1="{x+rw/2:.1f}" y1="{y:.1f}" x2="{x+rw/2:.1f}" y2="{y+rh:.1f}" stroke="{stroke_color}" stroke-width="0.5" stroke-dasharray="1,1" />')

    svg_content = f'<svg width="{w}" height="{h}" viewBox="0 0 {w} {h}" xmlns="http://www.w3.org/2000/svg">'
    svg_content += "\n" + "\n".join(elements)
    svg_content += "\n</svg>"
    return svg_content

def process_all():
    images = sorted(glob.glob("object_*.png"))
    for img_path in images:
        svg_content = get_svg_for_image(img_path)
        if svg_content:
            svg_path = img_path.replace(".png", ".svg")
            with open(svg_path, "w") as f:
                f.write(svg_content)

if __name__ == "__main__":
    process_all()