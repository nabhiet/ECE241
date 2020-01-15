/**************************************** 
Verilog code for 8-bit rotating register 
****************************************/

`timescale 1ns / 1ns // `timescale time_unit/time_precision

module Lab4_3(SW, KEY, LEDR);
	input [9:0] SW;
	input [3:0] KEY; 
	output [7:0] LEDR; 

	wire [7:0] Q;
	
	reg out;
	always @(*)
	begin
		case (KEY[3]) // KEY[3]=ASRight
			1'b0: out = Q[0];
			1'b1: out = Q[7];
		endcase
	end		

	SubCircuit b0(
		.right(Q[7]),
		.left(Q[1]),
		.LoadLeft(KEY[2]), // KEY[2]=RotateRight
		.D(SW[0]),
		.loadn(KEY[1]), // KEY[1]=ParallelLoadn
		.clock(~KEY[0]),
		.reset(SW[9]),
		.Q(Q[0])
	);

	SubCircuit b1(
		.right(Q[0]),
		.left(Q[2]),
		.LoadLeft(KEY[2]), // KEY[2]=RotateRight
		.D(SW[1]),
		.loadn(KEY[1]), // KEY[1]=ParallelLoadn
		.clock(~KEY[0]),
		.reset(SW[9]),
		.Q(Q[1])
	);

	SubCircuit b2(
		.right(Q[1]),
		.left(Q[3]),
		.LoadLeft(KEY[2]), // KEY[2]=RotateRight
		.D(SW[2]),
		.loadn(KEY[1]), // KEY[1]=ParallelLoadn
		.clock(~KEY[0]),
		.reset(SW[9]),
		.Q(Q[2])
	);

	SubCircuit b3(
		.right(Q[2]),
		.left(Q[4]),
		.LoadLeft(KEY[2]), // KEY[2]=RotateRight
		.D(SW[3]),
		.loadn(KEY[1]), // KEY[1]=ParallelLoadn
		.clock(~KEY[0]),
		.reset(SW[9]),
		.Q(Q[3])
	);

	SubCircuit b4(
		.right(Q[3]),
		.left(Q[5]),
		.LoadLeft(KEY[2]), // KEY[2]=RotateRight
		.D(SW[4]),
		.loadn(KEY[1]), // KEY[1]=ParallelLoadn
		.clock(~KEY[0]),
		.reset(SW[9]),
		.Q(Q[4])
	);

	SubCircuit b5(
		.right(Q[4]),
		.left(Q[6]),
		.LoadLeft(KEY[2]), // KEY[2]=RotateRight
		.D(SW[5]),
		.loadn(KEY[1]), // KEY[1]=ParallelLoadn
		.clock(~KEY[0]),
		.reset(SW[9]),
		.Q(Q[5])
	);

	SubCircuit b6(
		.right(Q[5]),
		.left(Q[7]),
		.LoadLeft(KEY[2]), // KEY[2]=RotateRight
		.D(SW[6]),
		.loadn(KEY[1]), // KEY[1]=ParallelLoadn
		.clock(~KEY[0]),
		.reset(SW[9]),
		.Q(Q[6])
	);

	SubCircuit b7(
		.right(Q[6]),
		.left(out),
		.LoadLeft(KEY[2]), // KEY[2]=RotateRight
		.D(SW[7]),
		.loadn(KEY[1]), // KEY[1]=ParallelLoadn
		.clock(~KEY[0]),
		.reset(SW[9]),
		.Q(Q[7])
	);
	
	assign LEDR = Q;

endmodule

module SubCircuit(right, left, LoadLeft, D, loadn, clock, reset, Q);
	input right, left, LoadLeft, D, loadn, clock, reset; 
	output Q;
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
		.Q(Q)
	);

endmodule

// registers 1 bit
module  DFlipFlop(D, clock, reset, Q);
	input D, clock, reset;
	output Q;
	
	reg Q;
	always@(posedge clock)
	begin
		if(reset==1'b1) // active high synchronous reset
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

endmodule
