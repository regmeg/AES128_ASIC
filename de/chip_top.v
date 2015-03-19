`include "chip_defines.v"

module chip_top (clk, reset, key_in, key_in_vld, data_in, data_in_vld, sbox_in, sbox_in_vld, data_accept, data_out, data_out_vld);

	//#############################
	// I/O
	//#############################

	input 												clk;
	input 												reset;
	input [`SEED_KEY_WIDTH-1:0] 	key_in;
	input 												key_in_vld;
	input [`BLOCK_DATA_WIDTH-1:0] data_in;
	input 												data_in_vld;
	input [`sbox_w*`sbox_h*8-1:0] sbox_in;
	input  												sbox_in_vld;

	output 												 data_accept;
	output [`BLOCK_DATA_WIDTH-1:0] data_out;
	output 												 data_out_vld;
	
	//#############################
	// Wires for connecting modules
	//#############################
	
	//Wires for add_round_key_block and flow_cntrl
	wire [`BLOCK_DATA_WIDTH-1:0] block_data_out;
	wire												 block_data_out_vld;
	
	//Wires for sbox_lut and flow_cntrl
	wire [`WORD_DATA_WIDTH-1:0] word_out_comb;
	wire											  word_out_comb_vld;
	
	//Wires for sbox_lut and mix_columns
	wire  [`WORD_DATA_WIDTH-1:0] sub_bytes_sbox_data;
	wire 												 sub_bytes_sbox_data_vld;
	
	//Wires for mix_columns and flow_cntrl
	wire mix_column_off;

	//Wires for add_round_key_word and mix_columns
	wire [`WORD_DATA_WIDTH-1:0] word_out_comb_mix_column;
	wire												word_out_comb_mix_column_vld;
	
	//Wires for add_round_key_word and flow_cntrl
	wire [`WORD_DATA_WIDTH-1:0] word_in_comb;
	wire 												word_in_comb_vld;
	
	//Wires for add_round_key_word and key_expansion
	wire [`WORD_DATA_WIDTH-1:0] rnd_word_key_val;
	wire 											  rnd_word_key_val_vld;
	
	//Wires for add_round_key_block and key_expansion
	wire [`SEED_KEY_WIDTH-1:0] seed_key;
	wire											 seed_key_vld;
	
	//Wires for key_expansion and flow_cntrl
	wire key_available,rnd_key_gen;
	
	//Wires for sbox and flow_cntrl
	wire sbox_available;
	
	//Wires for sbox and key_expansion
	wire [`WORD_DATA_WIDTH-1:0] key_exp_sbox_data;
	wire 												key_exp_sbox_data_vld;
	wire [`WORD_DATA_WIDTH-1:0] key_exp_val;
	wire 												key_exp_val_vld;





	flow_cntrl flow_cntrl(
	.clk(clk),
	.reset(reset),
	.block_data_in(block_data_out),
	.block_data_in_vld(block_data_out_vld),
	.data_out(data_out),
	.data_out_vld(data_out_vld),
	.data_accept(data_accept),
	.key_available(key_available),
	.sbox_available(sbox_available),
	.rnd_key_gen(rnd_key_gen),
	.word_out_comb(word_out_comb),
	.word_out_comb_vld(word_out_comb_vld),
	.mix_column_off(mix_column_off),
	.word_in_comb(word_in_comb),
	.word_in_comb_vld(word_in_comb_vld)
	
	);

	key_expansion key_expansion(
	.clk(clk),
	.reset(reset),
	.key_in(key_in),
	.key_in_vld(key_in_vld),
	.rnd_key_gen(rnd_key_gen),
	.data_in_vld(data_in_vld),
	.key_exp_sbox_data_vld(key_exp_sbox_data_vld),
	.key_exp_sbox_data(key_exp_sbox_data),
	.seed_key(seed_key),
	.seed_key_vld(seed_key_vld),
	.rnd_word_key_val(rnd_word_key_val),
	.rnd_word_key_val_vld(rnd_word_key_val_vld),
	.key_available(key_available),
	.key_exp_val_vld(key_exp_val_vld),
	.key_exp_val(key_exp_val)
	);
	
	add_round_key_block add_round_key_block(
	.data_in(data_in),
	.data_in_vld(data_in_vld),
	.seed_key(seed_key),
	.seed_key_vld(seed_key_vld),
	.block_data_out(block_data_out),
	.block_data_out_vld(block_data_out_vld)
	);
	
	sbox_lut sbox_lut(
	.clk(clk),
	.reset(reset),
	.sbox_in_vld(sbox_in_vld),
	.sbox_in(sbox_in),
	.sbox_available(sbox_available),
	.key_exp_val(key_exp_val),
	.key_exp_val_vld(key_exp_val_vld),
	.sub_bytes_val(word_out_comb),
	.sub_bytes_val_vld(word_out_comb_vld),
	.key_exp_sbox_data(key_exp_sbox_data),
	.key_exp_sbox_data_vld(key_exp_sbox_data_vld),
	.sub_bytes_sbox_data(sub_bytes_sbox_data),
	.sub_bytes_sbox_data_vld(sub_bytes_sbox_data_vld)
	);
	
	mix_columns mix_columns(
	.word_in_comb_sub_bytes(sub_bytes_sbox_data),
	.word_in_comb_sub_bytes_vld(sub_bytes_sbox_data_vld),
	.mix_column_off(mix_column_off),
	.word_out_comb_mix_column(word_out_comb_mix_column),
	.word_out_comb_mix_column_vld(word_out_comb_mix_column_vld)
	);
	
	add_round_key_word add_round_key_word(
	.word_in_comb_mix_column(word_out_comb_mix_column),
	.word_in_comb_mix_column_vld(word_out_comb_mix_column_vld),
	.word_out_comb(word_in_comb),
	.word_out_comb_vld(word_in_comb_vld),
	.rnd_word_key_val(rnd_word_key_val),
	.rnd_word_key_val_vld(rnd_word_key_val_vld)
	);

endmodule
