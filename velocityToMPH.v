`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:07:15 03/28/2016 
// Design Name: 
// Module Name:    velocityToMPH 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module velocityToMPH(
    input [31:0] velocity,
    input clk,
    output reg  [31:0] mph
    );
	
	 
	 wire rfd;
	 reg lastRfd = 0;
	 wire [31:0]quotient;
	 
	 divideVelToMPH velToMPH (
	.clk(clk), // input clk
	.rfd(rfd), // output rfd
	.dividend(velocity), // input [31 : 0] dividend
	.divisor(19'd447039), // input [18 : 0] divisor
	.quotient(quotient), // output [31 : 0] quotient
	.fractional()); // output [18 : 0] fractional
	 
	 always @(posedge clk)
	 begin
		lastRfd <= rfd;
		if(rfd == 1'b0 && lastRfd == 1'b1) begin
			mph[31:0] <= quotient[31:0];
		end
	 end


endmodule
