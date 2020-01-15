`timescale 1ns / 1ns // `timescale time_unit/time_precision

module Lab3_3(SW, KEY, LEDR ,HEX0, HEX2, HEX1, HEX3, HEX4, HEX5);
	input [9:0] SW;
	input [2:0] KEY;
	output [7:0] LEDR; 
	output [6:0] HEX0; 
	output [6:0] HEX2; 
	output [6:0] HEX1; 
	output [6:0] HEX3;
	output [6:0] HEX4; 
	output [6:0] HEX5;
	
	wire c1, c2, c3, s0, s1, s2, s3, cout;
	
	// set HEX1 to 0
	assign HEX1[0] = 0;
	assign HEX1[1] = 0;
	assign HEX1[2] = 0;
	assign HEX1[3] = 0;
	assign HEX1[4] = 0;
	assign HEX1[5] = 0;
	assign HEX1[6] = 1;
	
	// set HEX3 to 0
	assign HEX3[0] = 0;
	assign HEX3[1] = 0;
	assign HEX3[2] = 0;
	assign HEX3[3] = 0;
	assign HEX3[4] = 0;
	assign HEX3[5] = 0;
	assign HEX3[6] = 1;
	
	// set HEX0 to B
	hexdecoder u0(
		.c0(SW[0]),
		.c1(SW[1]),
		.c2(SW[2]),
		.c3(SW[3]),
		.eqn0(HEX0[0]),
		.eqn1(HEX0[1]),
		.eqn2(HEX0[2]),
		.eqn3(HEX0[3]),
		.eqn4(HEX0[4]),
		.eqn5(HEX0[5]),
		.eqn6(HEX0[6])
		);
	
	// set HEX2 to A
	hexdecoder u1(
		.c0(SW[4]),
		.c1(SW[5]),
		.c2(SW[6]),
		.c3(SW[7]),
		.eqn0(HEX2[0]),
		.eqn1(HEX2[1]),
		.eqn2(HEX2[2]),
		.eqn3(HEX2[3]),
		.eqn4(HEX2[4]),
		.eqn5(HEX2[5]),
		.eqn6(HEX2[6])
		);
	
	// set HEX4 to last 4 bits of output
	hexdecoder u2(
		.c0(LEDR[0]),
		.c1(LEDR[1]),
		.c2(LEDR[2]),
		.c3(LEDR[3]),
		.eqn0(HEX4[0]),
		.eqn1(HEX4[1]),
		.eqn2(HEX4[2]),
		.eqn3(HEX4[3]),
		.eqn4(HEX4[4]),
		.eqn5(HEX4[5]),
		.eqn6(HEX4[6])
		);
	
	// set HEX5 to first 4 bits of output
	hexdecoder u3(
		.c0(LEDR[4]),
		.c1(LEDR[5]),
		.c2(LEDR[6]),
		.c3(LEDR[7]),
		.eqn0(HEX5[0]),
		.eqn1(HEX5[1]),
		.eqn2(HEX5[2]),
		.eqn3(HEX5[3]),
		.eqn4(HEX5[4]),
		.eqn5(HEX5[5]),
		.eqn6(HEX5[6])
		);
	
	fulladder b0 (
		.A(SW[4]), 
		.B(SW[0]), 
		.cin(1'b0), 
		.S(s0),
		.cout(c1)
		);
	
	fulladder b1 (
		.A(SW[5]), 
		.B(SW[1]), 
		.cin(c1), 
		.S(s1),
		.cout(c2)
		);
	
	fulladder b2 (
		.A(SW[6]), 
		.B(SW[2]), 
		.cin(c2), 
		.S(s2),
		.cout(c3)
		);
		
	fulladder b3 (
		.A(SW[7]), 
		.B(SW[3]), 
		.cin(c3), 
		.S(s3),
		.cout(cout)
		);
	
	
	reg [7:0] LEDR;
	
	always @(*)
	begin
		case(~(KEY[2:0]))
			3'b000: LEDR = {3'b000, cout, s3, s2, s1, s0}; 
			3'b001: LEDR = SW[7:4]+SW[3:0]; 
			3'b010: LEDR = {~(SW[7:4]&SW[3:0]), SW[7:4]~^SW[3:0]};
			3'b011: if (!SW[7:4]==0 | !SW[3:0]==0) LEDR = 8'b00001111;
					  else LEDR = 8'b00000000; 
			3'b100: if ((SW[7:4]==4'b0001 | SW[7:4]==4'b0010 | SW[7:4]==4'b0100 | SW[7:4]==4'b1000) & 
						   (SW[3:0]==4'b0011 | SW[3:0]==4'b0110 |SW[3:0]==4'b1100  | SW[3:0]==4'b1010 | SW[3:0]==4'b0101 | SW[3:0]==4'b1001)) 
					  LEDR = 8'b01110000; 
					  else LEDR = 8'b00000000; 
			3'b101: LEDR = {SW[7:4], ~SW[3:0]};  
			default: LEDR = 8'b00000000;
		endcase
	end
	
endmodule

// full adder module
module fulladder(A, B, cin, S, cout);
	input A, B, cin;
	output S, cout;
	
	assign S = A^B^cin;
   assign cout = A & B | B & cin | A & cin;
	
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



