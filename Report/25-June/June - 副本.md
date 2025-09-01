## 本月工作

### 会议

- 参加了6月2日的ACT会议并写了会议纪要[MD](https://github.com/Pagerd/PLCT/blob/main/Report/week/week85/ACT.md)

- 参加了6月30日的ACT会议并写了会议纪要[MD](https://github.com/Pagerd/PLCT/blob/main/Report/week/week87/ACT.md)

### Sail/ACT

- 提交了一个关于两个仓库插件不同步导致riscof无法正常实现的bug[#671](https://github.com/riscv-non-isa/riscv-arch-test/issues/671)
- 更新了提交RV32 Zfinx的测试用例的pr[#638](https://github.com/riscv-non-isa/riscv-arch-test/pull/638)
- 更新了修复zdinx错误的测试用例的pr[#651](https://github.com/riscv-non-isa/riscv-arch-test/pull/651)
- 更新了提交RV64 Zdinx的测试用例的pr[#654](https://github.com/riscv-non-isa/riscv-arch-test/pull/654)

- 提交了暂时同步RISCOF仓库中的riscof插件的pr[#142](https://github.com/riscv-software-src/riscof/pull/142)
- 提交了修复请求内存过多的issue的pr并成功合并[#662](https://github.com/riscv-non-isa/riscv-arch-test/pull/662)

| 更新测试指令名 | 所属拓展 | 测试用例数 | 地址                                                         |
| -------------- | -------- | ---------- | ------------------------------------------------------------ |
| fadd.d         | Zdinx    | 11         | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fclass.d       | Zdinx    | 1          | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fdiv.d         | Zdinx    | 11         | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| feq.d          | Zdinx    | 2          | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fle.d          | Zdinx    | 2          | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| flt.d          | Zdinx    | 2          | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fmadd.d        | Zdinx    | 62         | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fmadd-b11  | zfinx    | 13             | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fmsub-b11  | zfinx    | 13             | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
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
| fadd-b11   | zfinx    | 5              | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| fsub-b11   | zfinx    | 5              | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| vclmul.vv  | Zvk      | 1              | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| vclmul.vx  | Zvk      | 1              | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| vclmulh.vv | Zvk      | 1              | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |
| vclmulh.vx | Zvk      | 1              | [github](https://github.com/riscv-non-isa/riscv-arch-test/tree/dev/riscv-test-suite/rv32i_m/Zfinx/src) |


### 其他

- 编写了玄铁课程ppt : 在Licheepi 4A上运行[Deepseek.ppt]((https://github.com/Pagerd/PLCT/blob/main/Report/25-June/runningDeepseek.pptx))




- 提交了一个修复rv 32 Zdinx测试错误的bug的pr[#651](https://github.com/riscv-non-isa/riscv-arch-test/pull/651)
- 为ACT添加缺失的rv64 Zdinx fmadd.d/fmsub.d共330个测试用例[#654](https://github.com/riscv-non-isa/riscv-arch-test/pull/654)

| 测试指令名 | 所属拓展 | 测试用例数 | 地址                                                         |
| ---------- | -------- | ---------- | ------------------------------------------------------------ |


