`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.05.2026 23:18:31
// Design Name: 
// Module Name: write_back_stage
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


module write_back_stage(
input logic RegWriteW,
input logic  [1:0] ResultSrcW,
input logic [31:0] ALUResultW,
input logic [31:0] ReadDataW,
input logic [4:0]RdW,
input logic [31:0] PcPlus4W,
output logic [31:0] ResultW
    );
    
    
     mux_3_1 m3 (
               .a(ALUResultW),
               .b(ReadDataW),
               .c(PcPlus4W),
               .s(ResultSrcW),
               .muxout(ResultW));
      
endmodule
