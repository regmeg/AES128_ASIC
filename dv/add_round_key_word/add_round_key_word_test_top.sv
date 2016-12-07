`include "chip_defines.v"
module add_round_key_word_test_top();
	integer simulation_cycle = 100; //define the clock cycle in ns
	reg MainClock;
	
	//initiate interface
	add_round_key_word_io add_round_key_word_io(MainClock);
	
	//initiate testbench
	add_round_key_word_test add_round_key_word_test(add_round_key_word_io);
	
	//initiate module
	add_round_key_word add_round_key_word(
		.word_in_comb_mix_column(add_round_key_word_io.word_in_comb_mix_column),
		.word_in_comb_mix_column_vld(add_round_key_word_io.word_in_comb_mix_column_vld),
		.rnd_word_key_val(add_round_key_word_io.rnd_word_key_val),
		.rnd_word_key_val_vld(add_round_key_word_io.rnd_word_key_val_vld),
		.word_out_comb(add_round_key_word_io.word_out_comb),
		.word_out_comb_vld(add_round_key_word_io.word_out_comb_vld));
		
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
