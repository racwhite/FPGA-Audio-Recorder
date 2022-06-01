`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2022 01:30:27 PM
// Design Name: 
// Module Name: fsm
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

module fsm(
    input clk, reset, btn_input_record, btn_input_play,
    output reg enable_rec, enable_play,
    output reg enable_write, enable_read, wire idle
    //output for states===============================
    
    );
    // values for the states
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    
    reg [2:0] PS, NS;
    // next state regs'===================================
    reg enableRec, enablePlay;
    reg enableWri, enableRead;
    
    assign idle = (PS == S0);
    
    // change from PS to NS
    always @ (posedge clk or posedge reset)
    begin
        if (reset == 1)
        begin
            PS <= S0;
            // default values:  ============================
            
            enable_rec <= 0; enable_play <= 0;
            enable_write <= 0; enable_read <= 0;
        end
        else begin
            PS <= NS;
            // next state values:  =============================
            enable_rec <= enableRec; enable_play <= enablePlay;
            enable_write <= enableWri; enable_read <= enableRead;
        end
    end
    
    // compute NS
    always @ (*)
    begin
        // state defaults
        NS = PS;
        // all next state = 0  ===================================
        enableRec = enable_rec; enablePlay = enable_play;
        enableWri = enable_write; enableRead = enable_read;
        case(PS)
        S0: begin 
                if (btn_input_record == 1)
                begin
                    NS = S1;
                    // next state regs =======
                    enableRec = 1;
                    enableRead = 0;
                    enablePlay = 0;
                    enableWri = 0;
                end
                else if (btn_input_play == 1)
                begin
                    NS = S2;
                    // next state regs =======
                    enableRead = 1;
                    enableRec = 0;
                    enablePlay = 0;
                    enableWri = 0;
                end
                else 
                begin
                    NS = S0;
                end
            end
        S1: begin 
                enableWri = 1;
                enablePlay = 0;
                // 2 seconds should pass
            end
        S2: begin 
                enablePlay = 1;
                enableWri = 0;
                // 2 seconds should pass
            end
        default begin end
        endcase
    end
endmodule
