module add_round_keys (clk,cpu_rd,cpu_rd_data,reset,data_in,data_in_vld,data_out,data_out_vld,pntr_num)

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
	reg reg_add_round_key_debug[`CPU_DATA_WIDTH-1:0];

	//Wires 
	wire pointers_count [`REG_PNTR_CNTR_WIDTH-1:0];
	//Assign pointer values
	
	//Comb logic for reading counter readings - to determine the round number, which is used to determine which key_schedules words to use for round key operation
	always @* begin
		pointers_count = {`REG_PNTR_CNTR_WIDTH{1b'0}}; //dont care about this values, as it does not matter what is it going to be when data_in_vld is not high
		if (pntr_num == 2'b00) begin
			pointers_count = reg_pntr_cntr[`REG_PNTR_CNTR_FIRST  ];
		end else if (pntr_num == 2'b01) begin
			pointers_count = reg_pntr_cntr[`REG_PNTR_CNTR_SECOND ];
		end else if (pntr_num == 2'b10) begin
			pointers_count = reg_pntr_cntr[`REG_PNTR_CNTR_SECOND ];
		end else if (pntr_num == 2'b11) begin
			pointers_count = reg_pntr_cntr[`REG_PNTR_CNTR_SECOND ];
		end

	//When reset comes in, set every regiser to the reset value.
	always @ posedge reset begin
	reg_pntr_cntr <= {`CPU_DATA_WIDTH{1b'0}};
	reg_add_round_key_debug <= {`CPU_DATA_WIDTH{1b'0}};
	end

	always @ posedge clk begin

		//If data in is valid perform add_round_keys operation as it is specified in AES specificaton, depending on which cycle is being executed. See the counter reg to determine.
		if  data_in_vld begin
		
			case (pointers_count) begin
			//If it is preliminary round 
				`REG_PNTR_CNTR_WIDTHh'0000 : begin
							data_out[`1st_wrd ] <= data_in[`1st_wrd ] ^ key_schedule[`1st_wrd ]
							data_out[`2nd_wrd ] <= data_in[`2nd_wrd ] ^ key_schedule[`2nd_wrd ]
							data_out[`3rd_wrd ] <= data_in[`3rd_wrd ] ^ key_schedule[`3rd_wrd ]
							data_out[`4th_wrd ] <= data_in[`4th_wrd ] ^ key_schedule[`4th_wrd ]
				end
				`REG_PNTR_CNTR_WIDTHh'0000 : begin
							//If it is the first round
							data_out[`1st_wrd ] <= data_in[`1st_wrd ] ^ key_schedule[`5th_wrd ]
							data_out[`2nd_wrd ] <= data_in[`2nd_wrd ] ^ key_schedule[`6th_wrd ]
							data_out[`3rd_wrd ] <= data_in[`3rd_wrd ] ^ key_schedule[`7th_wrd ]
							data_out[`4th_wrd ] <= data_in[`4th_wrd ] ^ key_schedule[`8th_wrd ]
				end
				`REG_PNTR_CNTR_WIDTHh'0000 : begin
							//If it is the second round
							data_out[`1st_wrd ] <= data_in[`1st_wrd ] ^ key_schedule[`9th_wrd  ]
							data_out[`2nd_wrd ] <= data_in[`2nd_wrd ] ^ key_schedule[`10th_wrd ]
							data_out[`3rd_wrd ] <= data_in[`3rd_wrd ] ^ key_schedule[`11th_wrd ]
							data_out[`4th_wrd ] <= data_in[`4th_wrd ] ^ key_schedule[`12th_wrd ]
				end
				`REG_PNTR_CNTR_WIDTHh'0000 : begin
							//If it is the third round
							data_out[`1st_wrd ] <= data_in[`1st_wrd ] ^ key_schedule[`13th_wrd ]
							data_out[`2nd_wrd ] <= data_in[`2nd_wrd ] ^ key_schedule[`14th_wrd ]
							data_out[`3rd_wrd ] <= data_in[`3rd_wrd ] ^ key_schedule[`15th_wrd ]
							data_out[`4th_wrd ] <= data_in[`4th_wrd ] ^ key_schedule[`16th_wrd ]
				end
				`REG_PNTR_CNTR_WIDTHh'0000 : begin
							//If it is the fourth round
							data_out[`1st_wrd ] <= data_in[`1st_wrd ] ^ key_schedule[`17th_wrd ]
							data_out[`2nd_wrd ] <= data_in[`2nd_wrd ] ^ key_schedule[`18th_wrd ]
							data_out[`3rd_wrd ] <= data_in[`3rd_wrd ] ^ key_schedule[`19th_wrd ]
							data_out[`4th_wrd ] <= data_in[`4th_wrd ] ^ key_schedule[`20th_wrd ]
				end
				`REG_PNTR_CNTR_WIDTHh'0000 : begin
							//If it is the fith round
							data_out[`1st_wrd ] <= data_in[`1st_wrd ] ^ key_schedule[`21st_wrd ]
							data_out[`2nd_wrd ] <= data_in[`2nd_wrd ] ^ key_schedule[`22n_wrd ]
							data_out[`3rd_wrd ] <= data_in[`3rd_wrd ] ^ key_schedule[`23rd_wrd ]
							data_out[`4th_wrd ] <= data_in[`4th_wrd ] ^ key_schedule[`24th_wrd ]
				end
				`REG_PNTR_CNTR_WIDTHh'0000 : begin
							//If it is the sixth round
							data_out[`1st_wrd ] <= data_in[`1st_wrd ] ^ key_schedule[`25th_wrd ]
							data_out[`2nd_wrd ] <= data_in[`2nd_wrd ] ^ key_schedule[`26th_wrd ]
							data_out[`3rd_wrd ] <= data_in[`3rd_wrd ] ^ key_schedule[`27th_wrd ]
							data_out[`4th_wrd ] <= data_in[`4th_wrd ] ^ key_schedule[`28th_wrd ]
				end
				`REG_PNTR_CNTR_WIDTHh'0000 : begin
							//If it is the seventh round
							data_out[`1st_wrd ] <= data_in[`1st_wrd ] ^ key_schedule[`29th_wrd ]
							data_out[`2nd_wrd ] <= data_in[`2nd_wrd ] ^ key_schedule[`30th_wrd ]
							data_out[`3rd_wrd ] <= data_in[`3rd_wrd ] ^ key_schedule[`31st_wrd ]
							data_out[`4th_wrd ] <= data_in[`4th_wrd ] ^ key_schedule[`32nd_wrd ]
				end
				`REG_PNTR_CNTR_WIDTHh'0000 : begin
							//If it is the eighth round
							data_out[`1st_wrd ] <= data_in[`1st_wrd ] ^ key_schedule[`33th_wrd ]
							data_out[`2nd_wrd ] <= data_in[`2nd_wrd ] ^ key_schedule[`34th_wrd ]
							data_out[`3rd_wrd ] <= data_in[`3rd_wrd ] ^ key_schedule[`35th_wrd ]
							data_out[`4th_wrd ] <= data_in[`4th_wrd ] ^ key_schedule[`36th_wrd ]
				end
				`REG_PNTR_CNTR_WIDTHh'0000 : begin
							//If it is the ninth round
							data_out[`1st_wrd ] <= data_in[`1st_wrd ] ^ key_schedule[`37th_wrd ]
							data_out[`2nd_wrd ] <= data_in[`2nd_wrd ] ^ key_schedule[`38th_wrd ]
							data_out[`3rd_wrd ] <= data_in[`3rd_wrd ] ^ key_schedule[`39th_wrd ]
							data_out[`4th_wrd ] <= data_in[`4th_wrd ] ^ key_schedule[`40th_wrd ]
				end
				`REG_PNTR_CNTR_WIDTHh'0000 : begin
							//If it is the tenth round
							data_out[`1st_wrd ] <= data_in[`1st_wrd ] ^ key_schedule[`41st_wrd ]
							data_out[`2nd_wrd ] <= data_in[`2nd_wrd ] ^ key_schedule[`42nd_wrd ]
							data_out[`3rd_wrd ] <= data_in[`3rd_wrd ] ^ key_schedule[`43rd_wrd ]
							data_out[`4th_wrd ] <= data_in[`4th_wrd ] ^ key_schedule[`44th_wrd ]
				end
			end
			//Set data out valid for output, at the next clock when valid comes and is sampled as such
			data_out_vld <= 1'b
			//Pass the pointers number to the next block
			pntr_num <= pntr_num;
			//Increase pointers counter once pointers value comes in with data_in_vld signal
			case (pntr_num)

				2'b00 : reg_pntr_cntr[`REG_PNTR_CNTR_FIRST ] <= reg_pntr_cntr[`REG_PNTR_CNTR_FIRST ] + 1'b;

				2'b01 : reg_pntr_cntr[`REG_PNTR_CNTR_SECOND] <= reg_pntr_cntr[`REG_PNTR_CNTR_SECOND] + 1'b;

				2'b10 : reg_pntr_cntr[`REG_PNTR_CNTR_THIRD ] <= reg_pntr_cntr[`REG_PNTR_CNTR_THIRD ] + 1'b;

				2'b11 : reg_pntr_cntr[`REG_PNTR_CNTR_FOURTH] <= reg_pntr_cntr[`REG_PNTR_CNTR_FOURTH] + 1'b;

			endcase
			//If data comes in and cpu read is perfomed at the same time, set up the innterupt register.
			if data_in_vld and cpu_read begin
				reg_shift_rows_debug[`CPU_READ_AND_VALID_BOTH_HIGH] <= 1'b1;
			end
			
		end
	end

end
