`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2022 02:13:09 PM
// Design Name: 
// Module Name: legSegments
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


module legSegments(
        input logic clock, reset, 
        recordNum, playNum,
        output logic AN0, AN1, AN2, AN3,
        AN4, AN5, AN6, AN7,
        a,b,c,d,e,g
    );
    parameter zeroM = 1'b0, oneM = 1'b1;
    
    reg PS, NS;
    reg AN0_N, AN1_N, a_n, b_n, c_n, d_n, e_n, g_n;
    
    
    
endmodule
