// `include "pc_module.v"
// `include "imem.v"
// `include "reg_module.v"
// `include "imm_gen.v"
// `include "branch.v"
// `include "alu_module.v"
// `include "dmem.v"
// `include "write_back.v"
// `include "control_unit.v"

module single_cycle (
    clk,
    rst_n
);
    input clk;
    input rst_n;

    wire [31:0] pc;
    wire [31:0] pc_4;
    wire [31:0] inst;
    wire [31:0] dataA;
    wire [31:0] dataB;
    wire [31:0] dataD;
    wire [31:0] imm;
    wire [31:0] alu;
    wire [31:0] mem;


    wire BrEq;
    wire BrLt;
    wire PCSel;
    wire [2:0] immSel;
    wire RegWEn;
    wire BrUn;
    wire Bsel;
    wire Asel;
    wire [3:0] ALUSel;
    wire MemRW;
    wire [1:0] WBSel;

    pc_module pc_mod(.alu(alu), .PCSel(PCSel), .clk(clk), .pc(pc), .pc_4(pc_4), .rst_n(rst_n));
    imem imem_mod(.pc(pc), .inst(inst));
    reg_module reg_mod(.inst(inst), .clk(clk), .dataD(dataD), .dataA(dataA), .dataB(dataB), .RegWEn(RegWEn));
    imm_gen imm_mod(.inst(inst), .immSel(immSel), .imm(imm));
    branch branch_mod(.dataA(dataA), .dataB(dataB), .BrUn(BrUn), .BrEq(BrEq), .BrLt(BrLt));
    alu_module alu_mod(.dataA(dataA), .dataB(dataB), .pc(pc), .imm(imm), .alu(alu), .Asel(Asel), .Bsel(Bsel), .ALUSel(ALUSel));
    dmem dmem_mod(.addr(alu), .dataW(dataB), .clk(clk), .dataB(mem), .MemRW(MemRW));
    write_back wb_mod(.alu(alu), .dataB(mem), .pc_4(pc_4), .WBSel(WBSel), .wb(dataD)); 

    control_unit cu(.PCSel(PCSel), .inst(inst), .immSel(immSel), .RegWEn(RegWEn), .BrUn(BrUn), .BrEq(BrEq), .BrLt(BrLt), .Bsel(Bsel), .Asel(Asel), .ALUSel(ALUSel), .MemRW(MemRW), .WBSel(WBSel));

    
endmodule