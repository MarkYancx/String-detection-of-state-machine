`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/27 10:38:07
// Design Name: 
// Module Name: jianceji
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


module jianceji(
    clk    ,
    rst_n  ,
    key_in ,
    
    led
    );
    //�����źŶ���
    input               clk    ;
    input               rst_n  ;
    input [1:0]         key_in ;

    //����źŶ���
    output [1:0]         led    ;

    //����ź�reg����
    reg    [1:0]         led    ;

    //�м��źŶ���
    reg                 key0   ;
    reg                 key_0  ;
    reg                 key1   ;
    reg                 key_1  ;
    reg                 key_done0   ;
    reg                 key_done1   ;
    reg [2:0]           state_c;
    reg [2:0]           state_n;
    
    wire                s0_2_s1 ;
    wire                s1_2_s2 ;
    wire                s2_2_s3 ;
    wire                s2_2_s0 ;
    wire                s3_2_s4 ;
    wire                s3_2_s2 ;
    wire                s4_2_s2 ;
    wire                s4_2_s1 ;
    
    //״̬��������
    parameter      S0 =  0     ;
    parameter      S1 =  1     ;
    parameter      S2 =  2     ;
    parameter      S3 =  3     ;
    parameter      S4 =  4     ;
    //�ⲿ����0�������
    always@(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            key0 <= 1;
            key_0 <= 1;
        end
        else begin
            key0 <= key_in[0];
            key_0 <= key0;
        end
    end
    //��ȡ����0������
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            key_done0 <= 0;
        end
        else if(key_0==1 && key0==0)begin
            key_done0 <= 1;
        end
        else begin 
            key_done0 <= 0;
        end
    end

    //�ⲿ����1�������
    always@(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            key1 <= 1;
            key_1 <= 1;
        end
        else begin
            key1 <= key_in[1];
            key_1 <= key1;
        end
    end
    //��ȡ����1������
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            key_done1 <= 0;
        end
        else if(key_1==1 && key1==0)begin
            key_done1 <= 1;
        end
        else begin 
            key_done1 <= 0;
        end
    end

    //״̬��
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            state_c <= S0;
        end
        else begin
            state_c <= state_n;
        end
    end

    //����߼�alwaysģ�飬����״̬ת�������ж�
    always@(*)begin
        if(!rst_n)begin 
            state_n = S0;
        end
        else begin
            case(state_c)
                S0:begin
                    if(s0_2_s1)begin
                        state_n = S1;
                    end
                    else begin
                        state_n = state_c;
                    end
                end
                S1:begin
                    if(s1_2_s2)begin
                        state_n = S2;
                    end
                    else begin
                        state_n = state_c;
                    end
                end
                S2:begin
                    if(s2_2_s3)begin
                        state_n = S3;
                    end
                    else if(s2_2_s0)begin
                        state_n = S0;
                    end
                    else begin
                        state_n = state_c;
                    end
                end
                S3:begin
                    if(s3_2_s4)begin
                        state_n = S4;
                    end
                    else if(s3_2_s2)begin
                        state_n = S2;
                    end
                    else begin
                        state_n = state_c;
                    end
                end
                S4:begin 
                    if(s4_2_s2)begin
                        state_n = S2;
                    end  
                    else if(s4_2_s1)begin
                        state_n = S1;
                    end
                    else begin   
                        state_n = state_c;   
                    end 
                end
                default:begin
                    state_n = S0;
                end
            endcase
        end
    end
    //�����Σ����ת������
    assign s0_2_s1  = state_c==S0 && key_done1==1;
    assign s1_2_s2  = state_c==S1 && key_done0==1;
    assign s2_2_s3  = state_c==S2 && key_done1==1;
    assign s2_2_s0  = state_c==S2 && key_done0==1;
    assign s3_2_s4  = state_c==S3 && key_done1==1;
    assign s3_2_s2  = state_c==S3 && key_done0==1;
    assign s4_2_s2  = state_c==S4 && key_done0==1;
    assign s4_2_s1  = state_c==S4 && key_done1==1;

    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            led <=1'b0;     //��ʼ��
        end
        else if(state_c==S4)begin
            led <= 2'b10;
        end
        else begin
            led <= 2'b01;
        end
    end

endmodule
