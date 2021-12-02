//////////////////////////////////////////////////////
//Control Unit Finite State Machine
//////////////////////////////////////////////////////
module CU(start, rst, clk, sipo_clk, piso_clk, load);
input logic clk, start, rst; //Control inputs
reg en_sipo, en_piso; //Control outputs
reg [5:0] cyc_cnt; //Conditional variable
output logic sipo_clk, piso_clk, load; //Outputs
typedef enum {RST, FILLSIPO, READPISO} states; //Define state type
states state, nextstate; //Create two state variables

//Next state register
always_ff @( posedge clk, posedge rst ) begin
    if(rst) begin
    state <= RST;
    cyc_cnt <= 0;
    end
    else begin
    state <= nextstate;
    cyc_cnt <= cyc_cnt + 1;
    end
end

//Next state logic
always_comb begin

    case(state)
    RST: begin
        en_sipo = 0;
        en_piso = 0;
        load = 0;
        if(start)
        nextstate = FILLSIPO;
        else
        nextstate = RST;
    end

    FILLSIPO: begin
        en_sipo = 1;
        load = 1;
        en_piso = 0;

        //Preload PISO
        if(cyc_cnt ==17) begin
        en_piso = 1;
        load = 1;
        en_sipo = 1;
        nextstate = FILLSIPO;
        end

        else if(cyc_cnt == 18) begin
        en_sipo = 0;
        en_piso = 0;
        load = 1;
        nextstate = READPISO;
        end

        else begin
        nextstate = FILLSIPO;
        en_sipo = 1;
        en_piso = 0;
        load = 1;
        end
    end

    READPISO: begin
        en_sipo = 0;
        en_piso = 1;
        load = 0;
        nextstate = READPISO;
    end

    default: begin
        nextstate = RST;
        en_piso = 0;
        en_sipo = 0;
        load = 0;
    end

    endcase
end

//Output logic
assign sipo_clk = clk & en_sipo;
assign piso_clk = clk & en_piso;

endmodule