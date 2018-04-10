module pipeid ( mwreg,mrn,ern,ewreg,em2reg,mm2reg,dpc4,inst,
	            wrn,wdi,ealu,malu,mmo,wwreg,clock,resetn,
	            bpc,jpc,pcsource,wpcir,dwreg,dm2reg,dwmem,daluc,
	            daluimm,da,db,dimm,drn,dshift,djal);
	input [31:0] dpc4, inst, wdi, ealu, malu, mmo;
	input [4:0] ern, mrn, wrn;
	input mwreg, ewreg, em2reg, mm2reg,
		  wwreg, clock, resetn;
	output [31:0] bpc, jpc, da, db, dimm;
	output [4:0] drn;
	output [3:0] daluc;
	output [1:0] pcsource;
	output wpcir, dwreg, dm2reg, dwmem,
		   daluimm, dshift, djal;
	
	wire rsrtequ, wpcir, regrt, sext;
	wire [1:0] pcsource, fwdb, fwda;
	wire [4:0] drn;
	wire [31:0] q1, q2, da, db, bpc, jpc;
	wire [15:0]	imm = {16{e}};
	wire [31:0] offset = {imm[13:0],inst[15:0],1'b0,1'b0};
	wire		e = sext & inst[15];
	wire [31:0]	dimm = {imm,inst[15:0]};
	
	cu control_unit(inst[31:26], inst[5:0], inst[25:21], inst[20:16], rsrtequ, ewreg, em2reg, ern, mwreg, mm2reg, mrn,
		   pcsource, wpcir, dwreg, dm2reg, dwmem, djal, daluc, daluimm, dshift, regrt, sext, fwdb, fwda);
	
	regfile rf(inst[25:21],inst[20:16],wdi,wrn,wwreg,clock,resetn,q1,q2);
	
	assign bpc = dpc4 + offset;
	assign jpc = {dpc4[31:28],inst[25:0],1'b0,1'b0};
	
	mux4x32 get_da(q1, ealu, malu, mmo, fwda, da);
	mux4x32 get_db(q2, ealu, malu, mmo, fwdb, db);
	assign rsrtequ = (da == db);
	
	mux2x5	get_drn(inst[15:11],inst[20:16],regrt,drn);
	
	
	
endmodule
