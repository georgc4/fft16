module conj(in_real, in_im, out_real, out_im);
input reg signed [63:0] in_real [0:15];
input reg signed [63:0] in_im   [0:15];

output reg signed  [63:0] out_real [0:15];
output reg signed  [63:0] out_im [0:15];

always_comb begin
    for (integer i = 0; i <16; i = i +1) begin
        //Scale and negate imaginary part for complex conjugate
        out_real[i] =  in_real[i] /  (268435456);
        out_im[i]   = -in_im[i]   /  (268435456);
    end
end
endmodule