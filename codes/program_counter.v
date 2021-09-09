module program_counter #(
    parameter DATA_W = 64
)(
    input                   i_clk,
    input                   i_rst_n,
    input  [ DATA_W-1 : 0 ] i_i_addr,
    input         [ 4 : 0 ] i_state,
    output [ DATA_W-1 : 0 ] o_i_addr,
    output                  o_i_valid_addr
);

reg [ DATA_W-1 : 0 ] o_i_addr_r,  o_i_addr_w;        
reg                  o_i_valid_addr_r, o_i_valid_addr_w;

assign o_i_addr       = o_i_addr_r;
assign o_i_valid_addr = o_i_valid_addr_r;

reg has_already, has_already_w;

always @(*) begin
    case (i_state)
        0:  begin 
            if (has_already) begin
                o_i_valid_addr_w = 0;
            end else begin
                o_i_valid_addr_w = 1;
                has_already_w    = 1;
            end
            o_i_addr_w       = o_i_addr_r;
        end
        10: begin 
            o_i_valid_addr_w = 0;
            o_i_addr_w       = i_i_addr;
            has_already_w    = 0;
        end
        default: begin
            o_i_valid_addr_w = 0;
            o_i_addr_w       = o_i_addr_r;
            has_already_w    = 0;
        end
    endcase
end


always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        o_i_addr_r       <= 0;
        o_i_valid_addr_r <= 0;
        has_already      <= 0;
    end else begin
        o_i_addr_r       <= o_i_addr_w;
        o_i_valid_addr_r <= o_i_valid_addr_w;
        has_already      <= has_already_w;
    end
end

endmodule
