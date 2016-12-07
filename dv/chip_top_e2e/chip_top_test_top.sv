`include "chip_defines.v"
module chip_top_test_top();
	integer simulation_cycle = 100; //define the clock cycle in ns
	reg MainClock;
	
	//initiate interface to chip_top
	chip_top_io chip_top_io(MainClock);
	
	//initiate testbench to chip_top
	chip_top_test chip_top_test(chip_top_io);
	
	//Initiate chip_top module
	chip_top chip_top(
		.clk(chip_top_io.clock),
		.reset(chip_top_io.reset),
		.key_in(chip_top_io.key_in),
		.key_in_vld(chip_top_io.key_in_vld),
		.data_in(chip_top_io.data_in),
		.data_in_vld(chip_top_io.data_in_vld),
		.sbox_in(chip_top_io.sbox_in),
		.sbox_in_vld(chip_top_io.sbox_in_vld),
		.data_accept(chip_top_io.data_accept),
		.data_out(chip_top_io.data_out),
		.data_out_vld(chip_top_io.data_out_vld));
		
		
	//define coverage for analysing generated keys and data
	
	covergroup block_and_key_data(bit[`SEED_KEY_WIDTH-1:0] 	 seed_key,bit[`BLOCK_DATA_WIDTH-1:0] gen_block_data);

	 option.auto_bin_max = 1000; //define how many bins to be generated for each sampled value
	 
	 //define coverpoint for data in
   data_in : coverpoint seed_key{
		}
	//define coverpoint for key_in
	 key_in  : coverpoint gen_block_data{
		}
endgroup

	// init covergroup
	block_and_key_data block_and_key_data_cov = new(chip_top_io.key_in,chip_top_io.data_in);	
		
		
	initial begin

		//initiate wave dump for the top module and submodules for debugging purposes
		$dumpfile("test.vcd");
    $dumpvars();
    $dumpports(chip_top, "test.vcd");
    $dumpports(chip_top.flow_cntr, "test.vcd");
    $dumpports(chip_top.add_round_key_block, "test.vcd");
    $dumpports(chip_top.mix_columns, "test.vcd");
    $dumpports(chip_top.sbox_lut, "test.vcd");
    $dumpports(chip_top.add_round_key_word, "test.vcd");
    
    // get the plussarg value for the simulation cycle value
		$value$plusargs("simulation_cycle=%d", simulation_cycle);
		MainClock = 0;
		//generate clock
		forever begin
			#(simulation_cycle/2)	begin MainClock = ~MainClock; block_and_key_data_cov.sample(); end
			//$display($time, "[ns]: clock tick, 0x%x", MainClock);
		end
	end
endmodule
