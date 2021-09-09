module Mux2to1 #(
    parameter DATA_W = 64
)(
    input  i_select,
    input  [ DATA_W - 1 : 0 ] i_input_1,
    input  [ DATA_W - 1 : 0 ] i_input_2,
    output [ DATA_W - 1 : 0 ] o_output
);

assign o_output = i_select ? i_input_1 : i_input_2;

endmodule
