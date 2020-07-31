`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/27 15:36:13
// Design Name: 
// Module Name: anjianxiaodou
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


module anjianxiaodou
(
    clk,rst_n,key_in,
	 key_flag,key_state
);

input clk;
input rst_n;
input [1:0]key_in;

output  reg key_flag;
output  reg key_state;

reg en;
wire gedge;
wire sedge;
localparam IDLE = 4'b0001;
reg [3:0]state;
localparam state_2 = 4'b0010;
localparam state_3 = 4'b0100;
localparam DONE = 4'b1000;
reg key_in_a;
reg key_in_b;
reg data_in_a;
reg data_in_b;

//一个500nS的计数器//

parameter cnt_max = 5'd24;
reg  [4:0]  cnt;
always @ (posedge clk or negedge rst_n)
    begin
      if(!rst_n)
		   cnt <= 5'd0;
		else if(en)
		   begin
			     if(cnt == cnt_max)
				     cnt <=5'd0;
				  else
				     cnt <= cnt +1'b1;
			end
		else
			cnt <= 1'b0;
    end

//单bit信号异步信号的转换,打两拍的方式实现//
always @ (posedge clk or negedge rst_n)
	 begin
		if(!rst_n)
			begin
				key_in_a <= 1'b0;
				key_in_b <= 1'b0;
			end
		else
			begin
				key_in_a <= key_in;
				key_in_b <= key_in_a;
			end
    end

//上升沿和下降沿的描述//

always @ (posedge clk or negedge rst_n)
	begin
			if(!rst_n)
				begin
				data_in_a <= 1'b0;
				data_in_b <= 1'b0;
				end
			else
				begin
					data_in_a <= key_in_b;
					data_in_b <= data_in_a;
				end
	end
	
		assign sedge = !data_in_a&data_in_b;
		assign gedge = data_in_a&!data_in_b;
		
//状态机的具体写法


always @ (posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
			key_flag <= 1'b0;
			key_state <= 1'b1;
			en <= 1'b0;
			state <= IDLE;
				
			end
		else
			begin
				case(state)
					IDLE: begin
						key_flag <= 1'b0;
						if(gedge)
							begin
							state <= state_2;
							en <= 1'b1;
			            end
						else
							state <= IDLE;
						   end
					state_2: begin
						if(cnt==cnt_max)
							begin
							en <= 1'b0;
							key_flag <= 1'b1;
							key_state <= 1'b0;
							state <= DONE;
							end
						else if(sedge)
							begin
								state <= IDLE;
								en <= 1'b0;
							end
						else
							state <= state_2;
						end
					DONE:begin
							key_flag <= 'b0;
							if(sedge)
								begin
								state <= state_3;
								en <= 1'b1;
								end
							else
								state <= DONE;
						   end
					state_3:begin
							if(cnt==cnt_max)
								begin
									en <= 1'b0;
									key_flag <= 1'b1;
									key_state <= 1'b1;
									state <= IDLE;
								end
							else if(gedge)
								begin
								state <= DONE;
								en <= 1'b0;
								end
							else
								state <= state_3;
						     end
					default : begin
								key_flag <= 1'b0;
								key_state <= 1'b1;
								en <= 1'b0;
							    end
								 endcase
   end
	end
endmodule
