# User config
set ::env(DESIGN_NAME) bit8alubehav

# Change if needed
set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/src/bit8alu.v]

# Fill this
set ::env(CLOCK_TREE_SYNTH) 1
set ::env(CLOCK_PORT) "clk"

######
# set ::env(PL_RANDOM_GLB_PLACEMENT) 1

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 300 400"
set ::env(PL_TARGET_DENSITY) 1

# set ::env(PL_TIME_DRIVEN) 1
# set ::env(PL_ROUTABILITY_DRIVEN) 1

set ::env(FP_HORIZONTAL_HALO 20
# set ::env(FP_VERTICAL_HALO) $::env(FP_HORIZONTAL_HALO)
######

set filename $::env(DESIGN_DIR)/$::env(PDK)_$::env(STD_CELL_LIBRARY)_config.tcl
if { [file exists $filename] == 1} {
	source $filename
}

