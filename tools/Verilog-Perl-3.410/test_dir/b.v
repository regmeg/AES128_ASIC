// Created by vsplitmodule from 56_editfiles.v

b_front_matter;

`ifdef B_HAS_X
module b;
`elsif
module b (input x);
`endif
   wire inside_module_b;
`ifndef SYNTHESIS
   wire in_translate_off;
`endif //SYNTHESIS
endmodule

