`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.02.2019 17:11:35
// Design Name: 
// Module Name: SaveFFT
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


module SaveFFT #(parameter N = 16, IW = 32)(
    input logic clkin,
    input logic unsigned [IW-1:0] dato_in_uart [N - 1:0],
    output logic [31:0] datoinFFT
    );
endmodule
