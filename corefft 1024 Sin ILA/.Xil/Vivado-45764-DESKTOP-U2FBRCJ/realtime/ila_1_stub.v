// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2018.2" *)
module ila_1(clk, probe0, probe1, probe2, probe3, probe4);
  input clk;
  input [4:0]probe0;
  input [4:0]probe1;
  input [31:0]probe2;
  input [31:0]probe3;
  input [0:0]probe4;
endmodule
