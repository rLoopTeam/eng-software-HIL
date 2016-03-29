`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:56:46 03/28/2016 
// Design Name: 
// Module Name:    reflectSensors 
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


module reflectSensors(
    input [63:0] position,
    input clk,
    output reg reflectF,
    output reg reflectM,
    output reg reflectR
    );
	 
	reg [63:0] FIRST_STRIPE = 64'd15240000000;
	reg [63:0] ONE_HUNDRED_FEET = 64'd30480000000;
	reg [63:0] MIDDLE_SENSOR = 64'd914400000;
	reg [63:0] REAR_SENSOR = 64'd1828800000;
	reg [63:0] FOUR_INCHES = 64'd101600000;
	 
	 reg [64:0] tempPosition = 0;
	 
	 reg [7:0] divideState = 0;
	 reg [63:0] frontPos = 64'd0;
	 reg [63:0] middlePos = 64'd0;
	 reg [63:0] rearPos = 64'd0;

	always @(posedge clk)
	begin
		case(divideState)
			0: begin frontPos <= position; middlePos <= position - MIDDLE_SENSOR; rearPos <= position - REAR_SENSOR; divideState<=divideState+1; end
			1: begin
				if(frontPos >= ONE_HUNDRED_FEET)
					frontPos <= frontPos - ONE_HUNDRED_FEET;
					
				if(middlePos >= ONE_HUNDRED_FEET)
					middlePos <= middlePos - ONE_HUNDRED_FEET;
					
				if(rearPos >= ONE_HUNDRED_FEET)
					rearPos <= rearPos - ONE_HUNDRED_FEET;
					
				if(frontPos < ONE_HUNDRED_FEET && middlePos < ONE_HUNDRED_FEET && rearPos < ONE_HUNDRED_FEET)
					divideState <= divideState + 1;
				end
			2: begin
				if(frontPos < FOUR_INCHES)
					reflectF <= 1;
				else
					reflectF <= 0;
					
				if(middlePos < FOUR_INCHES)
					reflectM <= 1;
				else
					reflectM <= 0;
					
				if(rearPos < FOUR_INCHES)
					reflectR <= 1;
				else
					reflectR <= 0;
					
				divideState <= 0;
				end
		endcase
	end
		
		
endmodule
