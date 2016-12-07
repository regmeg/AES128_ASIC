`line 1 "verilog/t_80_foo.v" 0
// DESCRIPTION: Verilog::Preproc: Example source code
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2012-2012 by Wilson Snyder.
//
// Test -F option in vppreproc.
// This is the top level module.

module foo(output wire y, input wire x);
   bar i_bar(y, x);
endmodule // foo
