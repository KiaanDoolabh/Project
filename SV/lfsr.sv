module lfsr(seed, clk, reset, shift_seed);
//inputs and outputs for a smaller implementation
input logic [7:0] seed;
input logic clk;
input logic reset;
output logic shift_seed;

logic [7:0] lfsr_reg = seed;

always_ff @(posedge clk or posedge reset)
begin
    if(reset)
    lfsr_reg <= seed;
    else 
    lfsr_reg <= {lfsr_reg[6:0], lfsr_reg[7]^ lfsr_reg[5]};
end
 assign shift_seed = lfsr_reg[0];
endmodule

module lfsr64 (seed, clk, reset, shift_seed);
//inputs and outputs for the full seed size (64 bits)
input logic [63:0] seed;
input logic clk;
input logic reset;
output logic shift_seed;
logic [63:0] lfsr_reg = seed;
always_ff @(posedge clk or posedge reset)
begin
    if(reset)
    lfsr_reg <= seed;
    else
    lfsr_reg <= {lfsr_reg[62:0], lfsr_reg[63] ^ lsr_reg[62]};
end
assign shift_seed = lfsr_reg[0];
endmodule