`timescale 1ns / 1ps
module dmem(input  logic        clk, we,
            input  logic [31:0] a, wd,
            input logic         memwidth,    //SB: added memwidth as an input to dmem
            output logic [31:0] rd
            );

  logic [31:0] RAM[63:0];

  assign rd = RAM[a[31:2]]; // word aligned

  always_ff @(posedge clk)
    if (we)                              
        //SB: added cases for saving bytes given the memwidth
        case(memwidth)
        0:  //SB: if the memwidth is 0, save a byte
            case(a[1:0])            //SB: given the last two bytes of the address, save the byte at a particular location (big-endian)
            0: RAM[a[31:2]][31:24] <= wd[7:0];  //SB: if it's 00, save it at the leftmost byte
            1: RAM[a[31:2]][23:16] <= wd[7:0];  //SB: if it's 01, save it at the second leftmost byte
            2: RAM[a[31:2]][15:8] <= wd[7:0];   //SB: if it's 10, save it at the second rightnost byte
            3: RAM[a[31:2]][7:0] <= wd[7:0];    //SB: if it's 11, save it at the rightmost byte
            endcase
        1:  RAM[a[31: 2]] <= wd;    //SB: if the memwidth is 1, save the whole word
        default: RAM[a[31: 2]] <= RAM[a[31: 2]];
        endcase
endmodule