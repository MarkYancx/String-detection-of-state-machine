`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/27 10:50:51
// Design Name: 
// Module Name: final_pro_tb
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


`define clk_period 10
module final_pro_tb(   
);	

	reg    clk  ;
	reg    rst_n;
	reg [1:0]   key_in   ;
    //���
	wire [1:0]  led  ;

    //����
    final_pro test(
        .clk    (clk)   ,
        .rst_n  (rst_n) ,
        .key_in (key_in),
        .led    (led)
    );
	
	initial clk = 1;
	    always#(`clk_period/2) clk = ~clk;
			
	initial begin 
		rst_n = 0;
		#100;
		rst_n = 1;
		#12000;
		rst_n = 0;
	end 
	
    //�������������ź�
	initial begin 
		key_in = 2'b11;
		#1000;
		key_in = 2'b10;//0
		#20;
		key_in = 2'b11;
		#1000;
		key_in = 2'b01;//1
		#20;              
		key_in = 2'b11; 
		#1000;  
		key_in = 2'b10;//0
		#20;              
		key_in = 2'b11;   
		#1000;
		key_in = 2'b01;//1
		#20;              
		key_in = 2'b11;   
		#1000;
		key_in = 2'b01;//1
		#20;              
		key_in = 2'b11;   
		#1000;
		key_in = 2'b10;//0
		#20;              
		key_in = 2'b11; 
		#1000;  
		key_in = 2'b10;//0
		#20;              
		key_in = 2'b11;   
	end 
   
	endmodule
