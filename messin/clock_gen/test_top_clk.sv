module clock_gen();
 reg clk = 0;
  
  always #5 clk++;
  
 initial begin
  $monitor("%d[ns]: clock tick x0%x",$time,clk);
  #201 $finish;
 end

endmodule
