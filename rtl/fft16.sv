/////////////////////////////////////////////////////////////////
//16 point FFT module
/////////////////////////////////////////////////////////////////
module fft16(a_Real_in, a_Im_in,
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
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//16 Complex inputs
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
input  reg signed [63:0] a_Real_in,  a_Im_in,  b_Real_in,  b_Im_in,  c_Real_in,  c_Im_in,  d_Real_in,  d_Im_in;
input  reg signed [63:0] e_Real_in,  e_Im_in,  f_Real_in,  f_Im_in,  g_Real_in,  g_Im_in,  h_Real_in,  h_Im_in;
input  reg signed [63:0] i_Real_in,  i_Im_in,  j_Real_in,  j_Im_in,  k_Real_in,  k_Im_in,  l_Real_in,  l_Im_in;
input  reg signed [63:0] m_Real_in,  m_Im_in,  n_Real_in,  n_Im_in,  o_Real_in,  o_Im_in,  p_Real_in,  p_Im_in;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//16 Complex outputs
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
output reg signed [63:0] a_Real_out, a_Im_out, b_Real_out, b_Im_out, c_Real_out, c_Im_out, d_Real_out, d_Im_out;
output reg signed [63:0] e_Real_out, e_Im_out, f_Real_out, f_Im_out, g_Real_out, g_Im_out, h_Real_out, h_Im_out;
output reg signed [63:0] i_Real_out, i_Im_out, j_Real_out, j_Im_out, k_Real_out, k_Im_out, l_Real_out, l_Im_out;
output reg signed [63:0] m_Real_out, m_Im_out, n_Real_out, n_Im_out, o_Real_out, o_Im_out, p_Real_out, p_Im_out;

///////////////////////////////////////////////////////
//Internal signals
///////////////////////////////////////////////////////
reg signed [63:0]   xReal_bits[0:15],   xIm_bits[0:15];
reg signed [63:0] xReal_stage1[0:15], xIm_stage1[0:15];
reg signed [63:0] xReal_stage2[0:15], xIm_stage2[0:15];
reg signed [63:0] xReal_stage3[0:15], xIm_stage3[0:15];
reg signed [63:0] xReal_stage4[0:15], xIm_stage4[0:15];

////////////////////////////////////////////////
//Registers assigned to improve code readability
////////////////////////////////////////////////
assign xReal_bits[0]  = a_Real_in;
assign xReal_bits[1]  = b_Real_in;
assign xReal_bits[2]  = c_Real_in;
assign xReal_bits[3]  = d_Real_in;
assign xReal_bits[4]  = e_Real_in;
assign xReal_bits[5]  = f_Real_in;
assign xReal_bits[6]  = g_Real_in;
assign xReal_bits[7]  = h_Real_in;
assign xReal_bits[8]  = i_Real_in;
assign xReal_bits[9]  = j_Real_in;
assign xReal_bits[10] = k_Real_in;
assign xReal_bits[11] = l_Real_in;
assign xReal_bits[12] = m_Real_in;
assign xReal_bits[13] = n_Real_in;
assign xReal_bits[14] = o_Real_in;
assign xReal_bits[15] = p_Real_in;

assign xIm_bits[0]    = a_Im_in;
assign xIm_bits[1]    = b_Im_in;
assign xIm_bits[2]    = c_Im_in;
assign xIm_bits[3]    = d_Im_in;
assign xIm_bits[4]    = e_Im_in;
assign xIm_bits[5]    = f_Im_in;
assign xIm_bits[6]    = g_Im_in;
assign xIm_bits[7]    = h_Im_in;
assign xIm_bits[8]    = i_Im_in;
assign xIm_bits[9]    = j_Im_in;
assign xIm_bits[10]   = k_Im_in;
assign xIm_bits[11]   = l_Im_in;
assign xIm_bits[12]   = m_Im_in;
assign xIm_bits[13]   = n_Im_in;
assign xIm_bits[14]   = o_Im_in;
assign xIm_bits[15]   = p_Im_in;


assign a_Real_out = xReal_stage4[0];
assign b_Real_out = xReal_stage4[1];
assign c_Real_out = xReal_stage4[2];
assign d_Real_out = xReal_stage4[3];
assign e_Real_out = xReal_stage4[4];
assign f_Real_out = xReal_stage4[5];
assign g_Real_out = xReal_stage4[6];
assign h_Real_out = xReal_stage4[7];
assign i_Real_out = xReal_stage4[8];
assign j_Real_out = xReal_stage4[9];
assign k_Real_out = xReal_stage4[10];
assign l_Real_out = xReal_stage4[11];
assign m_Real_out = xReal_stage4[12];
assign n_Real_out = xReal_stage4[13];
assign o_Real_out = xReal_stage4[14];
assign p_Real_out = xReal_stage4[15];

assign a_Im_out = xIm_stage4[0];
assign b_Im_out = xIm_stage4[1];
assign c_Im_out = xIm_stage4[2];
assign d_Im_out = xIm_stage4[3];
assign e_Im_out = xIm_stage4[4];
assign f_Im_out = xIm_stage4[5];
assign g_Im_out = xIm_stage4[6];
assign h_Im_out = xIm_stage4[7];
assign i_Im_out = xIm_stage4[8];
assign j_Im_out = xIm_stage4[9];
assign k_Im_out = xIm_stage4[10];
assign l_Im_out = xIm_stage4[11];
assign m_Im_out = xIm_stage4[12];
assign n_Im_out = xIm_stage4[13];
assign o_Im_out = xIm_stage4[14];
assign p_Im_out = xIm_stage4[15];
////////////////////////////////////////////////
////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Instantiating and connecting wires for the 4 stage butterfly operations
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
butterfly2 but2_0(  xReal_bits[0],    xIm_bits[0],    xReal_bits[1],    xIm_bits[1],    xReal_stage1[0],  xIm_stage1[0],  xReal_stage1[1],  xIm_stage1[1]);
butterfly2 but2_1(  xReal_bits[2],    xIm_bits[2],    xReal_bits[3],    xIm_bits[3],    xReal_stage1[2],  xIm_stage1[2],  xReal_stage1[3],  xIm_stage1[3]);
butterfly2 but2_2(  xReal_bits[4],    xIm_bits[4],    xReal_bits[5],    xIm_bits[5],    xReal_stage1[4],  xIm_stage1[4],  xReal_stage1[5],  xIm_stage1[5]);
butterfly2 but2_3(  xReal_bits[6],    xIm_bits[6],    xReal_bits[7],    xIm_bits[7],    xReal_stage1[6],  xIm_stage1[6],  xReal_stage1[7],  xIm_stage1[7]);
butterfly2 but2_4(  xReal_bits[8],    xIm_bits[8],    xReal_bits[9],    xIm_bits[9],    xReal_stage1[8],  xIm_stage1[8],  xReal_stage1[9],  xIm_stage1[9]);
butterfly2 but2_5(  xReal_bits[10],   xIm_bits[10],   xReal_bits[11],   xIm_bits[11],   xReal_stage1[10], xIm_stage1[10], xReal_stage1[11], xIm_stage1[11]);
butterfly2 but2_6(  xReal_bits[12],   xIm_bits[12],   xReal_bits[13],   xIm_bits[13],   xReal_stage1[12], xIm_stage1[12], xReal_stage1[13], xIm_stage1[13]);
butterfly2 but2_7(  xReal_bits[14],   xIm_bits[14],   xReal_bits[15],   xIm_bits[15],   xReal_stage1[14], xIm_stage1[14], xReal_stage1[15], xIm_stage1[15]);

butterfly4 but4_0(  xReal_stage1[0],  xIm_stage1[0],  xReal_stage1[1],  xIm_stage1[1],  xReal_stage1[2],  xIm_stage1[2],  xReal_stage1[3],  xIm_stage1[3], 
                    xReal_stage2[0],  xIm_stage2[0],  xReal_stage2[1],  xIm_stage2[1],  xReal_stage2[2],  xIm_stage2[2],  xReal_stage2[3],  xIm_stage2[3]);
butterfly4 but4_1(  xReal_stage1[4],  xIm_stage1[4],  xReal_stage1[5],  xIm_stage1[5],  xReal_stage1[6],  xIm_stage1[6],  xReal_stage1[7],  xIm_stage1[7], 
                    xReal_stage2[4],  xIm_stage2[4],  xReal_stage2[5],  xIm_stage2[5],  xReal_stage2[6],  xIm_stage2[6],  xReal_stage2[7],  xIm_stage2[7]);
butterfly4 but4_2(  xReal_stage1[8],  xIm_stage1[8],  xReal_stage1[9],  xIm_stage1[9],  xReal_stage1[10], xIm_stage1[10], xReal_stage1[11], xIm_stage1[11], 
                    xReal_stage2[8],  xIm_stage2[8],  xReal_stage2[9],  xIm_stage2[9],  xReal_stage2[10], xIm_stage2[10], xReal_stage2[11], xIm_stage2[11]);
butterfly4 but4_3(  xReal_stage1[12], xIm_stage1[12], xReal_stage1[13], xIm_stage1[13], xReal_stage1[14], xIm_stage1[14], xReal_stage1[15], xIm_stage1[15], 
                    xReal_stage2[12], xIm_stage2[12], xReal_stage2[13], xIm_stage2[13], xReal_stage2[14], xIm_stage2[14], xReal_stage2[15], xIm_stage2[15]);

butterfly8 but8_0(  xReal_stage2[0],  xIm_stage2[0],  xReal_stage2[1],  xIm_stage2[1],  xReal_stage2[2],  xIm_stage2[2],  xReal_stage2[3],  xIm_stage2[3], 
                    xReal_stage2[4],  xIm_stage2[4],  xReal_stage2[5],  xIm_stage2[5],  xReal_stage2[6],  xIm_stage2[6],  xReal_stage2[7],  xIm_stage2[7],
                    xReal_stage3[0],  xIm_stage3[0],  xReal_stage3[1],  xIm_stage3[1],  xReal_stage3[2],  xIm_stage3[2],  xReal_stage3[3],  xIm_stage3[3], 
                    xReal_stage3[4],  xIm_stage3[4],  xReal_stage3[5],  xIm_stage3[5],  xReal_stage3[6],  xIm_stage3[6],  xReal_stage3[7],  xIm_stage3[7]);
butterfly8 but8_1(  xReal_stage2[8],  xIm_stage2[8],  xReal_stage2[9],  xIm_stage2[9],  xReal_stage2[10], xIm_stage2[10], xReal_stage2[11], xIm_stage2[11], 
                    xReal_stage2[12], xIm_stage2[12], xReal_stage2[13], xIm_stage2[13], xReal_stage2[14], xIm_stage2[14], xReal_stage2[15], xIm_stage2[15],
                    xReal_stage3[8],  xIm_stage3[8],  xReal_stage3[9],  xIm_stage3[9],  xReal_stage3[10], xIm_stage3[10], xReal_stage3[11], xIm_stage3[11], 
                    xReal_stage3[12], xIm_stage3[12], xReal_stage3[13], xIm_stage3[13], xReal_stage3[14], xIm_stage3[14], xReal_stage3[15], xIm_stage3[15]);

butterfly16 but16_0(xReal_stage3[0],  xIm_stage3[0],  xReal_stage3[1],  xIm_stage3[1],  xReal_stage3[2],  xIm_stage3[2],  xReal_stage3[3],  xIm_stage3[3], 
                    xReal_stage3[4],  xIm_stage3[4],  xReal_stage3[5],  xIm_stage3[5],  xReal_stage3[6],  xIm_stage3[6],  xReal_stage3[7],  xIm_stage3[7],
                    xReal_stage3[8],  xIm_stage3[8],  xReal_stage3[9],  xIm_stage3[9],  xReal_stage3[10], xIm_stage3[10], xReal_stage3[11], xIm_stage3[11], 
                    xReal_stage3[12], xIm_stage3[12], xReal_stage3[13], xIm_stage3[13], xReal_stage3[14], xIm_stage3[14], xReal_stage3[15], xIm_stage3[15],
                    xReal_stage4[0],  xIm_stage4[0],  xReal_stage4[1],  xIm_stage4[1],  xReal_stage4[2],  xIm_stage4[2],  xReal_stage4[3],  xIm_stage4[3], 
                    xReal_stage4[4],  xIm_stage4[4],  xReal_stage4[5],  xIm_stage4[5],  xReal_stage4[6],  xIm_stage4[6],  xReal_stage4[7],  xIm_stage4[7],
                    xReal_stage4[8],  xIm_stage4[8],  xReal_stage4[9],  xIm_stage4[9],  xReal_stage4[10], xIm_stage4[10], xReal_stage4[11], xIm_stage4[11], 
                    xReal_stage4[12], xIm_stage4[12], xReal_stage4[13], xIm_stage4[13], xReal_stage4[14], xIm_stage4[14], xReal_stage4[15], xIm_stage4[15]);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

endmodule
