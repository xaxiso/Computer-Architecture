module ShiftLeft1 #(
    parameter DATA_W = 64
)(
    input  [DATA_W-1:0] i_data,
    output [DATA_W-1:0] o_data
);

assign o_data = i_data << 1;

endmodule