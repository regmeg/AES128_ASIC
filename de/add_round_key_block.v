`include "chip_defines.v"

module add_round_key_block (data_in,data_in_vld,block_data_out,block_data_out_vld,seed_key,seed_key_vld);

//Define input/output signals
	input [`BLOCK_DATA_WIDTH-1:0] data_in;
	input 					 							data_in_vld;
	input  [`SEED_KEY_WIDTH-1:0]  seed_key;
	input 												seed_key_vld;

	output [`BLOCK_DATA_WIDTH-1:0] block_data_out;
	output 												 block_data_out_vld;

	//Output signal regs
	reg [`BLOCK_DATA_WIDTH-1:0] block_data_out;
	reg 												block_data_out_vld;

// define a comibnational logic block
	always @* begin
	
		//assign data out valid to be same as data_in
		block_data_out_vld = data_in_vld;
		
		//if data in and key is valid, perform add round key, otherwise just output all zeros.
		if (data_in_vld && seed_key_vld) begin
			block_data_out = data_in ^ seed_key;
		end else begin
			block_data_out = {`BLOCK_DATA_WIDTH{1'b0}};
		end
	end

endmodule
