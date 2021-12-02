module butterfly2 (
    //2 complex inputs
    a_Real_in, a_Im_in,
    b_Real_in, b_Im_in,
    //2 complex outputs
    a_Real_out, a_Im_out,
    b_Real_out, b_Im_out
);
   //Complex IO
   input reg  signed [63:0] a_Real_in,  a_Im_in,  b_Real_in,  b_Im_in;
   output reg signed [63:0] a_Real_out, a_Im_out, b_Real_out, b_Im_out;

   //Twiddle values
   reg signed [31:0] twiddle2R;
   reg signed [31:0] twiddle2I;
   
   //After twiddling
   reg signed [63:0] b_Real_in_twiddled, b_Im_in_twiddled;
   
   //Lookup table for twiddle values
   initial begin
       twiddle2R = 32'sh00000080;
       twiddle2I = 32'sh00000000;
   end

   always_comb begin : butterfly2
   
        b_Real_in_twiddled = b_Real_in*twiddle2R - b_Im_in*twiddle2I; // complex multiplication
        b_Im_in_twiddled   = b_Real_in*twiddle2I + b_Im_in*twiddle2R; // complex multiplication0
        
        //Butterfly operations
        a_Real_out = (a_Real_in*128) + b_Real_in_twiddled;
        a_Im_out   = (a_Im_in  *128) + b_Im_in_twiddled;
        b_Real_out = (a_Real_in*128) - b_Real_in_twiddled;
        b_Im_out   = (a_Im_in  *128) - b_Im_in_twiddled;
   end 
endmodule