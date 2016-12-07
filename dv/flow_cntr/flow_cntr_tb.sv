`include "chip_defines.v"

//define program, which runs testbench
program automatic flow_cntr_test(flow_cntr_io.TB flow_cntr); //define the interface the second one is the name of the interface

	//import a fcuntion from c model so that correctes of the shiftrows operation can be checked, which is executed in flow_cntrl module
	import "DPI-C" function void aes_encrypt_shiftrows_test(input bit[127:0] in, output bit[127:0] out); // import function from the c file
	

	//define variables
	bit [`BLOCK_DATA_WIDTH-1:0] block_data_in;
	bit [`BLOCK_DATA_WIDTH-1:0] block_data_out;
	
	bit [`BLOCK_DATA_WIDTH-1:0] x_regs_data;
	bit [`BLOCK_DATA_WIDTH-1:0] y_regs_data;
	
	//assign two signals -x_regs_data and y_regs_data which cotain concatenated values from x and y regs of the flow_cntrl module
	assign x_regs_data = {flow_cntr_test_top.flow_cntr.reg_x_word_store_1,
												flow_cntr_test_top.flow_cntr.reg_x_word_store_2,
												flow_cntr_test_top.flow_cntr.reg_x_word_store_3,
												flow_cntr_test_top.flow_cntr.reg_x_word_store_4};
												
	assign y_regs_data = {flow_cntr_test_top.flow_cntr.reg_y_word_store_1,
												flow_cntr_test_top.flow_cntr.reg_y_word_store_2,
												flow_cntr_test_top.flow_cntr.reg_y_word_store_3,
												flow_cntr_test_top.flow_cntr.reg_y_word_store_4};	
	
//input data class, for random data genration
		class input_data;
			rand bit[`WORD_DATA_WIDTH-1:0] word_data;
			rand bit[`BLOCK_DATA_WIDTH-1:0] block_data;
		endclass

//init programm
	initial begin
	
		//test reset
		gen_reset();
		
		@(posedge flow_cntr.clock);
		display_regs(1); //see if regs are reset
		// drive key and sbox avail signals, so that data accept comes in.
		flow_cntr.cb.key_available <= 1'b1;
		flow_cntr.cb.sbox_available <= 1'b1;
		 //check data accept signals
		@(posedge flow_cntr.clock);
		check_data_accept(1);
		flow_cntr.cb.key_available <= 1'b0;
		flow_cntr.cb.sbox_available <= 1'b0;
		//check data accept signals, after signals go down
		@(posedge flow_cntr.clock);
		check_data_accept(0);
		// generate block data and drive it into flow_cntr block
		gen_and_drive_block_data();
		display_regs(0);
		@(posedge flow_cntr.clock);
		flow_cntr.cb.block_data_in_vld <= 1'b0;
		drive_flow_cntr();// start driving values
		@(posedge flow_cntr.clock);
		display_regs(0);
		check_x_regs(); // check if block data is saved
		//for 4*(5+5) = 20 cycles check that shifrows 
		
		for (int i = 0; i < 5; i++) begin
			for (int j = 1; j < 5; j++) begin 
				drive_flow_cntr(i, j);
				check_shiftrows(j, x_regs_data); // check if data is handled in shiftrows manner properly
				display_regs(0);
				check_mix_columns_off(0); //check that mixcolumns_off signal is low
				@(posedge flow_cntr.clock);
				
			end
			for (int k = 1; k < 5; k++) begin 
				if ((i == 4) && (k == 4)) begin end //skip lasst loop, as it is only suitable for checking, not generation
				else drive_flow_cntr(i, k);
				check_shiftrows(k, y_regs_data); // check if data is handled in shiftrows manner properly
				display_regs(0);
				if (i == 4) check_mix_columns_off(1); //on last four counter cycles check that mix_columns_off signal is off
				else check_mix_columns_off(0); // check that mix_columns singal is off
				@(posedge flow_cntr.clock);
			end
		end
		display_regs(0);
		check_data_out(); //check that data out concides with the last output of four shiftrows operations, as inbetween encryption steps - add_rnd_keys, subbytes, mix_columns are not checked in this testbench
		test_end();
		
	end
	
/*#######Driver part######
##################################*/

//taks to generate reset through the interface
	task gen_reset();

		flow_cntr.reset = 1'b1;
		$display($time, "[ns]: reset - 0x%x",flow_cntr.reset);
		#30;
		flow_cntr.reset = 1'b0;
		$display($time, "[ns]: reset - 0x%x, should have reset triggered",flow_cntr.reset);
	endtask

//task for generating block in data
	task gen_and_drive_block_data();
	//creat new input data object and randomize its values
	input_data input_d;
	input_d = new();
	input_d.randomize;
	block_data_in = input_d.block_data;	
	$display($time, "[ns]: generated_block_data = 0x%x",input_d.block_data);
	
  //drive the block value through the interface
	flow_cntr.cb.block_data_in_vld <= 1'b1;
	flow_cntr.cb.block_data_in <= input_d.block_data;
	endtask

//task for generating data into flow control, which comes out out intermediate ecnryption steps out of add_round_key_word 
	task drive_flow_cntr(int itr_par = 0, int itr_chil = 0);
	
					//creat new input data object and randomize its values
				input_data input_dat;
				input_dat = new();
				input_dat.randomize;
				$display($time, "[ns]: generated_word_data = 0x%x",input_dat.word_data);
				
				//drive generated values
				flow_cntr.cb.word_in_comb <= input_dat.word_data;
				flow_cntr.cb.word_in_comb_vld <= 1'b1;
				
				// save data for data out check
				if 			((itr_par == 4) && (itr_chil == 4)) block_data_out[`FIRST_WRD] = input_dat.word_data;
				else if ((itr_par == 4) && (itr_chil == 1)) block_data_out[`SECOND_WRD] = input_dat.word_data;
				else if ((itr_par == 4) && (itr_chil == 2)) block_data_out[`THIRD_WRD] = input_dat.word_data;
				else if ((itr_par == 4) && (itr_chil == 3)) block_data_out[`FOURTH_WRD] = input_dat.word_data;

	endtask

/*#######Checker part  start ######
##################################*/

//task for displaying registers and checking if reset values are set correctly
	task display_regs(bit res);
		
		// for rest of the resgisters of flow_cntrl module - if reset is set, check that they are set to zero, if not - print an error message, othewerise just print out what the value of the register is.
		if ( res && (flow_cntr_test_top.flow_cntr.reg_x_word_store_1	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] reg_x_word_store_1 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:reg_x_word_store_1 is 0x%x",flow_cntr_test_top.flow_cntr.reg_x_word_store_1);
		
		if ( res && (flow_cntr_test_top.flow_cntr.reg_x_word_store_2	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] reg_x_word_store_2 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:reg_x_word_store_2 is 0x%x",flow_cntr_test_top.flow_cntr.reg_x_word_store_2);
		
		if ( res && (flow_cntr_test_top.flow_cntr.reg_x_word_store_3	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] reg_x_word_store_3 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:reg_x_word_store_3 is 0x%x",flow_cntr_test_top.flow_cntr.reg_x_word_store_3);
		
		if ( res && (flow_cntr_test_top.flow_cntr.reg_x_word_store_4	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] reg_x_word_store_4 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:reg_x_word_store_4 is 0x%x",flow_cntr_test_top.flow_cntr.reg_x_word_store_4);
		
		if ( res && (flow_cntr_test_top.flow_cntr.reg_y_word_store_1	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] reg_y_word_store_1 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:reg_y_word_store_1 is 0x%x",flow_cntr_test_top.flow_cntr.reg_y_word_store_1);
		
		if ( res && (flow_cntr_test_top.flow_cntr.reg_y_word_store_2	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] reg_y_word_store_2 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:reg_y_word_store_2 is 0x%x",flow_cntr_test_top.flow_cntr.reg_y_word_store_2);
		
		if ( res && (flow_cntr_test_top.flow_cntr.reg_y_word_store_3	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] reg_y_word_store_3 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:reg_y_word_store_3 is 0x%x",flow_cntr_test_top.flow_cntr.reg_y_word_store_3);
		
		if ( res && (flow_cntr_test_top.flow_cntr.reg_y_word_store_4	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] reg_y_word_store_4 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:reg_y_word_store_4 is 0x%x",flow_cntr_test_top.flow_cntr.reg_y_word_store_4);

		if ( res && (flow_cntr_test_top.flow_cntr.reg_flow_cntr	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] reg_flow_cntr is not zero yet, even though reset has been set");
		else $display($time, "[ns]:reg_flow_cntr is 0x%x",flow_cntr_test_top.flow_cntr.reg_flow_cntr);
		
		$display($time, "[ns]: counter_on = 0x%x, input_cycle = 0x%x, cntr_mod_with_eight = 0x%x, is_mod_1_to_4 = 0x%x",  flow_cntr_test_top.flow_cntr.counter_on, flow_cntr_test_top.flow_cntr.input_cycle, flow_cntr_test_top.flow_cntr.cntr_mod_with_eight , flow_cntr_test_top.flow_cntr.is_mod_1_to_4 );
		
		$display($time, "[ns]:word_out_comb is 0x%x, word_out_comb_vld is 0x%x", flow_cntr.cb.word_out_comb, flow_cntr.cb.word_out_comb_vld);
	
		$display($time, "[ns]: data_from_store_regs_1 = 0x%x",  flow_cntr_test_top.flow_cntr.data_from_store_regs_1);
		$display($time, "[ns]: data_from_store_regs_2 = 0x%x",  flow_cntr_test_top.flow_cntr.data_from_store_regs_2);
		$display($time, "[ns]: data_from_store_regs_3 = 0x%x",  flow_cntr_test_top.flow_cntr.data_from_store_regs_3);
		$display($time, "[ns]: data_from_store_regs_4 = 0x%x",  flow_cntr_test_top.flow_cntr.data_from_store_regs_4);

	endtask
	
	//task for checking if data accept is set to the neccesary value
	task check_data_accept(bit value);
		//if data accept is not set to the required value print an error
		if ( flow_cntr.cb.data_accept != value) $display($time, "[ns]: [ERROR] data_accept is 0x%x, even though key_available = 0x%x and sbox_available = 0x%x",flow_cntr.cb.data_accept, flow_cntr.cb.key_available, flow_cntr.cb.sbox_available );
		else $display($time, "[ns]:data_accep = 0x%x, as expected",flow_cntr.cb.data_accept);
	endtask
	
//task for checking x registers - whether block data which is generated is acctually saved into the registers after in comes into the moules
	task check_x_regs ();
	
		//if data in the registers is not the same as block_data_in - generate an error!
		
		if (flow_cntr_test_top.flow_cntr.reg_x_word_store_1	 != block_data_in[`FIRST_WRD]) $display($time, "[ns]: [ERROR] reg_x_word_store_1 is 0%0x which is not same as block_data_in[`FIRST_WRD] =0x%x",flow_cntr_test_top.flow_cntr.reg_x_word_store_1,block_data_in[`FIRST_WRD]);
		else $display($time, "[ns]:reg_x_word_store_1 is 0x%x",flow_cntr_test_top.flow_cntr.reg_x_word_store_1);
		
		if (flow_cntr_test_top.flow_cntr.reg_x_word_store_2	 != block_data_in[`SECOND_WRD]) $display($time, "[ns]: [ERROR] reg_x_word_store_2 is 0%0x which is not same as block_data_in[`SECOND_WRD] =0x%x",flow_cntr_test_top.flow_cntr.reg_x_word_store_2,block_data_in[`FIRST_WRD]);
		else $display($time, "[ns]:reg_x_word_store_1 is 0x%x",flow_cntr_test_top.flow_cntr.reg_x_word_store_2);
		
		if (flow_cntr_test_top.flow_cntr.reg_x_word_store_3	 != block_data_in[`THIRD_WRD]) $display($time, "[ns]: [ERROR] reg_x_word_store_3 is 0%0x which is not same as block_data_in[`THIRD_WRD] =0x%x",flow_cntr_test_top.flow_cntr.reg_x_word_store_3,block_data_in[`FIRST_WRD]);
		else $display($time, "[ns]:reg_x_word_store_3 is 0x%x",flow_cntr_test_top.flow_cntr.reg_x_word_store_3);
		
		if (flow_cntr_test_top.flow_cntr.reg_x_word_store_4	 != block_data_in[`FOURTH_WRD]) $display($time, "[ns]: [ERROR] reg_x_word_store_1 is 0%0x which is not same as block_data_in[`FOURTH_WRD] =0x%x",flow_cntr_test_top.flow_cntr.reg_x_word_store_4,block_data_in[`FOURTH_WRD]);
		else $display($time, "[ns]:reg_x_word_store_4 is 0x%x",flow_cntr_test_top.flow_cntr.reg_x_word_store_4);
	
	endtask

	//this task checks if chift row is being executed correctly
	task check_shiftrows(int word ,bit[`BLOCK_DATA_WIDTH-1:0] data_in);
	
		bit [`BLOCK_DATA_WIDTH-1:0] data_out;
		
		//call function from the c model in order to get predicted shiftrows value
		aes_encrypt_shiftrows_test(data_in, data_out);
		$display($time, "[ns]:check_subbytes data_in 0x%x, data_out 0x%x", data_in, data_out);
		
		//the case statement determines which word in data_out generated by the c model is necessray to be check against the data_output of the flw_cntrl model into the, when it goes into the subbytes.
		// if values do not c model and actual output values do not match - print an error.
		case (word)
			1 : begin 
						if (flow_cntr.cb.word_out_comb != data_out[`FIRST_WRD]) $display($time, "[ns]: [ERROR] word_out_comb after subbytes is %0x0, but should be %0x0", flow_cntr.cb.word_out_comb, data_out[`FIRST_WRD]);
						else $display($time, "[ns]:word_out_comb is 0x%x, as expected", flow_cntr.cb.word_out_comb);
					end
			2 : begin
						if (flow_cntr.cb.word_out_comb != data_out[`SECOND_WRD]) $display($time, "[ns]: [ERROR] word_out_comb after subbytes is %0x0, but should be %0x0", flow_cntr.cb.word_out_comb, data_out[`SECOND_WRD]);
						else $display($time, "[ns]:word_out_comb is 0x%x, as expected", flow_cntr.cb.word_out_comb);
					end
			3 : begin 
						if (flow_cntr.cb.word_out_comb != data_out[`THIRD_WRD]) $display($time, "[ns]: [ERROR] word_out_comb after subbytes is %0x0, but should be %0x0", flow_cntr.cb.word_out_comb, data_out[`THIRD_WRD]);
						else $display($time, "[ns]:word_out_comb is 0x%x, as expected", flow_cntr.cb.word_out_comb);
					end
			4 : begin
						if (flow_cntr.cb.word_out_comb != data_out[`FOURTH_WRD]) $display($time, "[ns]: [ERROR] word_out_comb after subbytes is %0x0, but should be %0x0", flow_cntr.cb.word_out_comb, data_out[`FOURTH_WRD]);
						else $display($time, "[ns]:word_out_comb is 0x%x, as expected", flow_cntr.cb.word_out_comb);
					end
		endcase
		
	endtask

//this task checks if mix_columns_off signal which is generated in the flw_cntrl module is at the correct value - if not it will print an error
	task check_mix_columns_off(bit val);
		if (flow_cntr.cb.mix_column_off != val) $display($time, "[ns]: [ERROR] mix_column_off subbytes is not 1'b%b, even though it is last cycle of ecrpt", val);
		else $display($time, "[ns]:mix_column_off is 0x%x, as expected", flow_cntr.cb.mix_column_off);
	endtask
	
//check that data out concides with the last output of four shiftrows operations, as inbetween encryption steps - add_rnd_keys, subbytes, mix_columns are not checked in this testbench
	task 		check_data_out();
		$display($time, "[ns]:data_out is 0x%x, data_out_vld is 0x%x", flow_cntr.cb.data_out, flow_cntr.cb.data_out_vld);
		if (flow_cntr.cb.data_out != block_data_out)  $display($time, "[ns]: [ERROR] actual data_out 0x%x and predicted block_data_out 0x%x do not match", flow_cntr.cb.data_out, block_data_out);
		if (flow_cntr.cb.data_out_vld != 1'b1)  $display($time, "[ns]: [ERROR] data_out_vld 0x%x is not 1'b1", flow_cntr.cb.data_out_vld);
	endtask
//##############

//test finish task
	task test_end();
		$finish;
	endtask
	
endprogram 
