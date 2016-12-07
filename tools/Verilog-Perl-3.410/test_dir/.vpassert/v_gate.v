`line 1 "verilog/v_gate.v" 0
module buffer (
    output Z,
    input  A);
   buf u_buf(Z, A);
endmodule

module gate (
    output Z,
    input  A);
   buffer u_buf(Z, A);
endmodule
