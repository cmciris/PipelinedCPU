module pipeif ( pcsource,pc,bpc,da,jpc,npc,pc4,ins,mem_clock );
	input [31:0] pc, bpc, da, jpc;
	input [1:0] pcsource;
	input mem_clock;
	output [31:0] npc, pc4, ins;
	
	wire [31:0] ins;
	
	instmem imem (pc,ins,mem_clock);
	
	assign pc4 = pc + 4;
	mux4x32 if_npc(pc4, bpc, da, jpc, pcsource, npc);
	
endmodule
