module ImmGen #(
    parameter INST_W = 32,
    parameter DATA_W = 64
)(
    input i_clk,
    input i_rst_n,
    input  [ INST_W-1 : 0 ] i_input,
    output [ DATA_W-1 : 0 ] o_output
);

reg [DATA_W-1:0] o_output_r, o_output_w;

assign o_output = o_output_r;

always @(*) begin
    case(i_input[6:0]) 
    	7'b1100011: o_output_w = {{53{i_input[31]}},i_input[7],i_input[30:25],i_input[11:8]};
    	7'b0010011: o_output_w = {52'b0, i_input[31:20]};
    	7'b0000011: o_output_w = {52'b0, i_input[31:20]};
    	7'b0100011: o_output_w = {52'b0, i_input[31:25], i_input[11:7]};
    	default:    o_output_w = 0;
    endcase
end

always @(posedge i_clk or negedge i_rst_n) begin
	if (~i_rst_n) begin
		o_output_r <= 0;
	end else begin
		o_output_r <= o_output_w;
	end
end

endmodule
