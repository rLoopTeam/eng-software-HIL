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
	 output wire [0:7] LED,
	 
		 //LCD I/O
	 output LCD_E,
	 output LCD_RS,
	 output LCD_RW,
	 output [11:8]SF_D,
	 
	 output wire reflectF,
	 output wire reflectM,
	 output wire reflectR
    );
	
		reg [60:0] clockDiv = 32'd0;
		wire simClock100khz;
		wire simClock1khz;
		assign LED[0] = simClock100khz;
		reg [6:0] dummyLED = 7'd0;
		reg running = 1;
		
		reg [63:0] currentTime = 0; //100k per second
		
		simClockDiv clockDIVM(CLK_50MHZ,simClock100khz,simClock1khz);
		
		reg [31:0]currentAccel = 64'd18000;
		
		always @(posedge simClock1khz) begin
			if(running)
				currentTime <= currentTime + 1;
			case(currentTime)
				6000:begin currentAccel <= 0; end
				8000:begin currentAccel <= -64'd9000; end
				20000:begin currentAccel <= 0; running <= 0; end
			endcase
		end
		
		wire [63:0] position;
		wire [31:0] velocity;
		
		SimplePodModel podModel(currentAccel, running, simClock100khz, simClock1khz, CLK_50MHZ, position, velocity);
		
		wire [31:0] mph;
		velocityToMPH vToMPH( velocity, CLK_50MHZ, mph);
		
		assign LED[1:7] = position[7:0];
		
		//Position is in nanometers
		//Position updates at 100khz, velocity and accleration at 1khz
		//So 1 g = 9.8 meters per second squared 98000200 + 
		
		wire [5:0] posC14;
		wire [5:0] posC13;
		wire [5:0] posC12;
		wire [5:0] posC11;
		wire [5:0] posC10;
		wire [5:0] posC9;
		wire [5:0] posC8;
		wire [5:0] posC7;
		wire [5:0] posC6;
		wire [5:0] posC5;
		wire [5:0] posC4;
		wire [5:0] posC3;
		wire [5:0] posC2;
		wire [5:0] posC1;
		bin2dec64Bit posBCD(position[63:0], CLK_50MHZ, posC14,  posC13,  posC12,  posC11, posC10,  posC9,  posC8,  posC7,  posC6,  posC5,  posC4,  posC3,  posC2, posC1);
		
		wire [5:0] timeC14;
		wire [5:0] timeC13;
		wire [5:0] timeC12;
		wire [5:0] timeC11;
		wire [5:0] timeC10;
		wire [5:0] timeC9;
		wire [5:0] timeC8;
		wire [5:0] timeC7;
		wire [5:0] timeC6;
		wire [5:0] timeC5;
		wire [5:0] timeC4;
		wire [5:0] timeC3;
		wire [5:0] timeC2;
		wire [5:0] timeC1;
		bin2dec64Bit timeBCD(mph[31:0], CLK_50MHZ, timeC14,  timeC13,  timeC12,  timeC11, timeC10,  timeC9,  timeC8,  timeC7,  timeC6,  timeC5,  timeC4,  timeC3,  timeC2, timeC1);
		
		reg [7:0]state=0;
		reg LCD_WE = 0;
		reg [7:0]LCD_WRITE_ADDR=0;
		reg [7:0]LCD_WRITE_DATA=0;
		always @(posedge CLK_50MHZ) begin
			case(state)
				0:begin LCD_WE <= 1;state<=state+1;end
				1:begin LCD_WRITE_ADDR<=0; LCD_WRITE_DATA<=posC13;state <= state + 1; end
				2:begin LCD_WRITE_ADDR<=1; LCD_WRITE_DATA<=posC12;state <= state + 1; end
				3:begin LCD_WRITE_ADDR<=2; LCD_WRITE_DATA<=posC11;state <= state + 1; end
				4:begin LCD_WRITE_ADDR<=3; LCD_WRITE_DATA<=posC10;state <= state + 1; end
				5:begin LCD_WRITE_ADDR<=4; LCD_WRITE_DATA<=8'd46;state <= state + 1; end
				6:begin LCD_WRITE_ADDR<=5; LCD_WRITE_DATA<=posC9;state <= state + 1; end
				7:begin LCD_WRITE_ADDR<=6; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				8:begin LCD_WRITE_ADDR<=7; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				9:begin LCD_WRITE_ADDR<=8; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				10:begin LCD_WRITE_ADDR<=9; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				11:begin LCD_WRITE_ADDR<=10; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				12:begin LCD_WRITE_ADDR<=11; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				13:begin LCD_WRITE_ADDR<=12; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				14:begin LCD_WRITE_ADDR<=13; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				15:begin LCD_WRITE_ADDR<=14; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				16:begin LCD_WRITE_ADDR<=15; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				
				17:begin LCD_WRITE_ADDR<=16; LCD_WRITE_DATA<=timeC3;state <= state + 1; end
				18:begin LCD_WRITE_ADDR<=17; LCD_WRITE_DATA<=timeC2;state <= state + 1; end
				19:begin LCD_WRITE_ADDR<=18; LCD_WRITE_DATA<=timeC1;state <= state + 1; end
				20:begin LCD_WRITE_ADDR<=19; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				21:begin LCD_WRITE_ADDR<=20; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				22:begin LCD_WRITE_ADDR<=21; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				23:begin LCD_WRITE_ADDR<=22; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				24:begin LCD_WRITE_ADDR<=23; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				25:begin LCD_WRITE_ADDR<=24; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				26:begin LCD_WRITE_ADDR<=25; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				27:begin LCD_WRITE_ADDR<=26; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				28:begin LCD_WRITE_ADDR<=27; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				29:begin LCD_WRITE_ADDR<=28; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				30:begin LCD_WRITE_ADDR<=29; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				31:begin LCD_WRITE_ADDR<=30; LCD_WRITE_DATA<=8'h20;state <= state + 1; end
				32:begin LCD_WRITE_ADDR<=31; LCD_WRITE_DATA<=8'h20;state <=0; end
			endcase
		end
    
		reflectSensors reflectSens(position, CLK_50MHZ, reflectF, reflectM, reflectR);

		LCDI lcd(CLK_50MHZ, LCD_WRITE_DATA,LCD_WE,LCD_WRITE_ADDR, SF_D, {LCD_E, LCD_RS, LCD_RW});
endmodule
