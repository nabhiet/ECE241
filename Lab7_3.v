// SW[9:7] colour
// KEY[1] plot square
// KEY[0] active-low synchronous reset

module Lab7_3 (
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
	wire plot;
	assign resetn = KEY[0];
	assign plot = ~KEY[1];
	
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

	connect u0 (
			.clk(CLOCK_50), 
			.resetn(resetn), 
			.plot(plot), 
			.colour_in(SW[9:7]),
			.draw(draw),
			.x(x),
			.y(y),
			.colour(colour));

endmodule 


module connect (
	input clk, resetn, plot,
	input [2:0] colour_in,
	output draw,
	output [7:0] x,
	output [6:0] y,
	output [2:0] colour
	);
	
	wire draw_done, delay_done, clear_done, ld_c; 
	wire start_x, end_x, start_y, end_y, x_curr, y_curr;
	wire draw_en, delay_en, clear_en;
	wire update_x, update_y, flip_x, flip_y;
	wire [19:0] delay_count;
	wire [3:0] frame_count;
	
	FSM control(
			.clk(clk),				// inputs
			.resetn(resetn),
			.plot(plot),
			.draw_done(draw_done), 
			.delay_done(delay_done), 
			.clear_done(clear_done),
		   .ld_c(ld_c),
			.start_x(start_x),
			.end_x(end_x),
			.x_curr(x_curr),
			.y_curr(y_curr),
			.start_y(start_y),
			.end_y(end_y),
		   .draw(draw),        // outputs	
			.draw_en(draw_en),
			.delay_en(delay_en),
			.clear_en(clear_en),
			.update_x(update_x), 
			.update_y(update_y), 
			.flip_x(flip_x), 
			.flip_y(flip_y));
	
	Datapath dp(
			.clk(clk),				// inputs
			.resetn(resetn),
			.colour_in(colour_in),
			.ld_c(ld_c),	
			.draw_en(draw_en),
			.delay_en(delay_en),
			.clear_en(clear_en),
			.update_x(update_x), 
			.update_y(update_y), 
			.flip_x(flip_x), 
			.flip_y(flip_y),		
			.draw_done(draw_done),  // outputs
			.delay_done(delay_done), 
			.clear_done(clear_done),
			.start_x(start_x),
			.end_x(end_x),
			.start_y(start_y),
			.end_y(end_y),
			.x_out(x),
			.y_out(y),
			.colour_out(colour),
			.delay_count(delay_count),
			.frame_count(frame_count),
			.x_curr(x_curr),
			.y_curr(y_curr));


endmodule 