## 本月工作

### Sail/ACT

- 发现ISAC中负责覆盖点测试的插件不支持Zfh代码导致仓库内Zfh测试用例无法进行覆盖点测试，提交了一个issue [#568](https://github.com/riscv-non-isa/riscv-arch-test/issues/568)

- 在ACT上提交了一个用于修复isac字符串导致无法正常生成测试用例的pr[pr#544(已合并)](https://github.com/riscv-non-isa/riscv-arch-test/pull/544)

- 在ACT上提交了一个pr，对上述插件进行了Zfh代码支持更新[#573](https://github.com/riscv-non-isa/riscv-arch-test/pull/573)

| 添加支持指令名 | Link                                                         |
| -------------- | ------------------------------------------------------------ |
| fadd.h         | [fadd.h](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/zfh_2/riscv-isac/riscv_isac/plugins/internaldecoder.py) |
| fclass.h       | [fclass.h](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/zfh_2/riscv-isac/riscv_isac/plugins/internaldecoder.py) |
| fcvt.w.h       | [fcvt.w.h](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/zfh_2/riscv-isac/riscv_isac/plugins/internaldecoder.py) |
| fcvt.wu.h      | [fcvt.wu.h](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/zfh_2/riscv-isac/riscv_isac/plugins/internaldecoder.py) |
| fdiv           | [fdiv](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/zfh_2/riscv-isac/riscv_isac/plugins/internaldecoder.py) |
| feq            | [feq](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/zfh_2/riscv-isac/riscv_isac/plugins/internaldecoder.py) |
| fle            | [fle](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/zfh_2/riscv-isac/riscv_isac/plugins/internaldecoder.py) |
| flt            | [flt](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/zfh_2/riscv-isac/riscv_isac/plugins/internaldecoder.py) |
| fmax           | [fmax](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/zfh_2/riscv-isac/riscv_isac/plugins/internaldecoder.py) |
| fmin           | [fmin](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/zfh_2/riscv-isac/riscv_isac/plugins/internaldecoder.py) |
| fmv.h.x        | [fmv.h.x](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/zfh_2/riscv-isac/riscv_isac/plugins/internaldecoder.py) |
| fmv.x.h        | [fmv.x.h](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/zfh_2/riscv-isac/riscv_isac/plugins/internaldecoder.py) |
| fsgnj          | [fsgnj](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/zfh_2/riscv-isac/riscv_isac/plugins/internaldecoder.py) |
| fsgnjn         | [fsgnjn](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/zfh_2/riscv-isac/riscv_isac/plugins/internaldecoder.py) |
| fsgnjx         | [fsgnjx](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/zfh_2/riscv-isac/riscv_isac/plugins/internaldecoder.py) |
| fsqrt          | [fsqrt](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/zfh_2/riscv-isac/riscv_isac/plugins/internaldecoder.py) |

- 在ACT上重新提交了关于添加缺失Zfh测试用例的pr[#572](https://github.com/riscv-non-isa/riscv-arch-test/pull/572)

| 生成的测试用例名  | Link                                                         |
| ----------------- | ------------------------------------------------------------ |
| fcvt.d.h_b1-01.S  | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.d.h_b22-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.d.h_b23-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.d.h_b24-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.d.h_b27-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.d.h_b28-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.d.h_b29-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.d_b1-01.S  | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.d_b22-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.d_b23-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.d_b24-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.d_b27-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.d_b28-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.d_b29-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.s_b22-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.s_b23-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.s_b24-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.s_b27-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.s_b28-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.s_b29-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |

### 其他

- 参加了10月4日的ACT会议，并编写了会议纪要[MD](https://github.com/Pagerd/PLCT/blob/main/Report/week/week62/ACT.md)
