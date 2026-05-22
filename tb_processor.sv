`timescale 1ns / 1ps

module tb_processor;

logic clk;
logic rst;
logic [31:0] debug_out;

pipline_top dut(
    .clk(clk),
    .rst(rst),
    .debug_out(debug_out)
);

//////////////////////////////////////////////////////
// CLOCK GENERATION
//////////////////////////////////////////////////////

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

//////////////////////////////////////////////////////
// RESET
//////////////////////////////////////////////////////

initial begin
    rst = 0;
    #20;
    rst = 1;
end

//////////////////////////////////////////////////////
// SIMULATION STOP
//////////////////////////////////////////////////////

initial begin
    #15000;
    $finish;
end

//////////////////////////////////////////////////////
// MONITOR
//////////////////////////////////////////////////////

initial begin
    $monitor(
        "TIME=%0t PC=%h INSTR=%h RESULT=%h",
        $time,
        dut.fetch.PCF,
        dut.InstrD,
        debug_out
    );
end

//////////////////////////////////////////////////////
// REGISTER FILE CHECK
//////////////////////////////////////////////////////

initial begin

    #1000;                                          // ← was #800, changed to #1000

    $display("-----------------------------------");
    $display("REGISTER FILE VALUES");
    $display("-----------------------------------");

    $display("x1  = %h", dut.decode.register_file.reg_file[1]);
    $display("x2  = %h", dut.decode.register_file.reg_file[2]);
    $display("x3  = %h", dut.decode.register_file.reg_file[3]);
    $display("x4  = %h", dut.decode.register_file.reg_file[4]);
    $display("x5  = %h", dut.decode.register_file.reg_file[5]);
    $display("x6  = %h", dut.decode.register_file.reg_file[6]);
    $display("x7  = %h", dut.decode.register_file.reg_file[7]);
    $display("x8  = %h", dut.decode.register_file.reg_file[8]);
    $display("x9  = %h", dut.decode.register_file.reg_file[9]);
    $display("x10 = %h", dut.decode.register_file.reg_file[10]);
    $display("x11 = %h", dut.decode.register_file.reg_file[11]);
    $display("x12 = %h", dut.decode.register_file.reg_file[12]);
    $display("x13 = %h", dut.decode.register_file.reg_file[13]);
    $display("x14 = %h", dut.decode.register_file.reg_file[14]);
    $display("x15 = %h", dut.decode.register_file.reg_file[15]);
    $display("x16 = %h", dut.decode.register_file.reg_file[16]);
    $display("x17 = %h", dut.decode.register_file.reg_file[17]);
    $display("x18 = %h", dut.decode.register_file.reg_file[18]);
    $display("x19 = %h", dut.decode.register_file.reg_file[19]);
    $display("x20 = %h", dut.decode.register_file.reg_file[20]);
    $display("x21 = %h", dut.decode.register_file.reg_file[21]);
    $display("x22 = %h", dut.decode.register_file.reg_file[22]); // ← was "x21"
    $display("x23 = %h", dut.decode.register_file.reg_file[23]); // ← was "x21"
    $display("x24 = %h", dut.decode.register_file.reg_file[24]); // ← was "x21"
    $display("x25 = %h", dut.decode.register_file.reg_file[25]); // ← was "x21"
    $display("x26 = %h", dut.decode.register_file.reg_file[26]); // ← was "x21"
    $display("x27 = %h", dut.decode.register_file.reg_file[27]); // ← was "x21"
    $display("x28 = %h", dut.decode.register_file.reg_file[28]); // ← was "x21"
    $display("x29 = %h", dut.decode.register_file.reg_file[29]); // ← was "x21"
    $display("x30 = %h", dut.decode.register_file.reg_file[30]); // ← NEW
    $display("x31 = %h", dut.decode.register_file.reg_file[31]); // ← NEW
    $display("-----------------------------------");
    $display("DATA MEMORY VALUES");
    $display("-----------------------------------");

    $display("MEM[116] = %h", dut.memory_stage.dm.Mem[116]);
    $display("MEM[117] = %h", dut.memory_stage.dm.Mem[117]);
    $display("MEM[118] = %h", dut.memory_stage.dm.Mem[118]);
    $display("MEM[119] = %h", dut.memory_stage.dm.Mem[119]);
    $display("MEM[120] = %h", dut.memory_stage.dm.Mem[120]);
    $display("MEM[121] = %h", dut.memory_stage.dm.Mem[121]);
    $display("MEM[122] = %h", dut.memory_stage.dm.Mem[122]);
    $display("MEM[123] = %h", dut.memory_stage.dm.Mem[123]);
    $display("MEM[124] = %h", dut.memory_stage.dm.Mem[124]);
    $display("MEM[125] = %h", dut.memory_stage.dm.Mem[125]);
    $display("MEM[126] = %h", dut.memory_stage.dm.Mem[126]);
    $display("MEM[127] = %h", dut.memory_stage.dm.Mem[127]);
    

    $display("-----------------------------------");

end
endmodule