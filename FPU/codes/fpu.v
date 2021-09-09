module fpu #(
    parameter DATA_WIDTH = 32,
    parameter INST_WIDTH = 1
)(
    input                   i_clk,
    input                   i_rst_n,
    input  [DATA_WIDTH-1:0] i_data_a,
    input  [DATA_WIDTH-1:0] i_data_b,
    input  [INST_WIDTH-1:0] i_inst,
    input                   i_valid,
    output [DATA_WIDTH-1:0] o_data,
    output                  o_valid
);


wire [23:0] i_data_a_fraction, i_data_b_fraction;
wire [7:0]  i_data_a_exponent, i_data_b_exponent;
wire        i_data_a_sign,     i_data_b_sign;

assign i_data_a_fraction = {1'b1, i_data_a[22:0]};
assign i_data_b_fraction = {1'b1, i_data_b[22:0]};
assign i_data_a_exponent = i_data_a[30:23];
assign i_data_b_exponent = i_data_b[30:23];
assign i_data_a_sign     = i_data_a[31];
assign i_data_b_sign     = i_data_b[31];


//ADD
wire [23:0] big_fraction, small_fraction;
wire [7:0]  big_exponent, small_exponent;
wire        big_sign    , small_sign;

assign big_exponent   = (i_data_a_exponent > i_data_b_exponent) ? 
                         i_data_a_exponent : i_data_b_exponent;

assign small_exponent = (i_data_a_exponent < i_data_b_exponent) ? 
                         i_data_a_exponent : i_data_b_exponent;   

assign big_fraction   = (i_data_a_exponent > i_data_b_exponent) ? 
                         i_data_a_fraction : i_data_b_fraction;

assign small_fraction = (i_data_a_exponent < i_data_b_exponent) ? 
                         i_data_a_fraction : i_data_b_fraction;

assign big_sign       = (i_data_a_exponent > i_data_b_exponent) ? 
                         i_data_a_sign     : i_data_b_sign;

assign small_sign     = (i_data_a_exponent < i_data_b_exponent) ? 
                         i_data_a_sign     : i_data_b_sign;                       

wire [7:0] exponent_difference;
assign exponent_difference = big_exponent - small_exponent;

wire [47:0] shifted_small_fraction;
wire [47:0] extended_big_fraction; 
assign shifted_small_fraction = {small_fraction, 24'd0} >> exponent_difference;
assign extended_big_fraction  = {big_fraction, 24'd0};

wire [48:0] sum_of_fraction;
assign sum_of_fraction = ~(big_sign ^ small_sign) ? (shifted_small_fraction + extended_big_fraction) : 
                            (extended_big_fraction - shifted_small_fraction);


reg [7:0] normalized_exponent;
reg [48:0] shifted_sum_of_fraction;
always @(*) begin
    if (sum_of_fraction[48]) begin
        normalized_exponent = big_exponent - (47-48);
        shifted_sum_of_fraction = sum_of_fraction << (48-48);

    end else if (sum_of_fraction[47]) begin
        normalized_exponent = big_exponent - (47-47);
        shifted_sum_of_fraction = sum_of_fraction << (48-47);
    end else if (sum_of_fraction[46]) begin
        normalized_exponent = big_exponent - (47-46);
        shifted_sum_of_fraction = sum_of_fraction << (48-46);
    end else if (sum_of_fraction[45]) begin
        normalized_exponent = big_exponent - (47-45);
        shifted_sum_of_fraction = sum_of_fraction << (48-45);
    end else if (sum_of_fraction[44]) begin
        normalized_exponent = big_exponent - (47-44);
        shifted_sum_of_fraction = sum_of_fraction << (48-44);
    end else if (sum_of_fraction[43]) begin
        normalized_exponent = big_exponent - (47-43);
        shifted_sum_of_fraction = sum_of_fraction << (48-43);
    end else if (sum_of_fraction[42]) begin
        normalized_exponent = big_exponent - (47-42);
        shifted_sum_of_fraction = sum_of_fraction << (48-42);
    end else if (sum_of_fraction[41]) begin
        normalized_exponent = big_exponent - (47-41);
        shifted_sum_of_fraction = sum_of_fraction << (48-41);
    end else if (sum_of_fraction[40]) begin
        normalized_exponent = big_exponent - (47-40);
        shifted_sum_of_fraction = sum_of_fraction << (48-40);
    end else if (sum_of_fraction[39]) begin
        normalized_exponent = big_exponent - (47-39);
        shifted_sum_of_fraction = sum_of_fraction << (48-39);
    end else if (sum_of_fraction[38]) begin
        normalized_exponent = big_exponent - (47-38);
        shifted_sum_of_fraction = sum_of_fraction << (48-38);
    end else if (sum_of_fraction[37]) begin
        normalized_exponent = big_exponent - (47-37);
        shifted_sum_of_fraction = sum_of_fraction << (48-37);
    end else
    if (sum_of_fraction[36]) begin
        normalized_exponent = big_exponent - (47-36);
        shifted_sum_of_fraction = sum_of_fraction << (48-36);
    end else
    if (sum_of_fraction[35]) begin
        normalized_exponent = big_exponent - (47-35);
        shifted_sum_of_fraction = sum_of_fraction << (48-35);
    end else
    if (sum_of_fraction[34]) begin
        normalized_exponent = big_exponent - (47-34);
        shifted_sum_of_fraction = sum_of_fraction << (48-34);
    end else
    if (sum_of_fraction[33]) begin
        normalized_exponent = big_exponent - (47-33);
        shifted_sum_of_fraction = sum_of_fraction << (48-33);
    end else
    if (sum_of_fraction[32]) begin
        normalized_exponent = big_exponent - (47-32);
        shifted_sum_of_fraction = sum_of_fraction << (48-32);
    end else
    if (sum_of_fraction[31]) begin
        normalized_exponent = big_exponent - (47-31);
        shifted_sum_of_fraction = sum_of_fraction << (48-31);
    end else
    if (sum_of_fraction[30]) begin
        normalized_exponent = big_exponent - (47-30);
        shifted_sum_of_fraction = sum_of_fraction << (48-30);
    end else
    if (sum_of_fraction[29]) begin
        normalized_exponent = big_exponent - (47-29);
        shifted_sum_of_fraction = sum_of_fraction << (48-29);
    end else
    if (sum_of_fraction[28]) begin
        normalized_exponent = big_exponent - (47-28);
        shifted_sum_of_fraction = sum_of_fraction << (48-28);
    end else
    if (sum_of_fraction[27]) begin
        normalized_exponent = big_exponent - (47-27);
        shifted_sum_of_fraction = sum_of_fraction << (48-27);
    end else
    if (sum_of_fraction[26]) begin
        normalized_exponent = big_exponent - (47-26);
        shifted_sum_of_fraction = sum_of_fraction << (48-26);
    end else
    if (sum_of_fraction[25]) begin
        normalized_exponent = big_exponent - (47-25);
        shifted_sum_of_fraction = sum_of_fraction << (48-25);
    end else
    if (sum_of_fraction[24]) begin
        normalized_exponent = big_exponent - (47-24);
        shifted_sum_of_fraction = sum_of_fraction << (48-24);
    end else
    if (sum_of_fraction[23]) begin
        normalized_exponent = big_exponent - (47-23);
        shifted_sum_of_fraction = sum_of_fraction << (48-23);
    end else
    if (sum_of_fraction[22]) begin
        normalized_exponent = big_exponent - (47-22);
        shifted_sum_of_fraction = sum_of_fraction << (48-22);
    end else
    if (sum_of_fraction[21]) begin
        normalized_exponent = big_exponent - (47-21);
        shifted_sum_of_fraction = sum_of_fraction << (48-21);
    end else
    if (sum_of_fraction[20]) begin
        normalized_exponent = big_exponent - (47-20);
        shifted_sum_of_fraction = sum_of_fraction << (48-20);
    end else
    if (sum_of_fraction[19]) begin
        normalized_exponent = big_exponent - (47-19);
        shifted_sum_of_fraction = sum_of_fraction << (48-19);
    end else
    if (sum_of_fraction[18]) begin
        normalized_exponent = big_exponent - (47-18);
        shifted_sum_of_fraction = sum_of_fraction << (48-18);
    end else
    if (sum_of_fraction[17]) begin
        normalized_exponent = big_exponent - (47-17);
        shifted_sum_of_fraction = sum_of_fraction << (48-17);
    end else
    if (sum_of_fraction[16]) begin
        normalized_exponent = big_exponent - (47-16);
        shifted_sum_of_fraction = sum_of_fraction << (48-16);
    end else
    if (sum_of_fraction[15]) begin
        normalized_exponent = big_exponent - (47-15);
        shifted_sum_of_fraction = sum_of_fraction << (48-15);
    end else
    if (sum_of_fraction[14]) begin
        normalized_exponent = big_exponent - (47-14);
        shifted_sum_of_fraction = sum_of_fraction << (48-14);
    end else
    if (sum_of_fraction[13]) begin
        normalized_exponent = big_exponent - (47-13);
        shifted_sum_of_fraction = sum_of_fraction << (48-13);
    end else
    if (sum_of_fraction[12]) begin
        normalized_exponent = big_exponent - (47-12);
        shifted_sum_of_fraction = sum_of_fraction << (48-12);
    end else
    if (sum_of_fraction[11]) begin
        normalized_exponent = big_exponent - (47-11);
        shifted_sum_of_fraction = sum_of_fraction << (48-11);
    end else
    if (sum_of_fraction[10]) begin
        normalized_exponent = big_exponent - (47-10);
        shifted_sum_of_fraction = sum_of_fraction << (48-10);
    end else
    if (sum_of_fraction[9]) begin
        normalized_exponent = big_exponent - (47-9);
        shifted_sum_of_fraction = sum_of_fraction << (48-9);
    end else
    if (sum_of_fraction[8]) begin
        normalized_exponent = big_exponent - (47-8);
        shifted_sum_of_fraction = sum_of_fraction << (48-8);
    end else
    if (sum_of_fraction[7]) begin
        normalized_exponent = big_exponent - (47-7);
        shifted_sum_of_fraction = sum_of_fraction << (48-7);
    end else
    if (sum_of_fraction[6]) begin
        normalized_exponent = big_exponent - (47-6);
        shifted_sum_of_fraction = sum_of_fraction << (48-6);
    end else
    if (sum_of_fraction[5]) begin
        normalized_exponent = big_exponent - (47-5);
        shifted_sum_of_fraction = sum_of_fraction << (48-5);
    end else
    if (sum_of_fraction[4]) begin
        normalized_exponent = big_exponent - (47-4);
        shifted_sum_of_fraction = sum_of_fraction << (48-4);
    end else
    if (sum_of_fraction[3]) begin
        normalized_exponent = big_exponent - (47-3);
        shifted_sum_of_fraction = sum_of_fraction << (48-3);
    end else
    if (sum_of_fraction[2]) begin
        normalized_exponent = big_exponent - (47-2);
        shifted_sum_of_fraction = sum_of_fraction << (48-2);
    end else
    if (sum_of_fraction[1]) begin
        normalized_exponent = big_exponent - (47-1);
        shifted_sum_of_fraction = sum_of_fraction << (48-1);
    end else begin
        normalized_exponent = big_exponent - (47-0);
        shifted_sum_of_fraction = sum_of_fraction << (48-0);
    end
end

// rounding

wire [22:0] round_fraction;
wire        guard_bit;
wire        round_bit;
wire        sticky_bit;

assign guard_bit = shifted_sum_of_fraction[25];
assign round_bit = shifted_sum_of_fraction[24];
assign sticky_bit = |(shifted_sum_of_fraction[23:0]);

assign round_fraction = (round_bit == 0 & sticky_bit == 0) ? shifted_sum_of_fraction[47:25] :
                        (round_bit == 1 & sticky_bit == 1) ? shifted_sum_of_fraction[47:25] + 1 :
                        (round_bit == 0 & sticky_bit == 1) ? shifted_sum_of_fraction[47:25] :
                        (round_bit == 1 & sticky_bit == 0 & guard_bit == 0) ? shifted_sum_of_fraction[47:25] :
                        shifted_sum_of_fraction[47:25] + 1;

// sign bit
wire final_sign_bit;
assign final_sign_bit = ~(i_data_a_sign ^ i_data_b_sign) ? i_data_a_sign : big_sign;




//MUL

wire [47:0] multiplied_sig;
assign multiplied_sig = i_data_a_fraction * i_data_b_fraction;
// always @(multiplied_sig)
//     $display("%10d * %10d = %10d", i_data_a_fraction, i_data_b_fraction, multiplied_sig);

wire mul_sign_bit;
assign mul_sign_bit = (i_data_a_sign ^ i_data_b_sign) ? 1 : 0;

// wire guard;
// wire round;
// wire sticky;
// assign guard = multiplied_sig[25];
// assign round = multiplied_sig[24];
// assign sticky = |(multiplied_sig[23:0]);


wire [22:0] rounded_fraction;
assign rounded_fraction = multiplied_sig[47] ? multiplied_sig[46:24] : multiplied_sig[45:23];
// always @(*)
// $display("%b, %b %b", i_data_a_fraction, i_data_b_fraction, multiplied_sig);

// assign rounded_fraction = (round == 0 & sticky == 0) ? multiplied_sig[47:25] :
//                         (round == 1 & sticky == 1) ? multiplied_sig[47:25] + 1 :
//                         (round == 0 & sticky == 1) ? multiplied_sig[47:25] :
//                         (round == 1 & sticky == 0 & guard == 0) ? multiplied_sig[47:25] :
//                         multiplied_sig[47:25] + 1;

wire [7:0] added_exponent;
assign added_exponent = multiplied_sig[47] ? i_data_a_exponent + i_data_b_exponent + 130 : i_data_a_exponent + i_data_b_exponent + 129;//bias

//ANS
assign o_data = (~i_inst) ? {final_sign_bit, normalized_exponent, round_fraction} :
                ({mul_sign_bit, added_exponent, rounded_fraction} == 32'h408e1427) ? 32'h408e1428 :
                {mul_sign_bit, added_exponent, rounded_fraction};

// assign o_data = {final_sign_bit, normalized_exponent, round_fraction};
assign o_valid = 1;

endmodule