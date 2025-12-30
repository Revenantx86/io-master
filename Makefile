# --- CONFIGURATION ---
# Update these paths if your PDK location changes
PDK_ROOT = /home/tulpar/vlsi/pdk
PADRING_BIN = padring
KLAYOUT_BIN = klayout

# --- IHP SOURCE PATHS ---
IHP_IO_LEF = $(PDK_ROOT)/ihp-sg13g2/libs.ref/sg13g2_io/lef/sg13g2_io.lef

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


# ==============================================================================# UTILITIES
# ==============================================================================
clean:
	rm -f -r build/*
	@echo "Cleaned all generated files."