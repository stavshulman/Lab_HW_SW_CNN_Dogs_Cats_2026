set SynModuleInfo {
  {SRCNAME Conv2D_HW_Pipeline_loop_load_coef_x MODELNAME Conv2D_HW_Pipeline_loop_load_coef_x RTLNAME Conv2D_HW_Conv2D_HW_Pipeline_loop_load_coef_x
    SUBMODULES {
      {MODELNAME Conv2D_HW_flow_control_loop_pipe_sequential_init RTLNAME Conv2D_HW_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME Conv2D_HW_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME Conv2D_HW_Pipeline_loop_acc_x MODELNAME Conv2D_HW_Pipeline_loop_acc_x RTLNAME Conv2D_HW_Conv2D_HW_Pipeline_loop_acc_x
    SUBMODULES {
      {MODELNAME Conv2D_HW_mux_32_32_1_1 RTLNAME Conv2D_HW_mux_32_32_1_1 BINDTYPE op TYPE mux IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME Conv2D_HW_mul_32s_32s_52_2_1 RTLNAME Conv2D_HW_mul_32s_32s_52_2_1 BINDTYPE op TYPE mul IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME Conv2D_HW MODELNAME Conv2D_HW RTLNAME Conv2D_HW IS_TOP 1
    SUBMODULES {
      {MODELNAME Conv2D_HW_mul_32ns_32ns_64_2_1 RTLNAME Conv2D_HW_mul_32ns_32ns_64_2_1 BINDTYPE op TYPE mul IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME Conv2D_HW_mul_32ns_64ns_96_5_1 RTLNAME Conv2D_HW_mul_32ns_64ns_96_5_1 BINDTYPE op TYPE mul IMPL auto LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME Conv2D_HW_mul_32s_32s_32_2_1 RTLNAME Conv2D_HW_mul_32s_32s_32_2_1 BINDTYPE op TYPE mul IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME Conv2D_HW_filterCoeffs_RAM_AUTO_1R1W RTLNAME Conv2D_HW_filterCoeffs_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME Conv2D_HW_gmem0_m_axi RTLNAME Conv2D_HW_gmem0_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME Conv2D_HW_gmem1_m_axi RTLNAME Conv2D_HW_gmem1_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME Conv2D_HW_control_s_axi RTLNAME Conv2D_HW_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
