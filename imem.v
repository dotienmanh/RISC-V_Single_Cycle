module imem (
    pc,
    inst
);
    input [31:0] pc;
    output reg [31:0] inst;

    reg [31:0] mem_arr [31:0];
    
	 initial begin
        mem_arr[0]=32'b00000000000100000000001010010011;	//addi x5, x0, 1
        mem_arr[1]=32'b00000001010000110000001100010011;	//addi x6,x6, 20
        mem_arr[2]=32'b00000000000100101000001010010011;	//addi x5,x5,1
        mem_arr[3]=32'b11111110011000101100111011100011;	//blt x5, x6, 1
        mem_arr[4]=32'b00000000010100000010000000100011;	//sw x5, 0(x0)
        mem_arr[5]=32'b00000000000000000010001110000011;	//lw x7, 0(x0)
    end
	 
	 
	
    //initial begin
    //    $readmemb("exe.txt", mem_arr);
    // end
	

    always @(pc) begin
        inst = mem_arr[pc[31:2]];
    end


endmodule