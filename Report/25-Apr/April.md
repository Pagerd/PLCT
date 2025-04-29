## 本月工作

### 会议

- 参加了4月7日的Architectural Compatible Test SIG Meeting，并记录了会议文档[#MD](https://github.com/Pagerd/PLCT/blob/main/Report/week/week80/ACT.md)
- 参加了4月22日的Architectural Compatible Test SIG Meeting，并记录了会议文档[#MD](https://github.com/Pagerd/PLCT/blob/main/Report/week/week82/ACT.md)

### Sail/ACT

- 提交了一个拆分zfh测试用例的pr[#635](https://github.com/riscv-non-isa/riscv-arch-test/pull/635)[已合并]
- 提交了一个拆分zfinx测试用例的pr[#628](https://github.com/riscv-non-isa/riscv-arch-test/pull/628)[已合并]

| 测试用例名 | 所属拓展 | 地址                                                         |
| ---------- | -------- | ------------------------------------------------------------ |
| fmadd-b15  | zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv64i_m/Zhinx/src) |
| fmsub-b15  | zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv64i_m/Zhinx/src) |
| fnmadd-b15 | zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv64i_m/Zhinx/src) |
| fnmsub-b15 | zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv64i_m/Zhinx/src) |
| fmadd-b15  | zfh      | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfh/src) |
| fmsub-b15  | zfh      | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfh/src) |
| fnmadd-b15 | zfh      | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfh/src) |
| fnmsub-b15 | zfh      | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfh/src) |
| fmadd-b1   | zfh      | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfh/src) |
| fmsub-b1   | zfh      | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfh/src) |
| fnmadd-b1  | zfh      | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfh/src) |
| fnmsub-b1  | zfh      | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfh/src) |

- 为ACT添加缺失的RV32 Zfinx共117个测试用例[#638](https://github.com/riscv-non-isa/riscv-arch-test/pull/638)
- 为ACT添加缺失的rv32 Zdinx fmadd/fmsub共580个测试用例[#642](https://github.com/riscv-non-isa/riscv-arch-test/pull/642)

| 测试指令名 | 所属拓展 | 地址                                                         |
| ---------- | -------- | ------------------------------------------------------------ |
| fadd       | Zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fclass     | Zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fdiv       | Zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| feq        | Zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fle        | Zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| flt        | Zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fmadd      | Zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fmax       | Zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fmin       | Zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fmsub      | Zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fmul       | Zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fnmadd     | Zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fnmsub     | Zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fsgnj      | Zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fsgnjn     | Zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fsgnjx     | Zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fsqrt      | Zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fsub       | Zfinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fmadd      | Zdinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zdinx/src) |
| fnmadd     | Zdinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zdinx/src) |
| fmsub      | Zdinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zdinx/src) |
| fnmsub     | Zdinx    | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zdinx/src) |

