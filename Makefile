# ==========================================
# =                 MAKEFILE               =
# ==========================================

# --- 1. CONFIGURATION ---
PROJECT_NAME = io_ring_example
PROJECT_SRCS = top.v stubs.v

# Toolchain
IV = iverilog
TEST ?= none

# Paths
SRC_DIR = src
BUILD_DIR = build

# --- LIBRELANE / OPENLANE CONFIGURATION ---
LIBRELANE_DIR = /Users/refikyalcin/vlsi/tools/librelane

# Point to the TCL config now
OL_CONFIG = $(abspath config/config.tcl)

# Flags
IV_FLAGS = -g2012 -Wall

# Colors
GREEN = \033[0;32m
BLUE = \033[0;34m
YELLOW = \033[0;33m
NC = \033[0m

# Auto-resolve paths
SOURCES = $(addprefix $(SRC_DIR)/, $(PROJECT_SRCS))

# ==========================================
# --- 3. TARGETS ---
# ==========================================

.PHONY: all lint synth clean help

# Default target
all: lint

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# --- ICARUS VERILOG (SYNTAX CHECK) ---
lint: $(BUILD_DIR)
	@echo "$(GREEN)========================================$(NC)"
	@echo "$(BLUE)  [Icarus] Checking Syntax...$(NC)"
	@echo "$(GREEN)========================================$(NC)"
	$(IV) $(IV_FLAGS) -o $(BUILD_DIR)/syntax_check.out -I $(SRC_DIR) $(SOURCES)
	@echo "$(YELLOW) Syntax OK. Output at $(BUILD_DIR)/syntax_check.out$(NC)"

# ==========================================
# --- 5. SYNTHESIS (LIBRELANE) ---
# ==========================================

synth:
	@echo "$(GREEN)========================================$(NC)"
	@echo "$(BLUE)  [OpenLane] Starting Chip Layout...$(NC)"
	@echo "$(BLUE)  Config: $(OL_CONFIG)$(NC)"
	@echo "$(GREEN)========================================$(NC)"
	
	# FIX: Changed --tag to --run-tag per error log
	cd $(LIBRELANE_DIR) && \
	nix-shell --run "openlane $(OL_CONFIG) --run-tag run_1"
# --- UTILS ---
clean:
	@echo "  Cleaning build files..."
	rm -rf $(BUILD_DIR) *.vcd

help:
	@echo "Usage:"
	@echo "  make lint            -> Check Verilog syntax"
	@echo "  make synth           -> Run OpenLane to generate IO Ring"