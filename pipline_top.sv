`timescale 1ns / 1ps


module pipline_top(
input logic clk,
input logic rst,
output logic [31:0] debug_out
);

logic [31:0] InstrD;
logic [31:0] PcD;
logic [31:0] PcPlus4D;

logic RegWriteE;
logic [1:0] ResultSrcE;
logic MemWriteE;
logic jumpE;
logic BranchE;
logic [3:0] ALUControlE;
logic ALUSrcE;
logic [31:0] RD1E;
logic [31:0] RD2E;
logic [31:0] PCE;
logic [4:0] RdE;
logic [4:0] RS1E;
logic [4:0] RS2E;
logic [31:0] ImmExtendE;
logic [31:0] PcPlus4E;
logic [2:0] funct3E;

logic RegWriteM;
logic [1:0] ResultSrcM;
logic MemWriteM;
logic [31:0] ALUResultM;
logic [31:0] WriteDataM;
logic [4:0] RdM;
logic [31:0] PcPlus4M;
logic [31:0] PcTargetE;
logic PcSrcE;
logic [2:0] funct3M;

logic RegWriteW;
logic [1:0] ResultSrcW;
logic [31:0] ALUResultW;
logic [31:0] ReadDataW;
logic [4:0] RdW;
logic [31:0] PcPlus4W;

logic [31:0] ResultW;

logic [1:0] ForwardAE;
logic [1:0] ForwardBE;
logic StallF;
logic StallD;
logic FlushD;
logic FlushE;
logic [4:0] Rs1D;
logic [4:0] Rs2D;
logic lw_stall;

IF fetch(
    .clk(clk),
    .rst(rst),
    .PcSrcE(PcSrcE),
    .StallF(StallF),
    .PcTargetE(PcTargetE),
    .InstrD(InstrD),
    .PcD(PcD),
    .PcPlus4D(PcPlus4D)
);

decode_stage decode(
    .clk(clk),
    .rst(rst),
    .RegWriteW(RegWriteW),
    .InstrD(InstrD),
    .PCD(PcD),
    .PcPlus4D(PcPlus4D),
    .ResultW(ResultW),
    .RdW(RdW),
    .StallD(StallD),
    .FlushD(FlushD),
    .RegWriteE(RegWriteE),
    .ResultSrcE(ResultSrcE),
    .MemWriteE(MemWriteE),
    .jumpE(jumpE),
    .BranchE(BranchE),
    .ALUControlE(ALUControlE),
    .ALUSrcE(ALUSrcE),
    .RD1E(RD1E),
    .RD2E(RD2E),
    .PCE(PCE),
    .RdE(RdE),
    .RS1E(RS1E),
    .RS2E(RS2E),
    .ImmExtendE(ImmExtendE),
    .PcPlus4E(PcPlus4E),
    .RS1D(Rs1D),
    .RS2D(Rs2D),
    .funct3E(funct3E)
);

Execute_stage execute(
    .clk(clk),
    .rst(rst),
    .RegWriteE(RegWriteE),
    .ResultSrcE(ResultSrcE),
    .MemWriteE(MemWriteE),
    .jumpE(jumpE),
    .BranchE(BranchE),
    .ALUControlE(ALUControlE),
    .ALUSrcE(ALUSrcE),
    .RD1E(RD1E),
    .RD2E(RD2E),
    .PCE(PCE),
    .RdE(RdE),
    .RS1E(RS1E),
    .RS2E(RS2E),
    .ImmExtendE(ImmExtendE),
    .PcPlus4E(PcPlus4E),
    .ResultW(ResultW),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE),
    .FlushE(FlushE),
    .funct3E(funct3E),
    .RegWriteM(RegWriteM),
    .ResultSrcM(ResultSrcM),
    .MemWriteM(MemWriteM),
    .ALUResultM(ALUResultM),
    .WriteDataM(WriteDataM),
    .RdM(RdM),
    .PcPlus4M(PcPlus4M),
    .PcTargetE(PcTargetE),
    .PcSrcE(PcSrcE),
    .ALUResultM_forward(ALUResultM),
    .funct3M(funct3M)
);

data_mem_stage memory_stage(
    .clk(clk),
    .rst(rst),
    .RegWriteM(RegWriteM),
    .ResultSrcM(ResultSrcM),
    .MemWriteM(MemWriteM),
    .ALUResultM(ALUResultM),
    .WriteDataM(WriteDataM),
    .RdM(RdM),
    .PcPlus4M(PcPlus4M),
    .funct3M(funct3M),
    .RegWriteW(RegWriteW),
    .ResultSrcW(ResultSrcW),
    .ALUResultW(ALUResultW),
    .ReadDataW(ReadDataW),
    .RdW(RdW),
    .PcPlus4W(PcPlus4W)
);

write_back_stage wb(
    .RegWriteW(RegWriteW),
    .ResultSrcW(ResultSrcW),
    .ALUResultW(ALUResultW),
    .ReadDataW(ReadDataW),
    .RdW(RdW),
    .PcPlus4W(PcPlus4W),
    .ResultW(ResultW)
);

 hazard_unit ha(
    .rst(rst),
    .RegWriteM(RegWriteM),
    .RegWriteW(RegWriteW),
    .RdM(RdM),
    .RdW(RdW),
    .Rs1E(RS1E),
    .Rs2E(RS2E),
    .Rs1D(Rs1D),
    .Rs2D(Rs2D),
    .ResultSrcE(ResultSrcE),
    .RdE(RdE),
    .PcSrcE(PcSrcE),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE),
    .StallF(StallF),
    .StallD(StallD),
    .FlushD(FlushD),
    .FlushE(FlushE),
    .lw_stall(lw_stall)
);

assign debug_out = ResultW;

endmodule