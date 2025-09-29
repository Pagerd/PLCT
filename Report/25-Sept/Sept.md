## 本月工作

### 会议相关

- 参加了9月9日的Architectural Compatible Test SIG Meeting，并记录了会议文档[#MD](https://github.com/Pagerd/PLCT/blob/main/Report/week/week92/ACT.md)
- 参加了9月23日的Architectural Compatible Test SIG Meeting，并记录了会议文档[#MD](https://github.com/Pagerd/PLCT/blob/main/Report/week/week93/ACT.md)

### PR与Issue相关

- 更新了一个修复缺失的压缩非法指令缺失覆盖的pr[#695](https://github.com/riscv-non-isa/riscv-arch-test/pull/695)
- 提交了一个添加了Zfbmin拓展支持的[pr](https://github.com/Pagerd/riscv-arch-test/tree/zfbmin)
- 回复了一个关于测试 riscof 示例时出现错误的issue[#697](https://github.com/riscv-non-isa/riscv-arch-test/issues/697)
- 回复了一个关于vclmul 和 vclmulh 检查的issue[#686](https://github.com/riscv-non-isa/riscv-arch-test/issues/686)
- 回复了一个关于Zfinx FMadd/sub 测试太大的issue[#632](https://github.com/riscv-non-isa/riscv-arch-test/issues/632)

| 测试用例名      | 所属拓展 | 地址                                                         |
| --------------- | -------- | ------------------------------------------------------------ |
| cadd-01         | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| caddi-01        | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| caddi16sp-01    | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| caddi4spn-01    | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| cand-01         | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| candi-01        | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| cbeqz-01        | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| cbnez-01        | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| cjr-01          | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| cli-01          | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| clui            | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| clw-01          | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| clwsp-01        | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| cmv-01          | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| cor-01          | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| cslli-01        | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| csrai-01        | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| csrli-01        | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| csub-01         | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| csw-01          | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| cswsp-01        | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| cxor-01         | C        | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fcvt.bf16.s_b1  | Zfbmin   | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fcvt.bf16.s_b22 | Zfbmin   | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fcvt.bf16.s_b23 | Zfbmin   | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fcvt.bf16.s_b24 | Zfbmin   | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fcvt.bf16.s_b27 | Zfbmin   | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fcvt.bf16.s_b28 | Zfbmin   | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fcvt.bf16.s_b29 | Zfbmin   | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fcvt.s.bf16_b1  | Zfbmin   | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fcvt.s.bf16_b22 | Zfbmin   | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fcvt.s.bf16_b23 | Zfbmin   | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fcvt.s.bf16_b24 | Zfbmin   | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fcvt.s.bf16_b27 | Zfbmin   | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fcvt.s.bf16_b28 | Zfbmin   | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fcvt.s.bf16_b29 | Zfbmin   | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |

