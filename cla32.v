`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2023 18:53:58
// Design Name: 
// Module Name: cla32
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
module cla32 (a,b,ci,s); // 32-bit carry lookahead adder, no g, p outputs
input [31:0] a, b; // inputs: a, b
input ci; // input: carry_in
output [31:0] s; // output: sum
wire g_out, p_out; // internal wires
cla_32 cla (a, b, ci, g_out, p_out, s); // use cla_32 module
endmodule
