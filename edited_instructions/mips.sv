`timescale 1ns / 1ps
module mips(input  logic        clk, reset,
            output logic [31:0] pc,
            input  logic [31:0] instr,
            output logic        memwrite,
            output logic [31:0] aluout, writedata,
            output logic        memwidth,                   //SB: added memwidth as an output of mips module
            input  logic [31:0] readdata);

  logic       memtoreg, alusrc, regdst, 
              regwrite, jump, pcsrc, zero, sign;            //BLE: added sign as wire in the mips module to store the sign output of datapath 
  logic [2:0] alucontrol;

  controller c(instr[31:26], instr[5:0], zero, sign,        //BLE: added sign output of datapath as an input to the controller
               memtoreg, memwrite, pcsrc,
               alusrc, regdst, regwrite, jump,
               alucontrol, memwidth);                       //SB: added memwidth as an output of the controller module instance
  datapath dp(clk, reset, memtoreg, pcsrc,
              alusrc, regdst, regwrite, jump,
              alucontrol,                                   
              zero, sign, pc, instr,                        //BLE: added sign as an output of the datapath module instance
              aluout, writedata, readdata);
endmodule