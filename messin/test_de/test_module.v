`timescale 10ns/1ns
 
`include "../chip_defines.v"

module test_module ();

`define WIDTH 32

reg [1:0]  innn;
reg [1:0]  outtt;
reg [1:0]  plus_one;
reg [`WIDTH-1:0] cntr;
reg clk;
integer k;
integer i;
integer l;

wire [3:0] cycle_mod;
wire  		 is_mod_1_to_2;
assign cycle_mod = cntr % 3'h4;
assign is_mod_1_to_2  = ((cycle_mod > 4'h0) && (cycle_mod < 4'h3)) ? 1'b1 : 1'b0;


initial begin
			l= 0;
			$display("\t\max,\tmin,\tk,\ti"); 
			for (i = 0; i <  `sbox_h*`sbox_w*8; i = i + `sbox_w*8) begin
				l = l +1;
				$display("l is %d",l);
				for (k = 0; k < `sbox_w; k = k +1) begin
					$display("\t%d:\t:%d,\t%d,\t%d",(i + (k+1)*8 -1),(i + (k+1)*8 -1) - 7,k,i);
				end
			end
$finish;
end

endmodule
