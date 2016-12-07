`include "chip_defines.v"
module key_expansion_test_top();
	integer simulation_cycle = 100; //define the clock cycle in ns
	reg MainClock;
	
	//Signals for connecting key_expansion with sbox
	wire [`WORD_DATA_WIDTH-1:0] key_exp_val;
	wire 												key_exp_val_vld;
	wire [`WORD_DATA_WIDTH-1:0] key_exp_sbox_data;
	wire 												key_exp_sbox_data_vld;
		
	//initiate interface to key_expansion
	key_expansion_io key_expansion_io(MainClock);
	
	//initiate interface to sbox
	subbytes_io subbytes_io(MainClock);
	
		//initiate testbench to key expasion
	key_expansion_test key_expansion_test(key_expansion_io);
	
	//initiate testbench to sbox
	subbytes_test subbytes_test(subbytes_io);
	
	//initiate  key_expansion module
	key_expansion key_expansion(
		.clk(key_expansion_io.clock),
		.reset(key_expansion_io.reset),
		.key_in(key_expansion_io.key_in),
		.key_in_vld(key_expansion_io.key_in_vld),
		.rnd_key_gen(key_expansion_io.rnd_key_gen),
		.data_in_vld(key_expansion_io.data_in_vld),
		.key_exp_sbox_data_vld(key_exp_sbox_data_vld),
		.key_exp_sbox_data(key_exp_sbox_data),
		.seed_key(key_expansion_io.seed_key),
		.seed_key_vld(key_expansion_io.seed_key_vld),
		.rnd_word_key_val(key_expansion_io.rnd_word_key_val),
		.rnd_word_key_val_vld(key_expansion_io.rnd_word_key_val_vld),
		.key_available(key_expansion_io.key_available),
		.key_exp_val_vld(key_exp_val_vld),
		.key_exp_val(key_exp_val));
	
	//Initiate sbox module so that sub_word can be performed as required in key expansion
	sbox_lut sbox_lut(
		.clk(subbytes_io.clock),
		.reset(subbytes_io.reset),
		.sbox_in_vld(subbytes_io.sbox_in_vld),
		.sbox_in(subbytes_io.sbox_in),
		.key_exp_val(key_exp_val),
		.key_exp_val_vld(key_exp_val_vld),
		.sub_bytes_val(subbytes_io.sub_bytes_val),
		.sub_bytes_val_vld(subbytes_io.sub_bytes_val_vld),
		.key_exp_sbox_data(key_exp_sbox_data),
		.key_exp_sbox_data_vld(key_exp_sbox_data_vld),
		.sub_bytes_sbox_data(subbytes_io.sub_bytes_sbox_data),
		.sub_bytes_sbox_data_vld(subbytes_io.sub_bytes_sbox_data_vld),
		.sbox_available(subbytes_io.sbox_available));

		
	initial begin
	  // get the plussarg value for the simulation cycle value
		$value$plusargs("simulation_cycle=%d", simulation_cycle);
		MainClock = 0;
		//generate clock
		forever begin
			#(simulation_cycle/2)	MainClock = ~MainClock;
			//$display($time, "[ns]: clock tick, 0x%x", MainClock);
		end
	end
endmodule
