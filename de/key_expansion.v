`include "chip_defines.v"

module key_expansion (clk,reset,key_in,key_in_vld,rnd_key_gen,data_in_vld,key_exp_sbox_data_vld,key_exp_sbox_data,seed_key,seed_key_vld,rnd_word_key_val,rnd_word_key_val_vld,key_available,key_exp_val_vld,key_exp_val);

// I/O signals
	input 											 clk;
	input 											 reset;
	input [`SEED_KEY_WIDTH-1:0]  key_in;
	input 											 key_in_vld;
	input 											 rnd_key_gen;
	input												 data_in_vld;
	input												 key_exp_sbox_data_vld;
	input [`WORD_DATA_WIDTH-1:0] key_exp_sbox_data;

	output [`SEED_KEY_WIDTH-1:0]	seed_key;
	output 												seed_key_vld;
	output [`WORD_DATA_WIDTH-1:0] rnd_word_key_val;
	output 											  rnd_word_key_val_vld;
	output												key_available;
	output												key_exp_val_vld;
	output [`WORD_DATA_WIDTH-1:0] key_exp_val;


//Registers used for seed and round key storage value
	reg [`WORD_DATA_WIDTH-1:0] reg_seed_key_1;
	reg [`WORD_DATA_WIDTH-1:0] reg_seed_key_2;
	reg [`WORD_DATA_WIDTH-1:0] reg_seed_key_3;
	reg [`WORD_DATA_WIDTH-1:0] reg_seed_key_4;

	reg [`WORD_DATA_WIDTH-1:0] reg_round_key_words_1;
	reg [`WORD_DATA_WIDTH-1:0] reg_round_key_words_2;
	reg [`WORD_DATA_WIDTH-1:0] reg_round_key_words_3;
	reg [`WORD_DATA_WIDTH-1:0] reg_round_key_words_4;

//cntr and debug reg
	reg [`WORD_DATA_WIDTH-1:0] reg_key_expn;

//registers for driving signals
	reg [`SEED_KEY_WIDTH-1:0]  seed_key;
	reg 											 seed_key_vld;
	reg 											 key_available;
	reg 											 rnd_word_key_val_vld;
	reg [`WORD_DATA_WIDTH-1:0] rnd_word_key_val;
	reg [`WORD_DATA_WIDTH-1:0] key_exp_val;

//Valids
	assign key_exp_val_vld = rnd_word_key_val_vld;
	
	always @(negedge reset) begin
		reg_seed_key_1				<= {`WORD_DATA_WIDTH{1'b0}};
		reg_seed_key_2        <= {`WORD_DATA_WIDTH{1'b0}};
		reg_seed_key_3        <= {`WORD_DATA_WIDTH{1'b0}};
		reg_seed_key_4        <= {`WORD_DATA_WIDTH{1'b0}};
		reg_round_key_words_1 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_round_key_words_2 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_round_key_words_3 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_round_key_words_4 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_key_expn          <= {`WORD_DATA_WIDTH{1'b0}};
	end

	//Wait for KEY_IN_VLD signal and save the seed key into the seed_key regs and as well in round key regs for and issue key_available
	always @(posedge clk) begin
		if (key_in_vld) begin
			reg_seed_key_1        <= seed_key[`FIRST_WRD ];
			reg_seed_key_2        <= seed_key[`SECOND_WRD];
			reg_seed_key_3        <= seed_key[`THIRD_WRD ];
			reg_seed_key_4        <= seed_key[`FOURTH_WRD];
			reg_round_key_words_1 <= seed_key[`FIRST_WRD ];
			reg_round_key_words_2 <= seed_key[`SECOND_WRD];
			reg_round_key_words_3 <= seed_key[`THIRD_WRD ];
			reg_round_key_words_4 <= seed_key[`FOURTH_WRD];
			key_available 				<= 1'b1;
		end else begin
			key_available 				<= 1'b0;
		end
	end
	

	always @* begin

	end
	
	//Once RND_KEY_GEN signal goes high, start generating round keys, so that they can be used in all encryption rounds
	always @* begin
		rnd_word_key_val_vld = 1'b0;
		rnd_word_key_val     = {`WORD_DATA_WIDTH{1'b0}};
		if (rnd_key_gen) begin
			rnd_word_key_val_vld = 1'b1;
			case (reg_key_expn[`KEY_EXPN_CNTR_CYCLES])
				2'b00 : 
					begin
						rnd_word_key_val = reg_round_key_words_1 ^ (subWord(RotWord(reg_round_key_words_4)) ^ {Rcon(reg_key_expn[`KEY_EXPN_CNTR_RCON_CYCLES]),{24{1'b0}}} ); 
							//Drive the key_expansion values to the sbox lut
						if (key_exp_val_vld) begin
							key_exp_val = reg_round_key_words_4;
						end else begin
							key_exp_val = {`WORD_DATA_WIDTH{1'b0}};
						end
					end
				2'b01 : rnd_word_key_val = reg_round_key_words_2 ^ reg_round_key_words_1;
				2'b10 : rnd_word_key_val = reg_round_key_words_3 ^ reg_round_key_words_2;
				2'b11 : rnd_word_key_val = reg_round_key_words_4 ^ reg_round_key_words_3;
			endcase
		end
	end
	//
	//Implement the counter, as well as resave the reg values with newly generated key values, so that they can be used after for next key expansion rounds.
	always @(posedge clk) begin
		if(rnd_key_gen) begin		
			reg_key_expn[`KEY_EXPN_CNTR_CYCLES] <= reg_key_expn[`KEY_EXPN_CNTR_CYCLES] + 1'b1;
			//Increment the counter of Rcon one cycle before the Rcon operation has to be prepared
			if (reg_key_expn[`KEY_EXPN_CNTR_CYCLES] == 2'b11) begin
				reg_key_expn[`KEY_EXPN_CNTR_RCON_CYCLES] <= reg_key_expn[`KEY_EXPN_CNTR_RCON_CYCLES] + 1'b1;
			end
			
			case (reg_key_expn[`KEY_EXPN_CNTR_CYCLES])
				2'b00 : reg_round_key_words_1 <= rnd_word_key_val;
				2'b01 : reg_round_key_words_2 <= rnd_word_key_val;
				2'b10 : reg_round_key_words_3 <= rnd_word_key_val;
				2'b11 : reg_round_key_words_4 <= rnd_word_key_val;
			endcase 
		
		//Else reset the counter and put the seed key value into the reg_round_keys registers.
		end else begin
			reg_key_expn[`KEY_EXPN_CNTR_CYCLES] <= {`KEY_EXPN_CNTR_WIDTH{1'b0}};
			reg_key_expn[`KEY_EXPN_CNTR_RCON_CYCLES] <= {`KEY_EXPN_CNTR_RCON_WIDTH{1'b0}};
			reg_round_key_words_1 <= reg_seed_key_1;
			reg_round_key_words_2 <= reg_seed_key_2;
			reg_round_key_words_3 <= reg_seed_key_3;
			reg_round_key_words_4 <= reg_seed_key_4;
		
		end
	end
	
	//Once rnd_key_gen goes high and counter is at z, issue the seed key.
	always @* begin
		seed_key_vld = 1'b0;
		seed_key		 = {`SEED_KEY_WIDTH{1'b0}};
		if(data_in_vld) begin
		seed_key_vld = 1'b1;
		seed_key		 = {reg_seed_key_1,reg_seed_key_2,reg_seed_key_3,reg_seed_key_4};
		end
	end
	
	//Implement subWord by passing data into sbox module
	function [`WORD_DATA_WIDTH-1:0] subWord;
		input [`WORD_DATA_WIDTH-1:0] round_key_word;
		begin
			if (key_exp_sbox_data_vld) begin
					subWord = key_exp_sbox_data;
			end else begin
					subWord = {`WORD_DATA_WIDTH{1'b0}};
			end
		end
	endfunction
	
	function [`WORD_DATA_WIDTH-1:0] RotWord;
		input [`WORD_DATA_WIDTH-1:0] round_key_word;
		begin
			RotWord[`FIRST_WRD_BYTE]  = round_key_word[`SECOND_WRD_BYTE];
			RotWord[`SECOND_WRD_BYTE] = round_key_word[`THIRD_WRD_BYTE];
			RotWord[`THIRD_WRD_BYTE]  = round_key_word[`FOURTH_WRD_BYTE];
			RotWord[`FOURTH_WRD_BYTE] = round_key_word[`FIRST_WRD_BYTE];
		end
	endfunction
	
	function [7:0] Rcon;
		input [`KEY_EXPN_CNTR_RCON_WIDTH-1 : 0] counter_cycle;
		begin
			case (counter_cycle)
				`KEY_EXPN_CNTR_RCON_WIDTH'h0 : Rcon = 8'h01;
				`KEY_EXPN_CNTR_RCON_WIDTH'h1 : Rcon = 8'h02;
				`KEY_EXPN_CNTR_RCON_WIDTH'h2 : Rcon = 8'h04;
				`KEY_EXPN_CNTR_RCON_WIDTH'h3 : Rcon = 8'h08;
				`KEY_EXPN_CNTR_RCON_WIDTH'h4 : Rcon = 8'h10;
				`KEY_EXPN_CNTR_RCON_WIDTH'h5 : Rcon = 8'h20;
				`KEY_EXPN_CNTR_RCON_WIDTH'h6 : Rcon = 8'h40;
				`KEY_EXPN_CNTR_RCON_WIDTH'h7 : Rcon = 8'h80;
				`KEY_EXPN_CNTR_RCON_WIDTH'h8 : Rcon = 8'h1b;
				`KEY_EXPN_CNTR_RCON_WIDTH'h9 : Rcon = 8'h36;
			endcase
		end
	endfunction

endmodule
