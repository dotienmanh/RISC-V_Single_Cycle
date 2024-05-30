module branch(
    dataA,
    dataB,
    BrUn,
    BrEq,
    BrLt
);
    input [31:0] dataA;
    input [31:0] dataB;
    input BrUn;
    
    output reg BrEq;
    output reg BrLt;

    always @(dataA or dataB or BrUn) begin
        if(dataA == dataB) begin
            BrEq = 1;
            BrLt = 0;
        end else begin
            BrEq = 0;
            if(BrUn==1'b0) begin
                if($signed(dataA)<$signed(dataB))begin
                    BrLt = 1;
                end else begin
                    BrLt = 0;
                end
            end else begin
                if(dataA<dataB)begin
                    BrLt = 1;
                end else begin
                    BrLt = 0;
                end
            end
        end
    end


endmodule