`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2022 01:08:40 PM
// Design Name: 
// Module Name: SevenSegmentDisplay
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

module SevenSegmentDisplay(
    input clock, reset, record_N, play_N,
    output AN0,AN1,AN2,AN3,AN4,AN5,AN6,AN7,a,b,c,d,e,g);
parameter zeroMoore = 1'b0, oneMoore = 1'b1;

reg stateMoore_current, stateMoore_next;
reg AN0_next,AN1_next,a_next,b_next,c_next,d_next,e_next,g_next;
ClockScalar newClock(reset,clock , scaled_clock);
assign AN2 = 1;
assign AN3 = 1;
assign AN4 = 1;
assign AN5 = 1;
assign AN6 = 1;
assign AN7 = 1;

always @(posedge scaled_clock or posedge reset)
begin
if(reset)
    begin
    stateMoore_current <= zeroMoore;
    AN0 <= 1;
    AN1 <= 1;
    a <=1;
    b <=1;
    c <=1;
    d <=1;
    e <=1;
    g <=1;
    end
else
    begin
    stateMoore_current <= stateMoore_next;
    AN0 <= AN0_next;
    AN1 <= AN0_next;
    a <= a_next;
    b <= b_next;
    c <= c_next;
    d <= d_next;
    e <= e_next;
    g <= g_next;
    end
end

//  Moore

always@(*)
begin
    stateMoore_next = stateMoore_current;
    AN0_next = AN0;
    AN1_next = AN1;
    a_next = a;
    b_next = b;
    c_next = c;
    d_next = d;
    e_next = e;
    g_next = g;

case(stateMoore_current)
zeroMoore:
begin
    stateMoore_next = oneMoore;
    AN0_next = 1;
    AN1_next = 0;
    if(playNumber == 1)
        begin
        a_next = 0;
        b_next = 0;
        c_next = 1;
        d_next = 0;
        e_next = 0;
        g_next = 0;
        end
    else
        begin
        a_next = 1;
        b_next = 0;
        c_next = 0;
        d_next = 1;
        e_next = 1;
        g_next = 1;
        end
end
oneMoore:
begin
    stateMoore_next = zeroMoore;
    AN0_next = 0;
    AN1_next = 1;
    if(record_N == 1)
        begin
        a_next = 0;
        b_next = 0;
        c_next = 1;
        d_next = 0;
        e_next = 0;
        g_next = 0;
        end
    end
endcase
end
endmodule