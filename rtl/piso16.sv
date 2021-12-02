///////////////////////////////////
//Parallel In Serial Out Register
///////////////////////////////////
module piso16(pi, clk, so, load);
input logic clk, load;
input reg [1023:0] pi;
output reg [63:0] so;
reg [1023:0] tmp;
initial begin
tmp = 1024'b0;
so = 64'b0;
end    

always @(posedge clk ) begin
    if (load) begin
        tmp<= pi;
    end
    else begin
        so <= tmp[1023:960];
        tmp<= {tmp[959:0], 64'b0};
    end
end
endmodule