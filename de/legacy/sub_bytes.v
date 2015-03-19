`include "chip_defines.v"

module sub_bytes (word_in_comb,word_in_comb_vld,word_out_comb_sub_bytes,word_out_comb_sub_bytes_vld,sub_bytes_val,sub_bytes_val_vld,sub_bytes_sbox_data,sub_bytes_sbox_data_vld);

	input [`WORD_DATA_WIDTH-1:0] word_in_comb;
	input 											 word_in_comb_vld;
	input [`WORD_DATA_WIDTH-1:0] sub_bytes_sbox_data;
	input 								 			 sub_bytes_sbox_data_vld;

	output [`WORD_DATA_WIDTH-1:0] word_out_comb_sub_bytes;
	output 												word_out_comb_sub_bytes_vld;
	output [`WORD_DATA_WIDTH-1:0] sub_bytes_val;
	output 												sub_bytes_val_vld;
	
	//Drive valid signals
	assign sub_bytes_val_vld = word_in_comb_vld;
	assign word_out_comb_sub_bytes_vld = sub_bytes_sbox_data_vld;
	
	//Drive values
	assign sub_bytes_val = word_in_comb;
	assign word_out_comb_sub_bytes = sub_bytes_sbox_data;

endmodule
