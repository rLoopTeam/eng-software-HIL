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
    input wire [63:0] accel,
    input wire clk_200khz,
    output reg [63:0] position,
    output reg [63:0] velocity
    );
	
		always @(posedge clk_200khz)
		begin
			velocity <= velocity + accel;
			position <= position + velocity;
		end

endmodule
