module eth_fifo(clk,reset_n,write_en,read_en,data_in,data_out,empty,full);
parameter FIFO_W = 8;
parameter FIFO_D = 16;

input  clk,reset_n,write_en,read_en;
input [FIFO_W-1:0] data_in;
output [FIFO_W-1:0] data_out;
output empty,full;

wire clk; 
wire write_en; 
wire read_en; 
wire [FIFO_W-1:0] data_in; 
reg [FIFO_W-1:0] data_out; 
wire empty; 
wire full; 
reg [FIFO_W-1:0] mem[0:FIFO_D]; 
reg tmp_empty; 
reg tmp_full; 

integer front_ptr;
integer end_ptr;

assign empty = tmp_empty; 
assign full = tmp_full; 
  
always @(posedge clk)
begin
    if(!reset_n)
    begin
        if((write_en == 1'b1)&&(full == 1'b0))
        begin
            mem[front_ptr] = data_in;
            tmp_empty <= 1'b0;
            front_ptr = (front_ptr+1) % FIFO_D;
            if(end_ptr == front_ptr)
            begin
                tmp_full <= 1'b1;
            end
        end
        if((read_en == 1'b1) && (empty == 1'b0))
        begin
            data_out <= mem[end_ptr];
            tmp_full <= 1'b0;
            end_ptr<= (end_ptr+1)%FIFO_D;
            if(end_ptr == front_ptr)
            begin
                tmp_empty <=1'b1;
            end
        end
    end 
    else
    begin
        data_out <= 0;
        tmp_empty <= 1'b1; 
        tmp_full <= 1'b0; 
        front_ptr <= 0; 
        end_ptr <= 0; 
    end
           
end
endmodule
