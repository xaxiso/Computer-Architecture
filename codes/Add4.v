module Add4 #(
    parameter DATA_W = 64
)(
    input                     i_clk,
    input                     i_rst_n,
    input  [ DATA_W - 1 : 0 ] i_i_addr,
    output [ DATA_W - 1 : 0 ] o_i_addr
);

reg [ DATA_W - 1 : 0 ] o_i_addr_r, o_i_addr_w;

assign o_i_addr = o_i_addr_r;

always @(*) begin
    o_i_addr_w = i_i_addr + 4;
end

always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        o_i_addr_r <= 0;
    end else begin
        o_i_addr_r <= o_i_addr_w;
    end
end

endmodule
