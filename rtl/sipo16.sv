//////////////////////////////////
//Serial In Parallel Out Register
//////////////////////////////////
module sipo16(si, clk, po);
input reg clk;
input reg [63:0] si;
reg [1023:0] out;
output reg [1023:0] po;
initial begin
    out = 1024'b0;
end

always @(posedge clk) begin
        out = {out[959:0], si};
end
assign po = out;
endmodule