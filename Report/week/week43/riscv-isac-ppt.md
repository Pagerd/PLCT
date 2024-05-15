---
marp: true
---

# ISA覆盖率提取工具：RISC-V ISAC
报告人：朱旭昌

---

## SAIL-RISCV简介

- Sail 是一种用于描述指令集架构的语言 （ISA） 处理器的语义。旨在提供工程师友好型、类似供应商伪代码的方式来描述指令语义。
- Sail-RiSCV是一个用Sail语言编写的RISC-V架构的形式化规范，基于此规范，我们可以编写与之相关的编译器，解释器，构建汇编文件，elf可执行文件，虚拟执行软件等

---

## RISCOF测试工具

- **RISCOF** 是RISC-V架构测试框架的缩写，它是一种用于验证RISC-V实现是否符合RISC-V规范的工具，目前覆盖了RISCV的多种扩展，同时RISCOF再验证ISA实现中使用了sail作为参照的Golden model。
- RISCOF的工作方式如下图所示

![RISCOF](../week37/img/riscof.png)

可以看到其中ISAC所扮演的行为

---

## RISCV ISAC

RISC-V ISAC 是一种 ISA 覆盖率提取工具。给定一组覆盖点以及在模型上运行的测试/应用程序的执行跟踪，ISAC 可以提供一份报告，详细指示测试/应用程序覆盖了哪些覆盖点。 ISAC 还能够对测试/应用程序中发生的数据传播提供详细的质量分析。

ISAC通过[Coverage Group Format](https://riscv-isac.readthedocs.io/en/latest/cgf.html) (CGF)的特殊yaml文件格式捕捉，CGF 文件通常由单个数据集节点和多个覆盖组组成。每个覆盖组可以为不同的指令集定义多个覆盖点。


![](https://riscv-isac.readthedocs.io/en/latest/_images/riscv-isac.png)

---



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

---

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

此时便可以使用接下来的isac功能

---

## 标准化CGF文件

ISAC的一个作用是标准化cgf文件

```
Usage: riscv_isac normalize [OPTIONS]
  Normalize the cgf.
Options:
  -c, --cgf-file PATH     Coverage Group File  [required]
  -o, --output-file PATH  Coverage Group File  [required]
  -x, --xlen [32|64]      XLEN value for the ISA.
  --help                  Show this message and exit.
```

---

例如在riscv-ctg仓库中，可以在预设cgf文件中使用如下代码

```
riscv_isac --verbose info normalize -c dataset.cgf -c rv64i.cgf -o normalized.cgf -x 32
```

随后出现normalized.cgf文件，该文件可以单独由risccv-ctg生成测试用例

```
riscv_ctg -v debug -d ./tests/ -r -cf ./sample_cgfs/normalized.cgf -bi rv64i -p2
```

此操作生成的测试用例文件与使用下列代码生成的测试用例相同

```
riscv_ctg -v debug -d ./tests/ -r -cf ./dataset.cgf -cf ./rv32i.cgf -bi rv32i -p2
```

---

### 计算测试的覆盖率

isac的另一个作用是使用给定的日志和 cgf 文件计算测试的覆盖率。

```
Usage: riscv_isac coverage [OPTIONS]
  Run Coverage analysis on tracefile.
Options:
  -e, --elf PATH                  ELF file
  -t, --trace-file PATH           Instruction trace file to be analyzed
  -c, --cgf-file PATH             Coverage Group File  [required]
  -d, --detailed                  Select detailed mode of  coverage printing
  --parser-name NAME              Parser plugin name
  --decoder-name NAME             Decoder plugin name
  --parser-path PATH              Parser file path
  --decoder-path PATH             Decoder file path
  -o, --output-file PATH          Coverage Group File
  --test-label LABEL_START LABEL_END
                                  Pair of labels denoting start and end points
                                  of the test region(s). Multiple allowed.
  --sig-label LABEL_START LABEL_END
                                  Pair of labels denoting start and end points
                                  of the signature region(s). Multiple
                                  allowed.
  --dump PATH                     Dump Normalized Coverage Group File
  -l, --cov-label COVERAGE LABEL  Coverage labels to consider for this run.
  -x, --xlen [32|64]              XLEN value for the ISA.
  --help                          Show this message and exit.
```

---

进行计算时需要解码器和解析器，ISAC附带以下标准插件


解析器插件：

- SAIL C 模型  `c_sail`：用于解析SAIL 生成的 C 模型的执行日志的解析器。
- SPIKE `spike`：来自 riscv-isa-sim 的执行日志的解析器。

解码器插件：

- Native Python Decoder `internaldecoder`：用 python 编写的 RISC-V isa 解码器。

注意：目前，使用 SPIKE 模型的覆盖率报告不准确，因为跟踪文件中未报告有缺陷的指令。建议使用 SAIL 模型进行准确的覆盖率报告。

---

对于使用ACT进行的测试，可以通过以下方式来进行计算

```
riscv_isac coverage -d -t add-01.log --parser-name c_sail 
--decoder-name internaldecoder -o coverage.rpt 
--sig-label begin_signature end_signature 
--test-label rvtest_code_begin rvtest_code_end 
-e add-01.elf -c dataset.cgf -c rv32i.cgf -x 32 -l add
```

该操作将会在目录下生成coverage.rpt报告

---

## 合并报告

isca可以将生成的不同覆盖率的报告合并到一个主报告中

```
Usage: riscv_isac merge [OPTIONS] [FILES]...
  Merge given coverage files.
Options:
  -d, --detailed          Select detailed mode of  coverage printing
  -c, --cgf-file PATH     Coverage Group File  [required]
  -o, --output-file PATH  Coverage Group File.
  --help                  Show this message and exit.
```

要使用该功能，在命令栏中输入如下指令即可

```
riscv_isac merge -c dataset.cgf -c rv32i.cgf -o merged_report 1.rpt 2.rpt 3.rpt
```

---

合并后的报告如下图所示

![](/1.png)

---

## 总结

RISC-V ISAC的覆盖率报告对于RISCOF测试有着至关重要的作用，因此掌握ISAC的使用对于RISCOF测试有着至关重要的作用。

