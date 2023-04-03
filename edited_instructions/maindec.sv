`timescale 1ns / 1ps
module maindec(input  logic [5:0] op,
               output logic       memtoreg, memwrite,
               output logic       branch, alusrc,
               output logic       regdst, regwrite,
               output logic       jump,
               output logic [1:0] aluop,
               output logic       memwidth); //SB: Added memwidth as an output of maindec

  logic [9:0] controls;                      //SB: Changed number of bits to 10 to accommodate memwidth as a new output

  assign {memwidth, regwrite, regdst, alusrc, branch, memwrite,
          memtoreg, jump, aluop} = controls; //SB: added memwidth to be the 10th bit of control

  always_comb
    case(op)
      //SB: Added 10th bit to all controls. 1 if it saves a word, 0 if it saves a byte, x if it doesn't save anything
      6'b000000: controls <= 10'bx110000010; // RTYPE (NEW: includes sll and zfr)
      6'b100011: controls <= 10'bx101001000; // LW
      6'b101011: controls <= 10'b1001010000; // SW - Memwidth is 1 to indicate that we are saving a word
      6'b000100: controls <= 10'bx000100001; // BEQ
      6'b001000: controls <= 10'bx101000000; // ADDI
      6'b000010: controls <= 10'bx000000100; // J
      
      //Added the following new opcodes for the non r-type instructions
      6'b101000: controls <= 10'b0001010000; // SB - Memwidth is 0 to indicate that we are saving a byte
      6'b011111: controls <= 10'bx000100001; // BLE 
      6'b010001: controls <= 10'bx101000011; // LI  
      //End of added opcodes
      
      default:   controls <= 10'bxxxxxxxxxx; // illegal op
    endcase
endmodule