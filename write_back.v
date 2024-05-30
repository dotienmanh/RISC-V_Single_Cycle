module write_back(
    alu, 
    dataB,
    pc_4,
    WBSel,
    wb
);
    input [31:0] alu;
    input [31:0] dataB;
    input [31:0] pc_4;

    input [1:0] WBSel;

    output reg [31:0] wb;

    always @(WBSel or dataB or alu or pc_4) begin
        case (WBSel)
            2'b00: wb = dataB;
            2'b01: wb = alu;
            2'b10: wb = pc_4;
            default: wb = 32'h00000000;
        endcase
        // if(WBSel == 2'b00) begin
        //     wb = dataB;
        // end else if (WBSel == 2'b01) begin
        //     wb = alu;
        // end else if (WBSel == 2'b10) begin
        //     wb = pc_4;
        // end else if (WBSel == 2'b11) begin
        //     wb = wb;
        // end
    end

endmodule