`timescale 1ns / 1ps

module LCDI(clk, DIN,W,WADD, dataout, control);
         input clk;
         input [7:0] DIN;
         output [3:0] dataout;
         output [2:0] control;
	 input [4:0] WADD;
	 input W;
	 
	 reg [2:0] sel;
	 reg [25:0] delay;  
	 reg [5:0] state;
	 reg [3:0] dataout;
	 reg [2:0] control; // [E,D/C' , R/W'] 
	 reg [7:0] DR;
	 reg [4:0] add;
	 reg [7:0] datain;
	 reg R;
	 initial state=0;
	 reg [7:0]LCDRAM[0:31];

	always@(posedge clk)
		if(W)LCDRAM[WADD]<= DIN;

	always@(R,add)
		if(R)datain=LCDRAM[add];
		else datain=0;
	 
	 always @ (posedge clk)
	 begin
	 case(state)
	 //Power-On Initialization
	 0:begin delay <= 750_000; state<= 1;control[2:1] <= 0; control[0] <= 0;   end //wait 15 ms
	 1:begin 
	   if(delay==0)begin state <= 2; delay<=12; dataout<= 4'h3; control<=3'h4; end
		else delay <= delay -1; 
		end
	 2:begin if(delay==0)begin delay <= 205_000; state<= 3;control <= 0; end
	   else delay <= delay -1 ; 
		end
	 3:begin 
	   if(delay==0)begin state <= 4; delay<=12; dataout<= 4'h3; control<=3'h4; end
		else delay <= delay -1; 
		end
	 4:begin if(delay==0)begin delay <= 5_000; state<= 5;control <= 0; end
	   else delay <= delay -1 ; 
		end
	 5:begin 
	   if(delay==0)begin state <= 6; delay<=12; dataout<= 4'h3; control<=3'h4; end
		else delay <= delay -1; 
		end
	 6:begin if(delay==0)begin delay <= 2_000; state<= 7;control <= 0; end
	   else delay <= delay -1 ; 
		end
	 7:begin 
	   if(delay==0)begin state <= 8; delay<=12; dataout<= 4'h2; control<=3'h4; end
		else delay <= delay -1; 
		end
	 8:begin if(delay==0)begin delay <= 2_000; state<= 9;control <= 0; end  //waitfor 40 microsecond
	   else delay <= delay -1 ; 
		end
	 9:begin 
	   if(delay==0)begin state <= 10;sel <= 4; end
		else delay <= delay -1; 
		end
		
	// Display Configuration
	10:begin  
	   case(sel)
			 0: begin state <= 20; delay <= 82_000; end
			 1: begin state <= 11; DR <= 8'h01; end
			 2: begin state <= 11; DR <= 8'h0C; end
			 3: begin state <= 11; DR <= 8'h06; end
			 4: begin state <= 11; DR <= 8'h28; end 		 
	 default: state <= 0 ;
		endcase end
	11:begin state <= 12; control <= 0; dataout <= DR[7:4]; delay <= 2; sel <= sel -1; end
	12:begin if(delay==0)begin delay <= 12; state<= 13; control<=3'h4; end
	         else delay <= delay -1 ;end
	13:begin if(delay==0)begin delay <= 2; state<= 14; control<=0; end
	         else delay <= delay -1 ; end
	14:begin if(delay==0)begin delay <= 50 ; state<= 15; end
	         else delay <= delay -1 ; end
	15:begin if(delay==0)begin state <= 16; control <= 0; dataout <=DR[3:0]; delay <= 2;end
	         else delay <= delay -1 ; end
	16:begin if(delay==0)begin delay <= 12; state<= 17; control<=3'h4; end
	         else delay <= delay -1 ; end
	17:begin if(delay==0)begin delay <= 2; state<= 18; control<=0; end
	         else delay <= delay -1 ; end
	18:begin if(delay==0)begin delay <= 2_000 ; state<= 19; end
	         else delay <= delay -1 ; end
	19:begin if(delay==0)begin state<= 10; end
	         else delay <= delay -1 ; end
	20:begin if(delay==0)begin state<= 21; end
	   else delay <= delay -1 ; 
		end
	
	// Displaying
	21:begin state <= 22;add <= 0;R <=1; end
	// setting the line starting address
	22:begin state <= 23; if(add==0)DR <=8'h80;else DR<=8'hC0;  end//line 1=8'h80 , line 2=8'hC0
	23:begin state <= 24; control <= 0; dataout <= DR[7:4]; delay <= 2;end
	24:begin if(delay==0)begin delay <= 12; state<= 25; control<=3'h4; end
	         else delay <= delay -1 ;end
	25:begin if(delay==0)begin delay <= 2; state<= 26; control<=0; end
	         else delay <= delay -1 ; end
	26:begin if(delay==0)begin delay <= 50 ; state<= 27; end
	         else delay <= delay -1 ; end
	27:begin if(delay==0)begin state <= 28; control <= 0; dataout <=DR[3:0]; delay <= 2;end
	         else delay <= delay -1 ; end
	28:begin if(delay==0)begin delay <= 12; state<= 29; control<=3'h4; end
	         else delay <= delay -1 ; end
	29:begin if(delay==0)begin delay <= 2; state<= 30; control<=0; end
	         else delay <= delay -1 ; end
	30:begin if(delay==0)begin delay <= 2_000 ; state<= 31; end
	         else delay <= delay -1 ; end
	31:begin if(delay==0)begin state<= 32; end
	         else delay <= delay -1 ; end
	
	// Writing data to the display
	32:begin state <= 33; DR <= datain; add<= add+1; end
	33:begin state <= 34; control <= 3'b010; dataout <= DR[7:4]; delay <= 2; if(add==32)add<=0;end
	34:begin if(delay==0)begin delay <= 12; state<= 35; control<=3'b110; end
	         else delay <= delay -1 ;end
	35:begin if(delay==0)begin delay <= 2; state<= 36; control<=3'b010; end
	         else delay <= delay -1 ; end
	36:begin if(delay==0)begin delay <= 50 ; state<= 37;control<=0; end
	         else delay <= delay -1 ; end
	37:begin if(delay==0)begin state <= 38; control <= 3'b010; dataout <=DR[3:0]; delay <= 2;end
	         else delay <= delay -1 ; end
	38:begin if(delay==0)begin delay <= 12; state<= 39; control<=3'b110; end
	         else delay <= delay -1 ; end
	39:begin if(delay==0)begin delay <= 2; state<= 40; control<=3'b010; end
	         else delay <= delay -1 ; end
	40:begin if(delay==0)begin delay <= 2_000 ; state<= 41;control<=0; end
	         else delay <= delay -1 ; end
	41:begin if(delay==0)begin if(add==0 | add==16)state<= 42;else state<= 32;  end
	         else delay <= delay -1 ; end
	
	// delay between displaying
	42:begin if(add==0)begin state <= 43; delay <= 1_000_000;end else state<=22; end
        43:begin if(delay==0)begin state<= 22; end
	         else delay <= delay -1 ; end	
	default: state <= 0;
	endcase
	 end

   

endmodule

