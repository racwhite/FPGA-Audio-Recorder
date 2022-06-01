`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2022 02:30:19 PM
// Design Name: 
// Module Name: ClockScalar
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

module ClockScalar(
        input reset, clock,
        output reg scaled_clk
    );
    
    reg [27:0] counter;
    always @( posedge clock or posedge reset)
    begin
        if(reset)
         begin
            scaled_clk <= 0;
            counter <= 0;
         end
        else
        // on each clock edge 
            begin
                counter <= counter + 1;
                if (counter == 50) // 50 ns 
                    begin 
                        counter <= 0;
                        scaled_clk <= ~scaled_clk;
                        // pos edge to pos edge makes 100MHz -> 1MHz
                     end end end
endmodule
