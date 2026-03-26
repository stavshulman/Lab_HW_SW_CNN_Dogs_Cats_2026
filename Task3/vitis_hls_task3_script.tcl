############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
############################################################
open_project Task3_Vitis
set_top Conv2D_HW
add_files CNN_PROJECT/Lab_HW_SW_CNN_Dogs_Cats_2026/Task3/src/conv2d.hpp
add_files CNN_PROJECT/Lab_HW_SW_CNN_Dogs_Cats_2026/Task3/src/conv2d.cpp
add_files -tb CNN_PROJECT/Lab_HW_SW_CNN_Dogs_Cats_2026/Task3/src/conv2DTestbench.cpp -cflags "-Wno-unknown-pragmas -Wno-unknown-pragmas -Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
open_solution "solution1" -flow_target vivado
set_part {xc7z020-clg400-1}
create_clock -period 10 -name default
config_export -format ip_catalog -output C:/Users/stavs/Documents/Lab_HW_SW/Midterm_V2/CNN_PROJECT/Lab_HW_SW_CNN_Dogs_Cats_2026/Task3 -rtl verilog
source "./Task3_Vitis/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -rtl verilog -format ip_catalog -output C:/Users/stavs/Documents/Lab_HW_SW/Midterm_V2/CNN_PROJECT/Lab_HW_SW_CNN_Dogs_Cats_2026/Task3
