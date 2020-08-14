module Sim_ROM(
clk,rst_n,tvalid,tready,tdata
  );

  input clk;
  input rst_n;
  input tready;
  output tvalid;
  output reg tdata;                              

  reg  tvalid = 1'b1;
  reg  en;
  reg  [9:0] addr;
  wire ena;
  wire [9:0] addra;
  wire douta;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) 
        tdata <= 1'b0;
    else
        tdata <= douta;
end
  
  assign ena   = tready;
  assign addra = addr;

  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) 
      addr <= 10'd0;
    else begin
      if(tvalid && tready) begin
        if(addr <= 10'd1023)
          addr <= addr + 10'd1;   
        else
          addr <= 10'd0;
      end
      else
        addr <= addr;
    end
  end

  blk_mem_gen_0 ROM(
  .clka(clk),
  .addra(addra),
  .douta(douta),
  .ena(ena)
  );

endmodule