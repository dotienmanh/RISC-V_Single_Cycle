module reg_module(
    inst,
    clk,
    dataD,
    dataA,
    dataB,
    RegWEn,
);
    input [31:0] inst;
    input clk;
    input RegWEn;
    input [31:0] dataD;

    output reg [31:0] dataA;
    output reg [31:0] dataB;

    reg [5:0] addrA;
    reg [5:0] addrB;
    reg [5:0] addrD;

    always @(inst) begin
        addrA = inst[19:15];
        addrB = inst[24:20];
        addrD = inst[11:7];
    end
    

    reg [31:0] reg_data [31:0];

    integer i;
    initial begin
        for(i=0;i<32;i=i+1)begin
            reg_data[i] = 0;
        end
    end

    always @(inst) begin
        dataA = reg_data[addrA];
        dataB = reg_data[addrB];
    end

    always @(posedge clk ) begin
        if(RegWEn==1'b1 && addrD!=0)begin
            reg_data[addrD] <= dataD;
        end
    end

endmodule