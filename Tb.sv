`timescale 1ns/1ns

module TB();
	reg rst, clk = 0;
	Datapath cpu (clk, rst);
	always #10 clk = ~clk;
	initial begin
		rst = 1;
		#190;
		rst = 0;
		#2000;
		$stop;
	end
endmodule
