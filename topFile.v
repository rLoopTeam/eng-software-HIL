`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:46:42 03/26/2016 
// Design Name: 
// Module Name:    topFile 
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
module topFile(
    input wire CLK_50MHZ,
	 output wire [0:7] LED
    );
	
		reg [60:0] clockDiv = 32'd0;
		wire simClock;
		assign LED[0] = simClock;
		reg [6:0] dummyLED = 7'd0;
		assign LED[1:7] = dummyLED;
		

		
		simClockDiv clockDIVM(CLK_50Mhz,simClock);

endmodule
