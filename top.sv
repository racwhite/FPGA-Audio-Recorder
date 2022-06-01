`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2022 01:17:07 PM
// Design Name: 
// Module Name: top
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


module top(
        input logic clock, reset,
        //from board
        input logic record_btn,play_btn, // record on P17, play on M17
        input logic pdm_data_i,
        input logic switch0, switch1,
        // for led
        output logic anode0, anode1, anode2, anode3, anode4, anode5, anode6, anode7, a, b, c, d, e, g,
        // audio output
        output logic pdm_audio_o, pdm_sdaudio_o, pdm_lrsel_o, scaled1MHz,
        output logic idle
        
        
    );
    logic scaled1KHz;
    // fsm -> deserializer    
    logic des_done;
    logic [15:0] des_output_word;
    logic enable_record, enable_play, enable_write, enable_read;
    
    // fsm -> serializer
    // enable play/read above
    logic ser_done;
    logic [15:0] ser_input_word, ser_input_word_1, ser_input_word_2;
    // outputs part of top i/o
    
    logic twoSecondsPassed;
    
    // memory address stuff
    logic [16:0] memaddress;
    logic enable_write_1, enable_write_2;
    
    
    ClockScalar oneMHzClock(reset, clock, scaled1MHz);
    clockscalar_1khz oneKHzClock(reset, clock, scaled1KHz);
    
    fsm control(clock, reset || twoSecondsPassed, record_btn, play_btn, enable_record, enable_play, enable_write, enable_read, idle);
    // check for scaled clock shennanigans 
    deserializer des(scaled1MHz, reset, enable_record, pdm_data_i, des_done, des_output_word, pdm_lrsel_o);
    serializer ser(scaled1MHz, reset, enable_read, ser_done, ser_input_word, pdm_audio_o, pdm_sdaudio_o);
    segment_7 seg_leds(clock, reset, switch0, switch1, 
        anode0, anode1, anode2, anode3, anode4, anode5, anode6, anode7, a, b, c, d, e, g);
    // transfomring button inputs
    synch1 btn_rec_sync(clock, clock, reset, reset, record_btn, record_btn_sync);
    synch2 btn_play_sync(clock, clock, reset, reset, play_btn, play_btn_sync);
    synch3 rstbtn(clock, clock, reset, reset, reset, reset_btn_sync);
    
    Counter counter(reset || twoSecondsPassed, des_done || ser_done, memaddress);
    
    timer twoSec_tmr(enable_record, enable_read, scaled1KHz, reset, twoSecondsPassed);
    
    mem1 m1 (
      .clka(clock),    // input wire clka
      .ena(1'b1),      // input wire ena
      .wea(enable_write_1),      // input wire [0 : 0] wea
      .addra(memaddress),  // input wire [16 : 0] addra
      .dina(des_output_word),    // input wire [15 : 0] dina
      .douta(ser_input_word_1)  // output wire [15 : 0] douta
    );
    mem1 m2 (
      .clka(clock),    // input wire clka
      .ena(1'b1),      // input wire ena
      .wea(enable_write_2),      // input wire [0 : 0] wea
      .addra(memaddress),  // input wire [16 : 0] addra
      .dina(des_output_word),    // input wire [15 : 0] dina
      .douta(ser_input_word_2)  // output wire [15 : 0] douta
    );
    
    always_comb
    begin
        
        if (switch1 == 0)
        begin
           // record to m1
           enable_write_2 = 0;
           enable_write_1 = enable_write;
        end
        else
        begin
            // record to m2
            enable_write_1 = 0;
            enable_write_2 = enable_write;
        end
        if (switch0 == 0)
        begin
            // play from m1
            ser_input_word = ser_input_word_1;
        end
        else
        begin
            // play from m2
            ser_input_word = ser_input_word_2;
        end
    end
    
    
    
endmodule
