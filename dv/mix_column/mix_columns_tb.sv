`include "chip_defines.v"

//define program, which runs testbench
program automatic mix_columns_test(mix_columns_io.TB mix_columns); //define the interface the second one is the name of the interface

	//import a function from c model so that correctes of the output value can be checked
	import "DPI-C" function void aes_encrypt_mix_columns_test(input bit[`WORD_DATA_WIDTH-1:0] in, output bit[`WORD_DATA_WIDTH-1:0] out); // import function from the c file

	//define variables
	bit [`WORD_DATA_WIDTH-1:0] smp_data_out;
	bit 											 smp_data_out_vld;
	bit [`WORD_DATA_WIDTH-1:0] dpi_data_out;
	bit [`WORD_DATA_WIDTH-1:0] inp_mix_column_word_in;
	bit 											 inp_mix_column_off;

//input data class, for random input data genration
		class input_data;
			rand bit[`WORD_DATA_WIDTH-1:0] word_data;
		endclass

//init programm
	initial begin

		//generate word data at first possegde of the clock
		@(posedge mix_columns.clock);
		gen_word_data();
		//at second possedge sample output of the mix_columns module and compare values
		@(posedge mix_columns.clock);
		sample_mix_columns();
		compare_values();
		test_end();
		
	end
	
/*#######Driver part######
##################################*/

// task which generates input data
	task gen_word_data();
	
	// create new object of the input data class and randomize its values
	input_data input_d;
	input_d = new();
	input_d.randomize;
	
	inp_mix_column_word_in = input_d.word_data;//save generated data
	
	//Check mixcolumns_off signal - if plussarg is set - set inp_mix_column_off to 1, otherwise to 0, which is later on used to check if mix_columns_off singal works
	if($test$plusargs("mix_column_off")) inp_mix_column_off = 1'b1;
	else 																 inp_mix_column_off = 1'b0;
	

	$display($time, "[ns]: generated_data = 0x%x, mix_column_off = 0x%x",input_d.word_data, inp_mix_column_off);
	
	//Send data to the c model
	aes_encrypt_mix_columns_test(input_d.word_data,dpi_data_out);
	$display($time, "[ns]: C model output = 0x%x",dpi_data_out);
	
	//Drive the DUT word
	drive_add_mix_columns(input_d.word_data,inp_mix_column_off);
	endtask
	
	//task to drive mix_columns data_input signals
	task drive_add_mix_columns(bit[`WORD_DATA_WIDTH-1:0] word_data, bit mix_column_off);
	
		mix_columns.cb.word_in_comb_sub_bytes <= word_data;
		mix_columns.cb.word_in_comb_sub_bytes_vld <= 1'b1;
		mix_columns.cb.mix_column_off <= mix_column_off;

	endtask

/*#######Checker part  start ######
##################################*/

//sample and save ouput data values from mix_columns module
	task sample_mix_columns();
	
		smp_data_out_vld = mix_columns.cb.word_out_comb_mix_column_vld;
		smp_data_out = mix_columns.cb.word_out_comb_mix_column;
		
	endtask
	
	//task which compares predicted values with acutal values
	task compare_values();
		
		//if mix_column off singla is on, check that mix_columns just passed the input data through as output data, othersie generate an error
		if (inp_mix_column_off) begin
			if (smp_data_out != inp_mix_column_word_in) $display($time, "[ns]: [ERROR] The mix_column_off is 0x%x, but input data 0x%x and output data 0x%x do not match", inp_mix_column_off, inp_mix_column_word_in, smp_data_out);
			else $display($time, "[ns]: The mix_column_off is 0x%x and input data 0x%x and output data 0x%x do match", inp_mix_column_off, inp_mix_column_word_in, smp_data_out);
			
		// if mix_column-off signal is off, check that mix_columns value out of DUT is same as out of C model, otherwise generate an error
		end else if (smp_data_out != dpi_data_out)	$display($time, "[ns]: [ERROR] The C model output value 0x%x and output DUT value do not match 0x%x, data_out_vld = 1b'%b",dpi_data_out,smp_data_out, smp_data_out_vld );
		else	$display($time, "[ns]: The C model and DUT values match: C: 0x%x,DUT: 0x%x, data_out_vld = 1b'%b",dpi_data_out,smp_data_out, smp_data_out_vld );
			
	endtask
		
//##############
//task to end the simulation
	task test_end();
		$finish;
	endtask
	
endprogram
