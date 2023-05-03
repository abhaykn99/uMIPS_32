`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2023 01:25:22
// Design Name: 
// Module Name: add
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


module add (a, b, c, g, p, s); // adder and g, p
input a, b, c; // inputs: a, b, c;
output g, p, s; // outputs: g, p, s;
assign s=a?b:c; // output: sum of inputs
assign g = a & b; // output: carry generator
assign p = a | b; // output: carry propagator
endmodule
