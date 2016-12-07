`include "chip_defines.v"

//define interface module for subbytes, which connects testbench to the actual RTL modul
interface subbytes_io(input logic clock);
	logic 										   	reset;
	logic 											  sbox_in_vld;
	logic [`sbox_w*`sbox_h*8-1:0] sbox_in;
	logic [`WORD_DATA_WIDTH-1:0]  key_exp_val;
	logic 												key_exp_val_vld;
	logic [`WORD_DATA_WIDTH-1:0]  sub_bytes_val;
	logic 												sub_bytes_val_vld;

	logic [`WORD_DATA_WIDTH-1:0] key_exp_sbox_data;
	logic 											 key_exp_sbox_data_vld;
	logic [`WORD_DATA_WIDTH-1:0] sub_bytes_sbox_data;
	logic 											 sub_bytes_sbox_data_vld;
	logic 											 sbox_available;
	
	// create synchronous signals, which are driven and sampled on the clock cycles
	clocking cb @(posedge clock);
		default input #1 output #1; //sample and driving skew (offset).
	output reset;
	output sbox_in_vld;
	output sbox_in;
	output key_exp_val;
	output key_exp_val_vld;
	output sub_bytes_val;
	output sub_bytes_val_vld;
        
	input key_exp_sbox_data;
	input key_exp_sbox_data_vld;
	input sub_bytes_sbox_data;
	input sub_bytes_sbox_data_vld;
	input sbox_available;
	endclocking

	modport TB(clocking cb, input clock, output reset); // provides input output information.
endinterface
