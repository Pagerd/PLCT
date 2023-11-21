# RISCOF学习笔记

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

C 和 OCaml 模拟器可用于执行小型测试二进制文件。OCaml 模拟器依赖于设备树编译器包，可以通过以下命令在 Ubuntu 中安装该包：

```
sudo apt-get install device-tree-compiler
```

随后通过仓库中包含的make指令进行编译

```
bash build_simulators.sh
```

等待编译完成后，即可在对应c_emulator文件夹内看见riscv_sim_RV32和riscv_sim_RV64两个模拟器

将模拟器路径添加至PATH中即可

## RISCOF的安装与搭建

RISCOF是一个对RISCV进行测试的框架，本质上是一个python脚本，因此安装较为简单

#### 安装RISCOF

从官方仓库中克隆项目

```
git clone https:github.com/riscv/riscvof.git
```

随后进入项目，使用pip进行安装,由于后续开发需要，因此加上editable参数

```
cd riscof
pip3 install --editable .
```

### RISCV-GNU-TOOLCHAIN的安装

riscv-gnu-toolchain是riscof所必须的测试工具。在官方仓库下安装即可

#### 安装依赖

使用自带包管理器进行安装即可

```
sudo apt-get install autoconf automake curl python3 libmpc mpfr gmp gawk base-devel bison flex texinfo gperf libtool pathcutils bc zlib expat
```

#### 安装riscv-gnu-toolchain

从官方仓库拉去代码

```
git clone --recursive http://github.com/riscv/riscv-gnu-toolchain.git
```

然后进行make安装

```
./configure --perfix=/paht/to/install
make
```

需要将/path/to/install/bin加入PATH环境变量

### RISCV-ISA-SIM的安装

riscv-isa-sim（spike）为被测试的模拟器，sail作为结果参照的模拟器

```
sudo install dtc
git clone https://github.com/riscv-spftware-src/riscv-isa-sim.git
cd riscv-isa-sim
mkdir build
cd build
../configure --prefix=/path/to/install
make
make install
```

同时也需要将/path/to/install/bin加入PATH环境变量

### 执行测试样例

在安装完成后，新建文件夹进行初始化文件配置即可

```
riscof setup --dutname=spike
```

新建完成后，会在当前目录下生成一个config.ini以及一个spike和sail_cSim文件夹

spike文件夹中有两个yaml文件：spike_isa.yaml和spike_platform.yaml,默认配置为32位，若需要修改为64为，需要将spike_isa.yaml进行修改

```
hart_ids:[0]
hart0:
  ISA:RV64IMCZicsr_Zifencei
  physical_addr_sz:56
  User_Spec_Version:'2.3'
  supported_xlen:[64]
```

随后需要从官方仓库中拉去测试用例

```
riscof --verbose info arch-test --clone
```

随后会在当前目录下生成riscv-arch-tests目录，随后便可以输入命令运行测试并进行分析

```
riscof run --config=config.ini --suite=riscv-arch-test/riscv-test-suite/ --env=riscv-arch-test/riscv/test-suite/env
```

随后等待测试结束，会自动生成html形式的测试报告并自动打开s
