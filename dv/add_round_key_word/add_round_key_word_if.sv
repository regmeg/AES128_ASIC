`include "chip_defines.v"

//define interface module for add_round_key_word, which connects testbench to the actual RTL module
interface add_round_key_word_io(input logic clock);
	logic [`WORD_DATA_WIDTH-1:0] word_in_comb_mix_column;
	logic 					 						 word_in_comb_mix_column_vld;
	logic [`WORD_DATA_WIDTH-1:0]  rnd_word_key_val;
	logic 											 rnd_word_key_val_vld;

	logic [`WORD_DATA_WIDTH-1:0] word_out_comb;
	logic   										 word_out_comb_vld;
	
	// create synchronous signals, which are driven and sampled on the clock cycles
	clocking cb @(posedge clock);
		default input #1 output #1; //sample and driving skew (offset).
		output word_in_comb_mix_column;
		output word_in_comb_mix_column_vld;
		output rnd_word_key_val;
		output rnd_word_key_val_vld;
		input word_out_comb;
		input word_out_comb_vld;
	endclocking

	modport TB(clocking cb, input clock); // provides input output information.
endinterface
