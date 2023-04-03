`timescale 1ns / 1ps
module controller(input  logic [5:0] op, funct,
                  input  logic       zero,
                  input  logic       sign,                  //BLE: added sign as an input to controller
                  output logic       memtoreg, memwrite,
                  output logic       pcsrc, alusrc,
                  output logic       regdst, regwrite,
                  output logic       jump,
                  output logic [2:0] alucontrol,
                  output logic       memwidth);             //SB: added memwidth as an output of controller

  logic [1:0] aluop;
  logic       branch;

  maindec md(op, memtoreg, memwrite, branch,
             alusrc, regdst, regwrite, jump, aluop, memwidth);  //SB: added memwidth as an output of the maindec instantiated module
  aludec  ad(funct, aluop, alucontrol);

  assign pcsrc = (branch & zero) | (branch & sign & (op == 6'b011111)); //BLE: added additional gate that adds another condition to support BEQ and BLE
endmodule