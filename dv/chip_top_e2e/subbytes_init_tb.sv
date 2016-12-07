`include "chip_defines.v"
program automatic subbytes_test(subbytes_io.TB subbytes); //define the interface the second one is the name of the interface

	import "DPI-C" function void get_sboxvalues(output bit[`sbox_w*`sbox_h*8-1:0] out);


	//define vars
	bit [`sbox_w*`sbox_h*8-1:0] sbox_data;
	bit [`WORD_DATA_WIDTH-1:0]  smp_data_out;
	bit 											  smp_data_out_vld;
	bit [`WORD_DATA_WIDTH-1:0]  dpi_data_out;
	bit [`WORD_DATA_WIDTH-1:0]  dpi_data_out_key;

//input data class
		class input_data;
			rand bit[`WORD_DATA_WIDTH-1:0] word_data;
		endclass

//init programm
	initial begin
	
		gen_reset();
		@(posedge subbytes.clock);
		write_sbox();
		@(posedge subbytes.clock);
		/*forever begin
			show_signals();
			@(posedge subbytes.clock);
		end*/
	end
	
/*#######Driver part######
##################################*/
	task gen_reset();

		subbytes.reset = 1'b1;
		$display($time, "[ns]: Sbox reset - 0x%x",subbytes.reset);
		#30;
		subbytes.reset = 1'b0;
		$display($time, "[ns]: Sbox reset - 0x%x, should have reset triggered",subbytes.reset);
	endtask
	
	task write_sbox();
		get_sboxvalues(sbox_data);
		$display($time, "[ns]: sbox_data = 0x%x, writing to the sbox lut tables",sbox_data);
		subbytes.cb.sbox_in_vld <= 1'b1;
		subbytes.cb.sbox_in <= sbox_data;
	endtask 
	
	/*
	task show_signals();
		$display($time, "[ns]:from sbox key_exp_val_vld = 1'b%x, key_exp_val = 0x%x" ,subbytes.cb.key_exp_val_vld,subbytes.cb.key_exp_val);
		$display($time, "[ns]:from sbox key_exp_sbox_data_vld = 1'b%x, key_exp_sbox_data = 0x%x",subbytes.cb.key_exp_sbox_data_vld, subbytes.cb.key_exp_sbox_data);
	endtask
	*/
	
endprogram
