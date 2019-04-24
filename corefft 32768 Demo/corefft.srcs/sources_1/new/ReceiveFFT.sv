`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.02.2019 17:35:15
// Design Name: 
// Module Name: ReceiveFFT
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ReceiveFFT #(parameter N = 16, IW = 32)(
    input clkin,
    input [31:0] out_fft,
    output [IW-1:0] array_out_fft [N - 1:0]
    );
endmodule
