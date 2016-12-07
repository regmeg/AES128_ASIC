`include "chip_defines.v"

//define interface module for mix_columns, which connects testbench to the actual RTL module
interface mix_columns_io(input logic clock);
	logic [`WORD_DATA_WIDTH-1:0] word_in_comb_sub_bytes;
	logic 					 						 word_in_comb_sub_bytes_vld;
	logic 											 mix_column_off;

	logic [`WORD_DATA_WIDTH-1:0] word_out_comb_mix_column;
	logic   										 word_out_comb_mix_column_vld;
	
	// create synchronous signals, which are driven and sampled on the clock cycles
	clocking cb @(posedge clock);
		default input #1 output #1; //sample and driving skew (offset).
		output word_in_comb_sub_bytes;
		output word_in_comb_sub_bytes_vld;
		output mix_column_off;
		input  word_out_comb_mix_column;
		input  word_out_comb_mix_column_vld;
	endclocking

	modport TB(clocking cb, input clock); // provides input output information.
endinterface
