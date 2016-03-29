`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:04:55 03/26/2016 
// Design Name: 
// Module Name:    simClockDiv 
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
module simClockDiv(
    input clk_50Mhz,
    output reg clk_100khz = 1,
	 output reg clk_1khz = 1
    );

	reg [7:0] counter1 = 8'd0;
	reg [15:0] counter2 = 16'd0;
	always @(posedge clk_50Mhz)
	begin
		counter1 <= counter1 + 1;
		if(counter1 ==250) begin //efectively divide by 500
			counter1 <= 1;
			clk_100khz <= ~clk_100khz; 
		end
		
		counter2 <= counter2 + 1;
		if(counter2 ==25000) begin //efectively divide by 50000
			counter2 <= 1;
			clk_1khz <= ~clk_1khz; 
		end
	end

endmodule
