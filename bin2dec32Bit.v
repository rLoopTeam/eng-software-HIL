`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:45:17 03/26/2016 
// Design Name: 
// Module Name:    bin2dec32Bit 
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
module bin2dec64Bit(
    input [63:0] inputValue,
    input clk,
	 output reg [5:0] char14,
	 output reg [5:0] char13,
	 output reg [5:0] char12,
	 output reg [5:0] char11,
    output reg [5:0] char10,
    output reg [5:0] char9,
    output reg [5:0] char8,
    output reg [5:0] char7,
    output reg [5:0] char6,
    output reg [5:0] char5,
    output reg [5:0] char4,
    output reg [5:0] char3,
    output reg [5:0] char2,
    output reg [5:0] char1
    );
		
		reg[7:0]state = 0;
		
		reg [5:0] tempChar14;
		reg [5:0] tempChar13;
		reg [5:0] tempChar12;
		reg [5:0] tempChar11;
		reg [5:0] tempChar10;
		reg [5:0] tempChar9;
		reg [5:0] tempChar8;
		reg [5:0] tempChar7;
		reg [5:0] tempChar6;
		reg [5:0] tempChar5;
		reg [5:0] tempChar4;
		reg [5:0] tempChar3;
		reg [5:0] tempChar2;
		reg [5:0] tempChar1;
		
		reg [63:0] workingReg;
		
		always@(posedge clk)
		begin
			case(state)
				0:begin tempChar14 <= 0; tempChar13 <= 0; tempChar12 <= 0; tempChar11 <= 0; 
				tempChar10 <= 0; tempChar9 <= 0; tempChar8 <= 0; tempChar7 <= 0; tempChar6 <= 0; 
				tempChar5 <= 0; tempChar4 <= 0; tempChar3 <= 0; tempChar2 <= 0; tempChar1 <= 0; 
				workingReg <= inputValue;
				state<=1;
				end
				1:begin
					if(workingReg >= 10000000000000) begin tempChar14 <= tempChar14 + 1; workingReg <= workingReg - 10000000000000; end
					else begin state <= state+1; end
				end
				2:begin
					if(workingReg >= 1000000000000) begin tempChar13 <= tempChar13 + 1; workingReg <= workingReg - 1000000000000; end
					else begin state <= state+1; end
				end
				3:begin
					if(workingReg >= 100000000000) begin tempChar12 <= tempChar12 + 1; workingReg <= workingReg - 100000000000; end
					else begin state <= state+1; end
				end
				4:begin
					if(workingReg >= 10000000000) begin tempChar11 <= tempChar11 + 1; workingReg <= workingReg - 10000000000; end
					else begin state <= state+1; end
				end
				5:begin
					if(workingReg >= 1000000000) begin tempChar10 <= tempChar10 + 1; workingReg <= workingReg - 1000000000; end
					else begin state <= state+1; end
				end
				6:begin
					if(workingReg >= 100000000) begin tempChar9 <= tempChar9 + 1; workingReg <= workingReg - 100000000; end
					else begin state <= state+1; end
				end
				7:begin
					if(workingReg >= 10000000) begin tempChar8 <= tempChar8 + 1; workingReg <= workingReg - 10000000; end
					else begin state <= state+1; end
				end
				8:begin
					if(workingReg >= 1000000) begin tempChar7 <= tempChar7 + 1; workingReg <= workingReg - 1000000; end
					else begin state <= state+1; end
				end
				9:begin
					if(workingReg >= 100000) begin tempChar6 <= tempChar6 + 1; workingReg <= workingReg - 100000; end
					else begin state <= state+1; end
				end
				10:begin
					if(workingReg >= 10000) begin tempChar5 <= tempChar5 + 1; workingReg <= workingReg - 10000; end
					else begin state <= state+1; end
				end
				11:begin
					if(workingReg >= 1000) begin tempChar4 <= tempChar4 + 1; workingReg <= workingReg - 1000; end
					else begin state <= state+1; end
				end
				12:begin
					if(workingReg >= 100) begin tempChar3 <= tempChar3 + 1; workingReg <= workingReg - 100; end
					else begin state <= state+1; end
				end
				13:begin
					if(workingReg >= 10) begin tempChar2 <= tempChar2 + 1; workingReg <= workingReg - 10; end
					else begin state <= state+1; end
				end
				14:begin
					if(workingReg >= 1) begin tempChar1 <= tempChar1 + 1; workingReg <= workingReg - 1; end
					else begin state <= state+1; end
				end
				15:begin
					char1 <= tempChar1+6'd48;
					char2 <= tempChar2+6'd48;
					char3 <= tempChar3+6'd48;
					char4 <= tempChar4+6'd48;
					char5 <= tempChar5+6'd48;
					char6 <= tempChar6+6'd48;
					char7 <= tempChar7+6'd48;
					char8 <= tempChar8+6'd48;
					char9 <= tempChar9+6'd48;
					char10 <= tempChar10+6'd48;
					char11 <= tempChar11+6'd48;
					char12 <= tempChar12+6'd48;
					char13 <= tempChar13+6'd48;
					char14 <= tempChar14+6'd48;
					state<=0;
					end
			endcase
					
		end

endmodule
