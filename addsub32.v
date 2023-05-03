`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2023 00:59:02
// Design Name: 
// Module Name: addsub32
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


module addsub32(a,b,sub,s); // 32-bit adder/subtracter
input [31:0] a, b; // inputs: a, b
input sub; // sub == 1:s=a-b
output [31:0] s; // output sum s
wire [31:0] b_xor =b^{32{sub}};
cla32 as32(a,b_xor,sub,s); 
endmodule