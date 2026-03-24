set moduleName Conv2D_HW_Pipeline_loop_acc_x
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set C_modelName {Conv2D_HW_Pipeline_loop_acc_x}
set C_modelType { void 0 }
set C_modelArgList {
	{ gmem0 int 32 regular {axi_master 0}  }
	{ inputWidth int 32 regular  }
	{ inputHeight int 32 regular  }
	{ y int 32 regular  }
	{ mul_ln13_1 int 96 regular  }
	{ convWidth int 32 regular  }
	{ mul_ln13 int 64 regular  }
	{ p_cast10_mid1117 int 32 regular  }
	{ icmp_ln44_1 int 1 regular  }
	{ zext_ln60 int 32 regular  }
	{ input_r int 64 regular  }
	{ filterCoeffs int 32 regular {array 256 { 1 3 } 1 1 }  }
	{ filterCoeffs_1 int 32 regular {array 256 { 1 3 } 1 1 }  }
	{ filterCoeffs_2 int 32 regular {array 256 { 1 3 } 1 1 }  }
	{ filterCoeffs_3 int 32 regular {array 256 { 1 3 } 1 1 }  }
	{ filterCoeffs_4 int 32 regular {array 256 { 1 3 } 1 1 }  }
	{ filterCoeffs_5 int 32 regular {array 256 { 1 3 } 1 1 }  }
	{ filterCoeffs_6 int 32 regular {array 256 { 1 3 } 1 1 }  }
	{ filterCoeffs_7 int 32 regular {array 256 { 1 3 } 1 1 }  }
	{ filterCoeffs_8 int 32 regular {array 256 { 1 3 } 1 1 }  }
	{ acc_out int 32 regular {pointer 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "gmem0", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[ {"cElement": [{"cName": "input_r","offset": { "type": "dynamic","port_name": "input_r","bundle": "control"},"direction": "READONLY"},{"cName": "output_r","offset": { "type": "dynamic","port_name": "output_r","bundle": "control"},"direction": "WRITEONLY"}]}]} , 
 	{ "Name" : "inputWidth", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "inputHeight", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "mul_ln13_1", "interface" : "wire", "bitwidth" : 96, "direction" : "READONLY"} , 
 	{ "Name" : "convWidth", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "mul_ln13", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "p_cast10_mid1117", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "icmp_ln44_1", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "zext_ln60", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "input_r", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "filterCoeffs", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "filterCoeffs_1", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "filterCoeffs_2", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "filterCoeffs_3", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "filterCoeffs_4", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "filterCoeffs_5", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "filterCoeffs_6", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "filterCoeffs_7", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "filterCoeffs_8", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "acc_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 111
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ m_axi_gmem0_AWVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem0_AWREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem0_AWADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_gmem0_AWID sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem0_AWLEN sc_out sc_lv 32 signal 0 } 
	{ m_axi_gmem0_AWSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_gmem0_AWBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_gmem0_AWLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_gmem0_AWCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem0_AWPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_gmem0_AWQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem0_AWREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem0_AWUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem0_WVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem0_WREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem0_WDATA sc_out sc_lv 32 signal 0 } 
	{ m_axi_gmem0_WSTRB sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem0_WLAST sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem0_WID sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem0_WUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem0_ARVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem0_ARREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem0_ARADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_gmem0_ARID sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem0_ARLEN sc_out sc_lv 32 signal 0 } 
	{ m_axi_gmem0_ARSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_gmem0_ARBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_gmem0_ARLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_gmem0_ARCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem0_ARPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_gmem0_ARQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem0_ARREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem0_ARUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem0_RVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem0_RREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem0_RDATA sc_in sc_lv 32 signal 0 } 
	{ m_axi_gmem0_RLAST sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem0_RID sc_in sc_lv 1 signal 0 } 
	{ m_axi_gmem0_RFIFONUM sc_in sc_lv 9 signal 0 } 
	{ m_axi_gmem0_RUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_gmem0_RRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_gmem0_BVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem0_BREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem0_BRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_gmem0_BID sc_in sc_lv 1 signal 0 } 
	{ m_axi_gmem0_BUSER sc_in sc_lv 1 signal 0 } 
	{ inputWidth sc_in sc_lv 32 signal 1 } 
	{ inputHeight sc_in sc_lv 32 signal 2 } 
	{ y sc_in sc_lv 32 signal 3 } 
	{ mul_ln13_1 sc_in sc_lv 96 signal 4 } 
	{ convWidth sc_in sc_lv 32 signal 5 } 
	{ mul_ln13 sc_in sc_lv 64 signal 6 } 
	{ p_cast10_mid1117 sc_in sc_lv 32 signal 7 } 
	{ icmp_ln44_1 sc_in sc_lv 1 signal 8 } 
	{ zext_ln60 sc_in sc_lv 32 signal 9 } 
	{ input_r sc_in sc_lv 64 signal 10 } 
	{ filterCoeffs_address0 sc_out sc_lv 8 signal 11 } 
	{ filterCoeffs_ce0 sc_out sc_logic 1 signal 11 } 
	{ filterCoeffs_q0 sc_in sc_lv 32 signal 11 } 
	{ filterCoeffs_1_address0 sc_out sc_lv 8 signal 12 } 
	{ filterCoeffs_1_ce0 sc_out sc_logic 1 signal 12 } 
	{ filterCoeffs_1_q0 sc_in sc_lv 32 signal 12 } 
	{ filterCoeffs_2_address0 sc_out sc_lv 8 signal 13 } 
	{ filterCoeffs_2_ce0 sc_out sc_logic 1 signal 13 } 
	{ filterCoeffs_2_q0 sc_in sc_lv 32 signal 13 } 
	{ filterCoeffs_3_address0 sc_out sc_lv 8 signal 14 } 
	{ filterCoeffs_3_ce0 sc_out sc_logic 1 signal 14 } 
	{ filterCoeffs_3_q0 sc_in sc_lv 32 signal 14 } 
	{ filterCoeffs_4_address0 sc_out sc_lv 8 signal 15 } 
	{ filterCoeffs_4_ce0 sc_out sc_logic 1 signal 15 } 
	{ filterCoeffs_4_q0 sc_in sc_lv 32 signal 15 } 
	{ filterCoeffs_5_address0 sc_out sc_lv 8 signal 16 } 
	{ filterCoeffs_5_ce0 sc_out sc_logic 1 signal 16 } 
	{ filterCoeffs_5_q0 sc_in sc_lv 32 signal 16 } 
	{ filterCoeffs_6_address0 sc_out sc_lv 8 signal 17 } 
	{ filterCoeffs_6_ce0 sc_out sc_logic 1 signal 17 } 
	{ filterCoeffs_6_q0 sc_in sc_lv 32 signal 17 } 
	{ filterCoeffs_7_address0 sc_out sc_lv 8 signal 18 } 
	{ filterCoeffs_7_ce0 sc_out sc_logic 1 signal 18 } 
	{ filterCoeffs_7_q0 sc_in sc_lv 32 signal 18 } 
	{ filterCoeffs_8_address0 sc_out sc_lv 8 signal 19 } 
	{ filterCoeffs_8_ce0 sc_out sc_logic 1 signal 19 } 
	{ filterCoeffs_8_q0 sc_in sc_lv 32 signal 19 } 
	{ acc_out sc_out sc_lv 32 signal 20 } 
	{ acc_out_ap_vld sc_out sc_logic 1 outvld 20 } 
	{ grp_fu_371_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_371_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_371_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_371_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_420_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_420_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_420_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_420_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_734_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_734_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_734_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_734_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_738_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_738_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_738_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_738_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_425_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_425_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_425_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_425_p_ce sc_out sc_logic 1 signal -1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "m_axi_gmem0_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "AWVALID" }} , 
 	{ "name": "m_axi_gmem0_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "AWREADY" }} , 
 	{ "name": "m_axi_gmem0_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem0", "role": "AWADDR" }} , 
 	{ "name": "m_axi_gmem0_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "AWID" }} , 
 	{ "name": "m_axi_gmem0_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem0", "role": "AWLEN" }} , 
 	{ "name": "m_axi_gmem0_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem0", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_gmem0_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem0", "role": "AWBURST" }} , 
 	{ "name": "m_axi_gmem0_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem0", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_gmem0_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_gmem0_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem0", "role": "AWPROT" }} , 
 	{ "name": "m_axi_gmem0_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "AWQOS" }} , 
 	{ "name": "m_axi_gmem0_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "AWREGION" }} , 
 	{ "name": "m_axi_gmem0_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "AWUSER" }} , 
 	{ "name": "m_axi_gmem0_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "WVALID" }} , 
 	{ "name": "m_axi_gmem0_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "WREADY" }} , 
 	{ "name": "m_axi_gmem0_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem0", "role": "WDATA" }} , 
 	{ "name": "m_axi_gmem0_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "WSTRB" }} , 
 	{ "name": "m_axi_gmem0_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "WLAST" }} , 
 	{ "name": "m_axi_gmem0_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "WID" }} , 
 	{ "name": "m_axi_gmem0_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "WUSER" }} , 
 	{ "name": "m_axi_gmem0_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "ARVALID" }} , 
 	{ "name": "m_axi_gmem0_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "ARREADY" }} , 
 	{ "name": "m_axi_gmem0_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem0", "role": "ARADDR" }} , 
 	{ "name": "m_axi_gmem0_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "ARID" }} , 
 	{ "name": "m_axi_gmem0_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem0", "role": "ARLEN" }} , 
 	{ "name": "m_axi_gmem0_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem0", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_gmem0_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem0", "role": "ARBURST" }} , 
 	{ "name": "m_axi_gmem0_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem0", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_gmem0_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_gmem0_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem0", "role": "ARPROT" }} , 
 	{ "name": "m_axi_gmem0_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "ARQOS" }} , 
 	{ "name": "m_axi_gmem0_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "ARREGION" }} , 
 	{ "name": "m_axi_gmem0_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "ARUSER" }} , 
 	{ "name": "m_axi_gmem0_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "RVALID" }} , 
 	{ "name": "m_axi_gmem0_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "RREADY" }} , 
 	{ "name": "m_axi_gmem0_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem0", "role": "RDATA" }} , 
 	{ "name": "m_axi_gmem0_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "RLAST" }} , 
 	{ "name": "m_axi_gmem0_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "RID" }} , 
 	{ "name": "m_axi_gmem0_RFIFONUM", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "gmem0", "role": "RFIFONUM" }} , 
 	{ "name": "m_axi_gmem0_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "RUSER" }} , 
 	{ "name": "m_axi_gmem0_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem0", "role": "RRESP" }} , 
 	{ "name": "m_axi_gmem0_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "BVALID" }} , 
 	{ "name": "m_axi_gmem0_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "BREADY" }} , 
 	{ "name": "m_axi_gmem0_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem0", "role": "BRESP" }} , 
 	{ "name": "m_axi_gmem0_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "BID" }} , 
 	{ "name": "m_axi_gmem0_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "BUSER" }} , 
 	{ "name": "inputWidth", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "inputWidth", "role": "default" }} , 
 	{ "name": "inputHeight", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "inputHeight", "role": "default" }} , 
 	{ "name": "y", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y", "role": "default" }} , 
 	{ "name": "mul_ln13_1", "direction": "in", "datatype": "sc_lv", "bitwidth":96, "type": "signal", "bundle":{"name": "mul_ln13_1", "role": "default" }} , 
 	{ "name": "convWidth", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "convWidth", "role": "default" }} , 
 	{ "name": "mul_ln13", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "mul_ln13", "role": "default" }} , 
 	{ "name": "p_cast10_mid1117", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_cast10_mid1117", "role": "default" }} , 
 	{ "name": "icmp_ln44_1", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "icmp_ln44_1", "role": "default" }} , 
 	{ "name": "zext_ln60", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "zext_ln60", "role": "default" }} , 
 	{ "name": "input_r", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "input_r", "role": "default" }} , 
 	{ "name": "filterCoeffs_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filterCoeffs", "role": "address0" }} , 
 	{ "name": "filterCoeffs_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "filterCoeffs", "role": "ce0" }} , 
 	{ "name": "filterCoeffs_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "filterCoeffs", "role": "q0" }} , 
 	{ "name": "filterCoeffs_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filterCoeffs_1", "role": "address0" }} , 
 	{ "name": "filterCoeffs_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "filterCoeffs_1", "role": "ce0" }} , 
 	{ "name": "filterCoeffs_1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "filterCoeffs_1", "role": "q0" }} , 
 	{ "name": "filterCoeffs_2_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filterCoeffs_2", "role": "address0" }} , 
 	{ "name": "filterCoeffs_2_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "filterCoeffs_2", "role": "ce0" }} , 
 	{ "name": "filterCoeffs_2_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "filterCoeffs_2", "role": "q0" }} , 
 	{ "name": "filterCoeffs_3_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filterCoeffs_3", "role": "address0" }} , 
 	{ "name": "filterCoeffs_3_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "filterCoeffs_3", "role": "ce0" }} , 
 	{ "name": "filterCoeffs_3_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "filterCoeffs_3", "role": "q0" }} , 
 	{ "name": "filterCoeffs_4_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filterCoeffs_4", "role": "address0" }} , 
 	{ "name": "filterCoeffs_4_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "filterCoeffs_4", "role": "ce0" }} , 
 	{ "name": "filterCoeffs_4_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "filterCoeffs_4", "role": "q0" }} , 
 	{ "name": "filterCoeffs_5_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filterCoeffs_5", "role": "address0" }} , 
 	{ "name": "filterCoeffs_5_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "filterCoeffs_5", "role": "ce0" }} , 
 	{ "name": "filterCoeffs_5_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "filterCoeffs_5", "role": "q0" }} , 
 	{ "name": "filterCoeffs_6_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filterCoeffs_6", "role": "address0" }} , 
 	{ "name": "filterCoeffs_6_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "filterCoeffs_6", "role": "ce0" }} , 
 	{ "name": "filterCoeffs_6_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "filterCoeffs_6", "role": "q0" }} , 
 	{ "name": "filterCoeffs_7_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filterCoeffs_7", "role": "address0" }} , 
 	{ "name": "filterCoeffs_7_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "filterCoeffs_7", "role": "ce0" }} , 
 	{ "name": "filterCoeffs_7_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "filterCoeffs_7", "role": "q0" }} , 
 	{ "name": "filterCoeffs_8_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filterCoeffs_8", "role": "address0" }} , 
 	{ "name": "filterCoeffs_8_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "filterCoeffs_8", "role": "ce0" }} , 
 	{ "name": "filterCoeffs_8_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "filterCoeffs_8", "role": "q0" }} , 
 	{ "name": "acc_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "acc_out", "role": "default" }} , 
 	{ "name": "acc_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "acc_out", "role": "ap_vld" }} , 
 	{ "name": "grp_fu_371_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_371_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_371_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_371_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_371_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_371_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_371_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_371_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_420_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_420_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_420_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_420_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_420_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_420_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_420_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_420_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_734_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_734_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_734_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_734_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_734_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_734_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_734_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_734_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_738_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_738_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_738_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_738_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_738_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_738_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_738_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_738_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_425_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_425_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_425_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_425_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_425_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_425_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_425_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_425_p_ce", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5", "6", "7"],
		"CDFG" : "Conv2D_HW_Pipeline_loop_acc_x",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "gmem0", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "gmem0_blk_n_R", "Type" : "RtlSignal"},
					{"Name" : "gmem0_blk_n_AR", "Type" : "RtlSignal"}]},
			{"Name" : "inputWidth", "Type" : "None", "Direction" : "I"},
			{"Name" : "inputHeight", "Type" : "None", "Direction" : "I"},
			{"Name" : "y", "Type" : "None", "Direction" : "I"},
			{"Name" : "mul_ln13_1", "Type" : "None", "Direction" : "I"},
			{"Name" : "convWidth", "Type" : "None", "Direction" : "I"},
			{"Name" : "mul_ln13", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_cast10_mid1117", "Type" : "None", "Direction" : "I"},
			{"Name" : "icmp_ln44_1", "Type" : "None", "Direction" : "I"},
			{"Name" : "zext_ln60", "Type" : "None", "Direction" : "I"},
			{"Name" : "input_r", "Type" : "None", "Direction" : "I"},
			{"Name" : "filterCoeffs", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "filterCoeffs_1", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "filterCoeffs_2", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "filterCoeffs_3", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "filterCoeffs_4", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "filterCoeffs_5", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "filterCoeffs_6", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "filterCoeffs_7", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "filterCoeffs_8", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "acc_out", "Type" : "Vld", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "loop_acc_channels_loop_acc_y_loop_acc_x", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter1", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter18", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter18", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_32s_32s_32_2_1_U28", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mux_32_32_1_1_U29", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mux_32_32_1_1_U30", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mux_32_32_1_1_U31", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mux_32_32_1_1_U32", "Parent" : "0"},
	{"ID" : "6", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_32s_32s_52_2_1_U33", "Parent" : "0"},
	{"ID" : "7", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flow_control_loop_pipe_sequential_init_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	Conv2D_HW_Pipeline_loop_acc_x {
		gmem0 {Type I LastRead 15 FirstWrite -1}
		inputWidth {Type I LastRead 0 FirstWrite -1}
		inputHeight {Type I LastRead 0 FirstWrite -1}
		y {Type I LastRead 0 FirstWrite -1}
		mul_ln13_1 {Type I LastRead 0 FirstWrite -1}
		convWidth {Type I LastRead 0 FirstWrite -1}
		mul_ln13 {Type I LastRead 0 FirstWrite -1}
		p_cast10_mid1117 {Type I LastRead 0 FirstWrite -1}
		icmp_ln44_1 {Type I LastRead 0 FirstWrite -1}
		zext_ln60 {Type I LastRead 0 FirstWrite -1}
		input_r {Type I LastRead 0 FirstWrite -1}
		filterCoeffs {Type I LastRead 14 FirstWrite -1}
		filterCoeffs_1 {Type I LastRead 14 FirstWrite -1}
		filterCoeffs_2 {Type I LastRead 14 FirstWrite -1}
		filterCoeffs_3 {Type I LastRead 14 FirstWrite -1}
		filterCoeffs_4 {Type I LastRead 14 FirstWrite -1}
		filterCoeffs_5 {Type I LastRead 14 FirstWrite -1}
		filterCoeffs_6 {Type I LastRead 14 FirstWrite -1}
		filterCoeffs_7 {Type I LastRead 14 FirstWrite -1}
		filterCoeffs_8 {Type I LastRead 14 FirstWrite -1}
		acc_out {Type O LastRead -1 FirstWrite 17}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "-1", "Max" : "-1"}
	, {"Name" : "Interval", "Min" : "-1", "Max" : "-1"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	 { m_axi {  { m_axi_gmem0_AWVALID VALID 1 1 }  { m_axi_gmem0_AWREADY READY 0 1 }  { m_axi_gmem0_AWADDR ADDR 1 64 }  { m_axi_gmem0_AWID ID 1 1 }  { m_axi_gmem0_AWLEN SIZE 1 32 }  { m_axi_gmem0_AWSIZE BURST 1 3 }  { m_axi_gmem0_AWBURST LOCK 1 2 }  { m_axi_gmem0_AWLOCK CACHE 1 2 }  { m_axi_gmem0_AWCACHE PROT 1 4 }  { m_axi_gmem0_AWPROT QOS 1 3 }  { m_axi_gmem0_AWQOS REGION 1 4 }  { m_axi_gmem0_AWREGION USER 1 4 }  { m_axi_gmem0_AWUSER DATA 1 1 }  { m_axi_gmem0_WVALID VALID 1 1 }  { m_axi_gmem0_WREADY READY 0 1 }  { m_axi_gmem0_WDATA FIFONUM 1 32 }  { m_axi_gmem0_WSTRB STRB 1 4 }  { m_axi_gmem0_WLAST LAST 1 1 }  { m_axi_gmem0_WID ID 1 1 }  { m_axi_gmem0_WUSER DATA 1 1 }  { m_axi_gmem0_ARVALID VALID 1 1 }  { m_axi_gmem0_ARREADY READY 0 1 }  { m_axi_gmem0_ARADDR ADDR 1 64 }  { m_axi_gmem0_ARID ID 1 1 }  { m_axi_gmem0_ARLEN SIZE 1 32 }  { m_axi_gmem0_ARSIZE BURST 1 3 }  { m_axi_gmem0_ARBURST LOCK 1 2 }  { m_axi_gmem0_ARLOCK CACHE 1 2 }  { m_axi_gmem0_ARCACHE PROT 1 4 }  { m_axi_gmem0_ARPROT QOS 1 3 }  { m_axi_gmem0_ARQOS REGION 1 4 }  { m_axi_gmem0_ARREGION USER 1 4 }  { m_axi_gmem0_ARUSER DATA 1 1 }  { m_axi_gmem0_RVALID VALID 0 1 }  { m_axi_gmem0_RREADY READY 1 1 }  { m_axi_gmem0_RDATA FIFONUM 0 32 }  { m_axi_gmem0_RLAST LAST 0 1 }  { m_axi_gmem0_RID ID 0 1 }  { m_axi_gmem0_RFIFONUM LEN 0 9 }  { m_axi_gmem0_RUSER DATA 0 1 }  { m_axi_gmem0_RRESP RESP 0 2 }  { m_axi_gmem0_BVALID VALID 0 1 }  { m_axi_gmem0_BREADY READY 1 1 }  { m_axi_gmem0_BRESP RESP 0 2 }  { m_axi_gmem0_BID ID 0 1 }  { m_axi_gmem0_BUSER DATA 0 1 } } }
	inputWidth { ap_none {  { inputWidth in_data 0 32 } } }
	inputHeight { ap_none {  { inputHeight in_data 0 32 } } }
	y { ap_none {  { y in_data 0 32 } } }
	mul_ln13_1 { ap_none {  { mul_ln13_1 in_data 0 96 } } }
	convWidth { ap_none {  { convWidth in_data 0 32 } } }
	mul_ln13 { ap_none {  { mul_ln13 in_data 0 64 } } }
	p_cast10_mid1117 { ap_none {  { p_cast10_mid1117 in_data 0 32 } } }
	icmp_ln44_1 { ap_none {  { icmp_ln44_1 in_data 0 1 } } }
	zext_ln60 { ap_none {  { zext_ln60 in_data 0 32 } } }
	input_r { ap_none {  { input_r in_data 0 64 } } }
	filterCoeffs { ap_memory {  { filterCoeffs_address0 mem_address 1 8 }  { filterCoeffs_ce0 mem_ce 1 1 }  { filterCoeffs_q0 in_data 0 32 } } }
	filterCoeffs_1 { ap_memory {  { filterCoeffs_1_address0 mem_address 1 8 }  { filterCoeffs_1_ce0 mem_ce 1 1 }  { filterCoeffs_1_q0 in_data 0 32 } } }
	filterCoeffs_2 { ap_memory {  { filterCoeffs_2_address0 mem_address 1 8 }  { filterCoeffs_2_ce0 mem_ce 1 1 }  { filterCoeffs_2_q0 in_data 0 32 } } }
	filterCoeffs_3 { ap_memory {  { filterCoeffs_3_address0 mem_address 1 8 }  { filterCoeffs_3_ce0 mem_ce 1 1 }  { filterCoeffs_3_q0 in_data 0 32 } } }
	filterCoeffs_4 { ap_memory {  { filterCoeffs_4_address0 mem_address 1 8 }  { filterCoeffs_4_ce0 mem_ce 1 1 }  { filterCoeffs_4_q0 in_data 0 32 } } }
	filterCoeffs_5 { ap_memory {  { filterCoeffs_5_address0 mem_address 1 8 }  { filterCoeffs_5_ce0 mem_ce 1 1 }  { filterCoeffs_5_q0 in_data 0 32 } } }
	filterCoeffs_6 { ap_memory {  { filterCoeffs_6_address0 mem_address 1 8 }  { filterCoeffs_6_ce0 mem_ce 1 1 }  { filterCoeffs_6_q0 in_data 0 32 } } }
	filterCoeffs_7 { ap_memory {  { filterCoeffs_7_address0 mem_address 1 8 }  { filterCoeffs_7_ce0 mem_ce 1 1 }  { filterCoeffs_7_q0 in_data 0 32 } } }
	filterCoeffs_8 { ap_memory {  { filterCoeffs_8_address0 mem_address 1 8 }  { filterCoeffs_8_ce0 mem_ce 1 1 }  { filterCoeffs_8_q0 in_data 0 32 } } }
	acc_out { ap_vld {  { acc_out out_data 1 32 }  { acc_out_ap_vld out_vld 1 1 } } }
}
