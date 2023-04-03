module alu(input  logic [31:0] a, b,
           input  logic [2:0]  alucontrol,
           input  logic [4:0]  shamt,   //SLL: added new input for shift amount from the instruction for sll
           output logic [31:0] result,
           output logic        zero,
           output logic        sign);   //BLE: added sign as an output (to be used in the controller)
 
  //ZFR: Added masks to perform the ZFR operation
  logic [31:0] masked;                  //ZFR: refers to the result of the mask
  logic [31:0] mask;                    //ZFR: refers to the mask
  assign mask = {32{1'b1}} << b[4:0]+1; //ZFR: creates a bitstring of 1's that's shifted n+1 bits to the left
  assign masked = a & mask;             //ZFR: gets the AND of a and the mask to make the last n+1 bits of a into zeroes
  
  always_comb
    //GENERAL: made the cases look at the 3 bits of alucontrol instead of just the two bits
    case (alucontrol) 
      3'b000: result = a & b; //GENERAL: changed 00 to 000
      3'b001: result = a | b; //GENERAL: changed 01 to 001
      3'b010: result = a + b; //GENERAL: changed 10 to 010, adds a + b
      3'b110: result = a - b; //GENERAL: changed 10 to 110, subtracts b from a
      3'b111: result = $signed(a) < $signed(b); //GENERAL: changed 11 to 111, gets a < b
      
      //NEW OPERATIONS 
      3'b011: result = b << shamt;              //SLL: shifts b by shamt
      3'b101: result = {{16{0}}, b[15:0]};      //LI:  takes the first 2 bytes of b and zero-extends it
      3'b100: result = masked;                  //ZFR: returns the masked number
    endcase

  assign zero = (result == 32'b0);
  assign sign = result[31];                     //BLE: added sign of the result 
endmodule