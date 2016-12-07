`include "chip_defines.v"
module mix_columns_test_top();
	integer simulation_cycle = 100; //define the clock cycle in ns
	reg MainClock;
	
	//initiate interface
	mix_columns_io mix_columns_io(MainClock);
	
	//initiate testbench
	mix_columns_test mix_columns_test(mix_columns_io);
	
	//initiate module
	mix_columns mix_columns(
		.word_in_comb_sub_bytes(mix_columns_io.word_in_comb_sub_bytes),
		.word_in_comb_sub_bytes_vld(mix_columns_io.word_in_comb_sub_bytes_vld),
		.mix_column_off(mix_columns_io.mix_column_off),
		.word_out_comb_mix_column(mix_columns_io.word_out_comb_mix_column),
		.word_out_comb_mix_column_vld(mix_columns_io.word_out_comb_mix_column_vld));
		
	initial begin
		$value$plusargs("simulation_cycle=%d", simulation_cycle);
		MainClock = 0;
		forever begin
			#(simulation_cycle/2)	MainClock = ~MainClock;
			//$display($time, "[ns]: clock tick, 0x%x", MainClock);
		end
	end
endmodule
