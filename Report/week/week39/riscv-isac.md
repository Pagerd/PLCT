# ISA覆盖率提取工具：RISC-V ISAC

## SAIL-RISCV简介

- Sail 是一种用于描述指令集架构的语言 （ISA） 处理器的语义。旨在提供工程师友好型、类似供应商伪代码的方式来描述指令语义。
- Sail-RiSCV是一个用Sail语言编写的RISC-V架构的形式化规范，基于此规范，我们可以编写与之相关的编译器，解释器，构建汇编文件，elf可执行文件，虚拟执行软件等

## RISCOF测试工具

- **RISCOF** 是RISC-V架构测试框架的缩写，它是一种用于验证RISC-V实现是否符合RISC-V规范的工具，目前覆盖了RISCV的多种扩展，同时RISCOF再验证ISA实现中使用了sail作为参照的Golden model。
- RISCOF的工作方式如下图所示

![RISCOF](../week37/img/riscof.png)

可以看到其中ISAC所扮演的行为

## RISCV ISAC

RISC-V ISAC 是一种 ISA 覆盖率提取工具。给定一组覆盖点以及在模型上运行的测试/应用程序的执行跟踪，ISAC 可以提供一份报告，详细指示测试/应用程序覆盖了哪些覆盖点。 ISAC 还能够对测试/应用程序中发生的数据传播提供详细的质量分析。

ISAC通过[Coverage Group Format](https://riscv-isac.readthedocs.io/en/latest/cgf.html) (CGF)的特殊yaml文件格式捕捉，CGF 文件通常由单个数据集节点和多个覆盖组组成。每个覆盖组可以为不同的指令集定义多个覆盖点。







## 安装ISAC

从官方github仓库克隆代码

```
$ git clone https://github.com/riscv/riscv-isac
```

获得源代码副本后，使用pip3进行安装

考虑到后续开发调试修改，这里添加editable参数

```
$ cd riscv_isac
$ pip3 install --editable .
```

此时在终端输入`riscv_isac --help`应当显示如下内容

```
Options:
   --version                       Show the version and exit.
   -v, --verbose [info|error|debug]
                                   Set verbose level
   --help                          Show this message and exit.

Commands:
  coverage   Run Coverage analysis on tracefile.
  merge      Merge given coverage files.
  normalize  Normalize the cgf.
```





