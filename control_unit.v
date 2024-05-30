`timescale 1ps/1ps
module control_unit (
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

    parameter R = 3'b000;
    parameter I = 3'b001;
    parameter S = 3'b010;
    parameter B = 3'b011;
    parameter U = 3'b100;
    parameter J = 3'b101;

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

    parameter read = 0;
    parameter write = 1;

    input [31:0] inst ;
    input BrEq;
    input BrLt;

    output reg PCSel;
    output reg [2:0] immSel;
    output reg RegWEn;
    output reg BrUn;
    output reg Bsel;
    output reg Asel;
    output reg [3:0] ALUSel;
    output reg MemRW;
    output reg [1:0] WBSel;

    always @(inst) begin
	 #100
        if (inst[6:4]==3'b110) begin
            if(inst[2]==1) begin
                //JR instruction
                PCSel=1;
                RegWEn=1;
                Bsel=1;
                if(inst[3]==1) begin
                    //jal
                    Asel= 1;
                    immSel = J;
                end else begin
                    //jalr
                    Asel=0;
                    immSel = I;
                end
                ALUSel = add;
                MemRW = read;
                WBSel = 2;
                BrUn = 1'b0;
            end else begin
                //branch
                immSel = B;
                RegWEn = 0;
                Bsel = 1;
                Asel = 1;
                MemRW =read;
                ALUSel = add;
                WBSel = 2'b00;
                if(inst[14]==0) begin
                    if(inst[12]==0) begin
                        if(BrEq==1) begin
                            PCSel=1;
                        end else begin
                            PCSel=0;
                        end
                    end else begin
                        if(BrEq==1) begin
                            PCSel=0;
                        end else begin
                            PCSel=1;
                        end
                    end
                    BrUn = 0;
                end else begin
                    if(inst[12]==0) begin
                        if(BrLt==1) begin
                            PCSel=1;
                        end else begin
                            PCSel=0;
                        end
                    end else begin
                        if(BrLt==1) begin
                            PCSel=0;
                        end else begin
                            PCSel=1;
                        end
                    end
                    if (inst[13]==1) begin
                        BrUn = 1;
                    end else begin
                        BrUn = 0;
                    end
                end
            end
        end else if (inst[6:4]==3'b010) begin
            immSel = S;
            RegWEn = 0;
            Bsel = 1;
            ALUSel = add;
            MemRW = write;
            Asel = 0;
            PCSel = 0;
            BrUn = 1'b0;
            WBSel = 2'b00;
        end else if (inst[6:4]==3'b000) begin
            immSel = I;
            RegWEn = 1;
            Bsel = 1;
            ALUSel = add;
            MemRW = read;
            WBSel = 0;
            PCSel = 0;
            Asel =0;
            BrUn = 1'b0;
        end else if (inst[6:4]==3'b001) begin
            immSel = I;
            RegWEn = 1;
            Bsel =1;
            WBSel = 1;
            PCSel = 0;
            Asel =0;
            BrUn = 1'b0;
            MemRW = 1'b0;
            if(inst[14:12] == 3'b000)begin
                //add
                ALUSel = add;
            end else if (inst[14:12] == 3'b001) begin
               //slli 
                if(inst[31:25]==7'b0000000) begin
                    ALUSel = sll;
                end else begin
                    ALUSel = df;
                end
            end else if (inst[14:12] == 3'b010) begin
                //slt
                ALUSel = slt;
            end else if (inst[14:12] == 3'b011) begin
                //sltu
                ALUSel = sltu;
            end else if (inst[14:12] == 3'b100) begin
                //xor
                ALUSel = xor_op;
            end else if (inst[14:12] == 3'b101) begin
                //srli & srai
                if(inst[31:25]==7'b0000000) begin
                    ALUSel = srl;
                end else if(inst[31:25]==7'b0100000) begin
                    ALUSel = sra;
                end else begin
                    ALUSel = df;
                end
            end else if (inst[14:12] == 3'b110) begin
                //or
                ALUSel = or_op;
            end else if (inst[14:12] == 3'b111) begin
                //and
                ALUSel = and_op;
            end else begin
                ALUSel = df;
            end
        end else if (inst[6:4] == 3'b011) begin
            immSel = R;
            RegWEn = 1;
            WBSel = 1;
            Asel= 0;
            Bsel = 0;
            PCSel = 0;
            BrUn = 1'b0;
            MemRW = 1'b0;
            if(inst[31:25] == 7'b0000000)begin
                if(inst[14:12] == 3'b000)begin
                    //add
                    ALUSel = add;
                end else if (inst[14:12] == 3'b001) begin
                    //sll
                    ALUSel = sll;
                end else if (inst[14:12] == 3'b010) begin
                    //slt
                    ALUSel = slt;
                end else if (inst[14:12] == 3'b011) begin
                    //sltu
                    ALUSel = sltu;
                end else if (inst[14:12] == 3'b100) begin
                    //xor
                    ALUSel = xor_op;
                end else if (inst[14:12] == 3'b101) begin
                    //srl
                    ALUSel = srl;
                end else if (inst[14:12] == 3'b110) begin
                    //or
                    ALUSel = or_op;
                end else if (inst[14:12] == 3'b111) begin
                    //and
                    ALUSel = and_op;
                end else begin
                    ALUSel = df;
                end
            end else if (inst[31:25] == 7'b0100000) begin
                if (inst[14:12] == 3'b000) begin
                    //sub
                    ALUSel = sub;
                end else if (inst[14:12] == 3'b101) begin
                    //sra
                    ALUSel = sra;
                end else begin
                    //default
                    ALUSel = df;
                end
            end else begin
                //default
                    ALUSel = df;
            end
        end else begin
            PCSel = 0;
            immSel = 3'b000;
            RegWEn = 0;
            BrUn = 0;
            Bsel = 0;
            Asel = 0;
            ALUSel = 4'h0;
            MemRW = 0;
            WBSel = 2'b00;
        end
    end
    
endmodule