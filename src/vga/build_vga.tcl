# ===============================================================
# TCL script to add files for cmd_gather block simulation
# ===============================================================

# Create a *separate* project for block-level work
create_project vga_controller vga_controller -part xc7a50ticsg324-1L -force

# Clear previous sources
reset_project

# ---------------------- RTL ----------------------
# Add only RTL needed for cmd_gather sources_1
add_files -fileset sources_1 ./vga_controller.sv
add_files -fileset sources_1 ./vga_top.sv

# Update compile order
update_compile_order -fileset sources_1

# Optional: set top module for simulation and design
set_property top vga_top [get_filesets sources_1]

puts "TCL project setup for cmd_execute block complete."

# Uncomment to automatically launch simulation automatically
# launch_simulation

