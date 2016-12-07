`include "chip_defines.v"
//define program, which runs testbench
program automatic add_round_key_block_test(add_round_key_block_io.TB add_round_key_block); //define the interface the second one is the name of the interface

	//import a fcuntion from c model so that correctes of the output value can be checked
	import "DPI-C" function void aes_encrypt_block_wide_add_rnd_key_test(input bit[127:0] in, output bit[127:0] out, input bit[127:0] key); // import function from the c file

	//define variables
	bit [`BLOCK_DATA_WIDTH-1:0] smp_data_out;
	bit 												smp_data_out_vld;
	bit [`BLOCK_DATA_WIDTH-1:0] dpi_data_out;

//input data class, for random data genration
		class input_data;
			rand bit[`SEED_KEY_WIDTH-1:0] key;
			rand bit[`BLOCK_DATA_WIDTH-1:0] block_data;
		endclass

//init programm
	initial begin
	
		//at first edge of the clock generate values
		@(posedge add_round_key_block.clock);
		gen_key_and_block_data();
		
		//at second edge of the clock generate values sample output values and check if they coinside with ones from the c model
		@(posedge add_round_key_block.clock);
		sample_add_round_key_block();
		compare_values();
		test_end();
		
	end
	
/*#######Driver part######
##################################*/

	// task which generated input data
	task gen_key_and_block_data();
	// create new object of the iput data class and randomize its values
	input_data input_d;
	input_d = new();
	input_d.randomize;
	
	$display($time, "[ns]: generated key = 0x%x, generated_data = 0x%x",input_d.key,input_d.block_data);
	//Send data to the c model
	aes_encrypt_block_wide_add_rnd_key_test(input_d.block_data,dpi_data_out,input_d.key);
	$display($time, "[ns]: C model output = 0x%x",dpi_data_out);
	//Drive the DUT block
	drive_add_round_key_block(input_d.key, input_d.block_data);
	endtask
	
	//task to drive add_round_key_block through the interface
	task drive_add_round_key_block(bit[`SEED_KEY_WIDTH-1:0] key, bit[`BLOCK_DATA_WIDTH-1:0] block_data);
	
		add_round_key_block.cb.seed_key <= key;
		add_round_key_block.cb.seed_key_vld <= 1'b1;
		add_round_key_block.cb.data_in <= block_data;
		add_round_key_block.cb.data_in_vld <= 1'b1;

	endtask

/*#######Checker part  start ######
##################################*/

	//sample and save output values out fo add_round_key_block module
	task sample_add_round_key_block();
	
		smp_data_out_vld = add_round_key_block.cb.block_data_out_vld;
		smp_data_out = add_round_key_block.cb.block_data_out;
		
	endtask
	
	//task to compare sampled value with the c model data.
	task compare_values();
		
		//print an error if values do not match
		if (smp_data_out != dpi_data_out)	$display($time, "[ns]: [ERROR] The C model output value 0x%x and output DUT value do not match 0x%x, data_out_vld = 1b'%b",dpi_data_out,smp_data_out, smp_data_out_vld );
		else	$display($time, "[ns]: The C model and DUT values match: C: 0x%x,DUT: 0x%x, data_out_vld = 1b'%b",dpi_data_out,smp_data_out, smp_data_out_vld );
			
	endtask
		
//##############
	task test_end();
		$finish;
	endtask
	
endprogram 
