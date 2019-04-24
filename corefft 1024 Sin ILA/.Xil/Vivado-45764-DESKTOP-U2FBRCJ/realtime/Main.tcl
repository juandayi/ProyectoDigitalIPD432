# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    rt::HARTNDb_resetJobStats
    rt::HARTNDb_resetSystemStats
    rt::HARTNDb_startSystemStats
    rt::HARTNDb_startJobStats
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    rt::set_parameter enableParallelHelperSpawn true
    set ::env(RT_TMP) "D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/.Xil/Vivado-45764-DESKTOP-U2FBRCJ/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    set rt::partid xc7a100tcsg324-1

    set rt::multiChipSynthesisFlow false
    source $::env(SYNTH_COMMON)/common_vhdl.tcl
    set rt::defaultWorkLibName xil_defaultlib

    set rt::useElabCache false
    if {$rt::useElabCache == false} {
      rt::read_verilog -sv {
      {D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/corefft.srcs/sources_1/new/FFT.sv}
      {D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/corefft.srcs/sources_1/new/LoadFFT.sv}
      {D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/corefft.srcs/sources_1/imports/new/Save.sv}
      {D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/corefft.srcs/sources_1/imports/new/Sender.sv}
      {D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/corefft.srcs/sources_1/new/UnloadFFT.sv}
      {D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/corefft.srcs/sources_1/imports/new/uart_baud_tick_gen.sv}
      {D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/corefft.srcs/sources_1/imports/new/uart_rx.sv}
      {D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/corefft.srcs/sources_1/imports/new/uart_rx_driver.sv}
      {D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/corefft.srcs/sources_1/imports/new/uart_tx.sv}
      {D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/corefft.srcs/sources_1/imports/new/uart_tx_driver.sv}
      {D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/corefft.srcs/sources_1/imports/new/Main.sv}
      C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv
      C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv
    }
      rt::read_verilog {
      {D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/.Xil/Vivado-45764-DESKTOP-U2FBRCJ/realtime/clk_wiz_0_stub.v}
      {D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/.Xil/Vivado-45764-DESKTOP-U2FBRCJ/realtime/xfft_0_stub.v}
      {D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/.Xil/Vivado-45764-DESKTOP-U2FBRCJ/realtime/blk_mem_gen_0_stub.v}
      {D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/.Xil/Vivado-45764-DESKTOP-U2FBRCJ/realtime/ila_0_stub.v}
      {D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/.Xil/Vivado-45764-DESKTOP-U2FBRCJ/realtime/ila_1_stub.v}
      {D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/corefft.srcs/sources_1/imports/User_Custom_UartPort_1.0/data_sync.v}
    }
      rt::read_vhdl -lib xpm C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification false
    set rt::top Main
    rt::set_parameter enableIncremental true
    set rt::reportTiming false
    rt::set_parameter elaborateOnly true
    rt::set_parameter elaborateRtl true
    rt::set_parameter eliminateRedundantBitOperator false
    rt::set_parameter elaborateRtlOnlyFlow true
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter merge_flipflops true
    rt::set_parameter srlDepthThreshold 3
    rt::set_parameter rstSrlDepthThreshold 4
# MODE: 
    rt::set_parameter webTalkPath {}
    rt::set_parameter enableSplitFlowPath "D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx/.Xil/Vivado-45764-DESKTOP-U2FBRCJ/"
    set ok_to_delete_rt_tmp true 
    if { [rt::get_parameter parallelDebug] } { 
       set ok_to_delete_rt_tmp false 
    } 
    if {$rt::useElabCache == false} {
        set oldMIITMVal [rt::get_parameter maxInputIncreaseToMerge]; rt::set_parameter maxInputIncreaseToMerge 1000
        set oldCDPCRL [rt::get_parameter createDfgPartConstrRecurLimit]; rt::set_parameter createDfgPartConstrRecurLimit 1
        $rt::db readXRFFile
      rt::run_rtlelab -module $rt::top
        rt::set_parameter maxInputIncreaseToMerge $oldMIITMVal
        rt::set_parameter createDfgPartConstrRecurLimit $oldCDPCRL
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    rt::HARTNDb_stopJobStats
    if { $rt::flowresult == 1 } { return -code error }


  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] } { 
     $rt::db killSynthHelper $hsKey
  } 
  rt::set_parameter helper_shm_key "" 
    if { [ info exists ::env(RT_TMP) ] } {
      if { [info exists ok_to_delete_rt_tmp] && $ok_to_delete_rt_tmp } { 
        file delete -force $::env(RT_TMP)
      }
    }

    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  $rt::db resetHdlParse
  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] } { 
     $rt::db killSynthHelper $hsKey
  } 
  source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  return -code "error" $rt::result
}
