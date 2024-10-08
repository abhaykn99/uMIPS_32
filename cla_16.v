`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2023 01:29:34
// Design Name: 
// Module Name: cla_16
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


module cla_16 (a,b,c_in,g_out,p_out,s); // 16-bit carry lookahead adder
input [15:0] a, b; // inputs: a, b
input c_in; // input: carry_in
output g_out, p_out; // outputs: g, p
output [15:0] s; // output: sum
wire [1:0] g, p; // internal wires
wire c_out; // internal wire
cla_8 a0 (a[7:0], b[7:0], c_in, g[0],p[0],s[7:0]); // add on bits 0-7
cla_8 a1 (a[15:8],b[15:8],c_out,g[1],p[1],s[15:8]); // add on bits 8-15
gp gp0 (g,p,c_in, g_out,p_out,c_out); // higher level g,p
endmodule
