`include "chip_defines.v"

//define program, which runs testbench
program automatic subbytes_test(subbytes_io.TB subbytes); //define the interface the second one is the name of the interface

	 // import function from the c file in order to get predicted subbytes values
	import "DPI-C" function void aes_encrypt_subbytes_test(input bit[`WORD_DATA_WIDTH-1:0] in, output bit[`WORD_DATA_WIDTH-1:0] out);
	//import function from c model, which return values for sbox programming
	import "DPI-C" function void get_sboxvalues(output bit[`sbox_w*`sbox_h*8-1:0] out);

	//define variables
	bit [`sbox_w*`sbox_h*8-1:0] sbox_data;
	bit [`WORD_DATA_WIDTH-1:0]  smp_data_out;
	bit 											  smp_data_out_vld;
	bit [`WORD_DATA_WIDTH-1:0]  dpi_data_out;
	bit [`WORD_DATA_WIDTH-1:0]  dpi_data_out_key;

//input data class, for random data genration
		class input_data;
			rand bit[`WORD_DATA_WIDTH-1:0] word_data;
		endclass

//init programm
	initial begin
		
		//generate reset
		gen_reset();
		//on first edge of the clock check that registers are reset
		@(posedge subbytes.clock);
		display_sbox(0);
		//write sbox values into the sbox registers
		@(posedge subbytes.clock);
		write_sbox();
		//check that sbox regsiters are written
		@(posedge subbytes.clock);
		display_sbox(1);
		@(posedge subbytes.clock);
		check_sbox_avail(); //check that sbox avail signal goes high
		gen_word_data(0); // Gen data for sbox output to subbytes function
		@(posedge subbytes.clock);
		sample_subbytes(0); // Sample sbox output to subbytes function
		compare_values(0); // Compare sbox output to subbytes function to be as expected
		@(posedge subbytes.clock);
		gen_word_data(1); // Gen data for sbox output for keyexpansion subword function
		@(posedge subbytes.clock);
		sample_subbytes(1); // Sample sbox output to keyexpansion subword function
		compare_values(1);  // Compare sbox output to keyexpansion subword function to be as expected
		@(posedge subbytes.clock);
		//  Gen data for sbox output for both subbytes function and keyexpansion subword function at the same time
		gen_word_data(1);
		gen_word_data(0);
		@(posedge subbytes.clock);
		//   Sample sbox and check the output for both subbytes function and keyexpansion subword function at the same time
		sample_subbytes(1);
		compare_values(1);
		sample_subbytes(0);
		compare_values(0);
		test_end();
		
	end
	
/*#######Driver part######
##################################*/

//taks to generate reset through the interface
	task gen_reset();

		subbytes.reset = 1'b1;
		$display($time, "[ns]: reset - 0x%x",subbytes.reset);
		#30;
		subbytes.reset = 1'b0;
		$display($time, "[ns]: reset - 0x%x, should have reset triggered",subbytes.reset);
	endtask
	
	//task for writing sbox into sbox regs via the interface signals
	task write_sbox();
		//get sbox values from c model
		get_sboxvalues(sbox_data);
		$display($time, "[ns]: sbox_data = 0x%x, writing to the sbox lut tables",sbox_data);
		//drive sbox input signals with the c model values
		subbytes.cb.sbox_in_vld <= 1'b1;
		subbytes.cb.sbox_in <= sbox_data;
	endtask 
	
	//task for generating word in data
	task gen_word_data(bit drive_key);
	
	//creat new input data object and randomize its values
	input_data input_d;
	input_d = new();
	input_d.randomize;

	$display($time, "[ns]: generated_data = 0x%x", input_d.word_data);
	//Send data to the c model, either with generated key data or word data
	if (!drive_key) begin
		aes_encrypt_subbytes_test(input_d.word_data,dpi_data_out);
		$display($time, "[ns]: C model output = 0x%x",dpi_data_out);
	end else begin
		aes_encrypt_subbytes_test(input_d.word_data,dpi_data_out_key);
		$display($time, "[ns]: C model output for key_subword = 0x%x",dpi_data_out_key);
	end
	//Drive the DUT with word and key data
	drive_subbytes(input_d.word_data,drive_key);
	endtask
	
	//drive subbytes either with key_exapnasion or flow_cntrl input values
	task drive_subbytes(bit[`WORD_DATA_WIDTH-1:0] word_data, bit drive_key);
			
		if (!drive_key) begin
			subbytes.cb.sub_bytes_val <= word_data;
			subbytes.cb.sub_bytes_val_vld <= 1'b1;
		end else begin
			subbytes.cb.key_exp_val <= word_data;
			subbytes.cb.key_exp_val_vld <= 1'b1;
		end

	endtask

/*#######Checker part  start ######
##################################*/

//task for displaying registers and checking if reset values are set correctly
	task display_sbox(bit after_reset);
	
			//if reset bit is set check if sbox values are zero, if reset value is not set, check that values are not zeros, otherwise print out error
		int i,j;
		$display($time, "[ns]: The reg values are:");
		foreach (subbytes_test_top.sbox_lut.sbox[i]) begin
			foreach (subbytes_test_top.sbox_lut.sbox[i][j]) begin
			
			$write("0x%x ", subbytes_test_top.sbox_lut.sbox[i][j]);
			
			if (!after_reset) begin
				if (subbytes_test_top.sbox_lut.sbox[i][j] != 8'h00)
					$display($time, "[ns]: [ERROR] sbox[%d][%d] is not zero yet, even though reset has been set", i ,j);
			end else begin
				if ((subbytes_test_top.sbox_lut.sbox[i][j] == 8'h00) && (i != 5) && (j != 2)) //sbox[5][2] is 8'h00, so it has to be taken out of the check
					$display($time, "[ns]: [ERROR] subbytes_test_top.sbox_lut.sbox[%d][%d] value is 0x%x, but is has to written to another value",i,j,subbytes_test_top.sbox_lut.sbox[i][j]);
			end
			
			if (j == 0) $display("");
			end
		end
	endtask
	
	//task for checking sbox avail signal
	task check_sbox_avail();
		//if sbox avail is not hight generate an error, otherwise just print its value
		if (subbytes.cb.sbox_available != 1'b1) $display($time, "[ns]: [ERROR] sbox_available has to be 1'b1 after sbox is written, but it is 1'b%b", subbytes.cb.sbox_available);
		else $display($time, "[ns]: sbox_available is 1'b%b, as expected", subbytes.cb.sbox_available);
	endtask
	
	//task for sampling subbytes output values
	task sample_subbytes(bit drive_key);
		
		//sample subbytes output values for key_expansion
		if (!drive_key) begin
		smp_data_out_vld = subbytes.cb.sub_bytes_sbox_data_vld;
		smp_data_out = subbytes.cb.sub_bytes_sbox_data;
		//sample subbytes output values for subbytes encryption operation
		end else begin
		smp_data_out_vld = subbytes.cb.key_exp_sbox_data_vld;
		smp_data_out = subbytes.cb.key_exp_sbox_data;
		end
		
	endtask
	
	//compare if predicated values by from the c model coincide with actual DUT output values
	task compare_values(bit drive_key);
			bit [`WORD_DATA_WIDTH-1:0]  dpi_data_out_to_comp;
		
		//set wheter check the key_exapnsion or subbytes value
		if (drive_key) dpi_data_out_to_comp = dpi_data_out_key;
		else 					 dpi_data_out_to_comp = dpi_data_out;
		
		//if sampled data does not match with c model values, print an error, otherwise just print its value
		if (smp_data_out != dpi_data_out_to_comp)	$display($time, "[ns]: [ERROR] The C model output value 0x%x and output DUT value do not match 0x%x, data_out_vld = 1b'%b, key_expansson access is 1b'%b",dpi_data_out_to_comp,smp_data_out, smp_data_out_vld, drive_key);
		else	$display($time, "[ns]: The C model and DUT values match: C: 0x%x,DUT: 0x%x, data_out_vld = 1b'%b, key_expansson access is 1b'%b",dpi_data_out_to_comp,smp_data_out, smp_data_out_vld, drive_key );
			
	endtask
		
//##############
//task to finish the simulation
	task test_end();
		$finish;
	endtask
	
endprogram
