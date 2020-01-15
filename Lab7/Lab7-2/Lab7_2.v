// SW[9:7] colour
// SW[6:0] input X,Y coordinate
// KEY[3] load X value
// KEY[1] plot square
// KEY[2] clears entire screen to black
// KEY[0] active-low synchronous reset

module Lab7_2 (
		CLOCK_50, SW, KEY,							
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,				   //	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						   //	VGA Blue[9:0]
		);
		
	input			CLOCK_50;
	input	[3:0]	KEY;					
	input [9:0] SW;
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	
	wire resetn;
	wire load;
	wire plot;
	wire black;
	assign resetn = KEY[0];
	assign load = ~KEY[3];
	assign plot = ~KEY[1];
	assign black = ~KEY[2];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire draw;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(draw),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn
	// for the VGA controller, in addition to any other functionality your design may require.
//	wire count_done, ld_x, ld_y, ld_c, draw, count_en;
//	
//	FSM control(
//			.clk(CLOCK_50),				// inputs
//			.resetn(resetn),
//			.load(load),
//			.plot(plot),
//			.black(black),
//			.count_done(count_done), 
//			.ld_x(ld_x), 					// outputs
//			.ld_y(ld_y), 
//		   .ld_c(ld_c),
//		   .draw(draw),	
//			.count_en(count_en));
//	
//	Datapath dp(
//			.clk(CLOCK_50),				// inputs
//			.resetn(resetn),
//			.data_in(SW[6:0]),
//			.colour_in(SW[9:7]),
//			.ld_x(ld_x), 
//			.ld_y(ld_y),
//			.ld_c(ld_c),
//			.draw(draw),	
//			.count_en(count_en),
//			.count_done(count_done),	// outputs
//			.writeEn(writeEn),
//			.x_out(x),
//			.y_out(y),
//			.colour_out(colour));

	connect u0 (
			.clk(CLOCK_50), 
			.resetn(resetn), 
			.load(load), 
			.plot(plot), 
			.black(black),
			.data_in(SW[6:0]),
			.colour_in(SW[9:7]),
			.draw(draw),
			.x(x),
			.y(y),
			.colour(colour));



endmodule 


module connect (
	input clk, resetn, load, plot, black,
	input [6:0] data_in,
	input [2:0] colour_in,
	output draw,
	output [7:0] x,
	output [6:0] y,
	output [2:0] colour
	);
	
	wire count_done, clear_done, ld_x, ld_y, ld_c, count_en, clear_en;
	wire [3:0] counter;
	
	FSM control(
			.clk(clk),				// inputs
			.resetn(resetn),
			.load(load),
			.plot(plot),
			.black(black),
			.count_done(count_done), 
			.clear_done(clear_done),
			.ld_x(ld_x), 					// outputs
			.ld_y(ld_y), 
		   .ld_c(ld_c),
		   .draw(draw),	
			.count_en(count_en),
			.clear_en(clear_en));
	
	Datapath dp(
			.clk(clk),				// inputs
			.resetn(resetn),
			.data_in(data_in),
			.colour_in(colour_in),
			.ld_x(ld_x), 
			.ld_y(ld_y),
			.ld_c(ld_c),	
			.count_en(count_en),
			.clear_en(clear_en),
			.count_done(count_done),	// outputs
			.clear_done(clear_done),
			.x_out(x),
			.y_out(y),
			.colour_out(colour),
			.counter(counter));


endmodule 
