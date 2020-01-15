/************************************** 
Verilog code for various speed counter 
**************************************/

`timescale 1ns / 1ns // `timescale time_unit/time_precision
  
module Lab5_2(SW, KEY, CLOCK_50, HEX0);
	input [9:0] SW; 
	input [3:0] KEY;
	input CLOCK_50;
	output [6:0] HEX0;	
	
	wire enable;
	wire [3:0] HEX_IN;
	wire [26:0] Counter_NUM;
	
	SelectSpeed s0 (
		.Select(SW[1:0]),
		.Counter_NUM(Counter_NUM)
		);
	
	RateDivider r0 (
		.clock(CLOCK_50), 
		.reset(KEY[0]),
		.Counter_NUM(Counter_NUM), 
		.enable(enable)
		);
		
	FourBitCounter c0(
		.enable(enable), 
		.clock(CLOCK_50), 
		.reset(KEY[0]), 
		.HEX_IN(HEX_IN)
		);
	
	hexdecoder hex0(
		.c0(HEX_IN[0]),
		.c1(HEX_IN[1]),
		.c2(HEX_IN[2]),
		.c3(HEX_IN[3]),
		.eqn0(HEX0[0]),
		.eqn1(HEX0[1]),
		.eqn2(HEX0[2]),
		.eqn3(HEX0[3]),
		.eqn4(HEX0[4]),
		.eqn5(HEX0[5]),
		.eqn6(HEX0[6])
		);
				
		
endmodule

// selects desired speed and sends to RateDivider
module SelectSpeed(input [1:0] Select, output reg [26:0] Counter_NUM);
	
	always@(*)
		begin
			case(Select[1:0])
				2'b00: Counter_NUM = 27'd0; //Full speed enable
				2'b01: Counter_NUM = 27'd24999999; //2Hz speed enable
				2'b10: Counter_NUM = 27'd49999999; //1Hz speed enable
				2'b11: Counter_NUM = 27'd99999999; //0.5Hz speed enable
			endcase
		end

endmodule


// counts down based on what speed is chosen and when done enables FourBitCounter
module RateDivider(input clock, reset, input [26:0] Counter_NUM, output reg enable);	
	
	reg [26:0] Counter;
	always@(posedge clock)
		begin
			if (reset==1'b0)
				Counter <= 27'd0;
			else if	(Counter==Counter_NUM)
				begin
					enable = 1'b1;
					Counter <= 27'd0;
				end
			else
				begin
					enable = 1'b0;
					Counter <= Counter + 1;
				end
		end
			
	
endmodule


// waits for counter from RateDivider to finish and then increments hex display value
module FourBitCounter(input enable, clock, reset, output reg [3:0] HEX_IN);
	
	always@(posedge clock)
		begin
			if(reset==1'b0)
				HEX_IN <= 4'd0;
			else if(enable==1'b1)
				HEX_IN <= HEX_IN + 1;
		end
	
endmodule


// converts 4 bits to hex
module hexdecoder(input c0, c1, c2, c3, 
						output eqn0, eqn1, eqn2, eqn3, eqn4, eqn5, eqn6);
	
	assign eqn0 = !((c3|c2|c1|~c0) & (c3|~c2|c1|c0) & (~c3|c2|~c1|~c0) & (~c3|~c2|c1|~c0));
	assign eqn1 = !((c3|~c2|c1|~c0) & (c3|~c2|~c1|c0) & (~c3|c2|~c1|~c0) & (~c3|~c2|c1|c0) & (~c3|~c2|~c1|c0) & (~c3|~c2|~c1|~c0));
	assign eqn2 = !((c3|c2|~c1|c0) & (~c3|~c2|c1|c0) & (~c3|~c2|~c1|c0) & (~c3|~c2|~c1|~c0)); 
	assign eqn3 = !((c3|c2|c1|~c0) & (c3|~c2|c1|c0) & (c3|~c2|~c1|~c0) & (~c3|c2|c1|~c0) & (~c3|c2|~c1|c0) & (~c3|~c2|~c1|~c0));
	assign eqn4 = !((c3|c2|c1|~c0) & (c3|c2|~c1|~c0) & (c3|~c2|c1|c0) & (c3|~c2|c1|~c0) & (c3|~c2|~c1|~c0) & (~c3|c2|c1|~c0));
	assign eqn5 = !((c3|c2|c1|~c0) & (c3|c2|~c1|c0) & (c3|c2|~c1|~c0) & (c3|~c2|~c1|~c0) & (~c3|~c2|c1|~c0));
	assign eqn6 = !((c3|c2|c1|c0) & (c3|c2|c1|~c0) & (c3|~c2|~c1|~c0) & (~c3|~c2|c1|c0));
	
endmodule 


