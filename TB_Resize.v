`timescale 1ns/1ps
`define DATAWIDTH 32

module TB_Resize();

reg  clk;
reg  rst_n;
reg  tready;
wire tvalid;
wire tdata;
wire Debug_Din_Valid;
wire Debug_UnResize;

Resize_IP_wrapper TB(  
	.clk(clk),
	.rst_n(rst_n),
	.tready(tready),
	.tvalid(tvalid),
	.tdata(tdata),
	.Debug_Din_Valid(Debug_Din_Valid),
	.Debug_UnResize(Debug_UnResize)
);

integer fileoutput0,fileoutput1;

initial
begin
	$display("Running TestBench");
	fileoutput0 = $fopen("C:/Users/Howard/Desktop/Resize/Sim_Files/Sim_UnResize.txt");
	fileoutput1 = $fopen("C:/Users/Howard/Desktop/Resize/Sim_Files/Sim_Resize.txt");
	clk    = 0;
	rst_n  = 0;
	tready = 0;
	#20 rst_n  = 1;
	#20 tready = 1;
end

always #5 clk = ~clk; 

always @ (posedge clk) begin
	if(Debug_Din_Valid) begin
		$fwrite(fileoutput0,"%b\n",Debug_UnResize);
	end
end

always @(posedge clk) begin
	if(tvalid)begin
		$fwrite(fileoutput1,"%b\n",tdata);
	end
end

always @(posedge clk) begin
	if($realtime > 81980) begin
		$fclose(fileoutput0);
	end
end

always @(posedge clk) begin
	if($realtime > 82020) begin
		$display("End");
		$fclose(fileoutput1);
		$stop;
	end
end

endmodule