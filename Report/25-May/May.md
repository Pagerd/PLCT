## 本月工作

### Sail/ACT

- 更新了为ACT添加缺失的RV32 Zdinx共117个测试用例[#642](https://github.com/riscv-non-isa/riscv-arch-test/pull/642)并成功合并
- 更新了为ACT添加缺失的RV32 Zfinx的一些新测试用例[#642](https://github.com/riscv-non-isa/riscv-arch-test/pull/642)

| 测试用例名 | 所属拓展 | 添加测试用例数 | 地址                                                         |
| ---------- | -------- | -------------- | ------------------------------------------------------------ |
| fmadd-b11  | zfinx    | 13             | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fmsub-b11  | zfinx    | 13             | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fnmadd-b11 | zfinx    | 13             | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fnmsub-b11 | zfinx    | 13             | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fmadd-b1   | zfh      | 18             | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fmsub-b1   | zfh      | 18             | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fnmadd-b1  | zfh      | 18             | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fnmsub-b1  | zfh      | 18             | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |

- 提交了一个修复rv 32 Zdinx测试错误的bug的pr[#651](https://github.com/riscv-non-isa/riscv-arch-test/pull/651)
- 为ACT添加缺失的rv64 Zdinx fmadd.d/fmsub.d共330个测试用例[#654](https://github.com/riscv-non-isa/riscv-arch-test/pull/654)

| 测试指令名 | 所属拓展 | 测试用例数 | 地址                                                         |
| ---------- | -------- | ---------- | ------------------------------------------------------------ |
| fadd.d     | Zdinx    | 11         | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fclass.d   | Zdinx    | 1          | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fdiv.d     | Zdinx    | 11         | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| feq.d      | Zdinx    | 2          | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fle.d      | Zdinx    | 2          | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| flt.d      | Zdinx    | 2          | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fmadd.d    | Zdinx    | 62         | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fmax.d     | Zdinx    | 2          | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fmin.d     | Zdinx    | 2          | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fmsub.d    | Zdinx    | 62         | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fmul.d     | Zdinx    | 9          | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fnmadd.d   | Zdinx    | 62         | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fnmsub.d   | Zdinx    | 62         | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fsgnj.d    | Zdinx    | 1          | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fsgnjn.d   | Zdinx    | 1          | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fsgnjx.d   | Zdinx    | 1          | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fsqrt.d    | Zdinx    | 10         | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fsub.d     | Zdinx    | 12         | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |

