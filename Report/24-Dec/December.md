## 本周工作

### 会议纪要

- 2024.12.2 Architectural Compatible Test SIG Meeting [MD](https://github.com/Pagerd/PLCT/blob/main/Report/week/week68/ACT.md)
- 2024.12.17 Architectural Compatible Test SIG Meeting [MD](https://github.com/Pagerd/PLCT/blob/main/Report/week/week70/ACT.md)

### 文档相关

- 编写了ppt[ACT的不足，改进及意义](.\week69\ACT的不足，改进及意义.pptx)并于plct open day上进行了演讲.
- 编写了ACT测试2025年的计划与目标 [MD](https://github.com/Pagerd/PLCT/blob/main/Report/week/week70/Future_Act.md)

### Sail

- 更新了解码器Zfh代码支持更新,添加了更多指令支持[#573](https://github.com/riscv-non-isa/riscv-arch-test/pull/573)

- 将缺失的Zfh测试用例Pr进行了更新[#572](https://github.com/riscv-non-isa/riscv-arch-test/pull/572)

- 添加了修复ACT测试库中fcvt_d_s错误测试用例数据的pr[#581](https://github.com/riscv-non-isa/riscv-arch-test/pull/581)

  | 更新的测试用例名  | Link                                                         |
  | ----------------- | ------------------------------------------------------------ |
  | fcvt.d.s_b1-01.S  | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/riscv-test-suite/rv32i_m/Zfh/src/) |
  | fcvt.d.s_b22-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/riscv-test-suite/rv32i_m/Zfh/src/) |
  | fcvt.d.s_b23-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
  | fcvt.d.s_b24-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
  | fcvt.d.s_b27-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
  | fcvt.d.s_b28-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
  | fcvt.d.s_b29-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |

### 未完成

- 尝试在CTG中添加参数来生成对十进制数据添加16进制注释的功能（未完成，需要测试）[Github](https://github.com/Pagerd/riscv-arch-test)
