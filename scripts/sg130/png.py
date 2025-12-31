import pya
import sys

# 1. Parse Command Line Arguments
# We expect usage: klayout -z -r gds2img.py -rd input_file=design.gds -rd output_file=image.png
input_file = "build/sg130/sg130_final.gds"   # Default
output_file = "build/sg130/sg130_final.png"     # Default

# KLayout passes arguments defined with -rd into a global dictionary
if "input_file" in globals():
    input_file = globals()["input_file"]

if "output_file" in globals():
    output_file = globals()["output_file"]

# 2. Load Layout
print(f"Loading {input_file}...")
layout = pya.Layout()
layout.read(input_file)
# FIX: Handle multiple top cells by picking the largest one
top_cells = layout.top_cells()

if not top_cells:
    print("Error: Layout is empty!")
    sys.exit(1)

# Logic: The "real" design is usually the one with the largest bounding box
# We sort candidates by area and pick the biggest one.
best_cell = max(top_cells, key=lambda c: c.bbox().area())

print(f"Found {len(top_cells)} top cells. Selecting main design: '{best_cell.name}'")

# 3. Setup View
view = pya.LayoutView()
view.show_layout(layout, True)

# Force the view to focus only on our chosen 'best_cell'
# (This hides the stray unplaced pads from the image)
view.active_cellview().cell = best_cell 

view.max_hier() # Show all hierarchy levels
# 4. Export
print(f"Exporting to {output_file}...")
view.save_image(output_file, 4000, 3000)
print("Done.")