# 如何使用ACT测试其他的模拟器

使用RISCOF进行基础配置生成

```
riscof setup --dutname=xxx
```

此处xx为被测模型名称，随便填写即可

此时在文件夹内会生成以下文件

```
├──config.ini                   # configuration file for riscof
├──xxx/                       # DUT plugin templates
   ├── env
   │   ├── link.ld              # DUT linker script
   │   └── model_test.h         # DUT specific header file
   ├── xxx.py                   # DUT python plugin
   ├── spike_isa.yaml           # DUT ISA yaml based on riscv-config
   └── spike_platform.yaml      # DUT Platform yaml based on riscv-config
├──sail_cSim/                   # reference plugin templates
   ├── env
   │   ├── link.ld              # Reference linker script
   │   └── model_test.h         # Reference model specific header file
   ├── __init__.py
   └── riscof_sail_cSim.py      # Reference model python plugin.
```

点开xxx文件夹，首先修改其中的`qemu_isa.yaml`

```
hart_ids: [0]
hart0:
  ISA: RV32IMCZicsr_Zifencei      //测试使用的ISA字符串
  physical_addr_sz: 32            //若需要测试64位则修改为56
  User_Spec_Version: '2.3'        //版本
  supported_xlen: [32]            //若需要测试64位则修改为64
```

将其中修改为你所需的测试配置即可

若平台又特殊实现，则需要修改`qemu_platform.yaml`,此处不作展开

随后点开`riscof_qemu.py`文件，此处则为我们需要进行大量修改的地方

进入`def build`函数中

如果你的DUT支持 --isa命令，则需要在以下处进行修改来添加缺失的ISA

```
self.isa = 'rv' + self.xlen
      if "I" in ispec["ISA"]:
          self.isa += 'i'
      if "M" in ispec["ISA"]:
          self.isa += 'm'
      if "F" in ispec["ISA"]:
          self.isa += 'f'
      if "D" in ispec["ISA"]:
          self.isa += 'd'
      if "C" in ispec["ISA"]:
          self.isa += 'c'
      if "Zfh" in ispec["ISA"]:
          self.isa += '_Zfh'
      print(self.isa+' '+ispec["ISA"])
```

随后下拉到`RunTest`命令，此处需要根据不同的dut命令进行相应的修改以执行elf文件并生成结果

```
if self.target_run:
            # set up the simulation command. Template is for spike. Please change.
            simcmd = self.dut_exe + ' --isa={0} +signature={1} +signature-granularity=4 {2}'.format(self.isa, sig_file, elf)
```

以qemu为例，需要修改为以下代码（pending）

```
if self.target_run:
            # set up the simulation command. Template is for spike. Please change.
            self.dut_exe = "qemu-system-riscv64"
            simcmd = self.dut_exe + ' -nographic -bios none -kernel {2}'.format(self.isa, sig_file, elf)
```

随后返回测试界面，使用以下命令启动ACT测试即可

```
riscof run --config=config.ini --suite=riscv-arch-test/riscv-test-suite/ --env=riscv-arch-test/riscv-test-suite/env
```

