`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.05.2026 18:06:10
// Design Name: 
// Module Name: control_unit_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control_unit_top(
input logic [6:0]op,
input logic [2:0]funct3,
input logic [6:0]funct7,
output logic RegWriteD,
output logic [1:0] ResultSrcD,
output logic MemWriteD,
output logic jumpD,
output logic BranchD,
output logic [3:0]ALUControlD,
output logic ALUSrcD,
output logic [1:0]ImmSrcD);
 logic [1:0]ALUOpConnec;
 ALU_Decoder alu (
             .op(op),
             .funct3(funct3),
             .funct7(funct7),
             .ALUOp(ALUOpConnec),
             .ALUControl(ALUControlD));
             
 main_decoder decoder (
            .op(op),
            .ResultSrc(ResultSrcD),
            .MemWrite(MemWriteD),
            .ALUSrc(ALUSrcD),
            .ImmSrc(ImmSrcD),
            .RegWrite(RegWriteD),
            .jump(jumpD),
            .Branch(BranchD),
            .ALUOp(ALUOpConnec)
    );
endmodule
