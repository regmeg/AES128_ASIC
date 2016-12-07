`include "chip_defines.v"
module flow_cntr_test_top();
	integer simulation_cycle = 100; //define the clock cycle in ns
	reg MainClock;
	
	//initiate interface
	flow_cntr_io flow_cntr_io(MainClock);
	
	//initiate testbench
	flow_cntr_test flow_cntr_test(flow_cntr_io);
	
	//initiate flow_cntrl module
	flow_cntr flow_cntr(
		.clk(flow_cntr_io.clock),
		.reset(flow_cntr_io.reset),
		.block_data_in(flow_cntr_io.block_data_in),
		.block_data_in_vld(flow_cntr_io.block_data_in_vld),
		.word_in_comb(flow_cntr_io.word_in_comb),
		.word_in_comb_vld(flow_cntr_io.word_in_comb_vld),
		.key_available(flow_cntr_io.key_available),
		.sbox_available(flow_cntr_io.sbox_available),
		.data_out(flow_cntr_io.data_out),
		.data_out_vld(flow_cntr_io.data_out_vld),
		.data_accept(flow_cntr_io.data_accept),
		.rnd_key_gen(flow_cntr_io.rnd_key_gen),
		.word_out_comb(flow_cntr_io.word_out_comb),
		.word_out_comb_vld(flow_cntr_io.word_out_comb_vld),
		.mix_column_off(flow_cntr_io.mix_column_off));
		
	initial begin
	
		//initiate wave dump for the flow_cntrl module for debugging purposes
		$dumpfile("test.vcd");
		$dumpvars();
		$dumpports(flow_cntr, "test.vcd");
		
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

