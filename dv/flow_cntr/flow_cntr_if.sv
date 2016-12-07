`include "chip_defines.v"

//define interface module for flow_cntrl, which connects testbench to the actual RTL module
interface flow_cntr_io(input logic clock);

	logic 												reset;
	logic [`BLOCK_DATA_WIDTH-1:0] block_data_in;
	logic 												block_data_in_vld;
	logic [`WORD_DATA_WIDTH-1:0]		word_in_comb;
	logic 												word_in_comb_vld;
	logic 												key_available;
	logic 												sbox_available;

	logic [`BLOCK_DATA_WIDTH-1:0] data_out;
	logic 												 data_out_vld;
	logic 												 data_accept;
	logic 												 rnd_key_gen;
	logic [`WORD_DATA_WIDTH-1:0]	 word_out_comb;
	logic 												 word_out_comb_vld;
	logic 												 mix_column_off;

	// create synchronous signals, which are driven and sampled on the clock cycles
	clocking cb @(posedge clock);
		default input #1 output #1; //sample and driving skew (offset).

	output  reset;	
	output  block_data_in;
	output  block_data_in_vld;
	output  word_in_comb;
	output  word_in_comb_vld;
	output  key_available;
	output  sbox_available;

	input  data_out;
	input  data_out_vld;
	input  data_accept;
	input  rnd_key_gen;
	input  word_out_comb;
	input  word_out_comb_vld;
	input  mix_column_off;
	endclocking

	modport TB(clocking cb, input clock, output reset); // provides input output information.
endinterface
