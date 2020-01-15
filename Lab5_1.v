/******************************** 
Verilog code for 8-bit counter 
********************************/

`timescale 1ns / 1ns // `timescale time_unit/time_precision

module Lab5_1(SW, KEY, LEDR, HEX0, HEX1);
	input [9:0] SW;
	input [3:0] KEY; 
	output [7:0] LEDR; 
	output [6:0] HEX0;
	output [6:0] HEX1;
	
	wire t1, t2, t3, t4, t5, t6, t7;
	
	assign t1 = SW[1] & LEDR[0];
	assign t2 = (SW[1] & LEDR[0]) & LEDR[1];
	assign t3 = ((SW[1] & LEDR[0]) & LEDR[1]) & LEDR[2];
	assign t4 = (((SW[1] & LEDR[0]) & LEDR[1]) & LEDR[2]) & LEDR[3];
	assign t5 = ((((SW[1] & LEDR[0]) & LEDR[1]) & LEDR[2]) & LEDR[3]) & LEDR[4];
	assign t6 = (((((SW[1] & LEDR[0]) & LEDR[1]) & LEDR[2]) & LEDR[3]) & LEDR[4]) & LEDR[5];
	assign t7 = ((((((SW[1] & LEDR[0]) & LEDR[1]) & LEDR[2]) & LEDR[3]) & LEDR[4]) & LEDR[5]) & LEDR[6];
	
	TFlipFlop u0 (
		.T(SW[1]), // Enable
		.clock(~KEY[0]), 
		.clear_b(SW[0]), 
		.Q(LEDR[0])
		);
	
	TFlipFlop u1 (
		.T(t1), 
	   .clock(~KEY[0]), 
		.clear_b(SW[0]), 
		.Q(LEDR[1])
		);
	
	TFlipFlop u2 (
		.T(t2), 
      .clock(~KEY[0]),
		.clear_b(SW[0]), 
		.Q(LEDR[2])
		);
	
	TFlipFlop u3 (
		.T(t3), 
	   .clock(~KEY[0]), 
		.clear_b(SW[0]), 
		.Q(LEDR[3])
		);
	
	TFlipFlop u4 (
		.T(t4), 
		.clock(~KEY[0]), 
		.clear_b(SW[0]), 
		.Q(LEDR[4])
		);
	
	TFlipFlop u5 (
		.T(t5), 
		.clock(~KEY[0]), 
		.clear_b(SW[0]), 
		.Q(LEDR[5])
		);
	
	TFlipFlop u6 (
		.T(t6), 
		.clock(~KEY[0]), 
		.clear_b(SW[0]), 
		.Q(LEDR[6])
		);
	
	TFlipFlop u7 (
		.T(t7), 
		.clock(~KEY[0]), 
		.clear_b(SW[0]), 
		.Q(LEDR[7])
		);

	hexdecoder hex0(
		.c0(LEDR[0]),
		.c1(LEDR[1]),
		.c2(LEDR[2]),
		.c3(LEDR[3]),
		.eqn0(HEX0[0]),
		.eqn1(HEX0[1]),
		.eqn2(HEX0[2]),
		.eqn3(HEX0[3]),
		.eqn4(HEX0[4]),
		.eqn5(HEX0[5]),
		.eqn6(HEX0[6])
		);
		
	hexdecoder hex1(
		.c0(LEDR[4]),
		.c1(LEDR[5]),
		.c2(LEDR[6]),
		.c3(LEDR[7]),
		.eqn0(HEX1[0]),
		.eqn1(HEX1[1]),
		.eqn2(HEX1[2]),
		.eqn3(HEX1[3]),
		.eqn4(HEX1[4]),
		.eqn5(HEX1[5]),
		.eqn6(HEX1[6])
		);
		
		
endmodule


// Toggles state when T is high
module  TFlipFlop(T, clock, clear_b, Q);
	input T, clock, clear_b;
	output Q;
	
	reg Q;
	always@(posedge clock, negedge clear_b)
	begin
		if(clear_b==1'b0) // active-low asynchronous clear
			Q <= 1'b0;
		else 
			Q <= Q ^ T;
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
