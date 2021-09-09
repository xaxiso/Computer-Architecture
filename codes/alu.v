module alu #(
    parameter DATA_W = 64,
    parameter INST_W = 4
)(
    input                     i_clk,
    input                     i_rst_n,
    input  [ DATA_W - 1 : 0 ] i_data_a,
    input  [ DATA_W - 1 : 0 ] i_data_b,
    input  [ INST_W - 1 : 0 ] i_inst,
    output                    o_take,
    output [ DATA_W - 1 : 0 ] o_data
);

reg                    o_take_r, o_take_w;
reg [ DATA_W - 1 : 0 ] o_data_r, o_data_w;

assign o_take     = o_take_r;
assign o_data     = o_data_r;

always @ (*) begin
    case (i_inst)
        4'd0 : begin // add
            o_data_w = i_data_a + i_data_b;
            o_take_w = 0;
        end
        4'd1 : begin // sub
            o_data_w = i_data_a - i_data_b;
            o_take_w = 0;
        end
        4'd2 : begin // and
            o_data_w = i_data_a & i_data_b; 
            o_take_w = 0;
        end
        4'd3 : begin // or
            o_data_w = i_data_a | i_data_b; 
            o_take_w = 0;
        end
        4'd4 : begin // xor
            o_data_w = i_data_a ^ i_data_b; 
            o_take_w = 0;
        end
        4'd5 : begin // shift left 
            o_data_w = i_data_a << i_data_b;
            o_take_w = 0;
        end
        4'd6 : begin // shift right
            o_data_w = i_data_a >> i_data_b;
            o_take_w = 0;
        end 
        4'd7 : begin // beq
            o_data_w = 0;
            o_take_w = (i_data_a == i_data_b) ? 1 : 0; // eq
        end 
        4'd8 : begin // bne
            o_data_w = 0;
            o_take_w = (i_data_a != i_data_b) ? 1 : 0; // ne
        end 
        default: begin
            o_data_w = o_data_r;
            o_take_w = o_take_r;
        end
    endcase
end

always @ (posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        o_data_r     <= 0;
        o_take_r     <= 0;
    end else begin 
        o_data_r     <= o_data_w;
        o_take_r     <= o_take_w;
    end
end

endmodule

