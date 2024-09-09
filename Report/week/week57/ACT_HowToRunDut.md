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



##### def __init__(self, *args, **kwargs):

```
super().__init__(*args, **kwargs)
        config = kwargs.get('config')
        if config is None:
            print("Please enter input file paths in configuration.")
            raise SystemExit(1)
        self.num_jobs = str(config['jobs'] if 'jobs' in config else 1)
it from the config.ini
        self.pluginpath=os.path.abspath(config['pluginpath'])
config.ini file.
        self.isa_spec = os.path.abspath(config['ispec'])
        self.platform_spec = os.path.abspath(config['pspec'])
running
        if 'target_run' in config and config['target_run']=='0':
            self.target_run = False
        else:
            self.target_run = True
```

此处主要进行dut的基本设置，用于将config中的参数传递给riscof，大部分情况下不需要作更改



##### def initialise(self, suite, work_dir, archtest_env):

```
def initialise(self, suite, work_dir, archtest_env):
       self.work_dir = work_dir
       self.suite_dir = suite
       self.compile_cmd = 'riscv64-unknown-elf-gcc -march={0} \
         -static -mcmodel=medany -fvisibility=hidden -nostdlib -nostartfiles -g\
         -T '+self.pluginpath+'/env/link.ld\
         -I '+self.pluginpath+'/env/\
         -I ' + archtest_env + ' {1} -o {2} {3}'
```

此函数主要将待测测试用例编译为elf文件，大部分情况下不需要作更改

##### def build(self, isa_yaml, platform_yaml):

```
# load the isa yaml as a dictionary in python.
      ispec = utils.load_yaml(isa_yaml)['hart0']
      self.xlen = ('64' if 64 in ispec['supported_xlen'] else '32')
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

      self.compile_cmd = self.compile_cmd+' -mabi='+('lp64 ' if 64 in ispec['supported_xlen'] else 'ilp32 ')
```

通过选取 isa yaml 的“supported_xlen”字段中的最大值来捕获 XLEN 值。同时其中的ISA相关字段为spike获取ISA的函数，其余dut不一定支持此参数

##### def runTests(self, testList):

```
def runTests(self, testList):
      if os.path.exists(self.work_dir+ "/Makefile." + self.name[:-1]):
            os.remove(self.work_dir+ "/Makefile." + self.name[:-1])
      make = utils.makeUtil(makefilePath=os.path.join(self.work_dir, "Makefile." + self.name[:-1]))
      make.makeCommand = 'make -k -j' + self.num_jobs
      for testname in testList:
          testentry = testList[testname]
          test = testentry['test_path']
          test_dir = testentry['work_dir']
          elf = 'my.elf'
          sig_file = os.path.join(test_dir, self.name[:-1] + ".signature")
          # prefix with "-D". The following does precisely that.
          compile_macros= ' -D' + " -D".join(testentry['macros'])
          cmd = self.compile_cmd.format(testentry['isa'].lower(), self.xlen, test, elf, compile_macros)
          if self.target_run:
            simcmd = self.dut_exe + ' --isa={0} +signature={1} +signature-granularity=4 {2}'.format(self.isa, sig_file, elf)
          else:
            simcmd = 'echo "NO RUN"'
          execute = '@cd {0}; {1}; {2};'.format(testentry['work_dir'], cmd, simcmd)
          make.add_target(execute)
      if not self.target_run:
          raise SystemExit(0)
```

此函数主要负责进行测试，前半部分为riscof通用设置，不需要进行修改

对此函数的修改主要体现在此处

```
if self.target_run:
            simcmd = self.dut_exe + ' --isa={0} +signature={1} +signature-granularity=4 {2}'.format(self.isa, sig_file, elf)
          else:
            simcmd = 'echo "NO RUN"'
```

需要将此处的命令行修改为dut所符合的测试命令
