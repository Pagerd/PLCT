# RISCV-Config

## SAIL-RISCV简介

- Sail 是一种用于描述指令集架构的语言 （ISA） 处理器的语义。旨在提供工程师友好型、类似供应商伪代码的方式来描述指令语义。
- Sail-RiSCV是一个用Sail语言编写的RISC-V架构的形式化规范，基于此规范，我们可以编写与之相关的编译器，解释器，构建汇编文件，elf可执行文件，虚拟执行软件等

## RISCOF中RISCV-Config的作用

RISCOF的主要结果如下图所示

![riscv_config-flow](https://riscof.readthedocs.io/en/stable/_images/riscof.png)

可以看到，riscof要求用户提供 符合规范的yaml文件 并由riscv-config生成规范化的文件用于后续测试



## RISCV-Config

- **RISCV-Config**（RISCV 配置合法化器）是一个基于 YAML 的框架，可用于根据 RISC-V 特权和非特权 ISA 规范验证 RISC-V 实现的规范并生成标准规范 yaml 文件。

![riscv_config-flow](https://github.com/Pagerd/PLCT/blob/main/Report/week/week44/riscv_config-flow.png)

用户需要提供 2 个 YAML 文件作为输入：

1. **ISA 规范**：此 YAML 文件用于捕获用户实现的 ISA 相关功能。
2. **平台规范**：此 YAML 文件用于捕获用户实现的平台特定功能。

## 安装及使用

从官方github仓库进行安装

```
$ git clone https://github.com/riscv/riscv-config.git
$ cd riscv_config
$ pip3 install -r requirements.txt
```

此时在终端输入`riscv_isac --help`应当显示如下内容

```
riscv_config [-h] [--version] [--isa_spec YAML] [--platform_spec YAML]
                    [--work_dir DIR] [--verbose]

RISC-V Configuration Validator

optional arguments:
  --isa_spec YAML, -ispec YAML
                        The YAML which contains the ISA specs.
  --platform_spec YAML, -pspec YAML
                        The YAML which contains the Platfrorm specs.
  --verbose             debug | info | warning | error
  --version, -v         Print version of RISCV-CONFIG being used
  --work_dir DIR        The name of the work dir to dump the output files to.
  -h, --help            show this help message and exit
```

此时即安装完成

## 使用方法

以 riscv-config提供的examples文件为例

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

随后在工作区域内，即可看见以下两个文件

```
rv32i_isa_checked.yaml
rv32i_platform_checked.yaml
```

此即为后续riscof测试所需要的yaml文件

## YAML文件规范

riscv-config所需要的两个文件

1. **ISA 规范**：此 YAML 文件用于捕获用户实现的 ISA 相关功能。
2. **平台规范**：此 YAML 文件用于捕获用户实现的平台特定功能。

以example下rv32i_isa.yaml为例，打开文件，其中最头部显示以下内容

```
hart_ids: [0]
hart0: &hart0
  ISA: RV32IMAFCNSHUZicsr_Zifencei_Zbpbo_Zpn_Zpsf //输入一个表示实现支持的 ISA 的字符串。
  User_Spec_Version: '2.3'  //用户/非特权 ISA 规范的版本号
  supported_xlen: [32]   //目标上支持的 xlen 列表
  physical_addr_sz: 32  //物理地址的大小
  pmp_granularity: 5  //pmp粒度大小
...........
```

实际上还有一些其余的配置项可以添加

```
Vendor: Shakti  //供应商名称的字符串。
Device: E-Class //设备名称的字符串。
Privilege_Spec_Version: "1.10"  //特权 ISA 规范的版本号（字符串形式）。
hw_data_misaligned_support: True  //硬件是否支持未对齐的加载/存储请求。
```

随后便是CSR定义，所有 csrs 均使用通用模板定义，共分为两个模板：带子字段的 csrs 和不带子字段的 csrs

带子字段的 csrs 

```
<name>:                                   # 名称
  description: <text>                     # csr的文字描述
  address: <hex>                          # csr 地址
  priv_mode: <D/M/H/S/U>                  # 寄存器的特权模式
  reset-val: <hex>                        # 寄存器的复位值，积累子字段的所有重置值   
  rv32:                                   # 如果 [M/S/U]XL 值可以为1,则该节点及其后续字段可以存在
    accessible: <boolean>                 # 指示 csr 是否可以在 rv32 模式下访问。当为False时，下面的所有字段都将被无视
    fields:                               # csr 所有字段列表的快速摘要，包括 csr 的 WPRI 字段列表。
      - <field_name1>
      - <field_name2>
      - - [23,30]                         # 包含 csr 中所有 WPRI 位压缩对（形式为 [lsb,msb]）的列表。如果没有 WPRI 位，则不存在
        - 6

    <field_name1>:                        # 字段名称
      description: <text>                 # csr的文字描述
      shadow: <csr-name>::<field>         # 此字段会遮蔽的内容，'none' 表示此字段不会遮蔽任何内容。
      msb: <integer>                      # 字段的 msb 索引。最大值：31，最小值：0
      lsb: <integer>                      # 字段的 lsb 索引。最大值：31，最小值：0
      implemented: <boolean>              # 表示用户是否已实现此字段。如果为 False，则此字段下方的所有字段都将被删除。
      type:                               # 字段类型,只能为wlrl或warl
        wlrl: [list of value-descriptors] 
        ro_constant: <hex>                
        ro_variable: True                 
                                          
        warl:                             
          dependency_fields: [list]
          legal: [list of warl-string]
          wr_illegal: [list of warl-string]
  rv64:                                   # 如果 [M/S/U]XL 值可以为1,则该节点及其后续字段可以存在
    accessible: <boolean>                 # 指示 csr 是否可以在 rv64 模式下访问。当为False时，下面的所有字段都将被无视
  rv128:                                  # 如果 [M/S/U]XL 值可以为1,则该节点及其后续字段可以存在
    accessible: <boolean>                 # 指示 csr 是否可以在 rv128 模式下访问。当为False时，下面的所有字段都将被无视
```

### 没有子字段的 CSR

```
<name>:                                   # 名称
  description: <text>                     # csr的文字描述
  address: <hex>                          # csr 地址
  priv_mode: <D/M/H/S/U>                  # 寄存器的特权模式
  reset-val: <hex>                        # 寄存器的复位值，积累子字段的所有重置值   
  rv32:                                   # 如果 [M/S/U]XL 值可以为1,则该节点及其后续字段可以存在
    accessible: <boolean>                 # 指示 csr 是否可以在 rv32 模式下访问。当为False时，下面的所有字段都将被无视
    fields: []                            # 应该为空
    shadow: <csr-name>::<field>           # 此字段会遮蔽的内容，'none' 表示此字段不会遮蔽任何内容。
      msb: <integer>                      # 字段的 msb 索引。最大值：31，最小值：0
      lsb: <integer>                      # 字段的 lsb 索引。最大值：31，最小值：0
    type:                               # 字段类型,只能为wlrl或warl
        wlrl: [list of value-descriptors] 
        ro_constant: <hex>                
        ro_variable: True                 
                                          
        warl:                             
          dependency_fields: [list]
          legal: [list of warl-string]
          wr_illegal: [list of warl-string]
  rv64:                                   # 如果 [M/S/U]XL 值可以为1,则该节点及其后续字段可以存在
    accessible: <boolean>                 # 指示 csr 是否可以在 rv64 模式下访问。当为False时，下面的所有字段都将被无视
  rv128:                                  # 如果 [M/S/U]XL 值可以为1,则该节点及其后续字段可以存在
    accessible: <boolean>                 # 指示 csr 是否可以在 rv128 模式下访问。当为False时，下面的所有字段都将被无视
```





以mtvec 为例

```
mtvec:
reset-val: 0x80010000
rv32:
  accessible: true
  base:
    implemented: true
    type:
      warl:
        dependency_fields: [mtvec::mode]
        legal:
          - "mode[1:0] in [0] -> base[29:0] in [0x20000000, 0x20004000]"  
          - "mode[1:0] in [1] -> base[29:6] in [0x000000:0xF00000] base[5:0] in [0x00]" 
        wr_illegal:
          - "mode[1:0] in [0] -> Unchanged"
          - "mode[1:0] in [1] && writeval in [0x2000000:0x4000000] -> 0x2000000"
          - "mode[1:0] in [1] && writeval in [0x4000001:0x3FFFFFFF] -> Unchanged"
  mode:
    implemented: true
    type:
      warl:
        dependency_fields: []
        legal:
          - "mode[1:0] in [0x0:0x1] # Range of 0 to 1 (inclusive)"
        wr_illegal:
          - "Unchanged"
```

在riscv-config 对上述模板进行相关检查后输出的文件中：

```
mtvec:
  description: MXLEN-bit read/write register that holds trap vector configuration.
  address: 773
  priv_mode: M
  reset-val: 0x80010000
  rv32:
    accessible: true
    base:
      implemented: true
      type:
        warl:
          dependency_fields: [mtvec::mode, writeval]
          legal:
          - 'mode[1:0] in [0] -> base[29:0] in [0x20000000, 0x20004000]'      
          - 'mode[1:0] in [1] -> base[29:6] in [0x000000:0xF00000] base[5:0] in [0x00]'  
          wr_illegal:
          - 'mode[1:0] in [0] -> Unchanged'
          - 'mode[1:0] in [1] && writeval in [0x2000000:0x4000000] -> 0x2000000'
          - 'mode[1:0] in [1] && writeval in [0x4000001:0x3FFFFFFF] -> Unchanged'
      description: Vector base address.
      shadow: none
      msb: 31
      lsb: 2
    mode:
      implemented: true
      type:
        warl:
          dependency_fields: []
          legal:
          - 'mode[1:0] in [0x0:0x1] # Range of 0 to 1 (inclusive)'
          wr_illegal:
          - Unchanged
      description: Vector mode.
      shadow: none
      msb: 1
      lsb: 0
    fields:
    - mode
    - base
  rv64:
    accessible: false
```

### 平台规范

riscv-config所需要的第二个yaml文件为实现的平台特定功能-platform-yaml

以riscv-config的rv32i_platform.yaml为例

```
nmi:                        #存储 nmi 向量的值。它可以是标签或地址。
  label: nmi_vector
reset:                      #存储重置向量的值,可以是标签或地址。
  label: reset_vector
mtime:                      #存储内存映射mtime寄存器的字段。
  implemented: True
  address: 0x20000
```

除此之外，还可以设置以下字段

```
mtimecmp:                  #存储内存映射mtimecmp寄存器的字段。
   implemented: True
   address: 0x458
scause_non_standard:       #存储scause寄存器的字段。
   implemented: True
   value: [16,17,20]       #平台假定为整数的大于 16 的异常值列表。
zicbo_cache_block_sz :     #缓存块的字节大小
  implemented: true
  zicbom_sz: 64            #不能超过4096，且必须为必须是 2 的幂的整数
  zicboz_sz: 64            #不能超过4096，且必须为必须是 2 的幂的整数
```

