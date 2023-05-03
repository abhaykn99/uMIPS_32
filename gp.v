`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2023 01:24:27
// Design Name: 
// Module Name: gp
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


module gp (g,p,c_in,g_out,p_out,c_out); // carry generator, carry propagator
input [1:0] g, p; // lower level 2-set of g, p
input c_in; // lower level carry_in
output g_out,p_out,c_out; // higher level g, p, carry_out
assign g_out = g[1] | p[1] & g[0]; // higher level carry generator
assign p_out = p[1] & p[0]; // higher level carry propagator
assign c_out = g[0] | p[0] & c_in; // higher level carry_out
endmodule