module pipemem ( mwmem,malu,mb,mem_clock,mmo,
				resetn, out_port0,out_port1,in_port0,in_port1,mem_dataout,io_read_data);
	input mwmem, mem_clock;
	input [31:0] malu, mb;
	output [31:0] mmo;
	
	input resetn;
	input  [31:0]  in_port0, in_port1;
	output [31:0]  out_port0, out_port1;
	output [31:0]  mem_dataout;
    output [31:0]  io_read_data;
	
	wire [31:0] mmo;
	
	reg clk;
	
	always @ (posedge mem_clock) begin
		clk <= clk + 1;
	end
	
	datamem (malu,mb,mmo,mwmem,clk,mem_clock,
			resetn, out_port0,out_port1,in_port0,in_port1,mem_dataout,io_read_data);
	
endmodule 