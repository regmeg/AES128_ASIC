`include "chip_defines.v"

//define interface module for chip_top, which connects testbench to the actual RTL module
interface chip_top_io(input logic clock);
	logic 												reset;
	logic [`SEED_KEY_WIDTH-1:0] 	key_in;
	logic 												key_in_vld;
	logic [`BLOCK_DATA_WIDTH-1:0] data_in;
	logic 												data_in_vld;
	logic [`sbox_w*`sbox_h*8-1:0] sbox_in;
	logic  												sbox_in_vld;

	logic 												 data_accept;
	logic [`BLOCK_DATA_WIDTH-1:0]  data_out;
	logic 												 data_out_vld;


	// create synchronous signals, which are driven and sampled on the clock cycles
	clocking cb @(posedge clock);
		default input #1 output #1; //sample and driving skew (offset).
	output reset;
	output key_in;
	output key_in_vld;
	output data_in;
	output data_in_vld;
	output sbox_in;
	output sbox_in_vld;

	input data_accept;
	input data_out;
	input data_out_vld;
	
	endclocking

	modport TB(clocking cb, input clock, output reset); // provides input output information.
endinterface
