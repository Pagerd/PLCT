# RISCV-Config

## SAIL-RISCV简介

- Sail 是一种用于描述指令集架构的语言 （ISA） 处理器的语义。旨在提供工程师友好型、类似供应商伪代码的方式来描述指令语义。
- Sail-RiSCV是一个用Sail语言编写的RISC-V架构的形式化规范，基于此规范，我们可以编写与之相关的编译器，解释器，构建汇编文件，elf可执行文件，虚拟执行软件等

## RISCV-Config

- **RISCV-Config**（RISCV 配置合法化器）是一个基于 YAML 的框架，可用于根据 RISC-V 特权和非特权 ISA 规范验证 RISC-V 实现的规范并生成标准规范 yaml 文件。

![riscv_config-flow](D:\Work\PLCT\PLCT\Report\week\week44\riscv_config-flow.png)

用户需要提供 2 个 YAML 文件作为输入：

1. **ISA 规范**：此 YAML 文件用于捕获用户实现的 ISA 相关功能。此输入文件的详细信息可在此处找到：[ISA YAML 规范](https://riscv-config.readthedocs.io/en/stable/yaml-specs.html#isa-yaml-spec)。
2. **平台规范**：此 YAML 文件用于捕获用户实现的平台特定功能。此输入文件的详细信息可在此处找到：[平台 YAML 规范](https://riscv-config.readthedocs.io/en/stable/yaml-specs.html#platform-yaml-spec)。

## 安装ISAC

从官方github仓库进行安装

```
$ git clone https://github.com/riscv/riscv-config.git
$ cd riscv_config
$ pip3 install -r requirements.txt
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

此时便可以使用接下来的isac功能

## 使用方法

从官方riscvctg下example为例

执行以下操作

```
 riscv-config -ispec examples/rv32i_isa.yaml -pspec examples/rv32i_platform.yaml
```

此时控制台应显示以下内容

```
[INFO]    : Input-ISA file
[INFO]    : Loading input file: /scratch/git-repo/github/riscv-config/examples/rv32i_isa.yaml
[INFO]    : Load Schema /scratch/git-repo/github/riscv-config/riscv_config/schemas/schema_isa.yaml
[INFO]    : Initiating Validation
[INFO]    : No Syntax errors in Input ISA Yaml. :)
[INFO]    : Initiating post processing and reset value checks.
[INFO]    : Dumping out Normalized Checked YAML: /scratch/git-repo/github/riscv-config/riscv_config_work/rv32i_isa_checked.yaml
[INFO]    : Input-Platform file
[INFO]    : Loading input file: /scratch/git-repo/github/riscv-config/examples/rv32i_platform.yaml
[INFO]    : Load Schema /scratch/git-repo/github/riscv-config/riscv_config/schemas/schema_platform.yaml
[INFO]    : Initiating Validation
[INFO]    : No Syntax errors in Input Platform Yaml. :)
[INFO]    : Dumping out Normalized Checked YAML: /scratch/git-repo/github/riscv-config/riscv_config_work/rv32i_platform_checked.yaml
```



## YAML文件规范

### Vendor

> - **描述**：捕获供应商名称的字符串。
>
> - **例子**：
>
>   ```
>   Vendor: Shakti
>   Vendor: Incoresemi
>   ```

### Device

> - **描述**：捕获设备名称的字符串。
>
> - **例子**：
>
>   ```
>   Device: E-Class
>   Device: C-Class
>   ```

###  ISA

> - **描述**：输入一个表示实现支持的 ISA 的字符串。所有扩展名（Zext 除外）都应大写。Z 扩展名应以大写“Z”开头，后跟小写扩展名（不使用 Camel 大小写）
>
> - **默认值**：这是用户必须设置的必填字段。不存在默认值。
>
> - **限制**：
>
>   > - 某些扩展仅在某些用户规范版本中有效。例如，Zifencei 仅在用户规范 2.3 及以上版本中可用。
>   > - ISA 字符串必须按照规范中提到的约定指定（例如后续的 Z 扩展必须用“_”分隔）
>
> - **例子**：
>
>   ```
>   ISA: RV32IMA
>   ISA: RV64IMAFDCZifencei
>   ```

### User_Spec_Version

> - **描述**：用户/非特权 ISA 规范的版本号（字符串）。请将版本括在“”中以避免类型不匹配。
>
> - **默认值**：2.2
>
> - **限制**：应为 2.2 以上有效版本
>
> - **例子**：
>
>   ```
>   User_Spec_Version: "2.2"
>   User_Spec_Version: "2.3"
>   ```

### Privilege_Spec_Version

> - **描述**：特权 ISA 规范的版本号（字符串形式）。请将版本括在“”中以避免类型不匹配。
>
> - **默认值**：“1.10”
>
> - **限制**：应为 1.10 以后的有效版本
>
> - **例子**：
>
>   ```
>   Privilege_Spec_Version: "1.10"
>   Privilege_Spec_Version: "1.11"
>   ```

###  hw_data_misaligned_support

> - **描述**：一个布尔值，指示硬件是否支持未对齐的加载/存储请求。
>
> - **默认值**：False
>
> - **限制**：无
>
> - **例子**：
>
>   ```
>   hw_data_misaligned_support: True
>   hw_data_misaligned_support: False
>   ```

### supported_xlen

> - **描述**：目标上支持的 xlen 列表
>
> - **默认值**：这是用户必须设置的必填字段。不存在默认值。
>
> - **约束**：列表应包括以下整数：32、64 和/或 128。但是 XLEN=128 不完全受支持。
>
> - **例子**：
>
>   ```
>   supported_xlen : [32]
>   supported_xlen : [64, 32]
>   supported_xlen : [64]
>   ```

### pmp_granularity

> - **描述**：pmps 的粒度
>
> - **默认值**： 0
>
> - **限制**：无
>
> - **例子**：
>
>   ```
>   pmp_granularity : 2
>   pmp_granularity : 4
>   ```

### physical_addr_sz

> - **描述**：物理地址的大小
>
> - **默认值**：这是用户必须设置的必填字段。不存在默认值。
>
> - **限制**：不能超过 56 位
>
> - **例子**：
>
>   ```
>   physical_addr_sz : 32
>   ```

### custom_exceptions

> - **描述**：设备实现的自定义异常字典。字典中的每个节点包含 3 个字段：
>
>   > - cause_val：表示与该异常相关的原因值的整数。不能是保留的原因值。
>   > - cause_name：包含异常名称的字符串
>   > - priv_mode：包含 M、S 或 U 之一的字符串，表示与异常相关的特权模式。
>
> - **默认值**：空字典，表示不存在自定义异常。
>
> - **限制**：cause_val 中不能使用保留编码
>
> - **例子**：
>
>   ```
>   custom_exceptions:
>     - cause_val: 25
>       cause_name: mycustom
>       priv_mode: M
>     - cause_val: 26
>       cause_name: mycustom2
>       priv_mode: M
>   ```

### custom_interrupts

> - **描述**：设备实现的自定义中断字典。字典中的每个节点包含 4 个字段：
>
>   > - cause_val：表示与该中断关联的原因值的整数。不能是保留的原因值。
>   > - cause_name：包含中断名称的字符串
>   > - priv_mode：包含 M、S 或 U 之一的字符串，表示与异常相关的特权模式。
>   > - on_reset_enable：一个整数，为0或1，表示复位时是否使能中断。
>
> - **默认值**：空字典，表示不存在自定义异常。
>
> - **限制**：cause_val 中不能使用保留编码
>
> - **例子**：
>
>   ```
>   custom_interrupts:
>     - cause_val: 25
>       cause_name: mycustom
>       priv_mode: M
>       on_reset_enable: 1
>     - cause_val: 26
>       cause_name: mycustom2
>       priv_mode: S
>       on_reset_enable: 0
>   ```

###  pte_ad_hw_update

> - **描述**：这是一个布尔字段，表示当访问虚拟页面且 A 位清除时，或者写入虚拟页面且 D 位清除时，实现会在硬件本身的 PTE 中设置相应位，并且不会针对此特定场景引发异常。设置为 False 时，需要引发相应的页面错误异常。
>
> - **默认值**：False
>
> - **约束**：仅当 ISA 中实现了“S”模式并且 stap.mode 可以设置为虚拟化模式之一时，才可以设置为 True。
>
> - **例子**：
>
>   ```
>   pte_ad_hw_update: False
>   pte_ad_hw_update: True
>   ```

###  mtval_update

> - **描述**：此字段基本上是一个位图。如果设置了位n ，则表示当发生与原因n对应的异常时，设备将使用非零值更新 mtval CSR 。零值表示异常n将使用值 0 更新 mtval。
>
> - **默认值**：255（设置为异常原因值 0-7）
>
> - **限制**：
>
>   - 保留位 [10、11、16-23、32-47、>=64] 必须始终为零
>   - 仅当实现“S”模式时，才可以设置与页面错误相对应的位
>   - 仅当实现“H”模式时，才能设置与客户页面错误相对应的位
>
> - **例子**：
>
>   ```
>   mtval_update: 0b1110
>   ```
