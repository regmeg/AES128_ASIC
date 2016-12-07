`include "chip_defines.v"

//define program, which runs testbench
program automatic add_round_key_word_test(add_round_key_word_io.TB add_round_key_word); //define the interface the second one is the name of the interface

	//import a fcuntion from c model so that correctes of the output value of the module can be checked
	import "DPI-C" function void aes_encrypt_block_wide_add_rnd_key_test(input bit[`WORD_DATA_WIDTH-1:0] in, output bit[`WORD_DATA_WIDTH-1:0] out, input bit[`WORD_DATA_WIDTH-1:0] key); // import function from the c file

	//define variables
	bit [`WORD_DATA_WIDTH-1:0] smp_data_out;
	bit 												smp_data_out_vld;
	bit [`WORD_DATA_WIDTH-1:0] dpi_data_out;

//input data class, for random data genration
		class input_data;
			rand bit[`WORD_DATA_WIDTH-1:0] key;
			rand bit[`WORD_DATA_WIDTH-1:0] word_data;
		endclass

//init programm
	initial begin
	
		//at first edge of the clock generate values
		@(posedge add_round_key_word.clock);
		gen_key_and_word_data();
		
		//at second edge of the clock generate values sample output values and check if they coinside with ones from the c model
		@(posedge add_round_key_word.clock);
		sample_add_round_key_word();
		compare_values();
		test_end();
		
	end
	
/*#######Driver part######
##################################*/

	// task which generated input data
	task gen_key_and_word_data();
	// create new object of the iput data class and randomize its values
	input_data input_d;
	input_d = new();
	input_d.randomize;
	
	$display($time, "[ns]: generated key = 0x%x, generated_data = 0x%x",input_d.key,input_d.word_data);
	//Send data to the c model
	aes_encrypt_block_wide_add_rnd_key_test(input_d.word_data,dpi_data_out,input_d.key);
	$display($time, "[ns]: C model output = 0x%x",dpi_data_out);
	//Drive the DUT word
	drive_add_round_key_word(input_d.key, input_d.word_data);
	endtask
	
		//task to drive add_round_key_word through the interface
	task drive_add_round_key_word(bit[`WORD_DATA_WIDTH-1:0] key, bit[`WORD_DATA_WIDTH-1:0] word_data);
	
		add_round_key_word.cb.rnd_word_key_val <= key;
		add_round_key_word.cb.rnd_word_key_val_vld <= 1'b1;
		add_round_key_word.cb.word_in_comb_mix_column <= word_data;
		add_round_key_word.cb.word_in_comb_mix_column_vld <= 1'b1;

	endtask

/*#######Checker part  start ######
##################################*/

	//sample and save output values out fo add_round_key_word module
	task sample_add_round_key_word();
	
		smp_data_out_vld = add_round_key_word.cb.word_out_comb_vld;
		smp_data_out = add_round_key_word.cb.word_out_comb;
		
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
