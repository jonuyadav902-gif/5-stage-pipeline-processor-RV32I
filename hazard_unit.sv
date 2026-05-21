//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 19.05.2026 23:20:51
//// Design Name: 
//// Module Name: hazard_unit
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module hazard_unit(
//input logic rst,RegWriteM,RegWriteW,
//input logic [4:0] RdM,RdW,
//input logic [4:0] Rs1E,Rs2E,
//input logic [4:0] Rs1D,Rs2D,
//input logic [4:0] RdE,
//input logic [1:0] ResultSrcE,
//input logic PcSrcE,
//output logic StallF,StallD,FlushE,
//output logic FlushD,
//output logic [1:0] ForwardAE,ForwardBE,
//output logic lw_stall
//    );
//    //logic lw_stall;
//    assign ForwardAE = (rst == 1'b1)? 2'b00:
//        ((RegWriteM == 1'b1) && (RdM != 5'b00000) && (RdM == Rs1E)) ? 2'b10:
//        ((RegWriteW == 1'b1) && (RdW != 5'b00000) && (RdW == Rs1E)) ? 2'b01:2'b00;
//    assign ForwardBE = (rst == 1'b0)? 2'b00:
//        ((RegWriteM == 1'b1) && (RdM != 5'b00000) && (RdM == Rs2E)) ? 2'b10:
//        ((RegWriteW == 1'b1) && (RdW != 5'b00000) && (RdW == Rs2E)) ? 2'b01:2'b00;
        
      
//      // LOAD-USE HAZARD
//assign lw_Stall = (ResultSrcE == 2'b01) && 
//                 ((RdE == Rs1D) || (RdE == Rs2D));

//// STALLS
//assign StallF = lw_Stall;
//assign StallD = lw_Stall;

//// FLUSHES
//assign FlushD = PcSrcE;
//assign FlushE = lw_Stall | PcSrcE;
        
//endmodule
module hazard_unit(

input logic rst,

input logic RegWriteM,
input logic RegWriteW,

input logic [4:0] RdM,
input logic [4:0] RdW,

input logic [4:0] Rs1E,
input logic [4:0] Rs2E,

input logic [4:0] Rs1D,
input logic [4:0] Rs2D,

input logic [4:0] RdE,

input logic [1:0] ResultSrcE,

input logic PcSrcE,

output logic StallF,
output logic StallD,
output logic FlushE,
output logic FlushD,

output logic [1:0] ForwardAE,
output logic [1:0] ForwardBE,

output logic lw_stall

);

//////////////////////////////////////////////////////
// FORWARDING
//////////////////////////////////////////////////////

assign ForwardAE =
    (!rst) ? 2'b00 :

    ((RegWriteM) && (RdM != 0) && (RdM == Rs1E)) ? 2'b10 :

    ((RegWriteW) && (RdW != 0) && (RdW == Rs1E)) ? 2'b01 :

    2'b00;

assign ForwardBE =
    (!rst) ? 2'b00 :

    ((RegWriteM) && (RdM != 0) && (RdM == Rs2E)) ? 2'b10 :

    ((RegWriteW) && (RdW != 0) && (RdW == Rs2E)) ? 2'b01 :

    2'b00;

//////////////////////////////////////////////////////
// LOAD USE HAZARD
//////////////////////////////////////////////////////

assign lw_stall =
       (ResultSrcE == 2'b01) &&
       (RdE != 5'b00000) &&
       ((RdE == Rs1D) || (RdE == Rs2D));

//////////////////////////////////////////////////////
// STALLS
//////////////////////////////////////////////////////

assign StallF = lw_stall;
assign StallD = lw_stall;

//////////////////////////////////////////////////////
// FLUSHES
//////////////////////////////////////////////////////

assign FlushE = PcSrcE;
assign FlushD = lw_stall | PcSrcE ;

endmodule