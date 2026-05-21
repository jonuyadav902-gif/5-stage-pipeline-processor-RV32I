`timescale 1ns / 1ps

module data_mem_stage(
input logic clk,
input logic rst,
input logic RegWriteM,
input logic [1:0] ResultSrcM,
input logic MemWriteM,
input logic [31:0] ALUResultM,
input logic [31:0] WriteDataM,
input logic [4:0] RdM,
input logic [31:0] PcPlus4M,
input logic [2:0] funct3M,
output logic RegWriteW,
output logic [1:0] ResultSrcW,
output logic [31:0] ALUResultW,
output logic [31:0] ReadDataW,
output logic [4:0] RdW,
output logic [31:0] PcPlus4W
);

logic [31:0] ReadDataM;

data_memory dm(
    .clk(clk),
    .A(ALUResultM),
    .WD(WriteDataM),
    .WE(MemWriteM),
    .RD(ReadDataM),
    .funct3M(funct3M)
);

always_ff @(posedge clk or negedge rst)
begin
    if(!rst)
    begin
        RegWriteW  <= 0;
        ResultSrcW <= 0;
        ALUResultW <= 0;
        ReadDataW  <= 0;
        RdW        <= 0;
        PcPlus4W   <= 0;
    end
    else
    begin
        RegWriteW  <= RegWriteM;
        ResultSrcW <= ResultSrcM;
        ALUResultW <= ALUResultM;
        ReadDataW  <= ReadDataM;
        RdW        <= RdM;
        PcPlus4W   <= PcPlus4M;
    end
end

endmodule