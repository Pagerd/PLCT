
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

