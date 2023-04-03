`timescale 1ns / 1ps
module top(input  logic        clk, reset, 
           output logic [31:0] writedata, dataadr, 
           output logic        memwrite);

  logic [31:0] pc, instr, readdata;
  logic memwidth; //SB: added memwidth to take in the memwidth output of mips 
  
  // instantiate processor and memories
  mips mips(clk, reset, pc, instr, memwrite, dataadr, 
            writedata, memwidth, readdata);                         //SB: added memwidth as an output of the mips instantiated module
  imem imem(pc[7:2], instr);
  dmem dmem(clk, memwrite, dataadr, writedata, memwidth, readdata); //SB: added memwidth as an input to the instantiated dmem module
endmodule