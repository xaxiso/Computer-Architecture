module data_memory #(
    parameter ADDR_W = 64,
    parameter DATA_W = 64
)(
    input               i_clk,
    input               i_rst_n,
    input  [DATA_W-1:0] i_data,
    input  [ADDR_W-1:0] i_r_addr,
    input  [ADDR_W-1:0] i_w_addr,
    input               i_MemRead,
    input               i_MemWrite,
    output              o_valid,
    output [DATA_W-1:0] o_data
);
 
    reg [7:0] mem   [0:1023];
    reg [7:0] mem_w [0:1023];
    
    reg              o_valid_r, o_valid_w;
    reg [DATA_W-1:0] o_data_r,  o_data_w;
    
    reg              temp1_MemRead_r,  temp1_MemRead_w;
    reg [ADDR_W-1:0] temp1_r_addr_r, temp1_r_addr_w;
    
    integer i;
    
    assign o_valid = o_valid_r;
    assign o_data  = o_data_r;
    
    // cycle 1
    always @(*) begin
        temp1_r_addr_w   = i_r_addr;
        temp1_MemRead_w  = i_MemRead;
    end

    // cycle 1
    always @(*) begin
        for (i=0; i < 1024; i++) begin
            mem_w[i] = mem[i];
        end
        if (i_MemWrite) begin
            mem_w[i_w_addr+0] = i_data[ 7:0] ;
            mem_w[i_w_addr+1] = i_data[15:8] ;
            mem_w[i_w_addr+2] = i_data[23:16];
            mem_w[i_w_addr+3] = i_data[31:24];
            mem_w[i_w_addr+4] = i_data[39:32];
            mem_w[i_w_addr+5] = i_data[47:40];  
            mem_w[i_w_addr+6] = i_data[55:48];
            mem_w[i_w_addr+7] = i_data[63:56];
        end else begin
            mem_w[i_w_addr+0] = mem[i_w_addr+0];
            mem_w[i_w_addr+1] = mem[i_w_addr+1];
            mem_w[i_w_addr+2] = mem[i_w_addr+2];
            mem_w[i_w_addr+3] = mem[i_w_addr+3];
            mem_w[i_w_addr+4] = mem[i_w_addr+4];
            mem_w[i_w_addr+5] = mem[i_w_addr+5];  
            mem_w[i_w_addr+6] = mem[i_w_addr+6];
            mem_w[i_w_addr+7] = mem[i_w_addr+7];
        end
    end

    // cycle 2
    always @(*) begin
        o_valid_w = (temp1_MemRead_r) ? 1 : 0;
        o_data_w  = (temp1_MemRead_r) ? {mem[temp1_r_addr_r+7], mem[temp1_r_addr_r+6],
                                         mem[temp1_r_addr_r+5], mem[temp1_r_addr_r+4],
                                         mem[temp1_r_addr_r+3], mem[temp1_r_addr_r+2], 
                                         mem[temp1_r_addr_r+1], mem[temp1_r_addr_r+0]} : 0;
    end

    always @(posedge i_clk or negedge i_rst_n) begin
        if (~i_rst_n) begin
            o_valid_r        <= 0;
            o_data_r         <= 0;
            temp1_MemRead_r  <= 0;
            temp1_r_addr_r   <= 0;
            for (i=0; i<1024; i++)
                mem[i] <= 0;
        end else begin
            o_valid_r        <= o_valid_w;
            o_data_r         <= o_data_w;
            temp1_MemRead_r  <= temp1_MemRead_w;
            temp1_r_addr_r   <= temp1_r_addr_w;
            for (i=0; i<1024; i++)
                mem[i] <= mem_w[i];
        end
    end

endmodule 