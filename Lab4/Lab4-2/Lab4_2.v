/************************************ 
ALU Verilog code with 8bit register 
************************************/

`timescale 1ns / 1ns // `timescale time_unit/time_precision

module Lab4_2(SW, KEY, LEDR ,HEX0, HEX2, HEX1, HEX3, HEX4, HEX5);
	input [9:0] SW;
	input [3:0] KEY;
	output [7:0] LEDR; 
	output [6:0] HEX0; 
	output [6:0] HEX2; 
	output [6:0] HEX1; 
	output [6:0] HEX3;
	output [6:0] HEX4; 
	output [6:0] HEX5;
	
	wire [7:0] REGout;
	
	// set HEX1 to 0
	assign HEX1[0] = 0; assign HEX1[1] = 0; assign HEX1[2] = 0; assign HEX1[3] = 0;
	assign HEX1[4] = 0; assign HEX1[5] = 0; assign HEX1[6] = 1;
	
	// set HEX2 to 0
	assign HEX2[0] = 0; assign HEX2[1] = 0; assign HEX2[2] = 0; assign HEX2[3] = 0;
	assign HEX2[4] = 0; assign HEX2[5] = 0; assign HEX2[6] = 1;
	
	// set HEX3 to 0
	assign HEX3[0] = 0; assign HEX3[1] = 0; assign HEX3[2] = 0; assign HEX3[3] = 0;
	assign HEX3[4] = 0; assign HEX3[5] = 0; assign HEX3[6] = 1;
	
	// HEX0 displays value of data
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
		
		// HEX4 displays least significant 4 bits of output
	hexdecoder u2(
		.c0(REGout[0]),
		.c1(REGout[1]),
		.c2(REGout[2]),
		.c3(REGout[3]),
		.eqn0(HEX4[0]),
		.eqn1(HEX4[1]),
		.eqn2(HEX4[2]),
		.eqn3(HEX4[3]),
		.eqn4(HEX4[4]),
		.eqn5(HEX4[5]),
		.eqn6(HEX4[6])
		);
	
	// HEX5 displays most significant 4 bits of output
	hexdecoder u3(
		.c0(REGout[4]),
		.c1(REGout[5]),
		.c2(REGout[6]),
		.c3(REGout[7]),
		.eqn0(HEX5[0]),
		.eqn1(HEX5[1]),
		.eqn2(HEX5[2]),
		.eqn3(HEX5[3]),
		.eqn4(HEX5[4]),
		.eqn5(HEX5[5]),
		.eqn6(HEX5[6])
		);
	
	// display the output of the ALU onto LEDR
	ALU a0(
		.Data(SW[3:0]),
		.Select(~KEY[3:1]),
		.Clk(~KEY[0]),
		.Reset_b(SW[9]),
		.ALUout(LEDR[7:0]),
		.REGout(REGout[7:0])
		);
	
endmodule

// ALU with 8bit register
module ALU(Data, ,Select, Clk, Reset_b, ALUout, REGout);
	input [3:0] Data;
	input [2:0] Select;
	input Clk, Reset_b;
	output [7:0] ALUout;
	output [7:0] REGout;
	
	wire c1, c2, c3, s0, s1, s2, s3, cout;


	reg8 r0 (.d(ALUout[7:0]), .clk(Clk), .reset_b(Reset_b), .q(REGout[7:0]));
	
	fulladder b0 (.A(Data[0]), .B(REGout[0]), .cin(1'b0), .S(s0), .cout(c1));
	
	fulladder b1 (.A(Data[1]), .B(REGout[1]), .cin(c1), .S(s1), .cout(c2));
	
	fulladder b2 (.A(Data[2]), .B(REGout[2]), .cin(c2), .S(s2), .cout(c3));
		
	fulladder b3 (.A(Data[3]), .B(REGout[3]), .cin(c3), .S(s3), .cout(cout));
		
	
	reg [7:0] ALUout;
	
	always @(*)
	begin
		case(Select[2:0])
			3'b000: ALUout = {3'b000, cout, s3, s2, s1, s0}; 
			3'b001: ALUout = Data + REGout[3:0]; 
			3'b010: ALUout = {~(Data&REGout[3:0]), Data~^REGout[3:0]};
			3'b011: if(!Data==0 | !REGout[3:0]==0) ALUout = 8'b00001111;
					  else ALUout = 8'b00000000; 
			3'b100: if((Data==4'b0001 | Data==4'b0010 | Data==4'b0100 | Data==4'b1000) & 
						  (REGout[3:0]==4'b0011 | REGout[3:0]==4'b0110 | REGout[3:0]==4'b1100 | REGout[3:0]==4'b1010 | REGout[3:0]==4'b0101 | REGout[3:0]==4'b1001)) 
					  ALUout = 8'b11110000; 
					  else ALUout = 8'b00000000; 
			3'b101: ALUout = {Data, ~REGout[3:0]};  
			3'b110: ALUout = REGout; 
			default: ALUout = 8'b00000000;
		endcase
	end
	
	//wire [7:0] ALUtoREG8;
	//assign ALUtoREG8 = ALUout;

endmodule

// 8bit register
module reg8 (d, clk, reset_b, q);
	input [7:0] d;
	input clk, reset_b;
	output [7:0] q;
	
	reg [7:0] q;
	
	always@(posedge clk)
	begin
		if(reset_b==1'b0)
			q <= 8'b00000000;
		else 
			q <= d;
	end

endmodule 

// full adder
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



