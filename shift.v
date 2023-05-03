`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2023 01:17:25
// Design Name: 
// Module Name: shift
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

module shift (d,sa,right,arith,sh); // barrel shift, behavioral style
input [31:0] d; // input: 32-bit data to be shifted
input [4:0] sa; // input: shift amount, 5 bits
input right; // 1: shift right; 0: shift left
input arith; // 1: arithmetic shift; 0: logical
output [31:0] sh; // output: shifted result
reg [31:0] sh; // will be combinational
always @* begin // always block
if (!right) begin // if shift left
sh = d << sa; // shift left sa bits
end else if (!arith) begin // if shift right logical
sh = d >> sa; // shift right logical sa bits
end else begin // if shift right arithmetic
sh = $signed(d) >>> sa; // shift right arithmetic sa bits
end
end
endmodule
