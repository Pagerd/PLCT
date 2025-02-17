# ACT测试中的测试用例格式

汇报人：第三测试小队-朱旭昌



#### RISCV-ARCH-TEST (ACT)简介

ACT是RISC-V Architecture Test SIG 对RISC-V 基础架构的一套测试，旨在帮助确保为给定 RISC-V 配置文件/规范编写的软件能够在符合该配置文件的所有实现上运行。ACT测试还有助于确保实施者正确理解并实施了规范。

ACT是一个最小的过滤器。通过ACT测试并获得 RISC-V International 批准的结果是获得 RISC-V 商标许可的先决条件。通过 RISC-V ACT测试并不意味着设计符合 RISC-V 架构。ACT只是一组基本的测试，ACT测试主要检查规范的重要问题，而不关注细节。

#### RISCV-CTG简介



RISCV-CTG 是基于 RISC-V 的兼容性测试生成器。该工具用于生成官方RISC-V 架构测试套件和 RISC-V 架构测试框架RISCOF中使用的测试用例。

CTG通过(CGF)文件来生成测试用例，CGF文件包含了不同指令的各种覆盖点，CTG将每个覆盖点视为约束,并使用求解器来识别潜在的解决方案。



ACT使用的测试用例均来自CTG自动生成，然而目前CTG存在许多问题，生成的测试用例在某些指令上会出现很多错误，因此需要对测试用例进行手动修改来完成目标，因此，我们了解ACT测试用例的总体结构



#### 测试用例构成

针对一个指令的测试用例集由多个.S测试文件构成，每个测试用例用于负责测试单个指令的一部分功能。



#### 头文件定义

```
#include "model_test.h" //头文件
#include "arch_test.h"
RVTEST_ISA("RV32I")  //设置测试的ISA

.section .text.init
.globl rvtest_entry_point
rvtest_entry_point:
RVMODEL_BOOT    //测试代码的开始
RVTEST_CODE_BEGIN  //定义RVTEST_CASE字符串和条件
```

每个测试仅应包含以下头文件：

1. `model_test.h` – 定义特定于目标的宏，包括必需和可选的宏（例如：RVMODEL_xxx）。
2. `arch_test.h` – 定义预定义的测试宏，包括必需和可选的宏（例如：RVTEST_xxx）。

`arch_test.h` 的包含应始终在 `model_test.h` 文件之后进行。

关于头文件需要注意的几点：

1. 禁止在测试中添加新的头文件。这可能导致宏重定义和编译问题。
2. 宏可以在测试内部定义和使用，但不会在该测试之外定义和使用。 // 3. 断言将生成报告断言失败（以及可选的成功？）的代码，前提是框架启用了该功能。 // 4. 此外，框架可以收集断言值并将其作为签名输出文件保存，前提是框架启用了该功能。



```
#ifdef TEST_CASE_1

RVTEST_CASE(0,"//check ISA:=regex(.*32.*);check ISA:=regex(.*I.*);def  TEST_CASE_1=True;",add)// 该测试适用于实现rv32I扩展的设备，并且需要启用编译宏TEST_CASE_1。 // 该测试将贡献于“add”覆盖标签。

RVTEST_SIGBASE( x3,signature_x3_1) //初始化指向签名区域的指针
```

```
inst_0:
// rs2 == rd != rs1, rs1==x4, rs2==x24, rd==x24, rs1_val > 0 and rs2_val > 0, rs2_val == 1, rs1_val == (2**(xlen-1)-1), rs1_val != rs2_val, rs1_val == 2147483647
// opcode: add ; op1:x4; op2:x24; dest:x24; op1val:0x7fffffff;  op2val:0x1
TEST_RR_OP(add, x24, x4, x24, 0x80000000, 0x7fffffff, 0x1, x3, 0, x18)
```



具体的测试用例如下

这里的两个注释都是用来表示此测试函数使用了什么样的测试数据来进行测试的，而实际有用的测试函数则是这段

```
//测试带有寄存器立即操作数的指令
#define TEST_IMM_OP( inst, destreg, reg, correctval, val, imm, swreg, offset, testreg)	;\
    TEST_CASE(testreg, destreg, correctval, swreg, offset,	 ;\
      LI(reg, MASK_XLEN(val))		;\
      inst destreg, reg, SEXT_IMM(imm)	;\
    )

```



```
//测试具有单个寄存器操作数的浮点指令
#define TEST_FPSR_OP( inst, destreg, freg, rm, fcsr_val, correctval, valaddr_reg, val_offset, flagreg, swreg, testreg)
//测试具有单个寄存器操作数和整数目标寄存器的浮点指令
#define TEST_FPID_OP( inst, destreg, freg, rm, fcsr_val, correctval, valaddr_reg, val_offset, flagreg, swreg, testreg,load_instr)
//测试具有单个寄存器操作数和整数操作数寄存器的浮点指令
#define TEST_FPIO_OP( inst, destreg, freg, rm, fcsr_val, correctval, valaddr_reg, val_offset, flagreg, swreg, testreg, load_instr) \
```

更改签名基址寄存器:

```
inst_544:
// rs1_val==46339 and rs2_val==-46339, 
// opcode: add ; op1:x10; op2:x11; dest:x12; op1val:0xb503;  op2val:-0xb503
TEST_RR_OP(add, x12, x10, x11, 0x0, 0xb503, -0xb503, x1, 2044, x2)
RVTEST_SIGBASE( x1,signature_x1_1) // 这将把签名基址寄存器更改为 x1。x1 将指向签名区域中的 signature_x1_1
```

结束测试并停止测试目标。

```
RVTEST_CODE_END
RVMODEL_HALT
```

创建测试输入数据部分

```
RVTEST_DATA_BEGIN
.align 4
rvtest_data:
.word 0xbabecafe
.word 0xabecafeb
.word 0xbecafeba
.word 0xecafebab
RVTEST_DATA_END
```

除此之外，还可以使用NAN_BOXED来填充数据

```
.align 4
rvtest_data:
.word 0xbabecafe
.word 0xabecafeb
.word 0xbecafeba
.word 0xecafebab
test_dataset_0:
NAN_BOXED(1,64,FLEN)
NAN_BOXED(4503599627370492,64,FLEN)
NAN_BOXED(1,64,FLEN)
NAN_BOXED(9227875636482146048,64,FLEN)
NAN_BOXED(2,64,FLEN)
NAN_BOXED(9223372036854775815,64,FLEN)
NAN_BOXED(2,64,FLEN)
NAN_BOXED(9227875636482146297,64,FLEN)
......
NAN_BOXED(9223372036854775815,64,FLEN)
RVTEST_DATA_END
```

最后是创建预加载区域

```

signature_x3_0:
    .fill 0*(XLEN/32),4,0xdeadbeef
...
signature_x1_1:
    .fill 43*(XLEN/32),4,0xdeadbeef
....
sig_end_canary:
CANARY;
rvtest_sig_end:
RVMODEL_DATA_END
```

