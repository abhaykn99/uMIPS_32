`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2023 01:27:27
// Design Name: 
// Module Name: cla_4
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


module cla_4 (a,b,c_in,g_out,p_out,s); // 4-bit carry lookahead adder
input [3:0] a, b; // inputs: a, b
input c_in; // input: carry_in
output g_out, p_out; // outputs: g, p
output [3:0] s; // output: sum
wire [1:0] g, p; // internal wires
wire c_out; // internal wire
cla_2 a0 (a[1:0],b[1:0],c_in, g[0],p[0],s[1:0]); // add on bits 0,1
cla_2 a1 (a[3:2],b[3:2],c_out,g[1],p[1],s[3:2]); // add on bits 2,3
gp gp0 (g,p,c_in, g_out,p_out,c_out); // higher level g,p
endmodule
