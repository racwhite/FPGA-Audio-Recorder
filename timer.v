`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2022 11:56:48 AM
// Design Name: 
// Module Name: timer
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
module timer(
    input enable_i_rec, enable_i_play,
    input doneSignal,
    input reset,
    output reg done // 2 seconds have passed
    );
    
    reg [16:0] counter;
        
    initial begin
        counter <= 0;
    end
    
    always @(posedge doneSignal, posedge reset)
    begin
        if(reset)
        begin
            done <= 0;
            counter <= 0;
        end
        else if(enable_i_rec || enable_i_play)
            begin
            // pass in 1khz clock scalar
                if(counter == 2 * 1000)
                begin
                    done <= 1;
                    counter <= 0;
                end
                else
                begin
                    counter <= counter + 1;
                end            
            end
         else
         begin
            counter <= 0;
            done <= 0;
         end
        
    end    
endmodule
