`include "chip_defines.v"
//define program, which runs subbytes driver for key_expansion tests
program automatic subbytes_test(subbytes_io.TB subbytes); //define the interface the second one is the name of the interface

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
		@(posedge subbytes.clock);
		//write sbox
		write_sbox();
		@(posedge subbytes.clock);

	end
	
/*#######Driver part######
##################################*/
//task to generate ansynchrounous reset through the interface
	task gen_reset();

		subbytes.reset = 1'b1;
		$display($time, "[ns]: Sbox reset - 0x%x",subbytes.reset);
		#30;
		subbytes.reset = 1'b0;
		$display($time, "[ns]: Sbox reset - 0x%x, should have reset triggered",subbytes.reset);
	endtask
	
//task for writing sbox values into sbox regs
	task write_sbox();
		//get sbox values from c model
		get_sboxvalues(sbox_data);
		$display($time, "[ns]: sbox_data = 0x%x, writing to the sbox lut tables",sbox_data);
		//drive sbox input signals with the c model values
		subbytes.cb.sbox_in_vld <= 1'b1;
		subbytes.cb.sbox_in <= sbox_data;
	endtask 

endprogram
