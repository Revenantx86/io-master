import pya
import os

# --- CONFIGURATION ---
input_ring = "build/gf180/gf180.gds"
output_ring = "build/gf180/gf180_final.gds"

# GF180 GDS Path (inferred from your LEF path)
io_gds = "/home/tulpar/vlsi/pdk/gf180mcuD/libs.ref/gf180mcu_fd_io/gds/gf180mcu_fd_io.gds"

# --- MERGE ---
layout = pya.Layout()
layout.read(input_ring)

if os.path.exists(io_gds):
    print(f"Merging IHP IOs from: {io_gds}")
    layout.read(io_gds)
else:
    print(f"ERROR: Could not find {io_gds}")
    print("Please check if the 'gds' folder exists next to the 'lef' folder.")

layout.write(output_ring)
print(f"Done! Saved to {output_ring}")