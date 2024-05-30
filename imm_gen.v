module imm_gen (
    inst,
    immSel,
    imm
);
    parameter R = 3'b000;
    parameter I = 3'b001;
    parameter S = 3'b010;
    parameter B = 3'b011;
    parameter U = 3'b100;
    parameter J = 3'b101;

    input [31:0] inst;
    input [2:0] immSel;
    output reg [31:0] imm;

    always @(inst or immSel) begin
        case (immSel)
            I: begin
                imm={{21{inst[31]}}, inst[30:20]};
            end
            S: begin
                imm={{21{inst[31]}}, inst[30:25], inst[11:7]};
            end
            U: begin
                imm={inst[31], inst[30:12], {12{1'b0}}};
            end
            B: begin
                imm={{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
            end
            J: begin
                imm={{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
            end
            default: 
                imm= 32'h00000000;
        endcase
    end
    
endmodule