import urllib.request
import re
import os

components = {
    "motherboard": "https://en.wikipedia.org/wiki/Motherboard",
    "atx_motherboard": "https://en.wikipedia.org/wiki/ATX",
    "matx_motherboard": "https://en.wikipedia.org/wiki/MicroATX",
    "mini_itx": "https://en.wikipedia.org/wiki/Mini-ITX",
    "bios_uefi": "https://en.wikipedia.org/wiki/UEFI", # Might be a screenshot
    "lga_1700": "https://en.wikipedia.org/wiki/LGA_1700",
    "am5": "https://en.wikipedia.org/wiki/Socket_AM5",
    "chipset": "https://en.wikipedia.org/wiki/Chipset",
    "pcie_slot": "https://en.wikipedia.org/wiki/PCI_Express",
    "dimm_slot": "https://en.wikipedia.org/wiki/DIMM",
    "m2_slot": "https://en.wikipedia.org/wiki/M.2",
    "sata_port": "https://en.wikipedia.org/wiki/SATA",
    "atx_24pin": "https://en.wikipedia.org/wiki/ATX", # Might be hard to find specific connector image alone, but let's try
    "vrm": "https://en.wikipedia.org/wiki/Voltage_regulator_module",
    "cmos_battery": "https://en.wikipedia.org/wiki/Non-volatile_BIOS_memory", # Often shows the battery
    "back_panel_io": "https://en.wikipedia.org/wiki/Input/output" # Generic
}

output_dir = "assets/components"
os.makedirs(output_dir, exist_ok=True)

for name, url in components.items():
    print(f"Processing {name}...")
    try:
        req_page = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'})
        with urllib.request.urlopen(req_page) as response:
            html = response.read().decode('utf-8')
            # Look for typical wikimedia thumb images.
            # We prefer JPG or PNG.
            # Regex to find src="//upload..." 
            # We want the larger version if possible, but the thumb is safer to find.
            # Usually 'src="//upload.wikimedia.org/wikipedia/commons/thumb/x/xy/Filename.jpg/220px-Filename.jpg"'
            
            matches = re.findall(r'src="//(upload\.wikimedia\.org/wikipedia/commons/[^"]+\.(?:jpg|png|jpeg))"', html)
            
            if not matches:
                # Try finding without 'thumb' if it's a direct file
                matches = re.findall(r'src="//(upload\.wikimedia\.org/wikipedia/commons/[^"]+\.(?:jpg|png|jpeg))"', html)
            
            if matches:
                # Get the first one that looks like a photo (often in infobox)
                # Filter out small icons or svg if any (we asked for jpg/png)
                
                # Pick the first one
                image_url = "https://" + matches[0]
                
                # If it's a thumb, try to get a slightly larger version? 
                # e.g. /220px- -> /500px- or just remove the thumb part to get full size (might be too big)
                # Let's just use what we found, usually 220px or 250px is small but acceptable for a document if high res not needed.
                # Actually for a report, higher res is better.
                # Transform: .../thumb/a/ab/Name.jpg/220px-Name.jpg -> .../a/ab/Name.jpg
                
                if "/thumb/" in image_url:
                    # distinct parts
                    # pattern: .../thumb/shard/Name.ext/Size-Name.ext
                    # we want: .../shard/Name.ext
                    
                    # Split by /thumb/
                    base, rest = image_url.split("/thumb/")
                    # rest is shard/Name.ext/Size-Name.ext
                    parts = rest.split("/")
                    if len(parts) >= 2:
                         # Reconstruct full path
                         # The part before the last slash is likely the file path
                         # But wait, typically: .../commons/thumb/a/b/File.jpg/220px-File.jpg
                         # The full image is .../commons/a/b/File.jpg
                         
                         # Check if the last part starts with a size
                         if re.match(r'\d+px-', parts[-1]):
                             full_image_part = "/".join(parts[:-1])
                             image_url = base + "/" + full_image_part
                
                print(f"  Found image: {image_url}")
                
                # Download
                ext = image_url.split('.')[-1]
                filename = f"{output_dir}/{name}.{ext}"
                
                # Add user agent to avoid 403
                req = urllib.request.Request(image_url, headers={'User-Agent': 'Mozilla/5.0'})
                with urllib.request.urlopen(req) as img_response:
                     with open(filename, 'wb') as f:
                         f.write(img_response.read())
                print(f"  Saved to {filename}")
                
            else:
                print(f"  No image found for {name}")

    except Exception as e:
        print(f"  Error fetching {name}: {e}")
