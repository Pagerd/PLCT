### PR提交

| 仓库                                                         | 问题                                                    | 链接                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------- | ------------------------------------------------------------ |
| [riscv-ctg](https://github.com/riscv-software-src/riscv-ctg) | 解决了32h部分测试用例无法正常生成数据                   | [#pr119](https://github.com/riscv-software-src/riscv-ctg/issues/123) |
| [riscv-isac](https://github.com/riscv-software-src/riscv-isac) | 解决了当 flen 小于 iflen 时，isac 无法生成 rs_nanprefix | [#pr98](https://github.com/riscv-software-src/riscv-isac/pull/98) |
| [riscv-arch-test](https://github.com/riscv-non-isa/riscv-arch-test) | 添加了fcvt缺失的四个指令                                | [pr#483](https://github.com/riscv-non-isa/riscv-arch-test/pull/483 ) |

### Issue

- 在使用CTG新版本进行测试时发现isac中仍有inxFlag错误并提交相关issue[#95](https://github.com/riscv-software-src/riscv-isac/issues/95)
- 在使用生成的`fcvt.s.h`测试用例进行测试时发现出现非法操作数错误[#Issue498](https://github.com/riscv-non-isa/riscv-arch-test/issues/498)
- 使用CTG生成部分32H测试用例时发现字符串生成错误,将此问题提交至[#Issue123](https://github.com/riscv-software-src/riscv-ctg/issues/123)
- 使用CTG生成flen小于iflen用例时，发现无法正常生成rsx_nan_prefix的数据[#Issue97](https://github.com/riscv-software-src/riscv-isac/issues/97)
- 在Sail Issue [#169](https://github.com/riscv/sail-riscv/issues/169)中提交了一个[commit](https://github.com/riscv/sail-riscv/issues/169#issuecomment-2160190360)，协助进行issue的关闭
- 在Sail-RISCV仓库中 `pmpcfg 允许非法值 R=0, W=1`问题下进行了讨论，并协助跟进解决关闭此issue [#296](https://github.com/riscv/sail-riscv/issues/296#issuecomment-2175539444)
