 `timescale 10ns/1ns

module test_module ();

`define WIDTH 32

reg [1:0]  innn;
reg [1:0]  outtt;
reg [1:0]  plus_one;
reg [3:0] plus_one_out;

wire [3:0] comb_signal;

assign comb_signal = innn + 1'b1;
reg clk;

	always @(posedge clk) begin
		outtt <= innn;
		plus_one_out <= comb_signal;
	end

initial begin
$display("\t\ttime,\tclk,\tinnn,\touttt"); 
$monitor("%d,\t%b,\t%b,\t%b",$time, clk,innn, outtt); 
		  clk = 1'b1;
	@(posedge clk) innn = 2'b01;
	repeat (1) @(posedge clk) innn = 2'b10;
	repeat (2) @(posedge clk) innn = 2'b11;
	#10  $finish;
end
		
	always #1 clk = !clk;
	

endmodule
