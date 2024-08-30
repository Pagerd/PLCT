## 本周工作

### 分享报告

- 编写了技术分享ppt[在ACT测试框架中添加新指令支持](https://github.com/Pagerd/PLCT/blob/main/Report/week/week54/在ACT测试框架中添加新指令支持.pptx),并在8月14日进行了技术分享
- 编写了用于RV峰会分享的ppt[RISC-V Architectural Tests ISA 规范验证测试研究](https://github.com/Pagerd/PLCT/blob/main/Report/week/week55/RISC-V_Architectural_Tests_ISA_规范验证测试研究.pptx)，并在峰会同期活动中进行了演讲

### 会议纪要

- 参加了8月8日DataCenter的会议，并编写了[会议纪要](https://github.com/Pagerd/PLCT/blob/main/Report/week/week53/datacenter.md)
- 参加了8月26日的ACT会议，并编写了[会议纪要](https://github.com/Pagerd/PLCT/blob/main/Report/week/week57/ACT.md.md)

### PR更新

- 关于iasc部分ibm 16bit支持的pr由于仓库管理者自己添加了一个commit来添加支持因此关闭[pr#93](https://github.com/riscv-software-src/riscv-isac/pull/93) 
-  根据新的isac重新生成了浮点转换浮点测试用例，并重新提交了pr [pr#483](https://github.com/riscv-non-isa/riscv-arch-test/pull/483 )

| 生成的测试用例名  | Link                                                         |
| ----------------- | ------------------------------------------------------------ |
| fcvt.d.h_b1-01.S  | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.d.h_b22-01.S | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.d.h_b23-01.S | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.d.h_b24-01.S | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.d.h_b27-01.S | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.d.h_b28-01.S | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.d.h_b29-01.S | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.d_b1-01.S  | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.d_b22-01.S | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.d_b23-01.S | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.d_b24-01.S | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.d_b27-01.S | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.d_b28-01.S | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.d_b29-01.S | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.s_b1-01.S  | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.s_b22-01.S | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.s_b23-01.S | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.s_b24-01.S | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.s_b27-01.S | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.s_b28-01.S | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |
| fcvt.h.s_b29-01.S | [url](https://github.com/Pagerd/riscv-arch-test/blob/main/riscv-test-suite/rv32i_m/Zfh/src/) |



### Issue

- 在使用CTG新版本进行测试时发现isac中仍有inxFlag错误并提交相关issue[#95](https://github.com/riscv-software-src/riscv-isac/issues/95)

### 其他

- 协助对QEMU测试的拓展在ACT上是否支持进行了一个调研[QEMU](https://github.com/Pagerd/PLCT/blob/main/Report/week/week57/ACT_QEMU.md),并随后在主表格上进行了补充[Google Sheet](https://docs.google.com/spreadsheets/d/1ipYBVO5TWVI1L2Q_dCq6F5fycewLWgW7YvJwl51Wigk/edit?gid=1157775000#gid=1157775000)
- 由于对qemu测试需要修改RISCOF，调研了在非spike上进行ACT测试所需要的步骤并编写了一个初步文档[MD](https://github.com/Pagerd/PLCT/blob/main/Report/week/week57/ACT_HowToRunDut.md)