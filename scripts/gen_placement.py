# scripts/gen_placement.py
import os

# --- Configuration ---
DIE_WIDTH = 1000
DIE_HEIGHT = 1000
PAD_WIDTH = 70   # Approx width of Sky130 GPIO pad
PAD_HEIGHT = 195 # Approx height of Sky130 GPIO pad (depth)

# Margins to avoid corner conflicts
# We start placing pads a bit away from the absolute corner
MARGIN_X = 200 
MARGIN_Y = 200

# Spacing between pads
PITCH = 85 

# --- Pad Lists (Must match your top.v instance names) ---
# Check your top.v to ensure these match exactly!
north_pads = [
    "pad_vccd_main", "pad_vssd_main", "pad_vdda_main", "pad_vssa_main",
    "pad_clk", "pad_rst_n", "pad_vccd_aux", "pad_vssd_aux"
]

south_pads = [
    f"gen_south_pads[{i}].pad_gpio_out" for i in range(8)
]

east_pads = [
    f"gen_east_pads[{i}].pad_gpio_in" for i in range(8)
]

west_pads = [
    f"gen_west_pads[{i}].pad_analog" for i in range(8)
]

def write_placement():
    with open("macro_placement.cfg", "w") as f:
        # NORTH (Top Edge) - Orientation S (180 deg, facing out)
        # Y = Top - Pad_Height
        y_pos = DIE_HEIGHT - PAD_HEIGHT
        x_start = MARGIN_X
        for i, name in enumerate(north_pads):
            x_pos = x_start + (i * PITCH)
            f.write(f"{name} {x_pos} {y_pos} S\n")

        # SOUTH (Bottom Edge) - Orientation N (0 deg, facing out)
        # Y = 0
        y_pos = 0
        x_start = MARGIN_X
        for i, name in enumerate(south_pads):
            x_pos = x_start + (i * PITCH)
            f.write(f"{name} {x_pos} {y_pos} N\n")

        # EAST (Right Edge) - Orientation W (Logic faces West/Inward)
        # X = Right - Pad_Height (Because they are rotated, height becomes width impact?)
        # Actually for Sky130, standard orientation 'N' has IO on top. 
        # Rotated 'W' (90 deg CW? or CCW?): usually puts IO on Right.
        # Let's use coordinate logic:
        # X = DIE_WIDTH - PAD_HEIGHT
        x_pos = DIE_WIDTH - PAD_HEIGHT
        y_start = MARGIN_Y
        for i, name in enumerate(east_pads):
            y_pos = y_start + (i * PITCH)
            f.write(f"{name} {x_pos} {y_pos} W\n")

        # WEST (Left Edge) - Orientation E (Logic faces East/Inward)
        # X = 0
        x_pos = 0
        y_start = MARGIN_Y
        for i, name in enumerate(west_pads):
            y_pos = y_start + (i * PITCH)
            f.write(f"{name} {x_pos} {y_pos} E\n")

if __name__ == "__main__":
    write_placement()
    print("Generated macro_placement.cfg")