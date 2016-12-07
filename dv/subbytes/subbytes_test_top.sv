`include "chip_defines.v"
module subbytes_test_top();
	integer simulation_cycle = 100; //define the clock cycle in ns
	reg MainClock;
	
	//initiate interface
	subbytes_io subbytes_io(MainClock);
	
	//initiate testbench
	subbytes_test subbytes_test(subbytes_io);
	
	//initiate module
	sbox_lut sbox_lut(
		.clk(subbytes_io.clock),
		.reset(subbytes_io.reset),
		.sbox_in_vld(subbytes_io.sbox_in_vld),
		.sbox_in(subbytes_io.sbox_in),
		.key_exp_val(subbytes_io.key_exp_val),
		.key_exp_val_vld(subbytes_io.key_exp_val_vld),
		.sub_bytes_val(subbytes_io.sub_bytes_val),
		.sub_bytes_val_vld(subbytes_io.sub_bytes_val_vld),
		.key_exp_sbox_data(subbytes_io.key_exp_sbox_data),
		.key_exp_sbox_data_vld(subbytes_io.key_exp_sbox_data_vld),
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
