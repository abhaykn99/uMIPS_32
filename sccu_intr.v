`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2023 01:04:42
// Design Name: 
// Module Name: sccu_intr
// Project Name: cu_mips_interrupt
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sccu_intr(op,op1,rd,func,z,wmem,wreg,regrt,m2reg,aluc,shift,aluimm,pcsrc,jal,sext,intr,inta,v,sta,cause,exc,wsta,wcau,wepc,mtc0,mfc0,selpc);

   input [31:0]sta;
   input [5:0]op,func;
   input[4:0]op1,rd;
   input z,v;
   input intr;
   output[31:0]cause;
   output[3:0]aluc;
   output[1:0]mfc0;
   output [1:0]selpc;
   output [1:0]pcsrc;
   output wreg;
   output regrt;
   output jal;
   output m2reg;
   output shift;
   output aluimm;
   output sext;
   output wmem;
   output inta;
   output exc;
   output wsta;
   output wcau;
   output wepc;
   output mtc0;
   
   
   wire rtype=~|op;
   wire i_add=rtype&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0];
   wire i_sub=rtype&func[5]&~func[4]&~func[3]&~func[2]&func[1]&~func[0];
   wire i_and=rtype&func[5]&~func[4]&~func[3]&func[2]&~func[1]&~func[0];
   wire i_or=rtype&func[5]&~func[4]&~func[3]&func[2]&~func[1]&func[0];
   wire i_xor=rtype&func[5]&~func[4]&~func[3]&func[2]&func[1]&~func[0];
   wire i_sll=rtype&~func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0];
   wire i_srl=rtype&~func[5]&~func[4]&~func[3]&~func[2]&func[1]&~func[0];
   wire i_sra=rtype&~func[5]&~func[4]&~func[3]&~func[2]&func[1]&func[0];
   wire i_jr=rtype&~func[5]&~func[4]&func[3]&~func[2]&~func[1]&~func[0];
   wire i_addi=~op[5]&~op[4]&op[3]&~op[2]&~op[1]&~op[0];
   wire i_andi=~op[5]&~op[4]&op[3]&op[2]&~op[1]&~op[0];
   wire i_ori=~op[5]&~op[4]&op[3]&op[2]&~op[1]&op[0];
   wire i_xori=~op[5]&~op[4]&op[3]&op[2]&op[1]&~op[0];
   wire i_lw=op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0];
   wire i_sw=op[5]&~op[4]&op[3]&~op[2]&op[1]&op[0];
   wire i_beq=~op[5]&~op[4]&~op[3]&op[2]&~op[1]&~op[0];
   wire i_bne=~op[5]&~op[4]&~op[3]&op[2]&~op[1]&op[0];
   wire i_lui=~op[5]&~op[4]&op[3]&op[2]&op[1]&op[0];
   wire i_j=~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0];
   wire i_jal=~op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0];
   wire c0type=~op[5]&op[4]&~op[3]&~op[2]&~op[1]&~op[0];
   wire i_mfc0=c0type&~op1[4]&~op1[3]&~op1[2]&~op1[1]&~op1[0];
   wire i_mtc0=c0type&~op1[4]&~op1[3]&op1[2]&~op1[1]&~op1[0];
   wire i_eret=c0type&op1[4]&~op1[3]&~op1[2]&~op1[1]&~op1[0]&~func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0];
   wire i_syscall=rtype&~func[5]&~func[4]&func[3]&func[2]&~func[1]&~func[0];
   wire unimplemented_inst=~(i_mfc0|i_mtc0|i_eret|i_syscall|i_add|i_sub|i_and|i_or|i_xor|i_sll
                             |i_srl|i_sra|i_jr|i_addi|i_andi||i_ori|i_xori|i_lw|i_sw|i_beq|i_bne|i_lui|i_j|i_jal);
   wire rd_is_status=(rd==5'd12);
   wire rd_is_cause=(rd==5'd13);
   wire rd_is_epc=(rd==5'd14);
   wire overflow=v&(i_add|i_sub|i_addi);
   wire int_int=sta[0]&intr;
   wire exc_sys=sta[1]&i_syscall;
   wire exc_uni=sta[2]&unimplemented_inst;
   wire exc_ovr=sta[3]&overflow;
   assign inta=int_int;
   wire exccode0=i_syscall|overflow;
   wire exccode1=unimplemented_inst|overflow;
   
   assign mfc0[0]=i_mfc0& rd_is_status | i_mfc0& rd_is_epc;
   assign mfc0[1]=i_mfc0& rd_is_cause | i_mfc0& rd_is_epc;
   
   assign selpc[0]=i_eret;
   assign selpc[1]=exc;
   assign cause={28'h0,exccode1,exccode0,2'b00};
   assign exc=int_int|exc_sys|exc_uni|exc_ovr;
   assign mtc0=i_mtc0;
   assign wsta=exc|mtc0&rd_is_status|i_eret;
   assign wcau=exc|mtc0&rd_is_cause;
   assign wepc=exc |mtc0&rd_is_epc;
   assign regrt=i_addi|i_andi|i_ori|i_lw|i_lui|i_mfc0;
   assign jal=i_jal;
   assign m2reg=i_lw; 
   assign wmem=i_sw;
   assign aluc[3]=i_sra;
   assign aluc[2]=i_sub|i_or|i_srl|i_sra|i_ori|i_lui;
   assign aluc[1]=i_xori|i_sll|i_srl|i_sra|i_xori|i_beq|i_bne|i_lui;
   assign aluc[0]=i_and|i_or|i_sll|i_srl|i_sra|i_andi|i_ori;
   assign shift =i_sll|i_srl|i_sra;
   assign aluimm=i_addi|i_andi|i_ori|i_xori|i_lw|i_lui|i_sw;
   assign sext=i_addi|i_lw|i_sw|i_beq|i_bne;
   assign pcsrc[1]=i_jr|i_j|i_jal;
   assign pcsrc[0]=i_beq&z|i_bne&~z|i_j|i_jal;
   assign wreg=i_add|i_sub|i_and|i_or|i_xor|i_sll|i_srl|i_sra|i_addi|i_andi|
   i_ori|i_xori|i_lw|i_lw|i_lui|i_jal|i_mfc0;
     
   
   
   
   
   
   
   
   
endmodule
