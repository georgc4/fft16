module butterfly4(
    //4 Complex inputs
    a_Real_in, a_Im_in,
    b_Real_in, b_Im_in,
    c_Real_in, c_Im_in,
    d_Real_in, d_Im_in,
    //4 Complex outputs
    a_Real_out, a_Im_out,
    b_Real_out, b_Im_out,
    c_Real_out, c_Im_out,
    d_Real_out, d_Im_out
);
   //Coplex IO 
   input reg  signed [63:0] a_Real_in,  a_Im_in,  b_Real_in,  b_Im_in,  c_Real_in,  c_Im_in,  d_Real_in,  d_Im_in;
   output reg signed [63:0] a_Real_out, a_Im_out, b_Real_out, b_Im_out, c_Real_out, c_Im_out, d_Real_out, d_Im_out;

   //Twiddle values 
   reg signed [31:0] twiddle40_real;
   reg signed [31:0] twiddle40_im;
   reg signed [31:0] twiddle41_real;
   reg signed [31:0] twiddle41_im;
   
   //After twiddling
   reg signed [63:0] c_Real_twiddled, c_Im_twiddled, d_Real_twiddled, d_Im_twiddled; //post twiddle
   
   //Lookup table for twiddle values
   initial begin
   twiddle40_real = 32'sh00000080;
   twiddle40_im =   32'sh00000000;
   twiddle41_real = 32'sh00000000;
   twiddle41_im =   32'shffffff80; 
   end

   always_comb begin : butterfly4

        c_Real_twiddled = c_Real_in*twiddle40_real - c_Im_in*twiddle40_im; //complex multiplication
        c_Im_twiddled   = c_Real_in*twiddle40_im   + c_Im_in*twiddle40_real; // complex multiplication
        d_Real_twiddled = d_Real_in*twiddle41_real - d_Im_in*twiddle41_im; //complex multiplication
        d_Im_twiddled   = d_Real_in*twiddle41_im   + d_Im_in*twiddle41_real; // complex multiplication

        //Butterfly operations
        a_Real_out = (a_Real_in *128) + c_Real_twiddled;
        a_Im_out = (a_Im_in     *128) + c_Im_twiddled;
        b_Real_out = (b_Real_in *128) + d_Real_twiddled;
        b_Im_out = (b_Im_in     *128) + d_Im_twiddled;
        c_Real_out = (a_Real_in *128) - c_Real_twiddled;
        c_Im_out = (a_Im_in     *128) - c_Im_twiddled;
        d_Real_out = (b_Real_in *128) - d_Real_twiddled;
        d_Im_out = (b_Im_in     *128) - d_Im_twiddled;
   end 
endmodule