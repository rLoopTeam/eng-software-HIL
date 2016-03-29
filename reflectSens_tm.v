`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:26:19 03/28/2016
// Design Name:   reflectSensors
// Module Name:   C:/Users/David/Documents/GitHub/eng-software-HIL/reflectSens_tm.v
// Project Name:  rPod_HIL
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: reflectSensors
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module reflectSens_tm;

	// Inputs
	reg [63:0] position = 64'd15240000000;
	reg clk;

	// Outputs
	wire reflectF;
	wire reflectM;
	wire reflectR;

	// Instantiate the Unit Under Test (UUT)
	reflectSensors uut (
		.position(position), 
		.clk(clk), 
		.reflectF(reflectF), 
		.reflectM(reflectM), 
		.reflectR(reflectR)
	);
	
	always
		#10 clk = ~clk;
	
	always
		#40 position = position + 2540000.000;

	initial begin
		// Initialize Inputs
		position = 64'd15240000000;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

