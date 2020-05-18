`include "eth_fifo.v"
`include "eth_fsm.v"
// Code your design here
//////////////////////////////////////////////////////////////////////////////////
// Company: VITAP
// Engineer:  Rajesh K
// 
// Create Date: 15.05.2020 16:08:03
// Design Name:  Project_17BEV7015
// Module Name: eth_sw2x2
// Project Name: design and verification of Ethernet switch
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

module eth_sw2x2(clk,reset_n,inDataA,inSopA,inEopA,inDataB,inSopB,inEopB,outDataA, outSopA,outEopA, outDataB, outSopB,outEopB,portAStall,portBStall);
  input clk,reset_n,inSopA,inEopA,inSopB,inEopB;
  output  outSopA,outEopA,outSopB,outEopB,portAStall, portBStall;
  input [31:0] inDataA;
  input [31:0] inDataB;
  output  [31:0] outDataA; 
  output [31:0] outDataB; 

  reg [31:0] outDataA;
  reg outSopA;
  reg outEopA;
  reg [31:0] outDataB;
  reg outSopB;
  reg outEopB;
  reg portAStall;
  reg portBStall;
  
parameter PORTA_ADDR = 'hABCD;
parameter PORTB_ADDR = 'hBEEF;

wire fifo_wr_en[1:0];
wire[33:0] fifo_wr_data[1:0];
wire[33:0] fifo_rddata[1:0];
wire fifo_empty[1:0];
wire fifo_full[1:0];
reg fifo_rd_en[1:0];

eth_fifo #(.FIFO_D(32), .FIFO_W(34))
 inA_queue(.clk(clk),.reset_n(reset_n),.write_en(fifo_wr_en[0]),
  .read_en(fifo_rd_en[0]),.data_in(fifo_wr_data[0]),.data_out(fifo_rddata[0]),
  .empty(fifo_empty[0]),.full(fifo_full[0]));
  
eth_fifo #(.FIFO_D(32), .FIFO_W(34))
inB_queue(.clk(clk),.reset_n(reset_n),.write_en(fifo_wr_en[1]),
   .read_en(fifo_rd_en[1]),.data_in(fifo_wr_data[1]),.data_out(fifo_rddata[1]),
   .empty(fifo_empty[1]),.full(fifo_full[1]));
 
eth_fsm		portA_fsm(
  				.clk(clk),
  				.reset_n(reset_n),
  				.inData(inDataA),
  				.inSop(inSopA),
  				.inEop(inEopA),
  				.outWrEn(fifo_wr_en[0]),
  				.outData(fifo_wr_data[0]));

eth_fsm 	portB_fsm(				
    			.clk(clk), 				
                .reset_n(reset_n), 
                .inData(inDataB), 
                .inSop(inSopB),
                .inEop(inEopB),
                .outWrEn(fifo_wr_en[1]),
                .outData(fifo_wr_data[1]));




reg read_fifo_head[1:0];
reg read_fifo_data[1:0];
reg port_busy[1:0];
reg[1:0] dest_port[1:0];

integer i;

always @(posedge clk) 
	begin
	   if(!reset_n)
	   begin
	       for(i=0; i <2; i=i+1)
	       begin
	           read_fifo_head[i] <= 1'b1;
			   read_fifo_data[i] <=1'b0;
			   dest_port[i] <= 'b11; 
			   port_busy[i]='b0;
		   end
		   outDataA <='b0;
		   outDataB <='b0;
		   outSopA <='b0;
		   outSopB <='b0;
		   outEopA <='b0;
		   outEopB <='b0;
	   end 
	   else 
	   begin
	       outSopA <='b0;
		   outSopB <='b0;
		   outEopA <='b0;
		   outEopB <='b0;
		   for(i=0; i <2; i=i+1)
		   begin
		      if(read_fifo_head[i] &&  ~fifo_empty[i])
		      begin
		          fifo_rd_en[i]<=1'b1;
				  read_fifo_head[i]<=1'b0;
				  read_fifo_data[i] <=1'b1;
			  end
			  else if (read_fifo_data[i] && ~fifo_full[i])
			  begin
			     if(fifo_rddata[i][32])
			     begin
			         dest_port[i] = (fifo_rddata[i][31:0]==PORTB_ADDR) ? 'b01: 'b00;
					   if(port_busy[dest_port[i]])
					   begin
					       fifo_rd_en[i] <=1'b0; 
					   end 
					   else
					   begin
					       fifo_rd_en[i] <=1'b1;
					       port_busy[dest_port[i]] <=1'b1; 
						end
				  end
				  else if(fifo_rddata[i][33])
				  begin
				    fifo_rd_en[i]<=1'b0;
					read_fifo_data[i] <=1'b0;
					read_fifo_head[i]<=1'b1;
					port_busy[dest_port[i]] <=1'b0; 
				  end 
				  else 
				  begin
				    fifo_rd_en[i]<=1'b1;
				  end
				  if(dest_port[i] ==0) 
				  begin
				    outDataA <= fifo_rddata[i][31:0];
					outSopA <= fifo_rddata[i][32];
					outEopA <= fifo_rddata[i][33];
				  end
				  if(dest_port[i] ==1) 
				  begin
				    outDataB <= fifo_rddata[i][31:0];
					outSopB <= fifo_rddata[i][32];
					outEopB <= fifo_rddata[i][33];
				  end
				end
		    end
		end
	end

						
						
always @(posedge clk) 
begin
  if(reset_n==0) 
  begin
    portAStall<=0;
    portBStall<=0;
  end
  else 
  begin
    portAStall<=fifo_full[0];
    portBStall<=fifo_full[1];
  end
end

endmodule
