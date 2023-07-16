// FIFO

module fifo(
  input wire clock,reset,rd,wr,
  input wire [7:0] data_in,
  output wire full,empty,
  output reg [7:0] data_out
);
  
//Creating FIFO Memory
  reg [7:0] mem [31:0];
  
//Write Pointer
  reg [4:0] wr_ptr;

//Read Pointer
  reg [4:0] rd_ptr;
  
  
  always@(posedge clock)
    begin
      if(reset==1'b1)
        begin
          data_out<=0;
          wr_ptr<=0;
          rd_ptr<=0;
          for(int i=0;i<32;i++)
            begin
              mem[i]<=0;
            end
        end
      else
        begin
          if((wr==1'b1)&&(full==1'b0))
            begin
              mem[wr_ptr]<=data_in;
              wr_ptr<=wr_ptr+1;
            end
          if((rd==1'b1)&&(empty==1'b0))
            begin
              data_out<=mem[rd_ptr];
              mem[rd_ptr]<='d0;
              rd_ptr<=rd_ptr+1;
            end
        end
    end
  
  assign empty=((wr_ptr - rd_ptr)==0)?1'b1:1'b0;
  assign full=((wr_ptr - rd_ptr)==32)?1'b1:1'b0;
  
  
endmodule

interface fifo_if;
  
  logic clock,reset,wr,rd;
  logic [7:0] data_in;
  logic [7:0] data_out;
  logic full,empty;

endinterface
