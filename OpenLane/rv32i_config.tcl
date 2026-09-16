# User config
set ::env(DESIGN_NAME) RV32I

# Change if needed
set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/src/*.v]

# Fill this
set ::env(CLOCK_PERIOD) "20.0"
set ::env(CLOCK_PORT) "clk"

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 300 400"
set ::env(PL_TARGET_DENSITY) 0.5

set ::env(FP_HORIZONTAL_HALO) 150

set filename $::env(DESIGN_DIR)/$::env(PDK)_$::env(STD_CELL_LIBRARY)_config.tcl
if { [file exists $filename] == 1} {
	source $filename
}

