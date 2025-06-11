RVTEST_DATA_END

RVMODEL_DATA_BEGIN
rvtest_sig_begin:
sig_begin_canary:
CANARY;



signature_x1_0:
    .fill 0*((SIGALIGN)/4),4,0xdeadbeef


signature_x1_1:
    .fill 50*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_0:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_1:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_2:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_3:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_4:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_5:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_6:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_7:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_8:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_9:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_10:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_11:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_12:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_13:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_14:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_15:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_16:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_17:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_18:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_19:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_20:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_21:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_22:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_23:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_24:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_25:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_26:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_27:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_28:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_29:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_30:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_31:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_32:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_33:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_34:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_35:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_36:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_37:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_38:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_39:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_40:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_41:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_42:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_43:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_44:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_45:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_46:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_47:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_48:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_49:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_50:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_51:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_52:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_53:
    .fill 256*((SIGALIGN)/4),4,0xdeadbeef


signature_x8_54:
    .fill 160*((SIGALIGN)/4),4,0xdeadbeef

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
