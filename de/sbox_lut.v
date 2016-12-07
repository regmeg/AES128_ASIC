`include "chip_defines.v"

module sbox_lut (clk,reset,sbox_in_vld,sbox_in,sbox_available,key_exp_val,key_exp_val_vld,sub_bytes_val,sub_bytes_val_vld,key_exp_sbox_data,key_exp_sbox_data_vld,sub_bytes_sbox_data,sub_bytes_sbox_data_vld);

//Define input and output signals
	input 											  clk;
	input 										   	reset;
	input 											  sbox_in_vld;
	input [`sbox_w*`sbox_h*8-1:0] sbox_in;
	input [`WORD_DATA_WIDTH-1:0]  key_exp_val;
	input 												key_exp_val_vld;
	input [`WORD_DATA_WIDTH-1:0]  sub_bytes_val;
	input 												sub_bytes_val_vld;

	output [`WORD_DATA_WIDTH-1:0] key_exp_sbox_data;
	output 												key_exp_sbox_data_vld;
	output [`WORD_DATA_WIDTH-1:0] sub_bytes_sbox_data;
	output 												sub_bytes_sbox_data_vld;
	output 												sbox_available;

 //Output regs
	reg [`WORD_DATA_WIDTH-1:0] key_exp_sbox_data;
	reg 											 key_exp_sbox_data_vld;
	reg [`WORD_DATA_WIDTH-1:0] sub_bytes_sbox_data;
	reg 											 sub_bytes_sbox_data_vld;
	reg 											 sbox_available;
	
	//sbox register, which pernamently stores its values.
	// element_size         y        x
	reg [7:0] sbox [`sbox_w-1:0][`sbox_h-1:0];
	

//Reset sbox to zero when reset comes in

	genvar i,k;
	generate
		for (i = 0; i < `sbox_w; i = i +1) begin : width_reset
			for (k = 0; k < `sbox_h; k = k +1) begin : heigth_reset
				always @(negedge reset) begin
					sbox[i][k] <= {8'h0};
				end
			end
		end
	endgenerate

//Write actual values to sbox, from sbox_in signal
	genvar u,l;
	generate
		for (u = 0; u <  `sbox_h*`sbox_w*8; u = u + `sbox_w*8) begin : width
			for (l = 0; l < `sbox_w; l = l +1) begin : heigth
				always @(posedge clk) begin
					if (sbox_in_vld) begin
							sbox[u/(`sbox_w*8)][l] <= sbox_in[(u + (l+1)*8 - 1):((u + (l+1)*8 - 1) - 7)];
					end
				end
			end
		end
	endgenerate
	
	
	//Once sbox is available and written to the regs, init the sbox_available signal
	always @(posedge clk) begin
		if (sbox_in_vld) begin
			sbox_available <=1'b1;
		end else begin
			sbox_available <=1'b0;
		end
	end

//Assign value to key_expansion, when requested
	always @* begin
		sub_bytes_sbox_data_vld = sub_bytes_val_vld;
		if (sub_bytes_val_vld) begin
			sub_bytes_sbox_data[`FIRST_WRD_BYTE]  = get_sbox_data(sub_bytes_val[`FIRST_WRD_BYTE]);
			sub_bytes_sbox_data[`SECOND_WRD_BYTE] = get_sbox_data(sub_bytes_val[`SECOND_WRD_BYTE]);
			sub_bytes_sbox_data[`THIRD_WRD_BYTE]  = get_sbox_data(sub_bytes_val[`THIRD_WRD_BYTE]);
			sub_bytes_sbox_data[`FOURTH_WRD_BYTE] = get_sbox_data(sub_bytes_val[`FOURTH_WRD_BYTE]);
		end else begin
			sub_bytes_sbox_data = {`WORD_DATA_WIDTH{1'b0}};
		end
	end

//Assign value to sub_bytes function, when requested
	always @* begin
	key_exp_sbox_data_vld = key_exp_val_vld;
		if (key_exp_val_vld) begin
			key_exp_sbox_data[`FIRST_WRD_BYTE]  = get_sbox_data(key_exp_val[`FIRST_WRD_BYTE]);
			key_exp_sbox_data[`SECOND_WRD_BYTE] = get_sbox_data(key_exp_val[`SECOND_WRD_BYTE]);
			key_exp_sbox_data[`THIRD_WRD_BYTE]  = get_sbox_data(key_exp_val[`THIRD_WRD_BYTE]);
			key_exp_sbox_data[`FOURTH_WRD_BYTE] = get_sbox_data(key_exp_val[`FOURTH_WRD_BYTE]);
		end else begin
			key_exp_sbox_data = {`WORD_DATA_WIDTH{1'b0}};
		end
	end

	//Function in order to determine the corresponding sbox value for a given byte value
	function [7:0] get_sbox_data;
		//byte_data[7:4] - is the x coordidate, byte_data[3:0] is the y coordinate for the sbox matrix.
		input [7:0] block_byte_data;
		begin
			
			//firstly get the array of data for x coordinate, then launch a different function to get the y coordindate data
			case (block_byte_data[7:4])
				4'h0 : get_sbox_data = get_y_from_sbox( 0,block_byte_data[3:0]);
				4'h1 : get_sbox_data = get_y_from_sbox( 1,block_byte_data[3:0]);
				4'h2 : get_sbox_data = get_y_from_sbox( 2,block_byte_data[3:0]);
				4'h3 : get_sbox_data = get_y_from_sbox( 3,block_byte_data[3:0]);
				4'h4 : get_sbox_data = get_y_from_sbox( 4,block_byte_data[3:0]);
				4'h5 : get_sbox_data = get_y_from_sbox( 5,block_byte_data[3:0]);
				4'h6 : get_sbox_data = get_y_from_sbox( 6,block_byte_data[3:0]);
				4'h7 : get_sbox_data = get_y_from_sbox( 7,block_byte_data[3:0]);
				4'h8 : get_sbox_data = get_y_from_sbox( 8,block_byte_data[3:0]);
				4'h9 : get_sbox_data = get_y_from_sbox( 9,block_byte_data[3:0]);
				4'ha : get_sbox_data = get_y_from_sbox(10,block_byte_data[3:0]);
				4'hb : get_sbox_data = get_y_from_sbox(11,block_byte_data[3:0]);
				4'hc : get_sbox_data = get_y_from_sbox(12,block_byte_data[3:0]);
				4'hd : get_sbox_data = get_y_from_sbox(13,block_byte_data[3:0]);
				4'he : get_sbox_data = get_y_from_sbox(14,block_byte_data[3:0]);
				4'hf : get_sbox_data = get_y_from_sbox(15,block_byte_data[3:0]);
			endcase
		end

	endfunction

//function to determine the y value of sbox
	function [7:0] get_y_from_sbox;
		//byte_data[7:4] - is the x coordidate, byte_data[3:0] is the y coordinate for the sbox matrix.
		input integer index;
		input [3:0] block_byte_data;
		begin
			case (block_byte_data[3:0])
				4'h0 : get_y_from_sbox = sbox[index][ 0];
				4'h1 : get_y_from_sbox = sbox[index][ 1];
				4'h2 : get_y_from_sbox = sbox[index][ 2];
				4'h3 : get_y_from_sbox = sbox[index][ 3];
				4'h4 : get_y_from_sbox = sbox[index][ 4];
				4'h5 : get_y_from_sbox = sbox[index][ 5];
				4'h6 : get_y_from_sbox = sbox[index][ 6];
				4'h7 : get_y_from_sbox = sbox[index][ 7];
				4'h8 : get_y_from_sbox = sbox[index][ 8];
				4'h9 : get_y_from_sbox = sbox[index][ 9];
				4'ha : get_y_from_sbox = sbox[index][10];
				4'hb : get_y_from_sbox = sbox[index][11];
				4'hc : get_y_from_sbox = sbox[index][12];
				4'hd : get_y_from_sbox = sbox[index][13];
				4'he : get_y_from_sbox = sbox[index][14];
				4'hf : get_y_from_sbox = sbox[index][15];
			endcase
		end
	endfunction

endmodule
