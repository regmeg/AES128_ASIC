`include "chip_defines.v"

//define interface module for add_round_key_block, which connects testbench to the actual RTL module
interface add_round_key_block_io(input logic clock);
	logic [`BLOCK_DATA_WIDTH-1:0] data_in;
	logic 					 							data_in_vld;
	logic [`SEED_KEY_WIDTH-1:0]   seed_key;
	logic 												seed_key_vld;

	logic [`BLOCK_DATA_WIDTH-1:0] block_data_out;
	logic   											block_data_out_vld;
	
	// create synchronous signals, which are driven and sampled on the clock cycles
	clocking cb @(posedge clock);
		default input #1 output #1; //sample and driving skew (offset).
		output data_in;
		output data_in_vld;
		output seed_key;
		output seed_key_vld;
		input block_data_out;
		input block_data_out_vld;
	endclocking

	modport TB(clocking cb, input clock); // provides input output information.
endinterface
