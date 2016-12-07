`include "chip_defines.v"

module mix_columns (word_in_comb_sub_bytes, word_in_comb_sub_bytes_vld, mix_column_off, word_out_comb_mix_column, word_out_comb_mix_column_vld);

	//Define input signals
	input [`WORD_DATA_WIDTH-1:0] word_in_comb_sub_bytes;
	input 										 	 word_in_comb_sub_bytes_vld;
	input mix_column_off;

	output [`WORD_DATA_WIDTH-1:0] word_out_comb_mix_column;
	output 												word_out_comb_mix_column_vld;

	//Output signal regs
	reg [`WORD_DATA_WIDTH-1:0] word_out_comb_mix_column;
	reg 											 word_out_comb_mix_column_vld;

	always @* begin
	
	word_out_comb_mix_column_vld = word_in_comb_sub_bytes_vld;
		//If data in is valid perform mix_columns operation, as it is specified in AES specification, using xtime function
		if (word_in_comb_sub_bytes_vld) begin
			//if it is not the last encryption cycle - perform mix_column
			if (!mix_column_off) begin
				//Perform mix_columns on the incomming word
				word_out_comb_mix_column[`FOURTH_WRD_BYTE]   = xtime(word_in_comb_sub_bytes[`FOURTH_WRD_BYTE] ^ word_in_comb_sub_bytes[`THIRD_WRD_BYTE]) ^ word_in_comb_sub_bytes[`THIRD_WRD_BYTE] ^ word_in_comb_sub_bytes[`SECOND_WRD_BYTE] ^ word_in_comb_sub_bytes[`FIRST_WRD_BYTE];
			
				word_out_comb_mix_column[`THIRD_WRD_BYTE]   = word_in_comb_sub_bytes[`FOURTH_WRD_BYTE] ^ xtime(word_in_comb_sub_bytes[`THIRD_WRD_BYTE] ^ word_in_comb_sub_bytes[`SECOND_WRD_BYTE]) ^ word_in_comb_sub_bytes[`SECOND_WRD_BYTE] ^ word_in_comb_sub_bytes[`FIRST_WRD_BYTE];
			
				word_out_comb_mix_column[`SECOND_WRD_BYTE]   = word_in_comb_sub_bytes[`FOURTH_WRD_BYTE] ^ word_in_comb_sub_bytes[`THIRD_WRD_BYTE] ^ xtime(word_in_comb_sub_bytes[`SECOND_WRD_BYTE] ^ word_in_comb_sub_bytes[`FIRST_WRD_BYTE]) ^ word_in_comb_sub_bytes[`FIRST_WRD_BYTE];
			
				word_out_comb_mix_column[`FIRST_WRD_BYTE]   = word_in_comb_sub_bytes[`FOURTH_WRD_BYTE] ^ word_in_comb_sub_bytes[`THIRD_WRD_BYTE] ^ word_in_comb_sub_bytes[`SECOND_WRD_BYTE] ^ xtime(word_in_comb_sub_bytes[`FIRST_WRD_BYTE] ^ word_in_comb_sub_bytes[`FOURTH_WRD_BYTE]);
			//if it is the last encryption cycle - just pass the data through
			end else begin
				word_out_comb_mix_column = word_in_comb_sub_bytes;
			end
		end else begin
		//if data in is not valid, just pass out all zeros
			word_out_comb_mix_column = {`WORD_DATA_WIDTH{1'b0}};
		end
	end


//define xtime function
	function [7:0] xtime;

		input [7:0] word_byte_data;
		begin
			//If MSB is high, xor with 8’h1B  irreducible polynomial (x^8 + x^4 + x^3 + x + 1) and then shift left by 1 bit, otherwise just do the left shift.
			if (word_byte_data[7]) begin
				xtime = (word_byte_data << 1) ^ 8'h1b;
			end else begin
				xtime = word_byte_data << 1;
			end
		end
	endfunction

endmodule


