`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2023 18:50:41
// Design Name: 
// Module Name: dff32
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
module dff32 (d,clk,clrn,q); // dff (async) with write enable
input[31:0] d;
input  clk, clrn; // inputs d, clk, clrn (active low)
 // enable
output reg[31:0] q; // output q, register type
always @ (posedge clk or negedge clrn) begin // always block, "or"
if (!clrn) q <= 32'h00000000; // if clrn is asserted, reset dff
else  q <= d; // else if enabled store d to dff
end
endmodule
