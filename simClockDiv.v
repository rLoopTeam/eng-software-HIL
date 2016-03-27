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
    output clk_200khz
    );

	reg [7:0] counter = 8'b0000000;
	reg outputClk;
	assign clk_200khz = outputClk;
	always @(posedge clk_50Mhz)
	begin
		counter <= counter + 1;
		if(counter == 249) begin
			counter <= 0;
			outputClk <= ~outputClk; 
		end
	end

endmodule
