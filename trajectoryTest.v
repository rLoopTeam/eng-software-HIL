`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:31:59 03/26/2016
// Design Name:   topFile
// Module Name:   C:/Users/David/Documents/GitHub/eng-software-HIL/trajectoryTest.v
// Project Name:  rPod_HIL
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: topFile
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module trajectoryTest;

	// Inputs
	reg CLK_50MHZ;

	// Outputs
	wire [0:7] LED;
	wire LCD_E;
	wire LCD_RS;
	wire LCD_RW;
	wire [11:8] SF_D;

	// Instantiate the Unit Under Test (UUT)
	topFile uut (
		.CLK_50MHZ(CLK_50MHZ), 
		.LED(LED), 
		.LCD_E(LCD_E), 
		.LCD_RS(LCD_RS), 
		.LCD_RW(LCD_RW), 
		.SF_D(SF_D)
	);

	initial begin
		// Initialize Inputs
		CLK_50MHZ = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

