////////////
`timescale 1ns / 1ps
module aludec(input  logic [5:0] funct,
              input  logic [1:0] aluop,
              output logic [2:0] alucontrol);

  always_comb
    case(aluop)
      //for the non r-type instructions
      2'b00: alucontrol <= 3'b010;  // add (for lw/sw/addi)
      2'b01: alucontrol <= 3'b110;  // sub (for beq)
      2'b11: alucontrol <= 3'b101;  // LI: 101 in the alu performs the LI operation
      
      //for the r-type instructions
      default: case(funct)          
          6'b100000: alucontrol <= 3'b010; // add
          6'b100010: alucontrol <= 3'b110; // sub
          6'b100100: alucontrol <= 3'b000; // and
          6'b100101: alucontrol <= 3'b001; // or
          6'b101010: alucontrol <= 3'b111; // slt
          
          //Added the following new operations with regards to the funct fields of the new operations
          6'b000000: alucontrol <= 3'b011; // SLL: 011 in the alu performs the SLL operation
          6'b110011: alucontrol <= 3'b100; // ZFR: 100 in the alu performs the ZFR operation
          //End of added new operations
          
          default:   alucontrol <= 3'bxxx; // 
        endcase
    endcase
endmodule
