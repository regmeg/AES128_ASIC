`include "chip_defines.v"

module flow_cntr(clk,reset,block_data_in,block_data_in_vld,data_out,data_out_vld,data_accept,key_available,sbox_available,rnd_key_gen,word_out_comb,word_out_comb_vld,mix_column_off,word_in_comb,word_in_comb_vld);

//INPUTS
	input 												clk;
	input 												reset;
	
	input [`BLOCK_DATA_WIDTH-1:0] block_data_in;
	input 												block_data_in_vld;
	input [`WORD_DATA_WIDTH-1:0]	word_in_comb;
	input 												word_in_comb_vld;
	input 												key_available;
	input 												sbox_available;

//OUTPUTS
	output [`BLOCK_DATA_WIDTH-1:0] data_out;
	output 												 data_out_vld;
	output 												 data_accept;
	output 												 rnd_key_gen;
	output [`WORD_DATA_WIDTH-1:0]	 word_out_comb;
	output 												 word_out_comb_vld;
	output 												 mix_column_off;

//Store Registers
	reg [`WORD_DATA_WIDTH-1:0] reg_x_word_store_1;
	reg [`WORD_DATA_WIDTH-1:0] reg_x_word_store_2;
	reg [`WORD_DATA_WIDTH-1:0] reg_x_word_store_3;
	reg [`WORD_DATA_WIDTH-1:0] reg_x_word_store_4;
	reg [`WORD_DATA_WIDTH-1:0] reg_y_word_store_1;
	reg [`WORD_DATA_WIDTH-1:0] reg_y_word_store_2;
	reg [`WORD_DATA_WIDTH-1:0] reg_y_word_store_3;
	reg [`WORD_DATA_WIDTH-1:0] reg_y_word_store_4;
//Counter and debug registers
	reg [`WORD_DATA_WIDTH-1:0] reg_flow_cntr;


//Registers which drive signals
	//Outputs
	reg [`BLOCK_DATA_WIDTH-1:0] data_out;
	reg 												data_out_vld;
	reg 												data_acpt;
	reg [`WORD_DATA_WIDTH-1:0]	word_out_comb;
	wire												word_out_comb_vld;
	
	//Internal Signals
	reg counter_on;
	
//Internal wires
	wire [`WORD_DATA_WIDTH-1:0] data_from_store_regs_1;
	wire [`WORD_DATA_WIDTH-1:0] data_from_store_regs_2;
	wire [`WORD_DATA_WIDTH-1:0] data_from_store_regs_3;
	wire [`WORD_DATA_WIDTH-1:0] data_from_store_regs_4;
	wire [1:0]									input_cycle;
	wire [2:0]									cntr_mod_with_eight;
	wire 												is_mod_1_to_4;

	
//Assign rnd_key_gen signal to be issued the same time when valid signal comes in ,so that key expansion starts to generate keys and then let counter to drive it. Enable the word_out_comb_vld one clock cycle later, so that encryption process starts in the combinational AES logic.
	assign rnd_key_gen = counter_on;
	assign word_out_comb_vld = counter_on;
	
//Assign mixcolumns to be off for last four cycles, as it is specified for AES
	assign mix_column_off = (reg_flow_cntr[`FLOW_CNTR_COUNT_WORD_CYCLES] >= `SWITH_MIXCOLUMN_OFF_AFTER) ? 1'b1 : 1'b0;

/*Assign the switching signal logic, which switches between x and y regs
	The input cycle indicates if the current cycle of the counter is 1st,2nd,3rd or 4th in the row by using modulus operation. This allows the module to know which word in the row to send out for processing and which on of the 4 registers to use to save input word.
	In order to know which registers to use x or y, the counter is modded with 8, if mod is between 1 and 4, it means x regs should be used, otherwise y regs should be used for reading data and other way around for writing.
*/

	assign input_cycle 				 = reg_flow_cntr[`FLOW_CNTR_COUNT_WORD_CYCLES] % `FLOW_CNTR_COUNT_WORD_CYCLES_WIDTH'h4;
	assign cntr_mod_with_eight = reg_flow_cntr[`FLOW_CNTR_COUNT_WORD_CYCLES] % `FLOW_CNTR_COUNT_WORD_CYCLES_WIDTH'h8;
	assign is_mod_1_to_4 			 = ((cntr_mod_with_eight > 3'h0) && (cntr_mod_with_eight < 3'h5)) ? 1'b1 : 1'b0;
	
	assign data_from_store_regs_1 = (is_mod_1_to_4) ? reg_x_word_store_1 : reg_y_word_store_1;
	assign data_from_store_regs_2 = (is_mod_1_to_4) ? reg_x_word_store_2 : reg_y_word_store_2;
	assign data_from_store_regs_3 = (is_mod_1_to_4) ? reg_x_word_store_3 : reg_y_word_store_3;
	assign data_from_store_regs_4 = (is_mod_1_to_4) ? reg_x_word_store_4 : reg_y_word_store_4;

//Set all registers to 0 after the reset
	always @(negedge reset) begin
		reg_x_word_store_1 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_x_word_store_2 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_x_word_store_3 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_x_word_store_4 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_y_word_store_1 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_y_word_store_2 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_y_word_store_3 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_y_word_store_4 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_flow_cntr			 <= {`WORD_DATA_WIDTH{1'b0}};
			reg_flow_cntr			 <= {32{1'b0}};
		counter_on <= 1'b0;
	end
	
	//Issue DATA_ACCEPT if seed key becomes available or counter reaches d'40 (0x28)
	
	assign data_accept = (key_available && sbox_available) ? (key_available && sbox_available) : data_acpt ;
	
	always @(posedge clk) begin
		if ((reg_flow_cntr[`FLOW_CNTR_COUNT_WORD_CYCLES] == `LAST_CYCLE_OF_ENCRPT)) begin
			data_acpt <= 1'b1;
		end else begin
			data_acpt <= 1'b0;
		end
	end
	
	//Store BLOCK_DATA_IN[127:0] into X registers by the word basis and send signal to key when block_data_in_vld signal comes in. As well as enable the counter.
	always @(posedge clk) begin
		if (block_data_in_vld) begin
			reg_x_word_store_1	 <= block_data_in[`FIRST_WRD ];
			reg_x_word_store_2	 <= block_data_in[`SECOND_WRD];
			reg_x_word_store_3	 <= block_data_in[`THIRD_WRD ];
			reg_x_word_store_4	 <= block_data_in[`FOURTH_WRD];
		end
	end
	
	//Make the counter to work 
	always @(posedge clk) begin
		// As once data_vld comes in start incrementing the counter and continue to do so up until it reaches d'40; 0x28
		if (block_data_in_vld || counter_on) begin
				reg_flow_cntr[`FLOW_CNTR_COUNT_WORD_CYCLES] <= reg_flow_cntr[`FLOW_CNTR_COUNT_WORD_CYCLES] + 1'b1;
				counter_on <= 1'b1;
		end
		 // One cycle earlier before cntr=0x28, so that counter_on is sampled as low straight away after cntr = 0x28 and it gets reset.
		if (reg_flow_cntr[`FLOW_CNTR_COUNT_WORD_CYCLES] == `LAST_CYCLE_OF_ENCRPT) begin
				counter_on <= 1'b0;
				reg_flow_cntr[`FLOW_CNTR_COUNT_WORD_CYCLES]  <= {`FLOW_CNTR_COUNT_WORD_CYCLES_WIDTH{1'b0}};
		end
		
	end
	
	//Send the data into the combinational logic blocks in a shift_rows manner, first four cycles in use data from x registers, next four from y, up to the point when counter reaches max value.
	always @* begin
		
		//Default values, so that latch is not created
			word_out_comb = {`WORD_DATA_WIDTH{1'b0}};
			//word_out_comb_vld = 1'b0;

			//Send first word with applied shift_rows
		if      ((input_cycle == 2'h1) && counter_on) begin
			word_out_comb[`FOURTH_WRD_BYTE] = data_from_store_regs_1[`FOURTH_WRD_BYTE];
			word_out_comb[`THIRD_WRD_BYTE ] = data_from_store_regs_2[`THIRD_WRD_BYTE ];
			word_out_comb[`SECOND_WRD_BYTE] = data_from_store_regs_3[`SECOND_WRD_BYTE];
			word_out_comb[`FIRST_WRD_BYTE ] = data_from_store_regs_4[`FIRST_WRD_BYTE ];
		end
			//Send second word with applied shift_rows
		else if ((input_cycle == 2'h2)  && counter_on) begin
			word_out_comb[`FOURTH_WRD_BYTE] = data_from_store_regs_2[`FOURTH_WRD_BYTE];
			word_out_comb[`THIRD_WRD_BYTE ] = data_from_store_regs_3[`THIRD_WRD_BYTE ];
			word_out_comb[`SECOND_WRD_BYTE] = data_from_store_regs_4[`SECOND_WRD_BYTE];
			word_out_comb[`FIRST_WRD_BYTE ] = data_from_store_regs_1[`FIRST_WRD_BYTE ];
		end
			//Send third word with applied shift_rows
		else if ((input_cycle == 2'h3)  && counter_on) begin
			word_out_comb[`FOURTH_WRD_BYTE] = data_from_store_regs_3[`FOURTH_WRD_BYTE];
			word_out_comb[`THIRD_WRD_BYTE ] = data_from_store_regs_4[`THIRD_WRD_BYTE ];
			word_out_comb[`SECOND_WRD_BYTE] = data_from_store_regs_1[`SECOND_WRD_BYTE];
			word_out_comb[`FIRST_WRD_BYTE ] = data_from_store_regs_2[`FIRST_WRD_BYTE ];
		end
			//Send fourth word with applied shift_rows
		else if ((input_cycle == 2'h0)  && counter_on) begin
			word_out_comb[`FOURTH_WRD_BYTE] = data_from_store_regs_4[`FOURTH_WRD_BYTE];
			word_out_comb[`THIRD_WRD_BYTE ] = data_from_store_regs_1[`THIRD_WRD_BYTE ];
			word_out_comb[`SECOND_WRD_BYTE] = data_from_store_regs_2[`SECOND_WRD_BYTE];
			word_out_comb[`FIRST_WRD_BYTE ] = data_from_store_regs_3[`FIRST_WRD_BYTE ];
		end
	end
	
	//Save the encrypted data output from the combinational logic.
	always @(posedge clk) begin
		if (word_in_comb_vld) begin
			case ({input_cycle,is_mod_1_to_4})
		
				3'b01_1 : reg_y_word_store_1 <= word_in_comb;
				3'b01_0 : reg_x_word_store_1 <= word_in_comb;
				3'b10_1 : reg_y_word_store_2 <= word_in_comb;
				3'b10_0 : reg_x_word_store_2 <= word_in_comb;
				3'b11_1 : reg_y_word_store_3 <= word_in_comb;
				3'b11_0 : reg_x_word_store_3 <= word_in_comb;
				3'b00_1 : reg_y_word_store_4 <= word_in_comb;
				3'b00_0 : reg_x_word_store_4 <= word_in_comb;

			endcase
		end
	end
	
	//Send data out as soon as counter reaches last cycle of encryption, else send out all zeros and data valid low.
	always @(posedge clk) begin
		if ((reg_flow_cntr[`FLOW_CNTR_COUNT_WORD_CYCLES] == `LAST_CYCLE_OF_ENCRPT)) begin
			data_out_vld <= 1'b1;
			data_out <= {reg_x_word_store_1,reg_x_word_store_2,reg_x_word_store_3,word_in_comb};
		end else begin
			data_out_vld <= 1'b0;
			data_out <= {`BLOCK_DATA_WIDTH{1'b0}};
		end
	end

endmodule

	
