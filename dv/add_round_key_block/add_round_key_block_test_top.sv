`include "chip_defines.v"
module add_round_key_block_test_top();
	integer simulation_cycle = 100; //define the clock cycle in ns
	reg MainClock;
	
	//initiate interface
	add_round_key_block_io add_round_key_block_io(MainClock);
	
	//initiate testbench
	add_round_key_block_test add_round_key_block_test(add_round_key_block_io);
	
	//initiate module
	add_round_key_block add_round_key_block(
		.data_in(add_round_key_block_io.data_in),
		.data_in_vld(add_round_key_block_io.data_in_vld),
		.seed_key(add_round_key_block_io.seed_key),
		.seed_key_vld(add_round_key_block_io.seed_key_vld),
		.block_data_out(add_round_key_block_io.block_data_out),
		.block_data_out_vld(add_round_key_block_io.block_data_out_vld));
		
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
