`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.05.2026 21:53:53
// Design Name: 
// Module Name: main_decoder
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


module main_decoder(
input logic [6:0]op,
output logic [1:0]ResultSrc,
output logic MemWrite,
output logic ALUSrc,
output logic [1:0]ImmSrc,
output logic RegWrite,
output logic jump,
output logic Branch,
output logic [1:0]ALUOp
    );

always_comb begin

// defaults (VERY IMPORTANT)
RegWrite = 0;
MemWrite = 0;
ALUSrc   = 0;
ResultSrc= 2'b00;
Branch   = 0;
jump     = 0;
ALUOp    = 2'b00;
ImmSrc   = 2'b00;

case(op)

// R-type
7'b0110011: begin
    RegWrite = 1;
    ALUSrc   = 0;
    ALUOp    = 2'b10;
end

// I-type (addi, etc.)
7'b0010011: begin
    RegWrite = 1;
    ALUSrc   = 1;
    ALUOp    = 2'b10;
end

// LOAD
7'b0000011: begin
    RegWrite = 1;
    ALUSrc   = 1;
    ResultSrc= 2'b01;
    ALUOp    = 2'b00;
   
end

// STORE
7'b0100011: begin
    MemWrite = 1;
    ALUSrc   = 1;
    ImmSrc   = 2'b01;
     ALUOp    = 2'b00;
end

// BRANCH
7'b1100011: begin
    Branch   = 1;
    ALUOp    = 2'b01;
    ImmSrc   = 2'b10;
     RegWrite = 0 ;
end

// JAL
7'b1101111: begin
    RegWrite = 1;
    ResultSrc= 2'b10;   // PC+4
    jump     = 1;
    ImmSrc   = 2'b11;
    end
    
    // JALR  ← THIS WAS MISSING - fixes x18, x20
7'b1100111: begin
    RegWrite  = 1;
    ALUSrc    = 1;        // target = rs1 + imm
    ResultSrc = 2'b10;   // write PC+4 into rd
    jump      = 1;
    ImmSrc    = 2'b00;   // I-type immediate
end

default: ;

endcase

end
   
endmodule
