
// -----------
// This file was generated by riscv_ctg (https://github.com/riscv-software-src/riscv-ctg)
// version   : 0.11.0
// timestamp : Wed Feb  7 04:35:01 2024 GMT
// usage     : riscv_ctg \
//                  -- cgf //                  --cgf /home/riscv/riscv-ctg/sample_cgfs/dataset.cgf \
//                  --cgf /home/riscv/riscv-ctg/sample_cgfs/sample_cgfs_fext/rv32h_fnmsub.cgf \
 \
//                  -- xlen 32  \
// -----------
//
// -----------
// Copyright (c) 2020. RISC-V International. All rights reserved.
// SPDX-License-Identifier: BSD-3-Clause
// -----------
//
// This assembly file tests the fnmsub.h instruction of the RISC-V RV32F_Zicsr_Zfh,RV32FD_Zicsr,RV64F_Zicsr_Zfh,RV64FD_Zicsr extension for the fnmsub_b15 covergroup.
// 
#include "model_test.h"
#include "arch_test.h"
RVTEST_ISA("RV32IF_Zicsr_Zfh,RV32IFD_Zicsr,RV64IF_Zicsr_Zfh,RV64IFD_Zicsr")

.section .text.init
.globl rvtest_entry_point
rvtest_entry_point:
RVMODEL_BOOT
RVTEST_CODE_BEGIN

#ifdef TEST_CASE_1

RVTEST_CASE(0,"//check ISA:=regex(.*I.*F.*Zfh.*);def TEST_CASE_1=True;",fnmsub_b15)

RVTEST_FP_ENABLE()
RVTEST_VALBASEUPD(x3,test_dataset_0)
RVTEST_SIGBASE(x1,signature_x1_1)

#endif
RVTEST_CODE_END
RVMODEL_HALT
RVTEST_DATA_BEGIN
.align 4
rvtest_data:
.word 0xbabecafe
.word 0xabecafeb
.word 0xbecafeba
.word 0xecafebab
test_dataset_0:
RVTEST_DATA_END

RVMODEL_DATA_BEGIN
rvtest_sig_begin:
sig_begin_canary:
CANARY;



signature_x1_0:
    .fill 0*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_1:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_2:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_3:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_4:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_5:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_6:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_7:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_8:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_9:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_10:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_11:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_12:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_13:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_14:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_15:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_16:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_17:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_18:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_19:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_20:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_21:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_22:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_23:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_24:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_25:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_26:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_27:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_28:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_29:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_30:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_31:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_32:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_33:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_34:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_35:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_36:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_37:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_38:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_39:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_40:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_41:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_42:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_43:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_44:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_45:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_46:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_47:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_48:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_49:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_50:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_51:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_52:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_53:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_54:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_55:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_56:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_57:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_58:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_59:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_60:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_61:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_62:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_63:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_64:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_65:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_66:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_67:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_68:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_69:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_70:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_71:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_72:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_73:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_74:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_75:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_76:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_77:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_78:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_79:
    .fill 228*((SIGALIGN)/4),4,0xdeadbeef

#ifdef rvtest_mtrap_routine
tsig_begin_canary:
CANARY;

mtrap_sigptr:
    .fill 64*XLEN/32,4,0xdeadbeef

tsig_end_canary:
CANARY;
#endif

#ifdef rvtest_gpr_save

gpr_save:
    .fill 32*XLEN/32,4,0xdeadbeef

#endif


sig_end_canary:
CANARY;
rvtest_sig_end:
RVMODEL_DATA_END
