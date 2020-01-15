/************************************** 
Verilog code for Morse code encoder
**************************************/

`timescale 1ns / 1ns // `timescale time_unit/time_precision

module Lab5_3(input CLOCK_50, input[9:0] SW, input[3:0] KEY, output[9:0] LEDR);
	
	morseEncoder encoder(.rate(32'b00000010111110101111000001111111), .clock(CLOCK_50), .resetn(KEY[0]), .sel(SW[2:0]), .morse_out(LEDR[0]), .start(KEY[1]));
	
endmodule

module morseEncoder(input clock, resetn, start, input[31:0] rate, input[2:0] sel, output morse_out);
	wire[15:0] morseCode;
	wire rotate;
	wire[15:0] regOut;

	//morse LUT
	morseLUT mLut(.s(sel), .q(morseCode));
	
	//rate divider
	rateDivider32bit rateDiv(.s(rate), .enable(1'b1), .resetn(resetn), .clock(clock), .pulse(rotate));
	
	//shift register
	shift16bitRegister sreg(.data(morseCode), .aresetn(resetn), .parallelLoadn(start), .rotateLeft(rotate), .clock(clock), .reg_out(regOut));

	assign morse_out = regOut[15];
endmodule

//morse representation LUT
module morseLUT(input[2:0] s, output reg[15:0] q);
	always@(*)
		case(s)//16'b0000000000000000
			3'b000: q = {16'b1010000000000000};//i
			3'b001: q = {16'b1011101110111000};//j
			3'b010: q = {16'b1110101110000000};//k
			3'b011: q = {16'b1011101010000000};//l
			3'b100: q = {16'b1110111000000000};//m
			3'b101: q = {16'b1110111000000000};//n
			3'b110: q = {16'b1110111011100000};//o
			3'b111: q = {16'b1011101110100000};//p
		endcase
endmodule

//1hz: s=32'b00000010111110101111000001111111
//rate divider
module rateDivider32bit(input[31:0] s, input enable, resetn, clock, output pulse);
	reg[31:0] count;
	
	always @(posedge clock)
	begin
		if((resetn == 1'b0) | (count == 32'b0))
			count <= s;
		else if (enable == 1'b1)
			count <= count - 1;
	end
	
	assign pulse = (count == 32'b0) ? 1 : 0;
endmodule

//shift register
module shift16bitRegister(input[15:0] data, input aresetn, parallelLoadn, rotateLeft, clock, output[15:0] reg_out);

	// shift flip flop units [15:0]
	shiftFlipFlop u15(.shift(rotateLeft), .d(data[15]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[14]), .q(reg_out[15]));
	shiftFlipFlop u14(.shift(rotateLeft), .d(data[14]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[13]), .q(reg_out[14]));
	shiftFlipFlop u13(.shift(rotateLeft), .d(data[13]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[12]), .q(reg_out[13]));
	shiftFlipFlop u12(.shift(rotateLeft), .d(data[12]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[11]), .q(reg_out[12]));
	shiftFlipFlop u11(.shift(rotateLeft), .d(data[11]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[10]), .q(reg_out[11]));
	shiftFlipFlop u10(.shift(rotateLeft), .d(data[10]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[9]), .q(reg_out[10]));
	shiftFlipFlop u9(.shift(rotateLeft), .d(data[9]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[8]), .q(reg_out[9]));
	shiftFlipFlop u8(.shift(rotateLeft), .d(data[8]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[7]), .q(reg_out[8]));
	shiftFlipFlop u7(.shift(rotateLeft), .d(data[7]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[6]), .q(reg_out[7]));
	shiftFlipFlop u6(.shift(rotateLeft), .d(data[6]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[5]), .q(reg_out[6]));
	shiftFlipFlop u5(.shift(rotateLeft), .d(data[5]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[4]), .q(reg_out[5]));
	shiftFlipFlop u4(.shift(rotateLeft), .d(data[4]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[3]), .q(reg_out[4]));
	shiftFlipFlop u3(.shift(rotateLeft), .d(data[3]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[2]), .q(reg_out[3]));
	shiftFlipFlop u2(.shift(rotateLeft), .d(data[2]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[1]), .q(reg_out[2]));
	shiftFlipFlop u1(.shift(rotateLeft), .d(data[1]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[0]), .q(reg_out[1]));
	shiftFlipFlop u0(.shift(rotateLeft), .d(data[0]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(1'b0), .q(reg_out[0]));
endmodule

//shift flip flop
module shiftFlipFlop(input shift, d, loadn, clock, aresetn, right, output reg q);
	//load value into flip flop
	always @(posedge clock, negedge aresetn)
		if(aresetn == 1'b0)
			q <= 1'b0;
		else if (loadn == 1'b0)
			q <= d;
		else if (shift == 1'b1)
			q <= right;
endmodule 

/*
module Lab5_3(SW, KEY, CLOCK_50, LEDR);
	input [9:0] SW; 
	input [3:0] KEY;
	input CLOCK_50;
	output [7:0] LEDR;	
	
	wire [12:0] Code;
	wire enable;
	wire [12:0] morseOut;
	
	SelectMorseCode s0 (
		.Select(SW[2:0]),
		.Code(Code)
		);
	
	RateDivider r0 (
		.clock(CLOCK_50), 
		.reset(KEY[0]), 
		.enable(enable)
		);
		
	ShiftRegister reg0 (
		.D(Code), 
		.loadn(KEY[1]), 
		.clock(enable), 
		.reset(KEY[0]), 
		.Q(morseOut)
		);
		
	assign LEDR[0] = morseOut[0];
		
						
endmodule

// selects desired speed and sends to RateDivider
module SelectMorseCode(input [2:0] Select, output reg [12:0] Code);
	
	always@(*)
		begin
			case(Select[2:0])
				3'b000: Code = 13'b1010000000000; // letter I
				3'b001: Code = 13'b1011101110111; // letter J
				3'b010: Code = 13'b1110101110000; // letter K
				3'b011: Code = 13'b1011101010000; // letter L
				3'b100: Code = 13'b1110111000000; // letter M
				3'b101: Code = 13'b1110100000000; // letter N
				3'b110: Code = 13'b1110111011100; // letter O
				3'b111: Code = 13'b1011101110100; // letter P
			endcase
		end

endmodule


// counts down based on what speed is chosen and when done enables register
module RateDivider(input clock, reset, output reg enable);	

	reg [26:0] Counter;
	always@(posedge clock)
		begin
			if (reset==1'b0)
				Counter <= 27'd0;
			else if	(Counter==27'd24999999)
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


module ShiftRegister(input [12:0] D, loadn, clock, reset, output [12:0] Q);		

	SubCircuit b0(
		.right(Q[12]),
		.left(Q[1]),
		.LoadLeft(1'b1), 
		.LSRight(1'b0),
		.D(D[0]),
		.loadn(loadn), 
		.clock(clock),
		.reset(reset),
		.Q(Q[0])
	);
	
	SubCircuit b1(
		.right(Q[0]),
		.left(Q[2]),
		.LoadLeft(1'b1), 
		.LSRight(1'b0),
		.D(D[1]),
		.loadn(loadn), 
		.clock(clock),
		.reset(reset),
		.Q(Q[1])
	);
	
	SubCircuit b2(
		.right(Q[1]),
		.left(Q[3]),
		.LoadLeft(1'b1), 
		.LSRight(1'b0),
		.D(D[2]),
		.loadn(loadn), 
		.clock(clock),
		.reset(reset),
		.Q(Q[2])
	);
	
	SubCircuit b3(
		.right(Q[2]),
		.left(Q[4]),
		.LoadLeft(1'b1), 
		.LSRight(1'b0),
		.D(D[3]),
		.loadn(loadn), 
		.clock(clock),
		.reset(reset),
		.Q(Q[3])
	);
	
	SubCircuit b4(
		.right(Q[3]),
		.left(Q[5]),
		.LoadLeft(1'b1), 
		.LSRight(1'b0),
		.D(D[4]),
		.loadn(loadn), 
		.clock(clock),
		.reset(reset),
		.Q(Q[4])
	);
	
	SubCircuit b5(
		.right(Q[4]),
		.left(Q[6]),
		.LoadLeft(1'b1), 
		.LSRight(1'b0),
		.D(D[5]),
		.loadn(loadn), 
		.clock(clock),
		.reset(reset),
		.Q(Q[5])
	);
	
	SubCircuit b6(
		.right(Q[5]),
		.left(Q[7]),
		.LoadLeft(1'b1), 
		.LSRight(1'b0),
		.D(D[6]),
		.loadn(loadn), 
		.clock(clock),
		.reset(reset),
		.Q(Q[6])
	);
	
	SubCircuit b7(
		.right(Q[6]),
		.left(Q[8]),
		.LoadLeft(1'b1), 
		.LSRight(1'b0),
		.D(D[7]),
		.loadn(loadn), 
		.clock(clock),
		.reset(reset),
		.Q(Q[7])
	);
	
	SubCircuit b8(
		.right(Q[7]),
		.left(Q[9]),
		.LoadLeft(1'b1), 
		.LSRight(1'b0),
		.D(D[8]),
		.loadn(loadn), 
		.clock(clock),
		.reset(reset),
		.Q(Q[8])
	);
	
	SubCircuit b9(
		.right(Q[8]),
		.left(Q[10]),
		.LoadLeft(1'b1), 
		.LSRight(1'b0),
		.D(D[9]),
		.loadn(loadn), 
		.clock(clock),
		.reset(reset),
		.Q(Q[9])
	);
	
	SubCircuit b10(
		.right(Q[9]),
		.left(Q[11]),
		.LoadLeft(1'b1), 
		.LSRight(1'b0),
		.D(D[10]),
		.loadn(loadn), 
		.clock(clock),
		.reset(reset),
		.Q(Q[10])
	);
	
	SubCircuit b11(
		.right(Q[10]),
		.left(Q[12]),
		.LoadLeft(1'b1), 
		.LSRight(1'b0),
		.D(D[11]),
		.loadn(loadn), 
		.clock(clock),
		.reset(reset),
		.Q(Q[11])
	);
	
	SubCircuit b12(
		.right(Q[11]),
		.left(Q[0]),
		.LoadLeft(1'b1), 
		.LSRight(1'b1),
		.D(D[12]),
		.loadn(loadn), 
		.clock(clock),
		.reset(reset),
		.Q(Q[12])
	);

endmodule

module SubCircuit(input right, left, LoadLeft, LSRight, D, loadn, clock, reset, output Q);
	wire w1,  w2;

	mux2to1 u0(
		.x(right),
		.y(left),
		.s(LoadLeft),
		.m(w1)
	);

	mux2to1 u1(
		.x(D),
		.y(w1),
		.s(loadn),
		.m(w2)
	);

	DFlipFlop d0(
		.D(w2),
		.clock(clock),
		.reset(reset),
		.LoadLeft(LoadLeft),
		.LSRight(LSRight),
		.Q(Q)
	);

endmodule

// registers 1 bit
module  DFlipFlop(input D, clock, reset, LoadLeft, LSRight, output reg Q);
	
	always@(posedge clock, negedge reset)
	begin
		if(reset==1'b0) // active low asynchronous reset
			Q <= 1'b0;
		else if (LSRight==1'b1 && LoadLeft==1'b1)
			Q <= 1'b0;
		else 
			Q <= D;
	end

endmodule

// 2 to 1 multiplexer
module mux2to1(x, y, s, m);
	input x, y, s; 
	output m;
	
	assign m = s ? y : x;

endmodule */
