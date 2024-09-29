# 2024-9月

## Sail/ACT

#### Issue

| 仓库                                                         | 问题                                                         | 链接                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| [riscv-arch-test](https://github.com/riscv-non-isa/riscv-arch-test) | 使用 TEST_FPSR_OP 尝试运行浮点测试用例时出现非法操作数       | [#Issue498](https://github.com/riscv-non-isa/riscv-arch-test/issues/498) |
| [riscv-ctg](https://github.com/riscv-software-src/riscv-ctg) | 32h部分测试用例无法正常生成数据                              | [#Issue123](https://github.com/riscv-software-src/riscv-ctg/issues/123) |
| [riscv-isac](https://github.com/riscv-software-src/riscv-isac) | 当 flen 小于 iflen 时，isac 无法生成 rs_nanprefix            | [#Issue97](https://github.com/riscv-software-src/riscv-isac/issues/97) |
| [riscv-isac](https://github.com/riscv-software-src/riscv-isac) | 尝试生成 RV32H 时出现 KeyError: 'inxFlag'(已关闭 [commit](https://github.com/riscv-software-src/riscv-isac/issues/95#issuecomment-2326689932)） | [#Issue95](https://github.com/riscv-software-src/riscv-isac/issues/95) |

#### PR

| 仓库                                                         | 问题                                              | 链接                                                         |
| ------------------------------------------------------------ | ------------------------------------------------- | ------------------------------------------------------------ |
| [riscv-ctg](https://github.com/riscv-software-src/riscv-ctg) | 32h部分测试用例无法正常生成数据                   | [#pr119](https://github.com/riscv-software-src/riscv-ctg/issues/123) |
| [riscv-isac](https://github.com/riscv-software-src/riscv-isac) | 当 flen 小于 iflen 时，isac 无法生成 rs_nanprefix | [#pr98](https://github.com/riscv-software-src/riscv-isac/pull/98) |

#### 会议纪要

- 参加了9月9日的ACT会议，并编写了会议纪要[MD](./week59/ACT.md)
- 参加了9月24日的ACT会议，并编写了会议纪要[MD](./week61/ACT.md)

#### 其他

更新了如何在ACT上运行DUT[Dut](https://github.com/Pagerd/PLCT/tree/main/Report/week/week57/ACT_HowToRunDut.md)

对ACT上提交的pr[pr#483](https://github.com/riscv-non-isa/riscv-arch-test/pull/483)进行了后续更新[483zip](https://github.com/Pagerd/PLCT/tree/main/Report/week/week59/483),并由于CTG原因暂时关闭了此pr