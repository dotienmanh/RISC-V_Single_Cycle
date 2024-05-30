`timescale 1ps/1ps

module alu_module_tb();

parameter T=800;

reg [31:0] dataA;
reg [31:0] dataB;
reg [31:0] pc;
reg [31:0] imm;

reg Asel;
reg Bsel;
reg [3:0] ALUSel;

wire [31:0] alu;

alu_module uut(
    dataA,
    dataB,
    pc,
    imm,
    Asel,
    Bsel,
    ALUSel,
    alu
);

initial begin
    ALUSel=4'b0000;
    Asel=0;
    Bsel=0;
    pc=32'b00000000000000000000000000000000;
    imm=32'b00000000000000000000000000000000;
    dataA=32'b00000000000000000000000000000101;
    dataB=32'b00000000000000000000000000001010;
    #T
    ALUSel=2;
    #T
    ALUSel=3;
    #T
    ALUSel=4;
    #T
    ALUSel=5;
    #T
    ALUSel=6;
    #T
    ALUSel=7;
    #T
    ALUSel=8;
    #T
    ALUSel=9;
    #T
    ALUSel=10;
end

endmodule