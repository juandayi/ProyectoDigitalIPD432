// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Thu Apr  4 02:21:14 2019
// Host        : DESKTOP-U2FBRCJ running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {d:/Proyecto Final Digital/corefft UART Block RAM con FFT
//               UartTx/corefft.srcs/sources_1/ip/ila_1/ila_1_stub.v}
// Design      : ila_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2018.2" *)
module ila_1(clk, probe0, probe1, probe2, probe3, probe4)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[4:0],probe1[4:0],probe2[31:0],probe3[31:0],probe4[0:0]" */;
  input clk;
  input [4:0]probe0;
  input [4:0]probe1;
  input [31:0]probe2;
  input [31:0]probe3;
  input [0:0]probe4;
endmodule
