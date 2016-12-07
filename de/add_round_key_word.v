`include "chip_defines.v"

module add_round_key_word (word_in_comb_mix_column,word_in_comb_mix_column_vld,word_out_comb,word_out_comb_vld,rnd_word_key_val,rnd_word_key_val_vld);

//Define input/output signals
	input [`WORD_DATA_WIDTH-1:0] word_in_comb_mix_column;
	input 					 						 word_in_comb_mix_column_vld;
	input [`WORD_DATA_WIDTH-1:0] rnd_word_key_val;
	input												 rnd_word_key_val_vld;

	output [`WORD_DATA_WIDTH-1:0] word_out_comb;
	output 												word_out_comb_vld;


	//Output signal regs
	reg [`WORD_DATA_WIDTH-1:0] word_out_comb;
	reg 											 word_out_comb_vld;

// define a comibnational logic block
	always @* begin
	
		//assign data out valid to be same as data_in
		word_out_comb_vld = word_in_comb_mix_column_vld;
		
		//if data in and key is valid, perform add round key, otherwise just output all zeros.
		if (word_in_comb_mix_column_vld && rnd_word_key_val_vld) begin
			word_out_comb = word_in_comb_mix_column ^ rnd_word_key_val;
		end else begin
			word_out_comb = {`WORD_DATA_WIDTH{1'b0}};
		end
	end

endmodule

