`timescale 1ps/1ps
module pc_module_tb();

    reg [31:0] alu;
    reg PCSel;
    reg clk;
    reg rst_n;

    wire [31:0] pc_4;
    wire [31:0] pc;

    parameter T=800;
    pc_module uut(
        .alu(alu),
        .PCSel(PCSel),
        .clk(clk),
        .pc(pc),
        .pc_4(pc_4),
        .rst_n(rst_n)
    );

    initial begin
        clk=0;
        forever #(T/2) clk = ~clk;
    end

    initial begin
        rst_n=0;
        #200
        rst_n=1;
    end

    initial begin
        PCSel=0;
		  
        # (2*T)
        PCSel=1;
        alu=32'b00000000000000000000000001000100;
		  
        # (2*T)
        PCSel=0;
		  
        # (2*T)
        PCSel=0;
		  
        # (2*T)
        PCSel=1;
    end
endmodule
