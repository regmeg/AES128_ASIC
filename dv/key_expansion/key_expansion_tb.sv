`include "chip_defines.v"
`define NUM_OF_ENCRPT_CYCLES 10//define how many numbers of are needed

//define program, which runs testbench
program automatic key_expansion_test(key_expansion_io.TB key_expansion); //define the interface the second one is the name of the interface

		//import a fcuntion from c model so that correctes of the round keys generated can be checked
	import "DPI-C" function void get_key_expnasion(input bit[`SEED_KEY_WIDTH-1:0] key, input int keysize,output bit[`WORD_DATA_WIDTH] keyschedule_val, input int key_expansion_indx);

	//define variables
	bit [`WORD_DATA_WIDTH-1:0] key_schedule [4*(`NUM_OF_ENCRPT_CYCLES+1)];
	bit [`SEED_KEY_WIDTH-1:0]  seed_key;

//input data class, for random data genration
		class input_data;
			rand bit[`SEED_KEY_WIDTH-1:0] key_data;
		endclass

//init programm
	initial begin
	
		//generate reset, so that regs are reseted to zero
		gen_reset();
		//at posedge check is regs are reset correctly 
		@(posedge key_expansion.clock);
		display_regs(1);
		//att possege generate seed key value
		@(posedge key_expansion.clock);
		gen_key_data();
		@(posedge key_expansion.clock);
		key_expansion.cb.key_in_vld <= 1'b0; //sed key valid to 0, once seed key has been generated
		drive_key_expansion(1);// drive the key_expansion via data_in_vld, which will tell the module to start generating round keys
		@(posedge key_expansion.clock);
		check_seed_key_out(); //check if seed key outputed to the add_round_key_block module is correct
		display_regs(0);
		//for the whole encryption cycle check if round keys generated are correct 
		for (int i=0; i < 4*`NUM_OF_ENCRPT_CYCLES; i++) begin
			drive_key_expansion(0);//drive key exnapsion through rnd_key_gen signal
			@(posedge key_expansion.clock);
			check_rnd_key_reg_values(i+4); //check that generated round key value is correct

		end
		//stop driving key_expansion
		@(posedge key_expansion.clock);
		key_expansion.cb.rnd_key_gen <= 1'b0;
		@(posedge key_expansion.clock);
		display_regs(0);
		test_end(); //finish the test
		
	end
	
/*#######Driver part######
##################################*/

//taks to generate reset through the interface
	task gen_reset();

		key_expansion.reset = 1'b1;
		$display($time, "[ns]: key_expansion reset - 0x%x",key_expansion.reset);
		#30;
		key_expansion.reset = 1'b0;
		$display($time, "[ns]: key_expansion reset - 0x%x, should have reset triggered",key_expansion.reset);
		
	endtask

//task for generating seed_key values 
	task gen_key_data();
	
	//creat new input data object and randomize its values
	input_data input_d;
	input_d = new();
	input_d.randomize;
	$display($time, "[ns]: generated_seed_key = 0x%x", input_d.key_data);
	
	//drive the key_expansion module with the generated seed key value
	drive_key_value(input_d.key_data);
	seed_key = input_d.key_data; //save the generated seed key value
	//get the predicted round key values from the c model
	for (int i=0; i < 4*(`NUM_OF_ENCRPT_CYCLES+1); i++) begin
		get_key_expnasion(input_d.key_data,`SEED_KEY_WIDTH,key_schedule[i], i);
		$display($time, "[ns]: C model key_schedule[%03d] = 0x%x",i,key_schedule[i]);
	end
	endtask
	
	//task to drive key_in signals through the interface
	task drive_key_value(bit[`SEED_KEY_WIDTH-1:0] key);
		key_expansion.cb.key_in_vld <= 1'b1;
		key_expansion.cb.key_in 		<= key;
	endtask
	
	//task to drive key_exnansion from flow_cntrl module to make ti to generate round keys
	task drive_key_expansion(bit seed_key);
		
		if (seed_key)
			key_expansion.cb.data_in_vld <= 1'b1;
		else
			key_expansion.cb.rnd_key_gen <= 1'b1;

	endtask

//#######Checker part  start ######
//##################################

//task for displaying registers and checking if reset values are set correctly
	task display_regs(bit res);
	
		// for rest of the resgisters of flow_cntrl module - if reset is set, check that they are set to zero, if not - print an error message, othewerise just print out what the value of the register is.
		if ( res && (key_expansion_test_top.key_expansion.reg_seed_key_1	 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] reg_seed_key_1 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:reg_seed_key_1 is 0x%x",key_expansion_test_top.key_expansion.reg_seed_key_1);
		
		if ( res && (key_expansion_test_top.key_expansion.reg_seed_key_2  != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] reg_seed_key_2 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:reg_seed_key_2 is 0x%x",key_expansion_test_top.key_expansion.reg_seed_key_2);
		
		if ( res && (key_expansion_test_top.key_expansion.reg_seed_key_3  != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] reg_seed_key_3 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:reg_seed_key_3 is 0x%x",key_expansion_test_top.key_expansion.reg_seed_key_3);
		
		if ( res && (key_expansion_test_top.key_expansion.reg_seed_key_4  != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] reg_seed_key_4 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:reg_seed_key_4 is 0x%x",key_expansion_test_top.key_expansion.reg_seed_key_4);
		
		if ( res && (key_expansion_test_top.key_expansion.reg_round_key_words_1 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] reg_round_key_words_1 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:reg_round_key_words_1 is 0x%x",key_expansion_test_top.key_expansion.reg_round_key_words_1);
		
		if ( res && (key_expansion_test_top.key_expansion.reg_round_key_words_2 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] reg_round_key_words_2 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:reg_round_key_words_2 is 0x%x",key_expansion_test_top.key_expansion.reg_round_key_words_2);
		
		if ( res && (key_expansion_test_top.key_expansion.reg_round_key_words_3 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] reg_round_key_words_3 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:reg_round_key_words_3 is 0x%x",key_expansion_test_top.key_expansion.reg_round_key_words_3);
		
		if ( res && (key_expansion_test_top.key_expansion.reg_round_key_words_4 != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] reg_round_key_words_4 is not zero yet, even though reset has been set");
		else $display($time, "[ns]:reg_round_key_words_4 is 0x%x",key_expansion_test_top.key_expansion.reg_round_key_words_4);
		
		if ( res && (key_expansion_test_top.key_expansion.reg_key_expn          != {`WORD_DATA_WIDTH{1'b0}})) $display($time, "[ns]: [ERROR] reg_key_expn is not zero yet, even though reset has been set");
		else $display($time, "[ns]:reg_key_expn is 0x%x",key_expansion_test_top.key_expansion.reg_key_expn);
		
		$display($time, "[ns]: reg_key_expn[`KEY_EXPN_CNTR_CYCLES] is 0x%x", key_expansion_test_top.key_expansion.reg_key_expn[`KEY_EXPN_CNTR_CYCLES]);
		$display($time, "[ns]: reg_key_expn[`KEY_EXPN_CNTR_RCON_CYCLES] is 0x%x", key_expansion_test_top.key_expansion.reg_key_expn[`KEY_EXPN_CNTR_RCON_CYCLES]);
		
		$display($time, "[ns]: key_exp_val_vld = 1'b%x, key_exp_val = 0x%x", key_expansion_test_top.key_exp_val_vld, key_expansion_test_top.key_exp_val);
		$display($time, "[ns]: key_exp_sbox_data_vld = 1'b%x, key_exp_sbox_data = 0x%x", key_expansion_test_top.key_exp_sbox_data_vld, key_expansion_test_top.key_exp_sbox_data);
		
		$display($time, "[ns]: rnd_key_gen = 1'b%x", key_expansion.cb.rnd_key_gen);
		
	endtask
	
	//task for checking seed key value out
	task check_seed_key_out();
		//if seed key out is not the same as first for words of the key_schedule matrix - generate an error
		if (key_expansion.cb.seed_key != {key_schedule[0],key_schedule[1],key_schedule[2],key_schedule[3]}) $display($time, "[ns]: [ERROR] the key_expansion seed key output 0x%x and input seed key 0x%x do not match", key_expansion.cb.seed_key, {key_schedule[0],key_schedule[1],key_schedule[2],key_schedule[3]});
		else 																		   $display($time, "[ns]: Key_expansion seed key output 0x%x and input seed key 0x%x do match", key_expansion.cb.seed_key, {key_schedule[0],key_schedule[1],key_schedule[2],key_schedule[3]});
		
		//if seed_key_vld is not high, generated an error
		if (key_expansion.cb.seed_key_vld != 1'b1) $display($time, "[ns]: [ERROR] seed_key_vld is 1'b%b, but should be 1b'1", key_expansion.cb.seed_key_vld);
		else																			 $display($time, "[ns]: seed_key_vld is 1'b%b, as it should be", key_expansion.cb.seed_key_vld);
		
		//if key_available signal is not high - generate an error
		if (key_expansion.cb.key_available != 1'b1) $display($time, "[ns]: [ERROR] key_available is 1'b%b, but should be 1b'1", key_expansion.cb.seed_key_vld);
		else																			 $display($time, "[ns]: key_available is 1'b%b, as it should be", key_expansion.cb.seed_key_vld);
		
	endtask
	
	//task for checking if generated rnd_key values coincide with c models rnd_key values
	task check_rnd_key_reg_values(int round);
	
	//if output rnd_key val is not the same as its corresponding round key word in the key schedule - generate an error
	if (key_expansion.cb.rnd_word_key_val != key_schedule[round]) $display($time, "[ns]: [ERROR] the rnd_word_key_val key output 0x%x and c model round_key[%2d] 0x%x do not match", key_expansion.cb.rnd_word_key_val, round,key_schedule[round]);
	else 																		   $display($time, "[ns]: rnd_word_key_val key output 0x%x and and c model round_key[%2d] 0x%x do match", key_expansion.cb.rnd_word_key_val, round,key_schedule[round]);
	
	//if key expansion valid is not high, generate an error
	if (key_expansion.cb.rnd_word_key_val_vld != 1'b1) $display($time, "[ns]: [ERROR] rnd_word_key_val_vld is 1'b%b, but should be 1b'1", key_expansion.cb.seed_key_vld);
	else    																					 $display($time, "[ns]: rnd_word_key_val_vld is 1'b%b, as it should be", key_expansion.cb.seed_key_vld);
	
	endtask
	
//##############

	//task to end the test
	task test_end();
		$finish;
	endtask
	
endprogram
