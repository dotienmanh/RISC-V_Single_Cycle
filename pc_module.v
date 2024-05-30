module pc_module (
    alu, 
    PCSel,
    clk,
    pc,
    pc_4,
    rst_n
);

    input [31:0] alu;
    input PCSel;
    input clk;
    input rst_n;

    output reg [31:0] pc_4;
    output reg [31:0] pc;

    reg [31:0] pc_pre;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pc <= 0;
        end else begin
            pc <= pc_pre;
        end
        // pc <= pc_pre;
    end

    always @(pc) begin
        pc_4 = pc + 32'h00000004;
    end

    always @(PCSel or pc_4 or alu) begin
        if(PCSel == 0) begin
            pc_pre = pc_4;
        end else begin
            pc_pre = alu;
        end
    end
endmodule