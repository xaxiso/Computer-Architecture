module alu #(
    parameter DATA_WIDTH = 32,
    parameter INST_WIDTH = 4
)(
    //i = input, o = output
    input                   i_clk,
    input                   i_rst_n,
    input  [DATA_WIDTH-1:0] i_data_a,
    input  [DATA_WIDTH-1:0] i_data_b,
    input  [INST_WIDTH-1:0] i_inst,
    input                   i_valid,
    output [DATA_WIDTH-1:0] o_data,
    output                  o_overflow,
    output                  o_valid
);

    // r = reg, w = wire
    reg [DATA_WIDTH-1:0] o_data_r, o_data_w;
    reg                  o_overflow_r, o_overflow_w;
    reg                  o_valid_r, o_valid_w;
    reg [DATA_WIDTH-1:0] temp;
    reg [63:0] temp2;
    reg negcheck;
    reg poscheck;

    wire signed [DATA_WIDTH-1:0] signed_data_a, signed_data_b, signed_overflow_w;
    assign signed_data_a = i_data_a;
    assign signed_data_b = i_data_b;
    // assign signed_overflow_w = $signed(o_overflow_w);

    integer i;

    //continuous assignment
    assign o_data = o_data_r;
    assign o_overflow = o_overflow_r;
    assign o_valid = o_valid_r;

    //combinational port
    always @(*) begin
        if(i_valid) begin
            case (i_inst)
                4'd0: begin
                    // signed_data_a = i_data_a;
                    // signed_data_b = i_data_b;
                temp = signed_data_a + signed_data_b;
                o_data_w = temp[DATA_WIDTH-1:0];
                o_overflow_w = ~(signed_data_a[DATA_WIDTH-1] ^ signed_data_b[DATA_WIDTH-1]) &
                                (i_data_a[DATA_WIDTH-1] ^ temp[DATA_WIDTH-1]);
                o_valid_w = 1;
                end

                4'd1: begin
                    // signed_data_a = i_data_a;
                    // signed_data_b = i_data_b;
                   temp = signed_data_a - signed_data_b;
                    o_data_w = temp[DATA_WIDTH-1:0];
                    o_overflow_w = ~(signed_data_a[DATA_WIDTH-1] ^ ~signed_data_b[DATA_WIDTH-1]) &
                                    (i_data_a[DATA_WIDTH-1] ^ temp[DATA_WIDTH-1]);
                    o_valid_w = 1;
                end

                4'd2: begin
                    temp2 = signed_data_a * signed_data_b;
                    o_data_w = temp2[DATA_WIDTH-1:0];
                    negcheck = |(~temp2[62:31]); //significant digits in front to check for overflow
                    poscheck = |(temp2[62:31]);
                    o_overflow_w = (temp2[62] & negcheck) | (~(temp2[62]) & poscheck);
                    o_valid_w = 1;
                end

                4'd3: begin
                    if(signed_data_a > signed_data_b)
                        o_data_w = signed_data_a;
                    else
                        o_data_w = signed_data_b;
                    o_valid_w = 1;
                    o_overflow_w = 0;
                end

                4'd4: begin
                    if(signed_data_a < signed_data_b)
                        o_data_w = signed_data_a;
                    else
                        o_data_w = signed_data_b;
                    o_valid_w = 1;
                    o_overflow_w = 0;
                end


                4'd5: begin
                //          33 bit                  32 bit   32 bit
                    {o_overflow_w, o_data_w} = i_data_a + i_data_b;
                    o_valid_w = 1;
                end

                4'd6: begin
                    {o_overflow_w, o_data_w} = i_data_a - i_data_b;
                    o_valid_w = 1;
                end

                4'd7: begin
                    {o_overflow_w, o_data_w} = i_data_a * i_data_b;
                    o_valid_w = 1;
                end

                4'd8: begin
                    if(i_data_a > i_data_b)
                        o_data_w = i_data_a;
                    else
                        o_data_w = i_data_b;
                    o_valid_w = 1;
                    o_overflow_w = 0;
                end

                4'd9: begin
                    if(i_data_a < i_data_b)
                        o_data_w = i_data_a;
                    else
                        o_data_w = i_data_b;
                    o_valid_w = 1;
                    o_overflow_w = 0;
                end

                4'd10: begin
                    o_data_w = i_data_a & i_data_b;
                    o_valid_w = 1;
                end

                4'd11: begin
                    o_data_w = i_data_a | i_data_b;
                    o_valid_w = 1;
                end

                4'd12: begin
                    o_data_w = i_data_a ^ i_data_b;
                    o_valid_w = 1;
                end

                4'd13: begin
                    o_data_w = ~i_data_a;
                    o_valid_w = 1;
                end

                4'd14: begin
                    for(i=0;i<DATA_WIDTH;i++)
                        o_data_w[i] = i_data_a[DATA_WIDTH-i-1];
                    o_valid_w = 1;
                end

                default: begin
                    o_overflow_w = 0;
                    o_data_w     = 0;
                    o_valid_w    = 1;
                end
            endcase
        end
        else begin
            o_overflow_w = 0;
            o_data_w     = 0;
            o_valid_w    = 0;
        end
    end

    // sequential circuit
    always @(posedge i_clk or negedge i_rst_n) begin
        if(~i_rst_n) begin
            o_data_r <= 0;
            o_overflow_r <= 0;
            o_valid_r <= 0;
        end else begin
            o_data_r <= o_data_w;
            o_overflow_r <= o_overflow_w;
            o_valid_r <= o_valid_w;
        end
    end

    

endmodule