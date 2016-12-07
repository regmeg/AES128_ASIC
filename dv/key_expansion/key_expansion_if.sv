`include "chip_defines.v"

//define interface module for chip_top, which connects testbench to the actual RTL module
interface key_expansion_io(input logic clock);
	logic 											 reset;
	logic [`SEED_KEY_WIDTH-1:0]  key_in;
	logic 											 key_in_vld;
	logic 											 rnd_key_gen;
	logic												 data_in_vld;
	logic												 key_exp_sbox_data_vld;
	logic [`WORD_DATA_WIDTH-1:0] key_exp_sbox_data;
	logic [`SEED_KEY_WIDTH-1:0]	 seed_key;
	logic 											 seed_key_vld;
	logic [`WORD_DATA_WIDTH-1:0] rnd_word_key_val;
	logic 											 rnd_word_key_val_vld;
	logic												 key_available;
	logic												 key_exp_val_vld;
	logic [`WORD_DATA_WIDTH-1:0] key_exp_val;
	
	// create synchronous signals, which are driven and sampled on the clock cycles
	clocking cb @(posedge clock);
		default input #1 output #1; //sample and driving skew (offset).
	output reset;
	output key_in;
	output key_in_vld;
	output rnd_key_gen;
	output data_in_vld;
	output key_exp_sbox_data_vld;
	output key_exp_sbox_data;

	input seed_key;
	input seed_key_vld;
	input rnd_word_key_val;
	input rnd_word_key_val_vld;
	input	key_available;
	input	key_exp_val_vld;
	input key_exp_val;
	endclocking

	modport TB(clocking cb, input clock, output reset); // provides input output information.
endinterface

