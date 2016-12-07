`include "chip_defines.v"
`define NUM_OF_ENCRPT_CYCLES 10 //define how many numbers of are needed
//define program, which runs testbench
program automatic chip_top_test(chip_top_io.TB chip_top); //define the interface the second one is the name of the interface

	//import a fcuntion from c model so that correctes of the output value can be checked of the top level module for complete cipher functionality
	import "DPI-C" function aes_complete_encrypt_test(input bit[`BLOCK_DATA_WIDTH-1:0] data_in, output bit[`BLOCK_DATA_WIDTH-1:0] data_out, input bit[`SEED_KEY_WIDTH-1:0] key_in, int keysize);
	//import function from c model, which return values for sbox programming
	import "DPI-C" function void get_sboxvalues(output bit[`sbox_w*`sbox_h*8-1:0] out);

	//define variables
	bit [`sbox_w*`sbox_h*8-1:0] sbox_data;
	bit[`BLOCK_DATA_WIDTH-1:0] dpi_block_data;
	bit[`SEED_KEY_WIDTH-1:0] 	 seed_key;
	
//input data class, for random data genration
		class input_data;
			rand bit[`SEED_KEY_WIDTH-1:0] key_data;
			rand bit[`BLOCK_DATA_WIDTH-1:0] block_data;
			int block_data_high_val = ((2^128 - 1) / 4 ) * 4;
			int block_data_low_val = 0;
			int key_data_high_val = ((2^128 - 1) / 4 ) * 4;
			int key_data_low_val = 0;
			
			//Randomizastion constraints for hitting coverage for block data
			constraint block_data_range {
				block_data  inside { [block_data_low_val : block_data_high_val]};
			}
			
			//Randomizastion constraints for hitting coverage for key_data
			constraint key_data_range {
				key_data  inside { [key_data_low_val : key_data_high_val]};
			}
			
			// get the plusargs values once object is being constructed
			function new ();
				begin
				$value$plusargs("block_data_low_val=%d", block_data_low_val);   //get value what is the lowest value for block data in to be generated
				$value$plusargs("block_data_high_val=%d", block_data_high_val); //get value what is the highest value for block data in to be generated
				$value$plusargs("key_data_low_val=%d", key_data_low_val);   //get value what is the lowest value for seed key data in to be generated
				$value$plusargs("key_data_high_val=%d", key_data_high_val); //get value what is the highest value for seed key  data in to be generated
				end
			endfunction

		endclass

//init programm
	initial begin
		
		//generate reset, so that regs are reseted to zero
		gen_reset();
		//at posedge check is regs are reset correctly 
		@(posedge chip_top.clock);
		display_regs(1);
		//at posedge write values to sbox regs and generate new seed key
		@(posedge chip_top.clock);
		write_sbox();
		drive_key_value();
		//display what the reg values are and drive sbox in and key in valids to zero
		@(posedge chip_top.clock);
		display_regs(0);
		chip_top.cb.sbox_in_vld <= 1'b0;
		chip_top.cb.key_in_vld <= 1'b0;
		//generate block data in into the cihper
		@(posedge chip_top.clock);
		drive_block_data();
		display_regs(0);
		//wait until chiper gives out the data_accept signal and then check it data_out value given out is correct
		@(posedge chip_top.clock);
		chip_top.cb.data_in_vld <= 1'b0;
		display_regs(0);
		while (!chip_top.cb.data_accept) @(posedge chip_top.clock);
		check_data_out();
		test_end();
		
	end
	
/*#######Driver part######
##################################*/

//taks to generate reset through the interface
	task gen_reset();

		chip_top.reset = 1'b1;
		$display($time, "[ns]: key_expansion reset - 0x%x",chip_top.reset);
		#30;
		chip_top.reset = 1'b0;
		$display($time, "[ns]: key_expansion reset - 0x%x, should have reset triggered",chip_top.reset);
		
	endtask

//task for writing sbox values into sbox regs
	task write_sbox();
		//get sbox values from c model
		get_sboxvalues(sbox_data);
		$display($time, "[ns]: sbox_data = 0x%x, writing to the sbox lut tables",sbox_data);
		//drive sbox input signals with the c model values
		chip_top.cb.sbox_in_vld <= 1'b1;
		chip_top.cb.sbox_in <= sbox_data;
	endtask 

//task for generating key values 
	task drive_key_value();
		//creat new input data object and randomize its values
		input_data input_d;
		input_d = new();
		input_d.randomize;
		seed_key = input_d.key_data;
		
		//drive the key value through the interface
		$display($time, "[ns]: generated_seed_key = 0x%x", input_d.key_data);
		chip_top.cb.key_in_vld <= 1'b1;
		chip_top.cb.key_in 		 <= input_d.key_data;
	endtask
	
//task for generating block in data
	task drive_block_data();
		//creat new input data object and randomize its values
		input_data input_d;
		input_d = new();
		input_d.randomize;
		$display($time, "[ns]: generated_block_data = 0x%x", input_d.block_data);
		
		//get the predicted output value out from the c model
		aes_complete_encrypt_test(input_d.block_data,dpi_block_data,seed_key,`SEED_KEY_WIDTH);		
		$display($time, "[ns]: dpi_block_data = 0x%x", dpi_block_data);
		
		//drive the block value through the interface
		chip_top.cb.data_in_vld <= 1'b1;
		chip_top.cb.data_in 		 <= input_d.block_data;
	endtask

//#######Checker part  start ######
//##################################

//task for displaying registers and checking if reset values are set correctly
	task display_regs(bit res);
	
		
		//if reset bit is set check if sbox values are zero, if reset value is not set, check that values are not zeros, otherwise print out error
		int i,j;
		$display($time, "[ns]: The sbox values are:");
		foreach (chip_top_test_top.chip_top.sbox_lut.sbox[i]) begin
			foreach (chip_top_test_top.chip_top.sbox_lut.sbox[i][j]) begin
			
			$write("0x%x ", chip_top_test_top.chip_top.sbox_lut.sbox[i][j]);
			
			if (res) begin
				if (chip_top_test_top.chip_top.sbox_lut.sbox[i][j] != 8'h00)
					$display($time, "[ns]: [ERROR] sbox_lut.sbox[%d][%d] is not zero yet, even though reset has been set", i ,j);
			end else begin
				if ((chip_top_test_top.chip_top.sbox_lut.sbox[i][j] == 8'h00) && (i != 5) && (j != 2)) //sbox[5][2] is 8'h00, so it has to be taken out of the check, as it is 00 by default
					$display($time, "[ns]: [ERROR] sbox_lut.sbox[%d][%d] value is 0x%x, but is has to written to another value",i,j,chip_top_test_top.chip_top.sbox_lut.sbox[i][j]);
			end
			
			if (j == 0) $display("");
			end
		end
					
			
			
		// for rest of the resgisters of the chip - if reset is set, check that they are set to zero, if not - print an error message, othewerise just print out what the value of the register is.
			
		if ( res && (chip_top_test_top.chip_top.key_expansion.reg_seed_key_1	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] key_expansion.reg_seed_key_1 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:key_expansion.reg_seed_key_1 is 0x%x",chip_top_test_top.chip_top.key_expansion.reg_seed_key_1);
		
		if ( res && (chip_top_test_top.chip_top.key_expansion.reg_seed_key_2  != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] key_expansion.reg_seed_key_2 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:key_expansion.reg_seed_key_2 is 0x%x",chip_top_test_top.chip_top.key_expansion.reg_seed_key_2);
		
		if ( res && (chip_top_test_top.chip_top.key_expansion.reg_seed_key_3  != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] key_expansion.reg_seed_key_3 is not zero yet, even though reset has been set");
		else $display($time, "[ns]: key_expansion.reg_seed_key_3 is 0x%x",chip_top_test_top.chip_top.key_expansion.reg_seed_key_3);
		
		if ( res && (chip_top_test_top.chip_top.key_expansion.reg_seed_key_4  != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] key_expansion.reg_seed_key_4 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:key_expansion.reg_seed_key_4 is 0x%x",chip_top_test_top.chip_top.key_expansion.reg_seed_key_4);
		
		if ( res && (chip_top_test_top.chip_top.key_expansion.reg_round_key_words_1 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] key_expansion.reg_round_key_words_1 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:key_expansion.reg_round_key_words_1 is 0x%x",chip_top_test_top.chip_top.key_expansion.reg_round_key_words_1);
		
		if ( res && (chip_top_test_top.chip_top.key_expansion.reg_round_key_words_2 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] key_expansion.reg_round_key_words_2 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:key_expansion.reg_round_key_words_2 is 0x%x",chip_top_test_top.chip_top.key_expansion.reg_round_key_words_2);
		
		if ( res && (chip_top_test_top.chip_top.key_expansion.reg_round_key_words_3 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] key_expansion.reg_round_key_words_3 is not zero yet, even though reset has been set");
		else $display($time, "[ns]: key_expansion.reg_round_key_words_3 is 0x%x",chip_top_test_top.chip_top.key_expansion.reg_round_key_words_3);
		
		if ( res && (chip_top_test_top.chip_top.key_expansion.reg_round_key_words_4 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] key_expansion.reg_round_key_words_4 is not zero yet, even though reset has been set");
		else $display($time, "[ns]: key_expansion.reg_round_key_words_4 is 0x%x",chip_top_test_top.chip_top.key_expansion.reg_round_key_words_4);
		
		if ( res && (chip_top_test_top.chip_top.key_expansion.reg_key_expn          != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] key_expansion.reg_key_expn is not zero yet, even though reset has been set");
		else $display($time, "[ns]: key_expansion.reg_key_expn is 0x%x",chip_top_test_top.chip_top.key_expansion.reg_key_expn);

		if ( res && (chip_top_test_top.chip_top.flow_cntr.reg_x_word_store_1	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] flow_cntr.reg_x_word_store_1 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:flow_cntr.reg_x_word_store_1 is 0x%x",chip_top_test_top.chip_top.flow_cntr.reg_x_word_store_1);
		
		if ( res && (chip_top_test_top.chip_top.flow_cntr.reg_x_word_store_2	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] flow_cntr.reg_x_word_store_2 is not zero yet, even though reset has been set");
		else $display($time, "[ns]: flow_cntr.reg_x_word_store_2 is 0x%x",chip_top_test_top.chip_top.flow_cntr.reg_x_word_store_2);
		
		if ( res && (chip_top_test_top.chip_top.flow_cntr.reg_x_word_store_3	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] flow_cntr.reg_x_word_store_3 is not zero yet, even though reset has been set");
		else $display($time, "[ns]: flow_cntr.reg_x_word_store_3 is 0x%x",chip_top_test_top.chip_top.flow_cntr.reg_x_word_store_3);
		
		if ( res && (chip_top_test_top.chip_top.flow_cntr.reg_x_word_store_4	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] flow_cntr.reg_x_word_store_4 is not zero yet, even though reset has been set");
		else $display($time, "[ns]: flow_cntr.reg_x_word_store_4 is 0x%x",chip_top_test_top.chip_top.flow_cntr.reg_x_word_store_4);
		
		if ( res && (chip_top_test_top.chip_top.flow_cntr.reg_y_word_store_1	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] flow_cntr.reg_y_word_store_1 is not zero yet, even though reset has been set");
		else $display($time, "[ns]: flow_cntr.reg_y_word_store_1 is 0x%x",chip_top_test_top.chip_top.flow_cntr.reg_y_word_store_1);
		
		if ( res && (chip_top_test_top.chip_top.flow_cntr.reg_y_word_store_2	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] flow_cntr.reg_y_word_store_2 is not zero yet, even though reset has been set");
		else $display($time, "[ns]: flow_cntr.reg_y_word_store_2 is 0x%x",chip_top_test_top.chip_top.flow_cntr.reg_y_word_store_2);
		
		if ( res && (chip_top_test_top.chip_top.flow_cntr.reg_y_word_store_3	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] flow_cntr.reg_y_word_store_3 is not zero yet, even though reset has been set");
		else $display($time, "[ns]: flow_cntr.reg_y_word_store_3 is 0x%x",chip_top_test_top.chip_top.flow_cntr.reg_y_word_store_3);
		
		if ( res && (chip_top_test_top.chip_top.flow_cntr.reg_y_word_store_4	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] flow_cntr.reg_y_word_store_4 is not zero yet, even though reset has been set");
		else $display($time, "[ns]: flow_cntr.reg_y_word_store_4 is 0x%x",chip_top_test_top.chip_top.flow_cntr.reg_y_word_store_4);

		if ( res && (chip_top_test_top.chip_top.flow_cntr.reg_flow_cntr	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] flow_cntr.reg_flow_cntr is not zero yet, even though reset has been set");
		else $display($time, "[ns]: flow_cntr.reg_flow_cntr is 0x%x",chip_top_test_top.chip_top.flow_cntr.reg_flow_cntr);
		
		$display($time, "[ns]: flow_cntr.data_accept is 0x%x",chip_top_test_top.chip_top.flow_cntr.data_accept);
		
	endtask
	
	//task for checking dat adata out of the ciepr is correct
	task check_data_out();
			$display ($time, "[ns]: data_out = 0x%x, data_out_vld = 0x%x", chip_top.cb.data_out, chip_top.cb.data_out_vld);
			//if data is not the same as one out of the c model or valid is not set- print an error
			if (chip_top.cb.data_out != dpi_block_data)  $display($time, "[ns]: [ERROR] data_out  0x%x and  dpi_block_data differ 0x%x", chip_top.cb.data_out, dpi_block_data);
			if (chip_top.cb.data_out_vld != 1'b1) $display($time, "[ns]: [ERROR] data_out_vld is not 1'b1") ;
			
	endtask
//##############

//task for finishing the test run
	task test_end();
		$finish;
	endtask
	
endprogram

