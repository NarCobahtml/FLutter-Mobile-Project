from PIL import Image
import os

def add_padding(input_path, output_path, padding_ratio=0.5):
    try:
        img = Image.open(input_path).convert("RGBA")
        width, height = img.size
        
        # Calculate new size
        # If we want the logo to be 60% of the canvas, new_size = old_size / 0.6
        # Let's just make the canvas 1.5x larger, which provides nice padding.
        # Actually, Android 12 circle is centered.
        # If the image is square, the circle diameter is approx 2/3 of the width of the viewport?
        # The docs say: "Icon background: 960x960 px, fit within circle 640px in diameter"
        # So the visible area is roughly 66% (640/960). 
        # So if we make the content ~60% of the full image size, it should be safe.
        
        # Current size is W x H.
        # We want W to be 60% of New_W. => New_W = W / 0.6
        
        scale_factor = 1.0 / 0.6  # approx 1.67
        
        new_width = int(width * scale_factor)
        new_height = int(height * scale_factor)
        
        # Create new transparent image
        new_img = Image.new("RGBA", (new_width, new_height), (0, 0, 0, 0))
        
        # Paste original image in center
        paste_x = (new_width - width) // 2
        paste_y = (new_height - height) // 2
        
        new_img.paste(img, (paste_x, paste_y), img)
        
        new_img.save(output_path, "PNG")
        print(f"Successfully created {output_path}")
        
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    input_file = r"d:\belajar\pjbl\MOBILE\mobileswaranusa\swaranusaquiz\assets\image\logo.png"
    output_file = r"d:\belajar\pjbl\MOBILE\mobileswaranusa\swaranusaquiz\assets\image\logo_padded.png"
    add_padding(input_file, output_file)
