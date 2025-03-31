## 本月工作

### 会议相关

- 参加了3月11日的ACT会议，并编写了会议纪要[MD](https://github.com/Pagerd/PLCT/blob/main/Report/25-Mar/week78/ACT.md)
- 主持了3月20日第99届东亚时区双周会[Link](https://community.riscv.org/e/m9tw5p/)
- 调研了cvw-arch-verif并在技术分享上分享了[cvw-arch-verif_为wally的ACT测试用例集](https://github.com/Pagerd/PLCT/blob/main/Report/25-Mar/week79/cvw-arch-verif_为wally的ACT测试用例集.pptx)

### issue/pr相关

- 更新了修复ACT仓库中FD测试用例的nan_boxed为16进制的pr并成功合并[#614](https://github.com/riscv-non-isa/riscv-arch-test/pull/614)

修复列表：

| 测试用例指令名      | 所属拓展 | 链接                                                         |
| --------------- | -------- | ------------------------------------------------------------ |
| fadd.d-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fclass.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fcvt.d.s_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fcvt.d.wu_b25-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fcvt.d.w_b25-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fcvt.s.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fcvt.w.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fcvt.wu.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fdiv.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| feq.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fld-align-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fle.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| flt.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fmadd.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fmax.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fmin.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fmin.d_b19-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fmsub.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fmul.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fnmadd.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fnmsub.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fsd-align-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fsgnj.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fsgnjn.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fsgnjx.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fsqrt.d_b1-01.S  | D        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fadd_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fclass_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fcvt.s.wu_b25-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fcvt.s.w_b25-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fcvt.w.s_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fcvt.wu.s_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fdiv_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| feq_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fle_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| flt_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| flw-align-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fmadd_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fmax_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fmin_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fmsub_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fmsub_b2-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fmul_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fmv.w.x_b25-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fmv.x.w_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fnmadd_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fnmsub_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fsgnjn_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fsgnjx_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fsgnj_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fsub_b1-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fsub_b2-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fsw-align-01.S  | F        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| c.fld-01.S  | D_Zcd        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| c.fldsp-01.S  | D_Zcd        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| c.fsd-01.S  | D_Zcd        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| c.fsdsp-01.S  | D_Zcd        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fcvtmod.w.d_b1-01.S  | D_Zfa        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fleq.d_b1-01.S  | D_Zfa        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fleq.d_b19-01.S  | D_Zfa        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fleq_b1-01.S  | D_Zfa        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fli.d-01.S  | D_Zfa        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fltq.d_b1-01.S  | D_Zfa        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fltq_b1-01.S  | D_Zfa        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fmaxm.d_b1-01.S  | D_Zfa        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fmaxm_b1-01.S  | D_Zfa        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fminm.d_b1-01.S  | D_Zfa        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fminm_b1-01.S  | D_Zfa        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fmvh.x.d_b1-01.S  | D_Zfa        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| froundnx.d_b1-01.S  | D_Zfa        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| froundnx_b1-01.S  | D_Zfa        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fround_b1-01.S  | D_Zfa        | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| c.flw-01.S  | F_Zcf       | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| c.flwsp-01.S  | F_Zcf       | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| c.fsw-01.S  | F_Zcf       | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| c.fswsp-01.S  | F_Zcf       | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fleq_b1-01.S  | F_Zfa       | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fli.s-01.S  | F_Zfa       | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fltq_b1-01.S  | F_Zfa       | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fmaxm_b19-01.S  | F_Zfa       | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fminm_b19-01.S  | F_Zfa       | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| froundnx_b1-01.S  | F_Zfa       | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |
| fround_b1-01.S  | F_Zfa       | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |

- 提交了一个更新act的readme的pr[#620](https://github.com/riscv-non-isa/riscv-arch-test/pull/620)
- 提交了修复pmp test name的bug[#619](https://github.com/riscv-non-isa/riscv-arch-test/pull/620)

#### Issue相关

- 调研了压缩指令缺失测试条件的测试用例[#482](https://github.com/riscv-non-isa/riscv-arch-test/issues/482)
- 在无法运行RISCOF issue下进行评论并跟进帮助[#616](https://github.com/riscv-non-isa/riscv-arch-test/issues/616)
- 调研了fmadd_b15-01.S过大的问题[#625](https://github.com/riscv-non-isa/riscv-arch-test/issues/625)

