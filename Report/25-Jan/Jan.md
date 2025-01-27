## 本月工作

### 文档相关

- 编写了ppt[ACT测试中的测试用例格式](.\ACT测试中的测试用例格式.pptx)并于技术分享上进行了分享
- 编写了摘要与海报 [Adding fcvt support for ACT through RISCOF.](https://github.com/Pagerd/PLCT/blob/main/Report/25-Jan/Tokyo/)并提交至东京会议

### Sail

- 跟进了缺失的Zfh测试用例的Pr并成功合并[#572](https://github.com/riscv-non-isa/riscv-arch-test/pull/572)

- 更新了修复ACT测试库中fcvt_d_s错误测试用例数据的pr并成功合并[#581](https://github.com/riscv-non-isa/riscv-arch-test/pull/581)

- 提交了解码器Zfh代码支持更新，等待合并中[#573](https://github.com/riscv-non-isa/riscv-arch-test/pull/573)



  | 成功合入的测试用例名  | Link                                                         |
  | ----------------- | ------------------------------------------------------------ |
  | fcvt.d.s_b1-01.S  | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/riscv-test-suite/rv32i_m/Zfh/src/) |
  | fcvt.d.s_b22-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/riscv-test-suite/rv32i_m/Zfh/src/) |
  | fcvt.d.s_b23-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
  | fcvt.d.s_b24-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
  | fcvt.d.s_b27-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
  | fcvt.d.s_b28-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
  | fcvt.d.s_b29-01.S | [url](https://github.com/Pagerd/riscv-arch-test/tree/zfh_1/main/riscv-test-suite/rv32i_m/Zfh/src/) |
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

- 修改了D拓展及F拓展的测试用例，将10进制测试数据更新为16进制[Github](https://github.com/Pagerd/riscv-arch-test)


