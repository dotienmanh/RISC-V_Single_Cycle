`timescale 1ps/1ps
module control_unit_tb();

    wire PCSel;
    reg [31:0] inst;
    wire [2:0] immSel;
    wire RegWEn;
    wire BrUn;
    reg BrEq,BrLt;
    wire Bsel;
    wire Asel;
    wire [3:0] ALUSel;
    wire MemRW;
    wire [1:0] WBSel;

    parameter T=800;

    control_unit uut(
        PCSel,
        inst,
        immSel,
        RegWEn,
        BrUn,
        BrEq,
        BrLt,
        Bsel,
        Asel,
        ALUSel,
        MemRW,
        WBSel
    );

    initial begin
    end 
endmodule
