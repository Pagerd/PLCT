# 2024-9月

## Sail/ACT

#### Issue

- 在使用生成的`fcvt.s.h`测试用例进行测试时发现使用 TEST_FPSR_OP 尝试运行浮点测试用例时出现非法操作数的错误，而使用同函数相同参数的其他测试用例则无此问题，将此问题提交至[riscv-arch-test](https://github.com/riscv-non-isa/riscv-arch-test)仓库[#Issue498](https://github.com/riscv-non-isa/riscv-arch-test/issues/498)
- 使用CTG生成部分32H测试用例时发现其中字符串包含`rs0_nan_prefix`，而node节点中不包含此字符串，导致用例生成数据均为0，将此问题提交至[riscv-ctg](https://github.com/riscv-software-src/riscv-ctg)仓库[#Issue123](https://github.com/riscv-software-src/riscv-ctg/issues/123)
- 使用CTG生成flen小于iflen用例时，发现无法正常生成rsx_nan_prefix的数据，检查发现当flen小于iflen时结果为负数将无法正常生成数据，将此问题提交至[riscv-isac](https://github.com/riscv-software-src/riscv-isac)仓库[#Issue97](https://github.com/riscv-software-src/riscv-isac/issues/97)
- 尝试生成 RV32H 时出现 KeyError: 'inxFlag',将此问题提交至[riscv-isac](https://github.com/riscv-software-src/riscv-isac)仓库[#Issue95](https://github.com/riscv-software-src/riscv-isac/issues/95)(已关闭 [commit](https://github.com/riscv-software-src/riscv-isac/issues/95#issuecomment-2326689932)）

#### PR

| 仓库                                                         | 问题                                              | 链接                                                         |
| ------------------------------------------------------------ | ------------------------------------------------- | ------------------------------------------------------------ |
| [riscv-ctg](https://github.com/riscv-software-src/riscv-ctg) | 32h部分测试用例无法正常生成数据                   | [#pr119](https://github.com/riscv-software-src/riscv-ctg/issues/123) |
| [riscv-isac](https://github.com/riscv-software-src/riscv-isac) | 当 flen 小于 iflen 时，isac 无法生成 rs_nanprefix | [#pr98](https://github.com/riscv-software-src/riscv-isac/pull/98) |

#### 会议纪要

- 参加了9月9日的ACT会议，并编写了会议纪要[MD](https://github.com/Pagerd/PLCT/tree/main/Report/week//week59/ACT.md)
- 参加了9月24日的ACT会议，并编写了会议纪要[MD](https://github.com/Pagerd/PLCT/tree/main/Report/week//week61/ACT.md)

#### 其他

更新了如何在ACT上运行DUT[Dut](https://github.com/Pagerd/PLCT/tree/main/Report/week/week57/ACT_HowToRunDut.md)

对ACT上提交的pr[pr#483](https://github.com/riscv-non-isa/riscv-arch-test/pull/483)进行了后续更新[483zip](https://github.com/Pagerd/PLCT/tree/main/Report/week/week59/483),并由于CTG原因暂时关闭了此pr