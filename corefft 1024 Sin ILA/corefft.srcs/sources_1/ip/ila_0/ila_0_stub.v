// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Fri Apr 12 17:05:43 2019
// Host        : DESKTOP-U2FBRCJ running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {D:/Proyecto Final Digital/corefft UART Block RAM con FFT UartTx
//               1024/corefft.srcs/sources_1/ip/ila_0/ila_0_stub.v}
// Design      : ila_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2018.2" *)
module ila_0(clk, probe0, probe1, probe2, probe3, probe4, probe5, 
  probe6, probe7, probe8, probe9)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[0:0],probe1[0:0],probe2[15:0],probe3[0:0],probe4[0:0],probe5[31:0],probe6[0:0],probe7[31:0],probe8[0:0],probe9[0:0]" */;
  input clk;
  input [0:0]probe0;
  input [0:0]probe1;
  input [15:0]probe2;
  input [0:0]probe3;
  input [0:0]probe4;
  input [31:0]probe5;
  input [0:0]probe6;
  input [31:0]probe7;
  input [0:0]probe8;
  input [0:0]probe9;
endmodule
