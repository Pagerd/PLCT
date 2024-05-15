# SAIL和ACT

## sail简介

Sail 是一种用于描述指令集架构的语言 （ISA） 处理器的语义。旨在提供工程师友好型、类似供应商伪代码的方式来描述指令语义。它本质上是一阶命令语言，但包含数值类型和位向量长度。Sail 被用于多个 ISA 描述，包括 Armv8-A 顺序行为的基本完整版本、RISC-V、MIPS、CHERI-RISC-V 和 CHERI-MIPS;所有这些ISA都是完备的足以启动各种操作系统。还有针对 IBM POWER 和 x86 较小片段的 Sail 模型。

![](https://camo.githubusercontent.com/ce83c2d5e31f7eb3cf307e929abbc675ecf82a974a82d908a7a20b2e940b10a1/68747470733a2f2f7777772e636c2e63616d2e61632e756b2f7e70657332302f7361696c2f6f766572766965772d7361696c2e706e673f)

## SAIL-RISCV

Sail-RiSCV是一个用Sail语言编写的RISC-V架构的形式化规范，基于此规范，我们可以编写与之相关的编译器，解释器，构建汇编文件，elf可执行文件，虚拟执行软件等,该模型规定了指令的汇编语言格式、相应的编码器和解码器以及指令语义。

## ACT测试

ACT是RISC-V Architecture Test SIG 对RISC-V 基础架构的一套测试，旨在帮助确保为给定 RISC-V 配置文件/规范编写的软件能够在符合该配置文件的所有实现上运行。ACT测试还有助于确保实施者正确理解并实施了规范。

ACT是一个最小的过滤器。通过ACT测试并获得 RISC-V International 批准的结果是获得 RISC-V 商标许可的先决条件。通过 RISC-V ACT测试并不意味着设计符合 RISC-V 架构。ACT只是一组基本的测试，ACT测试主要检查规范的重要问题，而不关注细节。

ACT测试主要使用名叫RISCOF的测试框架进行测试

## RISCOF

RISCOF是RISC-V架构测试框架的缩写，它是一种用于验证RISC-V实现是否符合RISC-V规范的工具。RISCOF使用RISCV-CONFIG来选择和配置测试，目前覆盖了RV[32|64]IMCFD_Zb*_zK*_Zmmul_Zicsr_Zifencei等多种扩展。同时在验证ISA实现中使用sail作为参照的Golden model 。RISCOF的目标是提高测试的可重用性、可移植性和可扩展性，以适应RISC-V生态系统的多样性和快速发展。

下图为RISCOF的运作方式

![](https://riscof.readthedocs.io/en/latest/_images/riscof.png)

测试小队已为SAIL和ACT相关仓库贡献了数个issue和pr，在完善SAIL ACT测试方面做出了自己的一份贡献.