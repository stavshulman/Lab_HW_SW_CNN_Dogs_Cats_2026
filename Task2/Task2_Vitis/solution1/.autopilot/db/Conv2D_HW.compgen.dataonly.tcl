# This script segment is generated automatically by AutoPilot

set axilite_register_dict [dict create]
set port_control {
input_r { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 16
	offset_end 27
}
output_r { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 28
	offset_end 39
}
coeffs { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 40
	offset_end 51
}
numChannels { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 52
	offset_end 59
}
numFilters { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 60
	offset_end 67
}
inputWidth { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 68
	offset_end 75
}
inputHeight { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 76
	offset_end 83
}
convWidth { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 84
	offset_end 91
}
convHeight { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 92
	offset_end 99
}
ap_start { }
ap_done { }
ap_ready { }
ap_idle { }
interrupt {
}
}
dict set axilite_register_dict control $port_control


