`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2022 02:30:53 PM
// Design Name: 
// Module Name: serializer
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


module serializer(
        input clock, reset, enable,
        output reg done, // enables to load next audio word
        input [15:0] data_i, // from memory
        output reg pdm_audio_o, // output to audio filter pin A11
        output pdm_sdaudio_o // audio enable pin D12 tie high
    );
    
reg [4:0] counter;
assign pdm_sdaudio_o = 1;

always@(posedge clock or posedge reset) begin
    begin
        if (reset)
            begin
                // clear counter
                counter <= 0;
                done <= 0;
            end
        else if (enable)
        begin
        if (counter == 15) 
            begin
            // end of word reading
                counter <= 0;
                done <= 1;
                pdm_audio_o <= data_i[0];
            end
            // start of word reading, 
            //sets reg data to what the input word was
            else
            begin
                counter <= counter+1;
                pdm_audio_o <= data_i[15-counter];
                done <= 0;
            end
        
        end
        else
        begin
            done <= 0;
            counter <= 0;
            pdm_audio_o <= 0;
        end
    end
end
endmodule
