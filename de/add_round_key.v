`include "chip_defines.v"

module add_round_keys (clk,cpu_rd,cpu_rd_data,reset,data_in,data_in_vld,data_out,data_out_vld,pntr_num_in, pntr_num_out,key_schedule);

	input clk;
	input cpu_rd;
	input cpu_rd_data;
	input reset;
	input [`BLOCK_DATA_WIDTH-1:0] data_in;
	input data_in_vld;
	input [1:0] pntr_num_in;
	input [1407:0] key_schedule;

	output [`BLOCK_DATA_WIDTH-1:0] data_out;
	output data_out_vld;
	output [1:0] pntr_num_out;

	//Output signal regs
	reg [127:0] data_out;
	reg data_out_vld;

	// Counter regs
	reg [`CPU_DATA_WIDTH-1:0] reg_pntr_cntr;

	//Debug regs
	reg [`CPU_DATA_WIDTH-1:0] reg_add_round_key_debug;

	//Wires - have to be still defined as registers
	reg [`REG_PNTR_CNTR_WIDTH-1:0] pointers_count;
	reg [1:0] pntr_num_out; //this is automatically assumed to be the same as pntr_num_out reg
	//Assign pointer values
	//Comb logic for reading counter readings - to determine the round number, which is used to determine which key_schedules words to use for round key operation
	always @* begin
		pointers_count = {`REG_PNTR_CNTR_WIDTH{1'b0}}; //dont care about this values, as it does not matter what is it going to be when data_in_vld is not high
		if (pntr_num_in == 2'b00) begin
			pointers_count = reg_pntr_cntr[`REG_PNTR_CNTR_FIRST ];
		end else if (pntr_num_in == 2'b01) begin
			pointers_count = reg_pntr_cntr[`REG_PNTR_CNTR_SECOND];
		end else if (pntr_num_in == 2'b10) begin
			pointers_count = reg_pntr_cntr[`REG_PNTR_CNTR_SECOND];
		end else if (pntr_num_in == 2'b11) begin
			pointers_count = reg_pntr_cntr[`REG_PNTR_CNTR_SECOND];
		end
end
	//When reset comes in, set every regiser to the reset value.
	always @(posedge reset) begin
	reg_pntr_cntr <= {`CPU_DATA_WIDTH{1'b0}};
	reg_add_round_key_debug <= {`CPU_DATA_WIDTH{1'b0}};
	end

	always @(posedge clk) begin

		//If data in is valid perform add_round_keys operation as it is specified in AES specificaton, depending on which cycle is being executed. See the counter reg to determine.
		if (data_in_vld) begin
		
			case (pointers_count)
			//If it is preliminary round 
				
				`REG_PNTR_CNTR_WIDTH'h0 : begin
							data_out[`first_wrd ]  <= data_in[`first_wrd ]  ^ key_schedule[`zero_1_wrd ];
							data_out[`second_wrd ] <= data_in[`second_wrd ] ^ key_schedule[`zero_2_wrd ];
							data_out[`third_wrd ]  <= data_in[`third_wrd ]  ^ key_schedule[`zero_3_wrd ];
							data_out[`fourth_wrd ] <= data_in[`fourth_wrd ] ^ key_schedule[`zero_4_wrd ];
				end
				`REG_PNTR_CNTR_WIDTH'h1 : begin
							//If it is the first round
							data_out[`first_wrd ]  <= data_in[`first_wrd ]  ^ key_schedule[`zero_5_wrd ];
							data_out[`second_wrd ] <= data_in[`second_wrd ] ^ key_schedule[`zero_6_wrd ];
							data_out[`third_wrd ]  <= data_in[`third_wrd ]  ^ key_schedule[`zero_7_wrd ];
							data_out[`fourth_wrd ] <= data_in[`fourth_wrd ] ^ key_schedule[`zero_8_wrd ];
				end
				`REG_PNTR_CNTR_WIDTH'h2 : begin
							//If it is the second round
							data_out[`first_wrd ]  <= data_in[`first_wrd ]  ^ key_schedule[`zero_9_wrd];
							data_out[`second_wrd ] <= data_in[`second_wrd ] ^ key_schedule[`one_0_wrd ];
							data_out[`third_wrd ]  <= data_in[`third_wrd ]  ^ key_schedule[`one_1_wrd ];
							data_out[`fourth_wrd ] <= data_in[`fourth_wrd ] ^ key_schedule[`one_2_wrd ];
				end
				`REG_PNTR_CNTR_WIDTH'h3 : begin
							//If it is the third round
							data_out[`first_wrd ]  <= data_in[`first_wrd ]  ^ key_schedule[`one_3_wrd ];
							data_out[`second_wrd ] <= data_in[`second_wrd ] ^ key_schedule[`one_4_wrd ];
							data_out[`third_wrd ]  <= data_in[`third_wrd ]  ^ key_schedule[`one_5_wrd ];
							data_out[`fourth_wrd ] <= data_in[`fourth_wrd ] ^ key_schedule[`one_6_wrd ];
				end
				`REG_PNTR_CNTR_WIDTH'h4 : begin
							//If it is the fourth round
							data_out[`first_wrd ]  <= data_in[`first_wrd ]  ^ key_schedule[`one_7_wrd ];
							data_out[`second_wrd ] <= data_in[`second_wrd ] ^ key_schedule[`one_8_wrd ];
							data_out[`third_wrd ]  <= data_in[`third_wrd ]  ^ key_schedule[`one_9_wrd ];
							data_out[`fourth_wrd ] <= data_in[`fourth_wrd ] ^ key_schedule[`two_0_wrd ];
				end
				`REG_PNTR_CNTR_WIDTH'h5 : begin
							//If it is the fith round
							data_out[`first_wrd ]  <= data_in[`first_wrd ]  ^ key_schedule[`two_1_wrd ];
							data_out[`second_wrd ] <= data_in[`second_wrd ] ^ key_schedule[`two_2_wrd ];
							data_out[`third_wrd ]  <= data_in[`third_wrd ]  ^ key_schedule[`two_3_wrd ];
							data_out[`fourth_wrd ] <= data_in[`fourth_wrd ] ^ key_schedule[`two_4_wrd ];
				end
				`REG_PNTR_CNTR_WIDTH'h6 : begin
							//If it is the sixth round
							data_out[`first_wrd ]  <= data_in[`first_wrd ]  ^ key_schedule[`two_5_wrd ];
							data_out[`second_wrd ] <= data_in[`second_wrd ] ^ key_schedule[`two_6_wrd ];
							data_out[`third_wrd ]  <= data_in[`third_wrd ]  ^ key_schedule[`two_7_wrd ];
							data_out[`fourth_wrd ] <= data_in[`fourth_wrd ] ^ key_schedule[`two_8_wrd ];
				end
				`REG_PNTR_CNTR_WIDTH'h7 : begin
							//If it is the seventh round
							data_out[`first_wrd ]  <= data_in[`first_wrd ]  ^ key_schedule[`two_9_wrd ];
							data_out[`second_wrd ] <= data_in[`second_wrd ] ^ key_schedule[`three_0_wrd ];
							data_out[`third_wrd ]  <= data_in[`third_wrd ]  ^ key_schedule[`three_1_wrd ];
							data_out[`fourth_wrd ] <= data_in[`fourth_wrd ] ^ key_schedule[`three_2_wrd ];
				end
				`REG_PNTR_CNTR_WIDTH'h8 : begin
							//If it is the eighth round
							data_out[`first_wrd ]  <= data_in[`first_wrd ]  ^ key_schedule[`three_3_wrd ];
							data_out[`second_wrd ] <= data_in[`second_wrd ] ^ key_schedule[`three_4_wrd ];
							data_out[`third_wrd ]  <= data_in[`third_wrd ]  ^ key_schedule[`three_5_wrd ];
							data_out[`fourth_wrd ] <= data_in[`fourth_wrd ] ^ key_schedule[`three_6_wrd ];
				end
				`REG_PNTR_CNTR_WIDTH'h9 : begin
							//If it is the ninth round
							data_out[`first_wrd ]  <= data_in[`first_wrd ]  ^ key_schedule[`three_7_wrd ];
							data_out[`second_wrd ] <= data_in[`second_wrd ] ^ key_schedule[`three_8_wrd ];
							data_out[`third_wrd ]  <= data_in[`third_wrd ]  ^ key_schedule[`three_9_wrd ];
							data_out[`fourth_wrd ] <= data_in[`fourth_wrd ] ^ key_schedule[`four_0_wrd ];
				end
				`REG_PNTR_CNTR_WIDTH'ha : begin
							//If it is the tenth round
							data_out[`first_wrd ]  <= data_in[`first_wrd ]  ^ key_schedule[`four_1_wrd ];
							data_out[`second_wrd ] <= data_in[`second_wrd ] ^ key_schedule[`four_2_wrd ];
							data_out[`third_wrd ]  <= data_in[`third_wrd ]  ^ key_schedule[`four_3_wrd ];
							data_out[`fourth_wrd ] <= data_in[`fourth_wrd ] ^ key_schedule[`four_4_wrd ];
				end
			endcase
			//Set data out valid for output, at the next clock when valid comes and is sampled as such
			data_out_vld <= 1'b0;
			//Pass the pointers number to the next block
			pntr_num_out <= pntr_num_in;
			//Increase pointers counter once pointers value comes in with data_in_vld signal
			case (pntr_num_in) 

				2'b00 : reg_pntr_cntr[`REG_PNTR_CNTR_FIRST ] <= reg_pntr_cntr[`REG_PNTR_CNTR_FIRST ] + 1'b1;

				2'b01 : reg_pntr_cntr[`REG_PNTR_CNTR_SECOND] <= reg_pntr_cntr[`REG_PNTR_CNTR_SECOND] + 1'b1;

				2'b10 : reg_pntr_cntr[`REG_PNTR_CNTR_THIRD ] <= reg_pntr_cntr[`REG_PNTR_CNTR_THIRD ] + 1'b1;

				2'b11 : reg_pntr_cntr[`REG_PNTR_CNTR_FOURTH] <= reg_pntr_cntr[`REG_PNTR_CNTR_FOURTH] + 1'b1;

			endcase
			
			//If data comes in and cpu read is perfomed at the same time, set up the innterupt register.
			if (data_in_vld && cpu_rd) begin
				reg_add_round_key_debug[`CPU_READ_AND_VALID_BOTH_HIGH] <= 1'b1;
			end
			
		end
	end
	
endmodule
