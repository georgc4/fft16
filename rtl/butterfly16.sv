module butterfly16(
    //16 Complex inputs
    a_Real_in, a_Im_in,
    b_Real_in, b_Im_in,
    c_Real_in, c_Im_in,
    d_Real_in, d_Im_in,
    e_Real_in, e_Im_in,
    f_Real_in, f_Im_in,
    g_Real_in, g_Im_in,
    h_Real_in, h_Im_in,
    i_Real_in, i_Im_in,
    j_Real_in, j_Im_in,
    k_Real_in, k_Im_in,
    l_Real_in, l_Im_in,
    m_Real_in, m_Im_in,
    n_Real_in, n_Im_in,
    o_Real_in, o_Im_in,
    p_Real_in, p_Im_in,
    //16 Complex outputs
    a_Real_out, a_Im_out,
    b_Real_out, b_Im_out,
    c_Real_out, c_Im_out,
    d_Real_out, d_Im_out,
    e_Real_out, e_Im_out,
    f_Real_out, f_Im_out,
    g_Real_out, g_Im_out,
    h_Real_out, h_Im_out,
    i_Real_out, i_Im_out,
    j_Real_out, j_Im_out,
    k_Real_out, k_Im_out,
    l_Real_out, l_Im_out,
    m_Real_out, m_Im_out,
    n_Real_out, n_Im_out,
    o_Real_out, o_Im_out,
    p_Real_out, p_Im_out
);
   //Complex IO 
   input  reg signed [63:0] a_Real_in,  a_Im_in,  b_Real_in,  b_Im_in,  c_Real_in,  c_Im_in,  d_Real_in,  d_Im_in;
   input  reg signed [63:0] e_Real_in,  e_Im_in,  f_Real_in,  f_Im_in,  g_Real_in,  g_Im_in,  h_Real_in,  h_Im_in;
   input  reg signed [63:0] i_Real_in,  i_Im_in,  j_Real_in,  j_Im_in,  k_Real_in,  k_Im_in,  l_Real_in,  l_Im_in;
   input  reg signed [63:0] m_Real_in,  m_Im_in,  n_Real_in,  n_Im_in,  o_Real_in,  o_Im_in,  p_Real_in,  p_Im_in;
   output reg signed [63:0] a_Real_out, a_Im_out, b_Real_out, b_Im_out, c_Real_out, c_Im_out, d_Real_out, d_Im_out;
   output reg signed [63:0] e_Real_out, e_Im_out, f_Real_out, f_Im_out, g_Real_out, g_Im_out, h_Real_out, h_Im_out;
   output reg signed [63:0] i_Real_out, i_Im_out, j_Real_out, j_Im_out, k_Real_out, k_Im_out, l_Real_out, l_Im_out;
   output reg signed [63:0] m_Real_out, m_Im_out, n_Real_out, n_Im_out, o_Real_out, o_Im_out, p_Real_out, p_Im_out;

   //Twiddle value registers 
   reg signed [31:0] twiddle160_real;
   reg signed [31:0] twiddle160_im;
   reg signed [31:0] twiddle161_real;
   reg signed [31:0] twiddle161_im;
   reg signed [31:0] twiddle162_real;
   reg signed [31:0] twiddle162_im;
   reg signed [31:0] twiddle163_real;
   reg signed [31:0] twiddle163_im;
   reg signed [31:0] twiddle164_real;
   reg signed [31:0] twiddle164_im;
   reg signed [31:0] twiddle165_real;
   reg signed [31:0] twiddle165_im;
   reg signed [31:0] twiddle166_real;
   reg signed [31:0] twiddle166_im;
   reg signed [31:0] twiddle167_real;
   reg signed [31:0] twiddle167_im;

   //After twiddling 
   reg signed [63:0] i_Real_twiddled, i_Im_twiddled, j_Real_twiddled, j_Im_twiddled, k_Real_twiddled, k_Im_twiddled, l_Real_twiddled, l_Im_twiddled; //post twiddle
   reg signed [63:0] m_Real_twiddled, m_Im_twiddled, n_Real_twiddled, n_Im_twiddled, o_Real_twiddled, o_Im_twiddled, p_Real_twiddled, p_Im_twiddled; //post twiddle
   
   //Lookup table for twiddle values
   initial begin
   twiddle160_real = 32'sh00000080;
   twiddle160_im =   32'sh00000000;
   twiddle161_real = 32'sh00000076;
   twiddle161_im =   32'shffffffcf;
   twiddle162_real = 32'sh0000005a;
   twiddle162_im =   32'shffffffa6;
   twiddle163_real = 32'sh00000031;
   twiddle163_im =   32'shffffff8a;
   twiddle164_real = 32'sh00000000;
   twiddle164_im =   32'shffffff80;
   twiddle165_real = 32'shffffffcf;
   twiddle165_im =   32'shffffff8a;
   twiddle166_real = 32'shffffffa6;
   twiddle166_im =   32'shffffffa6;
   twiddle167_real = 32'shffffff8a;
   twiddle167_im =   32'shffffffcf;
   end

   always_comb begin : butterfly16

        i_Real_twiddled = i_Real_in*twiddle160_real - i_Im_in*twiddle160_im; //complex multiplication
        i_Im_twiddled =   i_Real_in*twiddle160_im   + i_Im_in*twiddle160_real; // complex multiplication
        j_Real_twiddled = j_Real_in*twiddle161_real - j_Im_in*twiddle161_im; //complex multiplication
        j_Im_twiddled =   j_Real_in*twiddle161_im   + j_Im_in*twiddle161_real; // complex multiplication
        k_Real_twiddled = k_Real_in*twiddle162_real - k_Im_in*twiddle162_im; //complex multiplication
        k_Im_twiddled =   k_Real_in*twiddle162_im   + k_Im_in*twiddle162_real; // complex multiplication
        l_Real_twiddled = l_Real_in*twiddle163_real - l_Im_in*twiddle163_im; //complex multiplication
        l_Im_twiddled =   l_Real_in*twiddle163_im   + l_Im_in*twiddle163_real; // complex multiplication
        m_Real_twiddled = m_Real_in*twiddle164_real - m_Im_in*twiddle164_im; //complex multiplication
        m_Im_twiddled =   m_Real_in*twiddle164_im   + m_Im_in*twiddle164_real; // complex multiplication
        n_Real_twiddled = n_Real_in*twiddle165_real - n_Im_in*twiddle165_im; //complex multiplication
        n_Im_twiddled =   n_Real_in*twiddle165_im   + n_Im_in*twiddle165_real; // complex multiplication
        o_Real_twiddled = o_Real_in*twiddle166_real - o_Im_in*twiddle166_im; //complex multiplication
        o_Im_twiddled =   o_Real_in*twiddle166_im   + o_Im_in*twiddle166_real; // complex multiplication
        p_Real_twiddled = p_Real_in*twiddle167_real - p_Im_in*twiddle167_im; //complex multiplication
        p_Im_twiddled =   p_Real_in*twiddle167_im   + p_Im_in*twiddle167_real; // complex multiplication

        //Butterfly operations
        a_Real_out = (a_Real_in*128) + i_Real_twiddled;
        a_Im_out   = (a_Im_in  *128) + i_Im_twiddled;
        b_Real_out = (b_Real_in*128) + j_Real_twiddled;
        b_Im_out   = (b_Im_in  *128) + j_Im_twiddled;
        c_Real_out = (c_Real_in*128) + k_Real_twiddled;
        c_Im_out   = (c_Im_in  *128) + k_Im_twiddled;
        d_Real_out = (d_Real_in*128) + l_Real_twiddled;
        d_Im_out   = (d_Im_in  *128) + l_Im_twiddled;
        e_Real_out = (e_Real_in*128) + m_Real_twiddled;
        e_Im_out   = (e_Im_in  *128) + m_Im_twiddled;
        f_Real_out = (f_Real_in*128) + n_Real_twiddled;
        f_Im_out   = (f_Im_in  *128) + n_Im_twiddled;
        g_Real_out = (g_Real_in*128) + o_Real_twiddled;
        g_Im_out   = (g_Im_in  *128) + o_Im_twiddled;
        h_Real_out = (h_Real_in*128) + p_Real_twiddled;
        h_Im_out   = (h_Im_in  *128) + p_Im_twiddled;
        i_Real_out = (a_Real_in*128) - i_Real_twiddled;
        i_Im_out   = (a_Im_in  *128) - i_Im_twiddled;
        j_Real_out = (b_Real_in*128) - j_Real_twiddled;
        j_Im_out   = (b_Im_in  *128) - j_Im_twiddled;
        k_Real_out = (c_Real_in*128) - k_Real_twiddled;
        k_Im_out   = (c_Im_in  *128) - k_Im_twiddled;
        l_Real_out = (d_Real_in*128) - l_Real_twiddled;
        l_Im_out   = (d_Im_in  *128) - l_Im_twiddled;
        m_Real_out = (e_Real_in*128) - m_Real_twiddled;
        m_Im_out   = (e_Im_in  *128) - m_Im_twiddled;
        n_Real_out = (f_Real_in*128) - n_Real_twiddled;
        n_Im_out   = (f_Im_in  *128) - n_Im_twiddled;
        o_Real_out = (g_Real_in*128) - o_Real_twiddled;
        o_Im_out   = (g_Im_in  *128) - o_Im_twiddled;
        p_Real_out = (h_Real_in*128) - p_Real_twiddled;
        p_Im_out   = (h_Im_in  *128) - p_Im_twiddled;
        
   end 
endmodule