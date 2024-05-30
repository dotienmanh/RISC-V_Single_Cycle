module alu_module (
    dataA,
    dataB,
    pc,
    imm,
    alu,
    Asel,
    Bsel,
    ALUSel
);
    parameter df = 4'b0000;
    parameter add = 4'b0001;
    parameter sub = 4'b0010;
    parameter sll = 4'b0011;
    parameter slt = 4'b0100;
    parameter sltu = 4'b0101;
    parameter xor_op = 4'b0110;
    parameter srl = 4'b0111;
    parameter sra = 4'b1000;
    parameter or_op = 4'b1001;
    parameter and_op = 4'b1010;

    input [31:0] dataA;
    input [31:0] dataB;
    input [31:0] pc;
    input [31:0] imm;
    
    input Asel;
    input Bsel;
    input [3:0] ALUSel;

    output reg [31:0] alu;

    reg [31:0] opA;
    reg [31:0] opB;

    always @(Asel or pc or dataA) begin
        if(Asel) begin
            opA = pc;
        end else begin
            opA = dataA;
        end
    end

    always @(Bsel or imm or dataB) begin
        if(Bsel) begin
            opB = imm;
        end else begin
            opB = dataB;
        end
    end

    always @(Asel or Bsel or ALUSel or opA or opB) begin
        case(ALUSel)
            add: alu = opA + opB;
            sub: alu = opA - opB;
            sll: alu = opA << opB;
            slt: alu = ($signed(opA) < $signed(opB)) ? 1 : 0;
            sltu: alu = (opA < opB) ? 1 : 0;
            xor_op: alu = opA ^ opB;
            srl: alu = opA >> opB;
            sra: alu = opA >>> opB;
            or_op: alu = opA | opB;
            and_op: alu = opA & opB;
            default: alu = 32'h00000000;
        endcase
    end
    
endmodule