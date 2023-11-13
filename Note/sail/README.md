# Sail学习笔记

[Sail](https://www.cl.cam.ac.uk/~pes20/sail/) ( [repo](https://github.com/rems-project/sail) ) 是一种用于描述处理器指令集架构 (ISA) 语义的语言。Sail 旨在提供一种工程师友好的、类似供应商伪代码的语言来描述指令语义。它本质上是一种一阶命令式语言，但具有数字类型和位向量长度的轻量级依赖类型，可以使用 Z3 自动检查。

给定 Sail 定义，该工具将对它进行类型检查并生成 LaTeX 片段以在文档、可执行模拟器（C 和 OCaml 中）、Isabelle、HOL4 和 Coq 的定理证明器定义以及与我们的 RMEM 和 Coq 集成的定义中 [使用](http://www.cl.cam.ac.uk/users/pes20/rmem) 。 用于并发语义的[isla-公理](https://github.com/riscv/sail-riscv/blob/master/isla-axiomatic.cl.cam.ac.uk)工具。

## 构建Sail模型

在安装Sail模型前，需要安装Sail，而Sail可以通过opam进行安装

#### 安装Opam

Opam在不同的Linux发行版包管理器中均有对应的软件包可供直接下载，如在Ubuntu中

```
sudo apt-get install opam
```

或者可以通过脚本进行二进制编码的下载

```
bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"
```

也可在[Github](https://github.com/ocaml/opam/releases)中下载源码进行编译安装

在安装完成后需要检查ocaml版本，ocaml版本需要在 OCaml 4.08.1 或以上才可正常运行,如果不是最新版本，可以将版本更新到最新版

```
opam switch create 5.1.0
```

在检查完成后需要对opam进行初始化，在命令行中输入如下代码

```
eval $(opam config env)
```

#### 安装Sail

安装sail前需要安装以下依赖项

```
sudo apt-get install build-essential libgmp-dev z3 pkg-config zlib1g-dev
```

在安装完成后，即可使用opam进行sail的安装

```
opam install sail
```

#### 构建模型

首先下载riscv-sail仓库

```
https://github.com/riscv/sail-riscv.git
```

随后在仓库中进行make指令

```
make
```

C 和 OCaml 模拟器可用于执行小型测试二进制文件。OCaml 模拟器依赖于设备树编译器包，可以通过以下命令在 Ubuntu 中安装该包：

```
sudo apt-get install device-tree-compiler
```

随后便可以运行测试二进制文件

```
$ ./ocaml_emulator/riscv_ocaml_sim_<arch>  <elf-file>
$ ./c_emulator/riscv_sim_<arch> <elf-file>
```

[test/riscv-tests/](https://github.com/riscv/sail-riscv/blob/master/test/riscv-tests)[`riscv-tests`](https://github.com/riscv/riscv-tests)下包含从测试套件派生的一套 RV32 和 RV64 测试程序 。测试套件可以使用运行。`test/run_tests.sh`
