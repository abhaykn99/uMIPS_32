`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2023 01:28:34
// Design Name: 
// Module Name: cla_8
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
module cla_8 (a,b,c_in,g_out,p_out,s); // 8-bit carry lookahead adder
input [7:0] a, b; // inputs: a, b
input c_in; // input: carry_in
output g_out, p_out; // outputs: g, p
output [7:0] s; // output: sum
wire [1:0] g, p; // internal wires
wire c_out; // internal wire
cla_4 a0 (a[3:0],b[3:0],c_in, g[0],p[0],s[3:0]); // add on bits 0-3
cla_4 a1 (a[7:4],b[7:4],c_out,g[1],p[1],s[7:4]); // add on bits 4-7
gp gp0 (g,p,c_in, g_out,p_out,c_out); // higher level g,p
endmodule