module sub_bytes (clk,cpu_rd,cpu_rd_data,reset,data_in,data_in_vld,data_out,data_out_vld,pntr_num)

	input clk
	input cpu_read;
	input cpu_read_data;
	input reset;
	input data_in [`BLOCK_DATA_WIDTH-1:0]
	input data_in_vld
	input pntr_num [1:0]

	output data_out [`BLOCK_DATA_WIDTH-1:0]
	output data_out_vld
	output pntr_num [1:0]

	//Output signal regs
	reg [127:0] data_out;
	reg data_out_vld;

	// Counter regs
	reg reg_pntr_cntr [`CPU_DATA_WIDTH-1:0];

	//Debug regs
	reg reg_shift_rows_debug[`CPU_DATA_WIDTH-1:0];
	
	//sbox register, which pernamently stores its values.
	// element_size   y     x
	reg [7:0] sbox [15:0][15:0]

	//When reset comes in, set every regiser to the reset value.
	always @ posedge reset begin
	reg_pntr_cntr <= {`CPU_DATA_WIDTH{1b'0}};
	reg_sub_bytes_debug <= {`CPU_DATA_WIDTH{1b'0}};
	sbox [15:0][15:0] < `SBOX_VALUES;
	
	end

	always @ posedge clk begin

		//If data in is valid perform subbytes operation, as it is specified in AES specificaton, by calling subbytes function defined below.
		if  data_in_vld begin
			//Perform subbytes on the first word
			data_out[`first_wrd_1st_byte]   <= get_sbox_data(data_in[`first_wrd_1st_byte]);
			data_out[`first_wrd_2nd_byte]   <= get_sbox_data(data_in[`first_wrd_2nd_byte]);
			data_out[`first_wrd_3rd_byte]   <= get_sbox_data(data_in[`first_wrd_3rd_byte]);
			data_out[`first_wrd_4th_byte]   <= get_sbox_data(data_in[`first_wrd_4th_byte]);
			//Perform subbytes on the second word
			data_out[`second_wrd_1st_byte]  <= get_sbox_data(data_in[`second_wrd_1st_byte]);
			data_out[`second_wrd_2nd_byte]  <= get_sbox_data(data_in[`second_wrd_2nd_byte]);
			data_out[`second_wrd_3rd_byte]  <= get_sbox_data(data_in[`second_wrd_3rd_byte]);
			data_out[`second_wrd_4th_byte]  <= get_sbox_data(data_in[`second_wrd_4th_byte]);
			//Perform subbytes on the third word
			data_out[`third_wrd_1st_byte]   <= get_sbox_data(data_in[`third_wrd_1st_byte]);
			data_out[`third_wrd_2nd_byte]   <= get_sbox_data(data_in[`third_wrd_2nd_byte]);
			data_out[`third_wrd_3rd_byte]   <= get_sbox_data(data_in[`third_wrd_3rd_byte]);
			data_out[`third_wrd_4th_byte]   <= get_sbox_data(data_in[`third_wrd_4th_byte]);
			//Perform subbytes on the fourth word
			data_out[`fourth_wrd_1st_byte]  <= get_sbox_data(data_in[`fourth_wrd_1st_byte]);
			data_out[`fourth_wrd_2nd_byte]  <= get_sbox_data(data_in[`fourth_wrd_2nd_byte]);
			data_out[`fourth_wrd_3rd_byte]  <= get_sbox_data(data_in[`fourth_wrd_3rd_byte]);
			data_out[`fourth_wrd_4th_byte]  <= get_sbox_data(data_in[`fourth_wrd_4th_byte]);
			//Set data out valid for output, at the next clock when valid comes and is sampled as such
			data_out_vld <= 1'b
			//Pass the pointers number to the next block
			pntr_num <= pntr_num;
			//Increase pointers counter once pointers value comes in with data_in_vld signal
			case (pntr_num)

				1'b00 : reg_pntr_cntr[`REG_PNTR_CNTR_FIRST ] <= reg_pntr_cntr[`REG_PNTR_CNTR_FIRST ] + 1'b;

				1'b01 : reg_pntr_cntr[`REG_PNTR_CNTR_SECOND] <= reg_pntr_cntr[`REG_PNTR_CNTR_SECOND] + 1'b;

				1'b10 : reg_pntr_cntr[`REG_PNTR_CNTR_THIRD ] <= reg_pntr_cntr[`REG_PNTR_CNTR_THIRD ] + 1'b;

				1'b11 : reg_pntr_cntr[`REG_PNTR_CNTR_FOURTH] <= reg_pntr_cntr[`REG_PNTR_CNTR_FOURTH] + 1'b;

			endcase
			//If data comes in and cpu read is perfomed at the same time, set up the innterupt register.
			if data_in_vld and cpu_read begin
				reg_shift_rows_debug[`CPU_READ_AND_VALID_BOTH_HIGH] <= 1'b1;
			end
			
		end
	end


	function [7:0] get_sbox_data;
		//byte_data[8:4] - is the x coordidate, byte_data[3:0] is the y coordinate for the sbox matrix.
		input block_byte_data[7:0];
		//firstly get the array of data for y coordinate, then launch a different function to get the x coordindate data
		case (block_byte_data[3:0])
			4h'0 : get_sbox_data = get_x_from_sbox(sbox[0],block_byte_data[7:4]);
			4h'1 : get_sbox_data = get_x_from_sbox(sbox[1],block_byte_data[7:4]);
			4h'2 : get_sbox_data = get_x_from_sbox(sbox[2],block_byte_data[7:4]);
			4h'3 : get_sbox_data = get_x_from_sbox(sbox[3],block_byte_data[7:4]);
			4h'4 : get_sbox_data = get_x_from_sbox(sbox[4],block_byte_data[7:4]);
			4h'5 : get_sbox_data = get_x_from_sbox(sbox[5],block_byte_data[7:4]);
			4h'6 : get_sbox_data = get_x_from_sbox(sbox[6],block_byte_data[7:4]);
			4h'7 : get_sbox_data = get_x_from_sbox(sbox[7],block_byte_data[7:4]);
			4h'8 : get_sbox_data = get_x_from_sbox(sbox[8],block_byte_data[7:4]);
			4h'9 : get_sbox_data = get_x_from_sbox(sbox[9],block_byte_data[7:4]);
			4h'a : get_sbox_data = get_x_from_sbox(sbox[10],block_byte_data[7:4]);
			4h'b : get_sbox_data = get_x_from_sbox(sbox[11],block_byte_data[7:4]);
			4h'c : get_sbox_data = get_x_from_sbox(sbox[12],block_byte_data[7:4]);
			4h'd : get_sbox_data = get_x_from_sbox(sbox[13],block_byte_data[7:4]);
			4h'e : get_sbox_data = get_x_from_sbox(sbox[14],block_byte_data[7:4]);
			4h'f : get_sbox_data = get_x_from_sbox(sbox[15],block_byte_data[7:4]);
end

	function [7:0] get_x_from_sbox;
		//byte_data[8:4] - is the x coordidate, byte_data[3:0] is the y coordinate for the sbox matrix.
		input sbox_row[15:0];
		input block_byte_data[3:0];		
		
		case (block_byte_data[3:0])
			4h'0 : get_x_from_sbox = sbox_row[0];
			4h'1 : get_x_from_sbox = sbox_row[1];
			4h'2 : get_x_from_sbox = sbox_row[2];
			4h'3 : get_x_from_sbox = sbox_row[3];
			4h'4 : get_x_from_sbox = sbox_row[4];
			4h'5 : get_x_from_sbox = sbox_row[5];
			4h'6 : get_x_from_sbox = sbox_row[6];
			4h'7 : get_x_from_sbox = sbox_row[7];
			4h'8 : get_x_from_sbox = sbox_row[8];
			4h'9 : get_x_from_sbox = sbox_row[9];
			4h'a : get_x_from_sbox = sbox_row[10];
			4h'b : get_x_from_sbox = sbox_row[11];
			4h'c : get_x_from_sbox = sbox_row[12];
			4h'd : get_x_from_sbox = sbox_row[13];
			4h'e : get_x_from_sbox = sbox_row[14];
			4h'f : get_x_from_sbox = sbox_row[15];
end

