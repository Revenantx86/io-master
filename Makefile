# --- CONFIGURATION ---
# Update these paths if your PDK location changes
PDK_ROOT = /home/tulpar/vlsi/pdk
PADRING_BIN = padring
KLAYOUT_BIN = klayout

# --- IHP SOURCE PATHS ---
IHP_IO_LEF = $(PDK_ROOT)/ihp-sg13g2/libs.ref/sg13g2_io/lef/sg13g2_io.lef

# --- GF180 SOURCE PATHS ---
GF180_IO_LEF = ./lef/gf180/gf180_io_merged.lef

# --- TARGETS ---

.PHONY: all sg130 clean

all: sg130

# ==============================================================================
# IHP SG13G2 BUILD
# ==============================================================================
sg130: 
	mkdir -p build/sg130
# 1. Run Padring (Generates the layout skeleton)
	@echo "--- Running Padring for IHP ---"
	$(PADRING_BIN) \
		--lef $(IHP_IO_LEF) \
		--svg build/sg130/sg130.svg \
		--def build/sg130/sg130.def \
		-o build/sg130/sg130.gds \
		scripts/sg130/sg130.config
		
# 2. Merge IHP GDS using KLayout script
	@echo "--- Merging IHP GDS ---"
	$(KLAYOUT_BIN) -z -r scripts/sg130/merge_sg130.py

gf180:
	mkdir -p build/gf180
# 1. Run Padring (Generates the layout skeleton)
	@echo "--- Running Padring for GF180 ---"
	$(PADRING_BIN) \
		--lef $(GF180_IO_LEF) \
		--svg build/gf180/gf180.svg \
		--def build/gf180/gf180.def \
		-o build/gf180/gf180.gds \
		scripts/gf180/gf180.config
# 2. Merge GF180 GDS using KLayout script
	@echo "--- Merging GF180 GDS ---"
	$(KLAYOUT_BIN) -z -r scripts/gf180/merge_gf180.py
	$(KLAYOUT_BIN) -b -r scripts/gf180/png.py -rd input_file=build/gf180/gf180_final.gds -rd output_file=build/gf180/gf180_final.png
# ==============================================================================# UTILITIES
# ==============================================================================
clean:
	rm -f -r build/*
	@echo "Cleaned all generated files."