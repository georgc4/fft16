module butterfly8(
    //8 Complex inputs
    a_Real_in, a_Im_in,
    b_Real_in, b_Im_in,
    c_Real_in, c_Im_in,
    d_Real_in, d_Im_in,
    e_Real_in, e_Im_in,
    f_Real_in, f_Im_in,
    g_Real_in, g_Im_in,
    h_Real_in, h_Im_in,
    //8 Complex outputs
    a_Real_out, a_Im_out,
    b_Real_out, b_Im_out,
    c_Real_out, c_Im_out,
    d_Real_out, d_Im_out,
    e_Real_out, e_Im_out,
    f_Real_out, f_Im_out,
    g_Real_out, g_Im_out,
    h_Real_out, h_Im_out
);
   //Complex IO 
   input reg  signed [63:0] a_Real_in,  a_Im_in,  b_Real_in,  b_Im_in,  c_Real_in,  c_Im_in,  d_Real_in,  d_Im_in;
   input reg  signed [63:0] e_Real_in,  e_Im_in,  f_Real_in,  f_Im_in,  g_Real_in,  g_Im_in,  h_Real_in,  h_Im_in;
   output reg signed [63:0] a_Real_out, a_Im_out, b_Real_out, b_Im_out, c_Real_out, c_Im_out, d_Real_out, d_Im_out;
   output reg signed [63:0] e_Real_out, e_Im_out, f_Real_out, f_Im_out, g_Real_out, g_Im_out, h_Real_out, h_Im_out;
   
   //Twiddle value registers
   reg signed [31:0] twiddle80_real;
   reg signed [31:0] twiddle80_im;
   reg signed [31:0] twiddle81_real;
   reg signed [31:0] twiddle81_im;
   reg signed [31:0] twiddle82_real;
   reg signed [31:0] twiddle82_im;
   reg signed [31:0] twiddle83_real;
   reg signed [31:0] twiddle83_im;

   //After twiddling
   reg signed [63:0] e_Real_twiddled, e_Im_twiddled, f_Real_twiddled, f_Im_twiddled, g_Real_twiddled, g_Im_twiddled, h_Real_twiddled, h_Im_twiddled;
   
   //Lookup table for twiddle values
   initial begin
   twiddle80_real = 32'sh00000080;
   twiddle80_im =   32'sh00000000;
   twiddle81_real = 32'sh0000005a;
   twiddle81_im =   32'shffffffa6;
   twiddle82_real = 32'sh00000000;
   twiddle82_im =   32'shffffff80;
   twiddle83_real = 32'shffffffa6;
   twiddle83_im =   32'shffffffa6;
   end

   always_comb begin : butterfly4
        e_Real_twiddled = e_Real_in*twiddle80_real - e_Im_in*twiddle80_im; //complex multiplication
        e_Im_twiddled =   e_Real_in*twiddle80_im   + e_Im_in*twiddle80_real; // complex multiplication
        f_Real_twiddled = f_Real_in*twiddle81_real - f_Im_in*twiddle81_im; //complex multiplication
        f_Im_twiddled =   f_Real_in*twiddle81_im   + f_Im_in*twiddle81_real; // complex multiplication
        g_Real_twiddled = g_Real_in*twiddle82_real - g_Im_in*twiddle82_im; //complex multiplication
        g_Im_twiddled =   g_Real_in*twiddle82_im   + g_Im_in*twiddle82_real; // complex multiplication
        h_Real_twiddled = h_Real_in*twiddle83_real - h_Im_in*twiddle83_im; //complex multiplication
        h_Im_twiddled =   h_Real_in*twiddle83_im   + h_Im_in*twiddle83_real; // complex multiplication

        //Butterfly operations
        a_Real_out = (a_Real_in*128) + e_Real_twiddled;
        a_Im_out   = (a_Im_in  *128) + e_Im_twiddled;
        b_Real_out = (b_Real_in*128) + f_Real_twiddled;
        b_Im_out   = (b_Im_in  *128) + f_Im_twiddled;
        c_Real_out = (c_Real_in*128) + g_Real_twiddled;
        c_Im_out   = (c_Im_in  *128) + g_Im_twiddled;
        d_Real_out = (d_Real_in*128) + h_Real_twiddled;
        d_Im_out   = (d_Im_in  *128) + h_Im_twiddled;
        e_Real_out = (a_Real_in*128) - e_Real_twiddled;
        e_Im_out   = (a_Im_in  *128) - e_Im_twiddled;
        f_Real_out = (b_Real_in*128) - f_Real_twiddled;
        f_Im_out   = (b_Im_in  *128) - f_Im_twiddled;
        g_Real_out = (c_Real_in*128) - g_Real_twiddled;
        g_Im_out   = (c_Im_in  *128) - g_Im_twiddled;
        h_Real_out = (d_Real_in*128) - h_Real_twiddled;
        h_Im_out   = (d_Im_in  *128) - h_Im_twiddled;
   end 
endmodule