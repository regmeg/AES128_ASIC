module test_module;

`define WIDTH 32

reg [`WIDTH-1:0]  a;

initial begin
  a = `WIDTH'hae234;
  $display ("Current Value of a = %h", a);
  a = -14'h1234;
  $display ("Current Value of a = %h", a);
  a = 32'hDEAD_BEEF;
  $display ("Current Value of a = %h", a);
  a = -32'hDEAD_BEEF;
  $display ("Current Value of a = %h", a);
   #10  $finish;
end

endmodule
