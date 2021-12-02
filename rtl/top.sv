//////////////////////////////
//Top module for 16 point FFT
/////////////////////////////

module top(start, rst, clk, in, out_Real, out_Im);
input start, rst, clk; //Control inputs
reg load, sipo_clk, piso_clk;

input reg   [63:0] in; //Serial input

output wire [63:0] out_Real, out_Im; //Serial outputs

///////////////////////////////////////////////////////////////////////
//Internal signals
///////////////////////////////////////////////////////////////////////
reg signed  [63:0] xReal_bits[0:15],          xIm_bits[0:15];
reg signed  [63:0] xReal_stage4[0:15],        xIm_stage4[0:15];
reg signed  [63:0] xReal_stage4_scaled[0:15], xIm_stage4_scaled[0:15];
reg signed  [63:0] xReal_inv[0:15],           xIm_inv[0:15];

///////////////////////////////////////////////////////////////////////////////////////
//Instantiate SIPO input register
/////////////////////////////////////////////////////////////////////////////////////// 
sipo16 inReg_Real(in, sipo_clk, 
                   {xReal_bits[0],  xReal_bits[1],  xReal_bits[2],  xReal_bits[3],  
                    xReal_bits[4],  xReal_bits[5],  xReal_bits[6],  xReal_bits[7], 
                    xReal_bits[8],  xReal_bits[9],  xReal_bits[10], xReal_bits[11], 
                    xReal_bits[12], xReal_bits[13], xReal_bits[14], xReal_bits[15]});

//////////////////////////////////////////
//Tie imaginary part of input to ground
//////////////////////////////////////////
initial begin 
for(integer i = 0; i<16; i = i +1)
    xIm_bits[i] = 0;
end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Instantiate forward 16 point transformer
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
fft16 mod0(//16 Complex inputs
           xReal_bits[0],    xIm_bits[0],    xReal_bits[1],    xIm_bits[1],    xReal_bits[2],    xIm_bits[2],    xReal_bits[3],    xIm_bits[3], 
           xReal_bits[4],    xIm_bits[4],    xReal_bits[5],    xIm_bits[5],    xReal_bits[6],    xIm_bits[6],    xReal_bits[7],    xIm_bits[7],
           xReal_bits[8],    xIm_bits[8],    xReal_bits[9],    xIm_bits[9],    xReal_bits[10],   xIm_bits[10],   xReal_bits[11],   xIm_bits[11], 
           xReal_bits[12],   xIm_bits[12],   xReal_bits[13],   xIm_bits[13],   xReal_bits[14],   xIm_bits[14],   xReal_bits[15],   xIm_bits[15],

           //16 Complex outputs        
           xReal_stage4[0],  xIm_stage4[0],  xReal_stage4[1],  xIm_stage4[1],  xReal_stage4[2],  xIm_stage4[2],  xReal_stage4[3],  xIm_stage4[3], 
           xReal_stage4[4],  xIm_stage4[4],  xReal_stage4[5],  xIm_stage4[5],  xReal_stage4[6],  xIm_stage4[6],  xReal_stage4[7],  xIm_stage4[7],
           xReal_stage4[8],  xIm_stage4[8],  xReal_stage4[9],  xIm_stage4[9],  xReal_stage4[10], xIm_stage4[10], xReal_stage4[11], xIm_stage4[11], 
           xReal_stage4[12], xIm_stage4[12], xReal_stage4[13], xIm_stage4[13], xReal_stage4[14], xIm_stage4[14], xReal_stage4[15], xIm_stage4[15]);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Instantiate inverse 16 point transformer
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
fft16 mod1(//16 Complex inputs
           xReal_stage4_scaled[0], xIm_stage4_scaled[0], xReal_stage4_scaled[8],  xIm_stage4_scaled[8],  xReal_stage4_scaled[4], xIm_stage4_scaled[4], xReal_stage4_scaled[12], xIm_stage4_scaled[12],
           xReal_stage4_scaled[2], xIm_stage4_scaled[2], xReal_stage4_scaled[10], xIm_stage4_scaled[10], xReal_stage4_scaled[6], xIm_stage4_scaled[6], xReal_stage4_scaled[14], xIm_stage4_scaled[14],
           xReal_stage4_scaled[1], xIm_stage4_scaled[1], xReal_stage4_scaled[9],  xIm_stage4_scaled[9],  xReal_stage4_scaled[5], xIm_stage4_scaled[5], xReal_stage4_scaled[13], xIm_stage4_scaled[13],
           xReal_stage4_scaled[3], xIm_stage4_scaled[3], xReal_stage4_scaled[11], xIm_stage4_scaled[11], xReal_stage4_scaled[7], xIm_stage4_scaled[7], xReal_stage4_scaled[15], xIm_stage4_scaled[15],
           //16 Complex outputs
           xReal_inv[0],           xIm_inv[0],           xReal_inv[1],            xIm_inv[1],            xReal_inv[2],           xIm_inv[2],           xReal_inv[3],            xIm_inv[3],
           xReal_inv[4],           xIm_inv[4],           xReal_inv[5],            xIm_inv[5],            xReal_inv[6],           xIm_inv[6],           xReal_inv[7],            xIm_inv[7],
           xReal_inv[8],           xIm_inv[8],           xReal_inv[9],            xIm_inv[9],            xReal_inv[10],          xIm_inv[10],          xReal_inv[11],           xIm_inv[11],
           xReal_inv[12],          xIm_inv[12],          xReal_inv[13],           xIm_inv[13],           xReal_inv[14],          xIm_inv[14],          xReal_inv[15],           xIm_inv[15]);

////////////////////////////////////////////////////////////////////////////////////
//Parallel In Serial Out Real Register
////////////////////////////////////////////////////////////////////////////////////
piso16 outRegReal({xReal_inv[0],  xReal_inv[1],  xReal_inv[2],    xReal_inv[3], 
                   xReal_inv[4],  xReal_inv[5],  xReal_inv[6],    xReal_inv[7],
                   xReal_inv[8],  xReal_inv[9],  xReal_inv[10],   xReal_inv[11], 
                   xReal_inv[12], xReal_inv[13], xReal_inv[14],   xReal_inv[15]},
                   piso_clk,out_Real,load);

////////////////////////////////////////////////////////////////////////////////////
//Parallel In Serial Out Imaginary Register
////////////////////////////////////////////////////////////////////////////////////
piso16 outRegIm  ({xIm_inv[0],  xIm_inv[1],  xIm_inv[2],    xIm_inv[3], 
                   xIm_inv[4],  xIm_inv[5],  xIm_inv[6],    xIm_inv[7],
                   xIm_inv[8],  xIm_inv[9],  xIm_inv[10],   xIm_inv[11], 
                   xIm_inv[12], xIm_inv[13], xIm_inv[14],   xIm_inv[15]},
                   piso_clk,out_Im,load);

/////////////////////////////////////////////////////////////////////////////
//Scaling before inverse transform
/////////////////////////////////////////////////////////////////////////////
conj calcConj(xReal_stage4[0:15], xIm_stage4[0:15], xReal_stage4_scaled[0:15], xIm_stage4_scaled[0:15]);

//////////////////////////////////////////////////////////
//Instantiate control unit
//////////////////////////////////////////////////////////
CU controller(start, rst, clk, sipo_clk, piso_clk, load);

endmodule

