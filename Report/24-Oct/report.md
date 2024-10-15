### PR提交

| 仓库                                                         | 问题                                                    | 链接                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------- | ------------------------------------------------------------ |
| [riscv-ctg](https://github.com/riscv-software-src/riscv-ctg) | 解决了32h部分测试用例无法正常生成数据                   | [#pr119](https://github.com/riscv-software-src/riscv-ctg/issues/123) |
| [riscv-isac](https://github.com/riscv-software-src/riscv-isac) | 解决了当 flen 小于 iflen 时，isac 无法生成 rs_nanprefix | [#pr98](https://github.com/riscv-software-src/riscv-isac/pull/98) |
| [riscv-arch-test](https://github.com/riscv-non-isa/riscv-arch-test) | 添加了fcvt缺失的四个指令                                | [pr#483](https://github.com/riscv-non-isa/riscv-arch-test/pull/483 ) |
| [riscv-isac](https://github.com/riscv-software-src/riscv-isac) | 添加了iasc ibm 16bit的支持                              | [#pr9](https://github.com/riscv-software-src/riscv-isac/pull/9) |

### Issue

- 在使用CTG新版本进行测试时发现isac中仍有inxFlag错误并提交相关issue[#95](https://github.com/riscv-software-src/riscv-isac/issues/95)
- 在使用生成的`fcvt.s.h`测试用例进行测试时发现出现非法操作数错误[#Issue498](https://github.com/riscv-non-isa/riscv-arch-test/issues/498)
- 使用CTG生成部分32H测试用例时发现字符串生成错误,将此问题提交至[#Issue123](https://github.com/riscv-software-src/riscv-ctg/issues/123)
- 使用CTG生成flen小于iflen用例时，发现无法正常生成rsx_nan_prefix的数据[#Issue97](https://github.com/riscv-software-src/riscv-isac/issues/97)
- 在Sail Issue [#169](https://github.com/riscv/sail-riscv/issues/169)中提交了一个[commit](https://github.com/riscv/sail-riscv/issues/169#issuecomment-2160190360)，协助进行issue的关闭
- 在Sail-RISCV仓库中 `pmpcfg 允许非法值 R=0, W=1`问题下进行了讨论，并协助跟进解决关闭此issue [#296](https://github.com/riscv/sail-riscv/issues/296#issuecomment-2175539444)

### 文档调研

- 协助对QEMU测试的拓展在ACT上是否支持进行了一个调研[QEMU](https://github.com/Pagerd/PLCT/blob/main/Report/week/week57/ACT_QEMU.md),并协助维护了当前Sail Spike ACT对RV拓展的支持文档[Google Sheet](https://docs.google.com/spreadsheets/d/1ipYBVO5TWVI1L2Q_dCq6F5fycewLWgW7YvJwl51Wigk/edit?gid=1157775000#gid=1157775000)
- 调研了在非spike上进行ACT测试所需要的步骤并编写了一个文档[MD](https://github.com/Pagerd/PLCT/blob/main/Report/week/week57/ACT_HowToRunDut.md)
- 调研了RISCV D拓展的定义并在sail中如何实现 [文档](https://github.com/Pagerd/PLCT/tree/main/Note/sail/D-TYPE.md)
- 调研了RISCV C拓展的定义并在sail中如何实现 [文档](https://github.com/Pagerd/PLCT/tree/main/Note/sail/C-TYPE.md)
- 调研了测试工具RISCV-ISAC,并编写了调研文档 [文档](https://github.com/Pagerd/PLCT/tree/main/Report/week/week43/riscv-isac.md)
- 调研了测试工具YAML配置工具RISCV-config,并编写了调研文档 [文档](https://github.com/Pagerd/PLCT/tree/main/Report/week/week45/riscv-config.md)
