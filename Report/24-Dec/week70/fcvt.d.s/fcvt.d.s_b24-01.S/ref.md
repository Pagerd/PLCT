
# Data Propagation Report

- **STAT1** : Number of instructions that hit unique coverpoints and update the signature
- **STAT2** : Number of instructions that hit covepoints which are not unique but still update the signature (completely or partially)
- **STAT3** : Number of instructions that hit a unique coverpoint but do not update the signature completely
- **STAT4** : Number of multiple signature updates for the same coverpoint
- **STAT5** : Number of times the signature was overwritten

| Param                     | Value    |
|---------------------------|----------|
| XLEN                      | 32      |
| TEST_REGION               | [('0x80000148', '0x8000053c')]      |
| SIG_REGION                | [('0x80003110', '0x80003330', '136 words')]      |
| COV_LABELS                | fcvt.d.s_b24      |
| TEST_NAME                 | /home/pager/Desktop/work/ZfhTest/riscof_work/rv32i_m/Zfh/src/fcvt.d.s_b24-01.S/ref/ref.S    |
| Total Number of coverpoints| 76     |
| Total Coverpoints Hit     | 67      |
| Total Signature Updates   | 66      |
| STAT1                     | 32      |
| STAT2                     | 1      |
| STAT3                     | 0     |
| STAT4                     | 0     |
| STAT5                     | 0     |

## Details for STAT2:

```
Op without unique coverpoint updates Signature
 -- Code Sequence:
      [0x8000052c]:fcvt.d.s ft11, ft10, rne
      [0x80000530]:csrrs tp, fcsr, zero
      [0x80000534]:fsd ft11, 0x200(ra)
      [0x80000538]:sw tp, 0x208(ra)
 -- Signature Addresses:
      Address: 0x80003318 Data: 0x00000000
      Address: 0x80003320 Data: 0x00000000
 -- Redundant Coverpoints hit by the op
      - mnemonic : fcvt.d.s
      - rs1 : f30
      - rd : f31
      - rs1 != rd






```

## Details of STAT3

```


```

## Details of STAT4:

```

```

## Details of STAT5:



## Details of STAT1:

- The first column indicates the signature address(es) and the data at that location in hexadecimal in the following format:
  ```
  [Address1]
  Data1

  [Address2]
  Data2

  ...
  ```

- The second column captures all the coverpoints which have been captured by that particular signature location

- The third column captures all the insrtuctions since the time a coverpoint was
  hit to the point when a store to the signature was performed. Each line has
  the following format:
  ```
  [PC of instruction] : mnemonic
  ```
- The order in the table is based on the order of signatures occuring in the
  test. These need not necessarily be in increasing or decreasing order of the
  address in the signature region.

|s.no|                          signature                           |                               coverpoints                               |                                                                         code                                                                          |
|---:|--------------------------------------------------------------|-------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
|   1|[0x80003118]<br>0x7D5BFDDB<br> [0x80003120]<br>0x00000000<br> |- mnemonic : fcvt.d.s<br> - rs1 : f16<br> - rd : f16<br> - rs1 == rd<br> |[0x800001ac]:fcvt.d.s fa6, fa6, rne<br> [0x800001b0]:csrrs tp, fcsr, zero<br> [0x800001b4]:fsd fa6, 0x0(ra)<br> [0x800001b8]:sw tp, 0x8(ra)<br>        |
|   2|[0x80003128]<br>0x00000000<br> [0x80003130]<br>0x00000000<br> |- rs1 : f31<br> - rd : f12<br> - rs1 != rd<br>                           |[0x800001c8]:fcvt.d.s fa2, ft11, rne<br> [0x800001cc]:csrrs tp, fcsr, zero<br> [0x800001d0]:fsd fa2, 0x10(ra)<br> [0x800001d4]:sw tp, 0x18(ra)<br>     |
|   3|[0x80003138]<br>0x00000000<br> [0x80003140]<br>0x00000000<br> |- rs1 : f24<br> - rd : f27<br>                                           |[0x800001e4]:fcvt.d.s fs11, fs8, rne<br> [0x800001e8]:csrrs tp, fcsr, zero<br> [0x800001ec]:fsd fs11, 0x20(ra)<br> [0x800001f0]:sw tp, 0x28(ra)<br>    |
|   4|[0x80003148]<br>0x00002000<br> [0x80003150]<br>0x00000000<br> |- rs1 : f2<br> - rd : f10<br>                                            |[0x80000200]:fcvt.d.s fa0, ft2, rne<br> [0x80000204]:csrrs tp, fcsr, zero<br> [0x80000208]:fsd fa0, 0x30(ra)<br> [0x8000020c]:sw tp, 0x38(ra)<br>      |
|   5|[0x80003158]<br>0x00000000<br> [0x80003160]<br>0x00000000<br> |- rs1 : f19<br> - rd : f6<br>                                            |[0x8000021c]:fcvt.d.s ft6, fs3, rne<br> [0x80000220]:csrrs tp, fcsr, zero<br> [0x80000224]:fsd ft6, 0x40(ra)<br> [0x80000228]:sw tp, 0x48(ra)<br>      |
|   6|[0x80003168]<br>0x00000000<br> [0x80003170]<br>0x00000000<br> |- rs1 : f28<br> - rd : f21<br>                                           |[0x80000238]:fcvt.d.s fs5, ft8, rne<br> [0x8000023c]:csrrs tp, fcsr, zero<br> [0x80000240]:fsd fs5, 0x50(ra)<br> [0x80000244]:sw tp, 0x58(ra)<br>      |
|   7|[0x80003178]<br>0x00000000<br> [0x80003180]<br>0x00000000<br> |- rs1 : f22<br> - rd : f29<br>                                           |[0x80000254]:fcvt.d.s ft9, fs6, rne<br> [0x80000258]:csrrs tp, fcsr, zero<br> [0x8000025c]:fsd ft9, 0x60(ra)<br> [0x80000260]:sw tp, 0x68(ra)<br>      |
|   8|[0x80003188]<br>0x00000000<br> [0x80003190]<br>0x00000000<br> |- rs1 : f27<br> - rd : f24<br>                                           |[0x80000270]:fcvt.d.s fs8, fs11, rne<br> [0x80000274]:csrrs tp, fcsr, zero<br> [0x80000278]:fsd fs8, 0x70(ra)<br> [0x8000027c]:sw tp, 0x78(ra)<br>     |
|   9|[0x80003198]<br>0x00000000<br> [0x800031a0]<br>0x00000000<br> |- rs1 : f21<br> - rd : f0<br>                                            |[0x8000028c]:fcvt.d.s ft0, fs5, rne<br> [0x80000290]:csrrs tp, fcsr, zero<br> [0x80000294]:fsd ft0, 0x80(ra)<br> [0x80000298]:sw tp, 0x88(ra)<br>      |
|  10|[0x800031a8]<br>0x00FAB7FF<br> [0x800031b0]<br>0x00000000<br> |- rs1 : f15<br> - rd : f17<br>                                           |[0x800002a8]:fcvt.d.s fa7, fa5, rne<br> [0x800002ac]:csrrs tp, fcsr, zero<br> [0x800002b0]:fsd fa7, 0x90(ra)<br> [0x800002b4]:sw tp, 0x98(ra)<br>      |
|  11|[0x800031b8]<br>0x00000000<br> [0x800031c0]<br>0x00000000<br> |- rs1 : f23<br> - rd : f15<br>                                           |[0x800002c4]:fcvt.d.s fa5, fs7, rne<br> [0x800002c8]:csrrs tp, fcsr, zero<br> [0x800002cc]:fsd fa5, 0xa0(ra)<br> [0x800002d0]:sw tp, 0xa8(ra)<br>      |
|  12|[0x800031c8]<br>0x00000000<br> [0x800031d0]<br>0x00000000<br> |- rs1 : f29<br> - rd : f13<br>                                           |[0x800002e0]:fcvt.d.s fa3, ft9, rne<br> [0x800002e4]:csrrs tp, fcsr, zero<br> [0x800002e8]:fsd fa3, 0xb0(ra)<br> [0x800002ec]:sw tp, 0xb8(ra)<br>      |
|  13|[0x800031d8]<br>0x00000000<br> [0x800031e0]<br>0x00000000<br> |- rs1 : f5<br> - rd : f22<br>                                            |[0x800002fc]:fcvt.d.s fs6, ft5, rne<br> [0x80000300]:csrrs tp, fcsr, zero<br> [0x80000304]:fsd fs6, 0xc0(ra)<br> [0x80000308]:sw tp, 0xc8(ra)<br>      |
|  14|[0x800031e8]<br>0x00000007<br> [0x800031f0]<br>0x00000000<br> |- rs1 : f12<br> - rd : f20<br>                                           |[0x80000318]:fcvt.d.s fs4, fa2, rne<br> [0x8000031c]:csrrs tp, fcsr, zero<br> [0x80000320]:fsd fs4, 0xd0(ra)<br> [0x80000324]:sw tp, 0xd8(ra)<br>      |
|  15|[0x800031f8]<br>0x00000000<br> [0x80003200]<br>0x00000000<br> |- rs1 : f9<br> - rd : f26<br>                                            |[0x80000334]:fcvt.d.s fs10, fs1, rne<br> [0x80000338]:csrrs tp, fcsr, zero<br> [0x8000033c]:fsd fs10, 0xe0(ra)<br> [0x80000340]:sw tp, 0xe8(ra)<br>    |
|  16|[0x80003208]<br>0x00000000<br> [0x80003210]<br>0x00000000<br> |- rs1 : f20<br> - rd : f11<br>                                           |[0x80000350]:fcvt.d.s fa1, fs4, rne<br> [0x80000354]:csrrs tp, fcsr, zero<br> [0x80000358]:fsd fa1, 0xf0(ra)<br> [0x8000035c]:sw tp, 0xf8(ra)<br>      |
|  17|[0x80003218]<br>0x80002010<br> [0x80003220]<br>0x00000000<br> |- rs1 : f18<br> - rd : f3<br>                                            |[0x8000036c]:fcvt.d.s ft3, fs2, rne<br> [0x80000370]:csrrs tp, fcsr, zero<br> [0x80000374]:fsd ft3, 0x100(ra)<br> [0x80000378]:sw tp, 0x108(ra)<br>    |
|  18|[0x80003228]<br>0x00000000<br> [0x80003230]<br>0x00000000<br> |- rs1 : f30<br> - rd : f9<br>                                            |[0x80000388]:fcvt.d.s fs1, ft10, rne<br> [0x8000038c]:csrrs tp, fcsr, zero<br> [0x80000390]:fsd fs1, 0x110(ra)<br> [0x80000394]:sw tp, 0x118(ra)<br>   |
|  19|[0x80003238]<br>0x00000000<br> [0x80003240]<br>0x00000000<br> |- rs1 : f10<br> - rd : f30<br>                                           |[0x800003a4]:fcvt.d.s ft10, fa0, rne<br> [0x800003a8]:csrrs tp, fcsr, zero<br> [0x800003ac]:fsd ft10, 0x120(ra)<br> [0x800003b0]:sw tp, 0x128(ra)<br>  |
|  20|[0x80003248]<br>0x0000000F<br> [0x80003250]<br>0x00000000<br> |- rs1 : f0<br> - rd : f5<br>                                             |[0x800003c0]:fcvt.d.s ft5, ft0, rne<br> [0x800003c4]:csrrs tp, fcsr, zero<br> [0x800003c8]:fsd ft5, 0x130(ra)<br> [0x800003cc]:sw tp, 0x138(ra)<br>    |
|  21|[0x80003258]<br>0x000003EA<br> [0x80003260]<br>0x00000000<br> |- rs1 : f13<br> - rd : f19<br>                                           |[0x800003dc]:fcvt.d.s fs3, fa3, rne<br> [0x800003e0]:csrrs tp, fcsr, zero<br> [0x800003e4]:fsd fs3, 0x140(ra)<br> [0x800003e8]:sw tp, 0x148(ra)<br>    |
|  22|[0x80003268]<br>0x00000000<br> [0x80003270]<br>0x00000000<br> |- rs1 : f6<br> - rd : f2<br>                                             |[0x800003f8]:fcvt.d.s ft2, ft6, rne<br> [0x800003fc]:csrrs tp, fcsr, zero<br> [0x80000400]:fsd ft2, 0x150(ra)<br> [0x80000404]:sw tp, 0x158(ra)<br>    |
|  23|[0x80003278]<br>0x80003118<br> [0x80003280]<br>0x00000000<br> |- rs1 : f7<br> - rd : f1<br>                                             |[0x80000414]:fcvt.d.s ft1, ft7, rne<br> [0x80000418]:csrrs tp, fcsr, zero<br> [0x8000041c]:fsd ft1, 0x160(ra)<br> [0x80000420]:sw tp, 0x168(ra)<br>    |
|  24|[0x80003288]<br>0x00000000<br> [0x80003290]<br>0x00000000<br> |- rs1 : f14<br> - rd : f23<br>                                           |[0x80000430]:fcvt.d.s fs7, fa4, rne<br> [0x80000434]:csrrs tp, fcsr, zero<br> [0x80000438]:fsd fs7, 0x170(ra)<br> [0x8000043c]:sw tp, 0x178(ra)<br>    |
|  25|[0x80003298]<br>0x00000000<br> [0x800032a0]<br>0x00000000<br> |- rs1 : f8<br> - rd : f14<br>                                            |[0x8000044c]:fcvt.d.s fa4, fs0, rne<br> [0x80000450]:csrrs tp, fcsr, zero<br> [0x80000454]:fsd fa4, 0x180(ra)<br> [0x80000458]:sw tp, 0x188(ra)<br>    |
|  26|[0x800032a8]<br>0x00000000<br> [0x800032b0]<br>0x00000000<br> |- rs1 : f4<br> - rd : f25<br>                                            |[0x80000468]:fcvt.d.s fs9, ft4, rne<br> [0x8000046c]:csrrs tp, fcsr, zero<br> [0x80000470]:fsd fs9, 0x190(ra)<br> [0x80000474]:sw tp, 0x198(ra)<br>    |
|  27|[0x800032b8]<br>0x0001F56F<br> [0x800032c0]<br>0x00000000<br> |- rs1 : f3<br> - rd : f18<br>                                            |[0x80000484]:fcvt.d.s fs2, ft3, rne<br> [0x80000488]:csrrs tp, fcsr, zero<br> [0x8000048c]:fsd fs2, 0x1a0(ra)<br> [0x80000490]:sw tp, 0x1a8(ra)<br>    |
|  28|[0x800032c8]<br>0x00000000<br> [0x800032d0]<br>0x00000000<br> |- rs1 : f1<br> - rd : f8<br>                                             |[0x800004a0]:fcvt.d.s fs0, ft1, rne<br> [0x800004a4]:csrrs tp, fcsr, zero<br> [0x800004a8]:fsd fs0, 0x1b0(ra)<br> [0x800004ac]:sw tp, 0x1b8(ra)<br>    |
|  29|[0x800032d8]<br>0x00000000<br> [0x800032e0]<br>0x00000000<br> |- rs1 : f25<br> - rd : f28<br>                                           |[0x800004bc]:fcvt.d.s ft8, fs9, rne<br> [0x800004c0]:csrrs tp, fcsr, zero<br> [0x800004c4]:fsd ft8, 0x1c0(ra)<br> [0x800004c8]:sw tp, 0x1c8(ra)<br>    |
|  30|[0x800032e8]<br>0x00000000<br> [0x800032f0]<br>0x00000000<br> |- rs1 : f11<br> - rd : f4<br>                                            |[0x800004d8]:fcvt.d.s ft4, fa1, rne<br> [0x800004dc]:csrrs tp, fcsr, zero<br> [0x800004e0]:fsd ft4, 0x1d0(ra)<br> [0x800004e4]:sw tp, 0x1d8(ra)<br>    |
|  31|[0x800032f8]<br>0x00000000<br> [0x80003300]<br>0x00000000<br> |- rs1 : f26<br> - rd : f31<br>                                           |[0x800004f4]:fcvt.d.s ft11, fs10, rne<br> [0x800004f8]:csrrs tp, fcsr, zero<br> [0x800004fc]:fsd ft11, 0x1e0(ra)<br> [0x80000500]:sw tp, 0x1e8(ra)<br> |
|  32|[0x80003308]<br>0x00000000<br> [0x80003310]<br>0x00000000<br> |- rs1 : f17<br> - rd : f7<br>                                            |[0x80000510]:fcvt.d.s ft7, fa7, rne<br> [0x80000514]:csrrs tp, fcsr, zero<br> [0x80000518]:fsd ft7, 0x1f0(ra)<br> [0x8000051c]:sw tp, 0x1f8(ra)<br>    |
