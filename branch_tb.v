`timescale 1ps/1ps

module branch_tb();

parameter T=800;

reg [31:0] dataA;
reg [31:0] dataB;
reg BrUn;

wire BrEq;
wire BrLt;

branch uut(
    dataA,
    dataB,
    BrUn,
    BrEq,
    BrLt
);

initial begin
    BrUn=0;
    //BrEq=0
    //BrLt=1
    dataA=32'b00000000000000000000000000000101;
    dataB=32'b00000000000000000000000000001010;
    #T
    //BrLt=0
    dataB=32'b00000000000000000000000000000101;
    dataA=32'b00000000000000000000000000001010;

    #T
    //BrEq=1 BrLt=0
    dataB=32'b00000000000000000000000000000101;
    dataA=32'b00000000000000000000000000000101;

end

endmodule