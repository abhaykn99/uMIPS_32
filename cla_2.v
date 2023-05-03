`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2023 01:26:41
// Design Name: 
// Module Name: cla_2
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


module cla_2 (a, b, c_in, g_out, p_out, s); // 2-bit carry lookahead adder
input [1:0] a, b; // inputs: a, b
input c_in; // input: carry_in
output g_out, p_out; // outputs: g, p
output [1:0] s; // output: sum
wire [1:0] g, p; // internal wires
wire c_out; // internal wire
// add (a, b, c, g, p, s); // generates g,p,s
add a0 (a[0], b[0], c_in, g[0], p[0], s[0]); // add on bit 0
add a1 (a[1], b[1], c_out, g[1], p[1], s[1]); // add on bit 1
// gp (g, p, c_in, g_out, p_out, c_out); // higher level g,p
gp gp0 (g, p, c_in, g_out, p_out, c_out); // higher level g,p
endmodule
