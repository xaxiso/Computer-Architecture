module register_file #(
    parameter ADDR_W = 64,
    parameter INST_W = 32,
    parameter DATA_W = 64
)(
    input               i_clk,
    input               i_rst_n,
    input               i_RegWrite,
    input         [4:0] i_read_register1,
    input         [4:0] i_read_register2,
    input         [4:0] i_write_register,
    input  [DATA_W-1:0] i_write_data,
    input         [4:0] i_state,
    output [DATA_W-1:0] o_write_data1, 
    output [DATA_W-1:0] o_write_data2
);

reg [DATA_W-1:0] o_write_data1_r, o_write_data1_w;
reg [DATA_W-1:0] o_write_data2_r, o_write_data2_w;

reg [DATA_W-1:0] registers [31:0];

integer idx;

assign o_write_data1 = o_write_data1_r;
assign o_write_data2 = o_write_data2_r;

always @(*) begin
    o_write_data1_w = registers[i_read_register1];
    o_write_data2_w = registers[i_read_register2];
end

always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        o_write_data1_r <= 0;
        o_write_data2_r <= 0;
        for (idx = 0; idx < 32; idx = idx + 1) begin
            registers[idx] <= 0;
        end
    end else begin
        o_write_data1_r <= o_write_data1_w;
        o_write_data2_r <= o_write_data2_w;
        if (i_RegWrite && i_state == 10) begin
            registers[i_write_register] <= i_write_data;
        end
    end
end

endmodule
