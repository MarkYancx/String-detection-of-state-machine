`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/27 15:36:59
// Design Name: 
// Module Name: final_pro
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


module final_pro(
    clk,
    rst_n,
    key_in,
    led
    );
    
    input clk ;
    input rst_n ;
    input [1:0] key_in ;
    
    output [1:0] led ;
    
    
    wire key_flag ;
    wire key_state ;
    
    jianceji jianceji(
        .clk(clk),
        .rst_n(rst_n),
        .key_in(key_in),
        .led(led)
    );
    anjianxiaodou anjianxiaodou(
        .clk(clk),
        .rst_n(rst_n),
        .key_in(key_in),
        .key_flag(key_flag),
        .key_state(key_state)
    );
endmodule
