`include "chip_defines.v"

module flow_cntrl(clk,reset,block_data_in,block_data_in_vld,data_out,data_out_vld,data_accept,key_available,rnd_key_gen,word_out_comb,word_out_comb_vld
mix_column_off,word_in_comb);

//INPUTS
	input 												clk;
	input 												reset;
	
	input [`BLOCK_DATA_WIDTH-1:0] block_data_in;
	input 												block_data_in_vld;
	input [`WORD_DATA_WIDTH:0]		word_in_comb;
	input 												key_available;

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
	reg 												data_accept;
	reg [`WORD_DATA_WIDTH-1:0]	word_out_comb;
	reg 												word_out_comb_vld;
	reg 												mix_column_off;
	//Internal Signals
	reg counter_on;
	
//Internal wires
	wire [`WORD_DATA_WIDTH-1:0] data_from_store_regs_1;
	wire [`WORD_DATA_WIDTH-1:0] data_from_store_regs_2;
	wire [`WORD_DATA_WIDTH-1:0] data_from_store_regs_3;
	wire [`WORD_DATA_WIDTH-1:0] data_from_store_regs_4;
	wire [1:0]									input_cycle;

	
//Assign rnd_key_gen signal to be issued the same time when valid signal comes in ,so that key expansion starts to generate keys and then let counter to drive it.
	assign rnd_key_gen = block_data_in_vld ? block_data_in_vld : counter_on;

/*Assign the switching signal logic, which switches between x and y regs.
 For reading data from regs as input to combinational logic, counter is going to indicate previous encryption cyclce
 For saving data into regs as output from combinational logic counter is going to indicate the current encryption cycle of the word*/
	assign input_cycle = 
	assign cntr_mod_with_eight    = reg_flow_cntr[`FLOW_CNTR_COUNT_WORD_CYCLES] % 1'h8;

	
	assign data_from_store_regs_1 = () ? reg_x_word_store_1 : reg_y_word_store_1;
	assign data_from_store_regs_2 = () ? reg_x_word_store_2 : reg_y_word_store_2;
	assign data_from_store_regs_3 = () ? reg_x_word_store_3 : reg_y_word_store_3;
	assign data_from_store_regs_4 = () ? reg_x_word_store_4 : reg_y_word_store_4;

//Set all registers to 0 after the reset
	always @(posedge reset) begin
		reg_x_word_store_1 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_x_word_store_2 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_x_word_store_3 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_x_word_store_4 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_y_word_store_1 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_y_word_store_2 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_y_word_store_3 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_y_word_store_4 <= {`WORD_DATA_WIDTH{1'b0}};
		reg_flow_cntr			 <= {`WORD_DATA_WIDTH{1'b0}};
	end
	
	//Issue DATA_ACCEPT if seed key becomes available or counter reaches d'40 (0x28)
	always @(posedge clk) begin
		if (key_available || (reg_flow_cntr[`FLOW_CNTR_COUNT_WORD_CYCLES] == `LAST_CYCLE_OF_ENCRPT)) begin
			data_accept <= 1'b1;
		else
			data_accept <= 1'b0;
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
				reg_flow_cntr[`FLOW_CNTR_COUNT_WORD_CYCLES] <= reg_flow_cntr[`FLOW_CNTR_COUNT_WORD_CYCLES] + 1b'1;
				counter_on <= block_data_in_vld;
		end
		 // One cycle earlier before cntr=0x28, so that counter_on is sampled as low straight away after cntr = 0x28 and it gets reset.
		if (reg_flow_cntr[`FLOW_CNTR_COUNT_WORD_CYCLES] == `LAST_CYCLE_OF_ENCRPT - 1b'1 ) begin
				counter_on <= 1'b0;
				reg_flow_cntr[`FLOW_CNTR_COUNT_WORD_CYCLES]  <= {`FLOW_CNTR_COUNT_WORD_CYCLES_WIDTH{1'b0}};
		end
		
	end
	
	//Send the data into the combinational logic blocks in a shift_rows manner, first four cycles in use data from x registers, next four from y, up to the point when counter reaches max value.
	always @* begin
		
		//Default values, so that latch is not created
			word_out_comb_vld = 1'b0;
			word_out_comb[`FIRST_WRD_BYTE ] = {`WORD_DATA_WIDTH{1'b0}};
			word_out_comb[`SECOND_WRD_BYTE] = {`WORD_DATA_WIDTH{1'b0}};
			word_out_comb[`THIRD_WRD_BYTE ] = {`WORD_DATA_WIDTH{1'b0}};
			word_out_comb[`FOURTH_WRD_BYTE] = {`WORD_DATA_WIDTH{1'b0}};
			//Send first word with applied shift_rows
		if      (first_input_cycle) begin
			word_out_comb_vld = 1'b1;
			word_out_comb[`FIRST_WRD_BYTE ] = data_from_store_regs_1[`FIRST_WRD_BYTE ];
			word_out_comb[`SECOND_WRD_BYTE] = data_from_store_regs_2[`FOURTH_WRD_BYTE];
			word_out_comb[`THIRD_WRD_BYTE ] = data_from_store_regs_3[`THIRD_WRD_BYTE ];
			word_out_comb[`FOURTH_WRD_BYTE] = data_from_store_regs_4[`SECOND_WRD_BYTE];
			//Send second word with applied shift_rows
		else if (second_input_cycle) begin
			word_out_comb_vld = 1'b1;
			word_out_comb[`FIRST_WRD_BYTE ] = data_from_store_regs_1[`SECOND_WRD_BYTE];
			word_out_comb[`SECOND_WRD_BYTE] = data_from_store_regs_2[`FIRST_WRD_BYTE ];
			word_out_comb[`THIRD_WRD_BYTE ] = data_from_store_regs_3[`FOURTH_WRD_BYTE];
			word_out_comb[`FOURTH_WRD_BYTE] = data_from_store_regs_4[`THIRD_WRD_BYTE ];
			//Send third word with applied shift_rows
		else if (third_input_cycle) begin
			word_out_comb_vld = 1'b1;
			word_out_comb[`FIRST_WRD_BYTE ] = data_from_store_regs_1[`THIRD_WRD_BYTE ];
			word_out_comb[`SECOND_WRD_BYTE] = data_from_store_regs_2[`SECOND_WRD_BYTE];
			word_out_comb[`THIRD_WRD_BYTE ] = data_from_store_regs_3[`FIRST_WRD_BYTE ];
			word_out_comb[`FOURTH_WRD_BYTE] = data_from_store_regs_4[`FOURTH_WRD_BYTE];
			//Send fourth word with applied shift_rows
		else if (fourth_input_cycle) begin
			word_out_comb_vld = 1'b1;
			word_out_comb[`FIRST_WRD_BYTE ] = data_from_store_regs_1[`FOURTH_WRD_BYTE];
			word_out_comb[`SECOND_WRD_BYTE] = data_from_store_regs_2[`THIRD_WRD_BYTE ];
			word_out_comb[`THIRD_WRD_BYTE ] = data_from_store_regs_3[`SECOND_WRD_BYTE];
			word_out_comb[`FOURTH_WRD_BYTE] = data_from_store_regs_4[`FIRST_WRD_BYTE ];
		
	end
endmodule

	
