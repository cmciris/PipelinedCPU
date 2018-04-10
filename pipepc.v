module pipepc( npc,wpcir,clock,resetn,pc );
	input wpcir, clock, resetn;
	input [31:0] npc;
	output [31:0] pc;
	
	reg [31:0] pc;
	
	always @ (posedge clock) begin
		if (resetn == 0) begin
			pc <= 0;
		end
		else begin
			if (wpcir) begin
				pc <= npc;
			end
		end
	end
endmodule
