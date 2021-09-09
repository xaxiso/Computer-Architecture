module decoder #(
    parameter OPCODE_W = 10
)(
    input                     i_clk,
    input                     i_rst_n,
    input                     i_d_valid_data,
    input                     i_i_valid_inst,
    input                     i_add_or_sub,
    input  [ OPCODE_W-1 : 0 ] i_inst,
    output [          3 : 0 ] o_alu_op,
    output                    o_alu_src,
    output                    o_branch,
    output                    o_mem_read,
    output                    o_mem_write,
    output                    o_mem_to_reg,
    output                    o_reg_write,
    output                    o_stop,
    output [          4 : 0 ] o_state
);

reg [ 3 : 0 ] o_alu_op_r,     o_alu_op_w;
reg           o_alu_src_r,    o_alu_src_w;
reg           o_branch_r,     o_branch_w;
reg           o_mem_read_r,   o_mem_read_w;
reg           o_mem_write_r,  o_mem_write_w;
reg           o_mem_to_reg_r, o_mem_to_reg_w;
reg           o_reg_write_r,  o_reg_write_w;
reg           o_stop_r,       o_stop_w;
reg [ 4 : 0 ] state, state_w;
reg           canWrite;

assign o_alu_op     = o_alu_op_r;
assign o_alu_src    = o_alu_src_r;
assign o_branch     = o_branch_r;
assign o_mem_read   = o_mem_read_r;
assign o_mem_write  = o_mem_write_r  & canWrite;
assign o_mem_to_reg = o_mem_to_reg_r;
assign o_reg_write  = o_reg_write_r;
assign o_stop       = o_stop_r;
assign o_state      = state;

always @(*) begin
    case (state)
        0: begin
            if (i_i_valid_inst) begin
                state_w  = 1;
                canWrite = 0;
            end else begin
                state_w  = 0;
                canWrite = 0;
            end
        end
        10: begin
            state_w  = 0;
            canWrite = 1;
        end
        default: begin
            state_w  = state + 1;
            canWrite = 0;
        end
    endcase
end

always @(*) begin
    case (i_inst)
        10'b1111111111 : begin  // eof
            o_alu_op_w     = 4'd0;
            o_alu_src_w    = 0;
            o_branch_w     = 0;
            o_mem_read_w   = 0;
            o_mem_write_w  = 0;
            o_mem_to_reg_w = 0;
            o_reg_write_w  = 0;
            o_stop_w       = 1;
        end
        10'b0001100011 : begin  // beq
            o_alu_op_w     = 4'd7; // eq
            o_alu_src_w    = 0;
            o_branch_w     = 1;
            o_mem_read_w   = 0;
            o_mem_write_w  = 0;
            o_mem_to_reg_w = 0;
            o_reg_write_w  = 0;
            o_stop_w       = 0;
        end
        10'b0011100011 : begin  // bne
            o_alu_op_w     = 4'd8; // ne
            o_alu_src_w    = 0;
            o_branch_w     = 1;
            o_mem_read_w   = 0;
            o_mem_write_w  = 0;
            o_mem_to_reg_w = 0;
            o_reg_write_w  = 0;
            o_stop_w       = 0;
        end
        10'b0000010011 : begin  // addi
            o_alu_op_w     = 4'd0; // add
            o_alu_src_w    = 1;
            o_branch_w     = 0;
            o_mem_read_w   = 0;
            o_mem_write_w  = 0;
            o_mem_to_reg_w = 0;
            o_reg_write_w  = 1;
            o_stop_w       = 0;
        end
        10'b1000010011 : begin  // xori
            o_alu_op_w     = 4'd4; // xor
            o_alu_src_w    = 1;
            o_branch_w     = 0;
            o_mem_read_w   = 0;
            o_mem_write_w  = 0;
            o_mem_to_reg_w = 0;
            o_reg_write_w  = 1;
            o_stop_w       = 0;
        end
        10'b1100010011 : begin  // ori
            o_alu_op_w     = 4'd3; // or
            o_alu_src_w    = 1;
            o_branch_w     = 0;
            o_mem_read_w   = 0;
            o_mem_write_w  = 0;
            o_mem_to_reg_w = 0;
            o_reg_write_w  = 1;
            o_stop_w       = 0;
        end
        10'b1110010011 : begin  // andi
            o_alu_op_w     = 4'd2; // and
            o_alu_src_w    = 1;
            o_branch_w     = 0;
            o_mem_read_w   = 0;
            o_mem_write_w  = 0;
            o_mem_to_reg_w = 0;
            o_reg_write_w  = 1;
            o_stop_w       = 0;
        end
        10'b0010010011 : begin  // slli
            o_alu_op_w     = 4'd5; // sl
            o_alu_src_w    = 1;
            o_branch_w     = 0;
            o_mem_read_w   = 0;
            o_mem_write_w  = 0;
            o_mem_to_reg_w = 0;
            o_reg_write_w  = 1;
            o_stop_w       = 0;
        end
        10'b1010010011 : begin  // srli
            o_alu_op_w     = 4'd6; // sr
            o_alu_src_w    = 1;
            o_branch_w     = 0;
            o_mem_read_w   = 0;
            o_mem_write_w  = 0;
            o_mem_to_reg_w = 0;
            o_reg_write_w  = 1;
            o_stop_w       = 0;
        end
        10'b0000110011 : begin  // add
            o_alu_op_w     = {3'd0, i_add_or_sub}; // add
            o_alu_src_w    = 0;
            o_branch_w     = 0;
            o_mem_read_w   = 0;
            o_mem_write_w  = 0;
            o_mem_to_reg_w = 0;
            o_reg_write_w  = 1;
            o_stop_w       = 0;
        end
        10'b0000110011 : begin  // sub
            o_alu_op_w     = 4'd1; // sub
            o_alu_src_w    = 0;
            o_branch_w     = 0;
            o_mem_read_w   = 0;
            o_mem_write_w  = 0;
            o_mem_to_reg_w = 0;
            o_reg_write_w  = 1;
            o_stop_w       = 0;
        end
        10'b1000110011 : begin  // xor
            o_alu_op_w     = 4'd4; // xor
            o_alu_src_w    = 0;
            o_branch_w     = 0;
            o_mem_read_w   = 0;
            o_mem_write_w  = 0;
            o_mem_to_reg_w = 0;
            o_reg_write_w  = 1;
            o_stop_w       = 0;
        end
        10'b1100110011 : begin  // or
            o_alu_op_w     = 4'd3; // or
            o_alu_src_w    = 0;
            o_branch_w     = 0;
            o_mem_read_w   = 0;
            o_mem_write_w  = 0;
            o_mem_to_reg_w = 0;
            o_reg_write_w  = 1;
            o_stop_w       = 0;
        end
        10'b1110110011 : begin  // and
            o_alu_op_w     = 4'd2; // and
            o_alu_src_w    = 0;
            o_branch_w     = 0;
            o_mem_read_w   = 0;
            o_mem_write_w  = 0;
            o_mem_to_reg_w = 0;
            o_reg_write_w  = 1;
            o_stop_w       = 0;
        end
        10'b0110000011 : begin  // ld
            o_alu_op_w     = 4'd0; // add
            o_alu_src_w    = 1;
            o_branch_w     = 0;
            o_mem_read_w   = 1;
            o_mem_write_w  = 0;
            o_mem_to_reg_w = 1;
            o_reg_write_w  = 1;
            o_stop_w       = 0;
        end
        10'b0110100011 : begin  // sd
            o_alu_op_w     = 4'd0; // add
            o_alu_src_w    = 1;
            o_branch_w     = 0;
            o_mem_read_w   = 0;
            o_mem_write_w  = 1;
            o_mem_to_reg_w = 0;
            o_reg_write_w  = 0;
            o_stop_w       = 0;
        end
        default : begin
            o_alu_op_w     = o_alu_op_r;
            o_alu_src_w    = o_alu_src_r;
            o_branch_w     = o_branch_r;
            o_mem_read_w   = o_mem_read_r;
            o_mem_write_w  = o_mem_write_r;
            o_mem_to_reg_w = o_mem_to_reg_r;
            o_reg_write_w  = o_reg_write_r;
            o_stop_w       = o_stop_r;
        end
    endcase
end

always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        o_alu_op_r     <= 0;
        o_alu_src_r    <= 0;
        o_branch_r     <= 0;
        o_mem_read_r   <= 0;
        o_mem_write_r  <= 0;
        o_mem_to_reg_r <= 0;
        o_reg_write_r  <= 0;
        o_stop_r       <= 0;
        state          <= 0;
    end else begin
        o_alu_op_r     <= o_alu_op_w;
        o_alu_src_r    <= o_alu_src_w;
        o_branch_r     <= o_branch_w;
        o_mem_read_r   <= o_mem_read_w;
        o_mem_write_r  <= o_mem_write_w;
        o_mem_to_reg_r <= o_mem_to_reg_w;
        o_reg_write_r  <= o_reg_write_w;
        o_stop_r       <= o_stop_w;
        state          <= state_w;
    end
end
endmodule


