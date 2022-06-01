`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2022 01:15:19 PM
// Design Name: 
// Module Name: deserializer
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


module deserializer(
    // clock should be scaled to 1MHz in top module
    input clock, reset, enable_i, pdm_data_i, // audio input bitstream pin H5
    output reg done_o, // ready to put into memory
    reg [15:0]data_o, // 16 bit word
    wire pdm_lrsel_o // select L/R channel pin F5
    );
reg [16:0] data;
// scaling clock internally in case you didnt scale it in top module
//ClockScalar newClock(clock, reset , scaled_clock);

assign pdm_lrsel_o = 0;

reg [4:0] counter;
always@(posedge clock or posedge reset)begin
    begin
            if (reset) 
                begin
                    counter <= 0;
                    done_o <= 0;
                    // values should be cleared 
                    data <= 15'd0;
                    data_o <= data;
                end
            else if (enable_i)
            begin
            if(counter == 15) 
                begin
                    // send data out, reset values
                    data_o <= data[15:0];
                    data <= {16'd0, pdm_data_i};
                    counter <= 0;
                    done_o <= 1;
                end 
                else 
                begin
                    data <= {data[15:0], pdm_data_i};
                    
                    counter <= counter+1;
                    done_o <= 0;
                end
             end
             else
             begin
                counter <= 0;
                done_o <= 0;
             end
         
    end
end
endmodule
