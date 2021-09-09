module Adder #(
    parameter DATA_W = 64
)(
    input                     i_clk,
    input                     i_rst_n,
    input  [ DATA_W - 1 : 0 ] i_data2,
    input  [ DATA_W - 1 : 0 ] i_data1,
    output [ DATA_W - 1 : 0 ] o_data
);

reg [ DATA_W - 1 : 0 ] o_data_r, o_data_w;

assign o_data = o_data_r;

always @(*) begin
    o_data_w = i_data1 + i_data2;
end

always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        o_data_r <= 0;
    end else begin
        o_data_r <= o_data_w;
    end
end

endmodule
