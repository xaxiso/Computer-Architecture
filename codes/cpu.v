module cpu #( // Do not modify interface
    parameter ADDR_W = 64,
    parameter INST_W = 32,
    parameter DATA_W = 64
)(
    input                   i_clk,
    input                   i_rst_n,
    input                   i_i_valid_inst, // from instruction memory
    input  [ INST_W-1 : 0 ] i_i_inst,       // from instruction memory
    input                   i_d_valid_data, // from data memory
    input  [ DATA_W-1 : 0 ] i_d_data,       // from data memory
    output                  o_i_valid_addr, // to instruction memory
    output [ ADDR_W-1 : 0 ] o_i_addr,       // to instruction memory
    output [ DATA_W-1 : 0 ] o_d_w_data,     // to data memory
    output [ ADDR_W-1 : 0 ] o_d_w_addr,     // to data memory
    output [ ADDR_W-1 : 0 ] o_d_r_addr,     // to data memory
    output                  o_d_MemRead,    // to data memory
    output                  o_d_MemWrite,   // to data memory
    output                  o_finish
);

// wire for control signal
wire       RegWrite;
wire       alu_take;
wire       decoder_branch;
wire       Branch;
wire [3:0] ALUOp;
wire       ALUSrc; 
wire       MemtoReg;
wire       MemRead;
wire       MemWrite;
wire [4:0] WriteRegister;
wire [4:0] state;

wire [ DATA_W-1 : 0 ] WriteData,
                      ReadData1, ReadData2, ALUsrcData, ImmGenData, ShiftedImmGenData,
                      ALUResult,
                      ProgramCounter, ProgramCounter_add4, 
                      ProgramCounter_with_branch, NewProgramCounter;

reg  [ INST_W-1 : 0] temp_inst;
always @(posedge i_clk) begin
    if(~i_rst_n) begin
        temp_inst <= 0;
    end else begin
        if (i_i_valid_inst) begin
            temp_inst <= i_i_inst;
        end
    end
end

assign Branch       = (alu_take & decoder_branch);
assign o_d_w_addr     = ALUResult;
assign o_d_r_addr     = ALUResult;
assign o_d_MemRead  = MemRead;
assign o_d_MemWrite = MemWrite;
assign o_d_w_data     = ReadData2;
assign o_i_addr     = ProgramCounter;

register_file #(
    .ADDR_W(ADDR_W),
    .INST_W(INST_W),
    .DATA_W(DATA_W)
) u_register_file (
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_RegWrite(RegWrite),
    .i_read_register1(temp_inst[19:15]),
    .i_read_register2(temp_inst[24:20]),
    .i_write_register(temp_inst[11:7]),
    .i_write_data(WriteData),
    .i_state(state),
    .o_write_data1(ReadData1),
    .o_write_data2(ReadData2)
);

decoder #(
    .OPCODE_W(10)
) u_decoder (
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_d_valid_data(i_d_valid_data),
    .i_i_valid_inst(i_i_valid_inst),
    .i_inst({temp_inst[14:12], temp_inst[6:0]}),
    .i_add_or_sub(temp_inst[30]),
    .o_alu_op(ALUOp),
    .o_alu_src(ALUSrc),
    .o_branch(decoder_branch),
    .o_mem_read(MemRead),
    .o_mem_write(MemWrite),
    .o_mem_to_reg(MemtoReg),
    .o_reg_write(RegWrite),
    .o_stop(o_finish),
    .o_state(state)
);

program_counter #(
    .DATA_W(DATA_W)
) u_program_counter (
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_i_addr(NewProgramCounter),
    .i_state(state),
    .o_i_addr(ProgramCounter),
    .o_i_valid_addr(o_i_valid_addr)
);

alu #(
    .DATA_W(DATA_W),
    .INST_W(4)
) u_alu (
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_data_a(ReadData1),
    .i_data_b(ALUsrcData),
    .i_inst(ALUOp),
    .o_take(alu_take),
    .o_data(ALUResult)
);

Add4 #(
    .DATA_W(DATA_W)
) u_Add4 (
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_i_addr(ProgramCounter),
    .o_i_addr(ProgramCounter_add4)
);

Adder #(
    .DATA_W(DATA_W)
) u_Adder (
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_data1(ProgramCounter),
    .i_data2(ShiftedImmGenData),
    .o_data(ProgramCounter_with_branch)
);

// for PC branch control
Mux2to1 #(
    .DATA_W(DATA_W)
) u1_Mux2to1 (
    .i_select(Branch),
    .i_input_1(ProgramCounter_with_branch),
    .i_input_2(ProgramCounter_add4),
    .o_output(NewProgramCounter)
);

// for write back to register file
Mux2to1 #(
    .DATA_W(DATA_W)
) u2_Mux2to1 (
    .i_select(MemtoReg),
    .i_input_1(i_d_data),
    .i_input_2(ALUResult),
    .o_output(WriteData)
);

// for ALU src
Mux2to1 #(
    .DATA_W(DATA_W)
) u3_Mux2to1 (
    .i_select(ALUSrc),
    .i_input_1(ImmGenData),
    .i_input_2(ReadData2),
    .o_output(ALUsrcData)
);

ImmGen #(
    .DATA_W(DATA_W)
) u_ImmGen (
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_input(temp_inst[31:0]),
    .o_output(ImmGenData)
);

ShiftLeft1 #(
    .DATA_W(DATA_W)
) u_ShiftLeft1 (
    .i_data(ImmGenData),
    .o_data(ShiftedImmGenData)
);

endmodule
