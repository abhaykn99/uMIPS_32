`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2023 01:07:37
// Design Name: 
// Module Name: cla_32
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
module cla_32(a,b,c_in,g_out,p_out,s); // 32-bit carry lookahead adder
input [31:0] a, b; // inputs: a, b
input c_in; // input: carry_in
output g_out, p_out; // outputs: g, p
output [31:0] s; // output: sum
wire [1:0] g, p; // internal wires
wire c_out; // internal wire
cla_16 a0 (a[15:0], b[15:0], c_in, g[0],p[0],s[15:0]); // + bits 0-15
cla_16 a1 (a[31:16],b[31:16],c_out,g[1],p[1],s[31:16]); // + bits 16-31
gp gp0 (g,p,c_in,g_out,p_out,c_out);
endmodule
