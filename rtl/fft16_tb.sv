module fft16_tb();
reg start, rst, clk;
reg [63:0] in;
reg [63:0] out_Real, out_Im;
real xReal[0:15], xIm[0:15];
real yReal[0:15], yIm[0:15];
reg signed [63:0] xReal_bits[0:15], xIm_bits[0:15];
integer i;
initial begin
    clk   = 0;
    rst   = 1;
    start = 0;

    //Input sequence 0-15 (bit reversed)
    xReal[0] =  0.0;
    xReal[1] =  8.0;
    xReal[2] =  4.0;
    xReal[3] =  12.0;
    xReal[4] =  2.0;
    xReal[5] =  10.0;
    xReal[6] =  6.0;
    xReal[7] =  14.0;
    xReal[8] =  1.0;
    xReal[9] =  9.0;
    xReal[10] = 5.0;
    xReal[11] = 13.0;
    xReal[12] = 3.0;
    xReal[13] = 11.0;
    xReal[14] = 7.0;
    xReal[15] = 15.0;

    //All real numbers, so imaginary part is 0
    xIm[0] = 0.0;
    xIm[1] = 0.0;
    xIm[2] = 0.0;
    xIm[3] = 0.0;
    xIm[4] = 0.0;
    xIm[5] = 0.0;
    xIm[6] = 0.0;
    xIm[7] = 0.0;
    xIm[8] = 0.0;
    xIm[9] = 0.0;
    xIm[10] = 0.0;
    xIm[11] = 0.0;
    xIm[12] = 0.0;
    xIm[13] = 0.0;
    xIm[14] = 0.0;
    xIm[15] = 0.0;

    //Display the input sequence
    $display("Input sequence\n");
    $display("x[0]  = %f + (%f)i\n", xReal[0],   xIm[0]);
    $display("x[1]  = %f + (%f)i\n", xReal[8],   xIm[8]);
    $display("x[2]  = %f + (%f)i\n", xReal[4],   xIm[4]);
    $display("x[3]  = %f + (%f)i\n", xReal[12],  xIm[12]);
    $display("x[4]  = %f + (%f)i\n", xReal[2],   xIm[2]);
    $display("x[5]  = %f + (%f)i\n", xReal[10],  xIm[10]);
    $display("x[6]  = %f + (%f)i\n", xReal[6],   xIm[6]);
    $display("x[7]  = %f + (%f)i\n", xReal[14],  xIm[14]);
    $display("x[8]  = %f + (%f)i\n", xReal[1],   xIm[1]);
    $display("x[9]  = %f + (%f)i\n", xReal[9],   xIm[9]);
    $display("x[10] = %f + (%f)i\n", xReal[5],   xIm[5]);
    $display("x[11] = %f + (%f)i\n", xReal[13],  xIm[13]);
    $display("x[12] = %f + (%f)i\n", xReal[3],   xIm[3]);
    $display("x[13] = %f + (%f)i\n", xReal[11],  xIm[11]);
    $display("x[14] = %f + (%f)i\n", xReal[7],   xIm[7]);
    $display("x[15] = %f + (%f)i\n", xReal[15],  xIm[15]);    

    //Convert input sequence to integer values
    for(i = 0; i < 16; i = i +1) begin
        xReal_bits[i] = $rtoi(xReal[i]);
        xIm_bits[i] = $rtoi(xIm[i]);
    end

    //Now we start the machine
    #20;
    start =1;
    rst = 0;
    i = 0;
    in = xReal_bits[0];

    //Clock generation
    forever begin
        #5 clk = ~clk;
    end
end

//Instantiate the machine
top dut(start, rst, clk, in, out_Real, out_Im);

//Verification process
always @(posedge clk) begin
    
    //Send input number
    in <= xReal_bits[i]; 
    #3; //Wait for combinational logic
   
    
    //Wait certain number of clock cycles to read serial output
    if(i>=18) begin
    //Convert back to real numbers by dividing by (16*128^4) 128 is scaling factor, 4th power because of 4 stages, and 16 because of inverse transform
    yReal[i-18] = $itor(out_Real)/4294967296.0; 
    yIm[i-18]   = $itor(out_Im)  /4294967296.0;
    end
    
    i = i +1; //increment counter
    
    //Grab values from internal signals to show transformed values
    if(i == 17) begin
    $display("Input sequence after transform to frequency domain\n");
    //Divide by 128^4 because of 4 stages
    $display("y[0]  = %f + (%f)i\n", $itor(dut.xReal_stage4[0])/268435456.0,  $itor(dut.xIm_stage4[0])/268435456.0 );
    $display("y[1]  = %f + (%f)i\n", $itor(dut.xReal_stage4[1])/268435456.0,  $itor(dut.xIm_stage4[1])/268435456.0 );
    $display("y[2]  = %f + (%f)i\n", $itor(dut.xReal_stage4[2])/268435456.0,  $itor(dut.xIm_stage4[2])/268435456.0 );
    $display("y[3]  = %f + (%f)i\n", $itor(dut.xReal_stage4[3])/268435456.0,  $itor(dut.xIm_stage4[3])/268435456.0 );
    $display("y[4]  = %f + (%f)i\n", $itor(dut.xReal_stage4[4])/268435456.0,  $itor(dut.xIm_stage4[4])/268435456.0 );
    $display("y[5]  = %f + (%f)i\n", $itor(dut.xReal_stage4[5])/268435456.0,  $itor(dut.xIm_stage4[5])/268435456.0 );
    $display("y[6]  = %f + (%f)i\n", $itor(dut.xReal_stage4[6])/268435456.0,  $itor(dut.xIm_stage4[6])/268435456.0 );
    $display("y[7]  = %f + (%f)i\n", $itor(dut.xReal_stage4[7])/268435456.0,  $itor(dut.xIm_stage4[7])/268435456.0 );
    $display("y[8]  = %f + (%f)i\n", $itor(dut.xReal_stage4[8])/268435456.0,  $itor(dut.xIm_stage4[8])/268435456.0 );
    $display("y[9]  = %f + (%f)i\n", $itor(dut.xReal_stage4[9])/268435456.0,  $itor(dut.xIm_stage4[9])/268435456.0 );
    $display("y[10] = %f + (%f)i\n", $itor(dut.xReal_stage4[10])/268435456.0, $itor(dut.xIm_stage4[10])/268435456.0);
    $display("y[11] = %f + (%f)i\n", $itor(dut.xReal_stage4[11])/268435456.0, $itor(dut.xIm_stage4[11])/268435456.0);
    $display("y[12] = %f + (%f)i\n", $itor(dut.xReal_stage4[12])/268435456.0, $itor(dut.xIm_stage4[12])/268435456.0);
    $display("y[13] = %f + (%f)i\n", $itor(dut.xReal_stage4[13])/268435456.0, $itor(dut.xIm_stage4[13])/268435456.0);
    $display("y[14] = %f + (%f)i\n", $itor(dut.xReal_stage4[14])/268435456.0, $itor(dut.xIm_stage4[14])/268435456.0);
    $display("y[15] = %f + (%f)i\n", $itor(dut.xReal_stage4[15])/268435456.0, $itor(dut.xIm_stage4[15])/268435456.0);    
    end

    //Display serial outputs after inverse transform
    if(i == 40) begin
    $display("Input sequence after transform to frequency domain then back to time domain\n");
    $display("y[0]  = %f + (%f)i\n", yReal[0],  yIm[0] );
    $display("y[1]  = %f + (%f)i\n", yReal[1],  yIm[1] );
    $display("y[2]  = %f + (%f)i\n", yReal[2],  yIm[2] );
    $display("y[3]  = %f + (%f)i\n", yReal[3],  yIm[3] );
    $display("y[4]  = %f + (%f)i\n", yReal[4],  yIm[4] );
    $display("y[5]  = %f + (%f)i\n", yReal[5],  yIm[5] );
    $display("y[6]  = %f + (%f)i\n", yReal[6],  yIm[6] );
    $display("y[7]  = %f + (%f)i\n", yReal[7],  yIm[7] );
    $display("y[8]  = %f + (%f)i\n", yReal[8],  yIm[8] );
    $display("y[9]  = %f + (%f)i\n", yReal[9],  yIm[9] );
    $display("y[10] = %f + (%f)i\n", yReal[10], yIm[10]);
    $display("y[11] = %f + (%f)i\n", yReal[11], yIm[11]);
    $display("y[12] = %f + (%f)i\n", yReal[12], yIm[12]);
    $display("y[13] = %f + (%f)i\n", yReal[13], yIm[13]);
    $display("y[14] = %f + (%f)i\n", yReal[14], yIm[14]);
    $display("y[15] = %f + (%f)i\n", yReal[15], yIm[15]);    
    $stop();
    end
end
endmodule 
