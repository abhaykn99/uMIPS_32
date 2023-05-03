`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2023 02:18:56
// Design Name: 
// Module Name: sccpu_intr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: cpu-mips
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sccpu_intr(clk,clrn,inst,mem,pc,wmem,alu,data,intr,inta );
input [31:0]inst;
input [31:0]mem;
input intr;
input clk,clrn;
output [31:0]pc;
output [31:0]alu;
output [31:0]data;
output wmem;
output inta;
parameter BASE=32'h00000008;
parameter ZERO=32'h00000000;

wire [5:0]op=inst[31:26];
wire [4:0]rs=inst[25:21];
wire[4:0]rt=inst[20:16];
wire [4:0]rd=inst[15:11];
wire[5:0]func=inst[5:0];
wire [15:0]imm=inst[15:0];
wire [25:0]addr=inst[25:0];

//control signals

wire [3:0]aluc;
wire [1:0]pcsrc;
wire wreg;
wire regrt;
wire m2reg;
wire shift;
wire aluimm;
wire jal;
wire sext;
wire [1:0]mfc0;
wire [1:0] selpc;
wire v;  
wire exc;
wire wsta;
wire wcau;
wire wepc;
wire mtc0;
//data path wires between components
wire[31:0] p4;
wire[31:0]bpc;

wire [31:0]npc;
wire[31:0]qa;
wire[31:0]qb;
wire[31:0]alua;
wire[31:0]alub;
wire[31:0]wd;
wire[31:0]r;
wire[31:0]sa={27'b0,inst[10:6]};
wire [15:0]s16={16{sext&inst[15]}};
wire [31:0]i32={s16,imm};
wire[31:0]dis={s16[13:0],imm,2'b00};
wire [31:0]jpc={p4[31:28],addr,2'b00};
wire [4:0]reg_dest;
wire [4:0]wn=reg_dest|{5{jal}};

wire z;
wire [31:0]sta;
wire [31:0]cau;
wire[31:0]epc;
wire[31:0]sta_in;
wire[31:0]cau_in;
wire[31:0]epc_in;
wire[31:0]sta_lr;
wire[31:0]pc_npc;
wire[31:0]cause;
wire[31:0]res_c0;
wire[31:0]n_pc;
wire[31:0]sta_r={4'h0,sta[31:4]};
sccu_intr cu(op,rs,rd,func,z,wmem,wreg,
           regrt,m2reg,aluc,shift,aluimm,pcsrc,jal,sext,
           intr,inta,v,sta,cause,,exc,wsta,wcau,wepc,mtc0,mfc0,selpc);
  //datpaths
dff32 i_point (n_pc,clk,clrn,pc); // pc register
cla32 pcplus4 (pc,32'h4,1'b0,p4); // pc + 4
cla32 br_addr (p4,dis,1'b0,bpc); // branch target address
mux2x32 alu_a (qa,sa,shift,alua); // alu input a
mux2x32 alu_b (qb,i32,aluimm,alub); // alu input b
mux2x32 alu_m (alu,mem,m2reg,r); // alu out or mem
mux2x32 link (res_c0,p4,jal,wd); // res_c0 or p4
mux2x5 reg_wn (rd,rt,regrt,reg_dest); // rs or rt
mux4x32 nextpc(p4,bpc,qa,jpc,pcsrc,npc); // next pc, not exc/int
regfile rf (rs,rt,wd,wn,wreg,clk,clrn,qa,qb); // register file
alu_ov alunit (alua,alub,aluc,alu,z,v); // alu_ov, z and v tags
dffe32 c0sta (sta_in,clk,clrn,wsta,sta); // c0 status register
dffe32 c0cau (cau_in,clk,clrn,wcau,cau); // c0 cause register
dffe32 c0epc (epc_in,clk,clrn,wepc,epc); // c0 epc register
mux2x32 cau_x (cause,qb,mtc0,cau_in); // mux for cause reg
mux2x32 sta_1 (sta_r,sta_l,exc,sta_lr); // mux1 for status reg
mux2x32 sta_2 (sta_lr,qb,mtc0,sta_in); // mux2 for status reg
mux2x32 epc_1 (pc,npc,inta,pc_npc); // mux1 for epc reg
mux2x32 epc_2 (pc_npc,qb,mtc0,epc_in); // mux2 for epc reg
mux4x32 nxtpc (npc,epc,BASE,ZERO,selpc,n_pc); // mux for pc
mux4x32 fr_c0 (r,sta,cau,epc,mfc0,res_c0); // r or c0 regs
assign data = qb;


endmodule
