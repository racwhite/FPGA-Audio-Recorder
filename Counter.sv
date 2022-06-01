`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2022 12:31:02 PM
// Design Name: 
// Module Name: Counter
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


module Counter(
        input logic reset, cnt_en, 
        output logic [16:0] addr
    );
    always_ff@(posedge cnt_en or posedge reset)
    begin
        if (reset)
            addr <= 17'd0;
        else
            // add one to memory address 
            addr <= addr + 17'd1;
        end
endmodule
