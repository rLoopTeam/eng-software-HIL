`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:02:31 03/26/2016 
// Design Name: 
// Module Name:    SimplePodModel 
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
module SimplePodModel(
    input wire [31:0] accel,
	 input wire running,
    input wire clk_100khz,
	 input wire clk_1khz,
	 input wire clk_50Mhz,
    output reg [63:0] position=64'd15240000000, //Starts at 50 '
    output reg [31:0] velocity=0
    );

		wire [31:0] posStep ;
		
		
		//Could redo the core with more clock cycles, currently using single
		divide100 velDivider (
					.clk(clk_50Mhz), // input clk
					.rfd(), // output rfd
					.dividend(velocity), // input [31 : 0] dividend
					.divisor(32'd100), // input [31 : 0] divisor
					.quotient(posStep), // output [31 : 0] quotient
					.fractional()); // output [31 : 0] fractional

	
		always @(posedge clk_100khz)
		begin
			if(running)
				position <= position[63:0] + {32'd0,posStep[31:0]};
		end
		
		always @(posedge clk_1khz)
		begin
			if(running)
				velocity <= velocity + accel;
		end

endmodule
