# 在ACT框架上添加测试用例

前言：在查看ACT上的Zfh拓展测试用例时，发现fcvt缺少浮点转换为浮点的指令的测试用例：

- fcvt.h.s
- fcvt.h.d
- fcvt.s.h
- fcvt.d.h

因此，需要在RISCV-CTG上对这些指令生成测试用例

为了在CTG上添加新指令的支持，我们首先需要在data文件夹中的yaml文件中依据模板添加对应的指令： 

以fcvt.d.h为例：

```
fcvt.d.h:
......
  xlen: [32,64]     //此指令适用的 XLEN 值列表
  isa:             //此指令属性所属的 RISC-V ISA 扩展
    - IFD_Zicsr_Zfh
  flen: [16,32,64]    //此指令适用的 FLEN 值列表
......
  rs1_op_data: *all_fregs     # 可用作操作数 1 的合法寄存器列表
  rd_op_data: *all_fregs      # 可用作目标的合法寄存器列表
  template: |-                # 用于创建测试的汇编宏的字符串。

    // $comment
    /* opcode: $inst ; op1:$rs1; dest:$rd; op1val:$rs1_val; valaddr_reg:$valaddr_reg;
    val_offset:$val_offset; correctval:??; testreg:$testreg;
    fcsr_val: $fcsr */
    TEST_FPSR_OP_NRM($inst, $rd, $rs1, $fcsr, $correctval, $valaddr_reg, $val_offset, $flagreg, $swreg, $testreg)  
```

随后需要编写指令相关的cgf文件用于生成测试用例

依旧以fcvt.d.h为例

```
fcvt.d.h_b1:
    config: 
      - check ISA:=regex(.*I.*F.*D.*Zfh.*)
    mnemonics: 
      fcvt.d.h: 0
    rs1: 
      <<: *all_fregs
    rd: 
      <<: *all_fregs
    op_comb: 
      <<: *ifmt_op_comb
    val_comb:
      abstract_comb:
        'ibm_b1(flen,16, "fcvt.d.h", 1)': 0
        
fcvt.d.h_b22:
.....
      abstract_comb:
        'ibm_b22(flen,16, "fcvt.d.h", 1)': 0
        
fcvt.d.h_b23:
.....
      abstract_comb:
        'ibm_b23(flen,16, "fcvt.d.h", 1)': 0
        
```

依照其余的fcvt测试用例cgf，共需要编写b1,b22,b23,b24,b27,b28,b29等测试用例集合

随后执行命令生成测试用例，会发现有报错：

```
ERROR | Error_evaluating abstract comb: ibo_b22(flen,16. "fcvt.d.i"，1) in fcvt.d.h_b22: local variable 'e_sz' referenced before assignnent
ERROR | Error_evaluating abstract comb: iby_b23(fLen,16. "fcvt.d.h", 1) in fcvt.d.h_b23: local variable 'string' referenced before assignnent
ERROR | Error_evaluating abstract comb: iby_b24(fLen,16. "fevt.d.h", 1) in fcvt.d.h_b24: local variable 'hex_tp' referenced before assignnent
ERROR |Error_ evaluating abstract comb: iby_b27(flen,16，"fevt.d.h"，1) in fcvt.d.h_b27: local variable 'string' referenced before assignnent
ERROR  Error_ evaluating abstract conb: iby_b28(fLen,16."feyt.d.h"，1) in fcvt.d.h_b28: local variable 'hex_tp' referenced before assignnent
ERROR  Error evaluating abstract conb: ibn_b29(fLen,16,"fcvt.d.h"，1) in fcvt.d.h_b29: local variable 'string' referenced before assignnent
```

原因是isac中负责生成测试数据的函数并没有支持16位

```
def ibm_b1(flen, iflen, opcode, ops):
sanitise = get_sanitise_func(opcode)

    elif iflen == 32:
        basic_types = fzero + fminsubnorm + [fsubnorm[0], fsubnorm[3]] +\
            fmaxsubnorm + fminnorm + [fnorm[0], fnorm[3]] + fmaxnorm + \
            finfinity + fdefaultnan + [fqnan[0], fqnan[3]] + \
            [fsnan[0], fsnan[3]] + fone
    elif iflen == 64:
        basic_types = dzero + dminsubnorm + [dsubnorm[0], dsubnorm[1]] +\
            dmaxsubnorm + dminnorm + [dnorm[0], dnorm[1]] + dmaxnorm + \
            dinfinity + ddefaultnan + [dqnan[0], dqnan[1]] + \
            [dsnan[0], dsnan[1]] + done
    else:
        logger.error('Invalid iflen value!')
        sys.exit(1)
        ...
```

因此 需要对本次涉及到的所有ibm函数进行16位的支持

以ibm_b1为例:

```
    if iflen == 16:
        basic_types = hzero + hminsubnorm + [hsubnorm[0], hsubnorm[3]] +\
            hmaxsubnorm + hminnorm + [hnorm[0], hnorm[3]] + hmaxnorm + \
            hinfinity + hdefaultnan + [hqnan[0], hqnan[3]] + \
            [hsnan[0], hsnan[3]] + hone
    elif iflen == 32:
        basic_types = fzero + fminsubnorm + [fsubnorm[0], fsubnorm[3]] +\
            fmaxsubnorm + fminnorm + [fnorm[0], fnorm[3]] + fmaxnorm + \
            finfinity + fdefaultnan + [fqnan[0], fqnan[3]] + \
            [fsnan[0], fsnan[3]] + fone
    elif iflen == 64:
        basic_types = dzero + dminsubnorm + [dsubnorm[0], dsubnorm[1]] +\
            dmaxsubnorm + dminnorm + [dnorm[0], dnorm[1]] + dmaxnorm + \
            dinfinity + ddefaultnan + [dqnan[0], dqnan[1]] + \
            [dsnan[0], dsnan[1]] + done
```

```
hzero       = ['0x0000','0x8000']
hminsubnorm = ['0x0001', '0x8001']
hsubnorm    = ['0x0002', '0x8002', '0x077E', '0xF77E', '0x02AA', '0x82AA']
hmaxsubnorm = ['0x03FF', '0x83FF']
hminnorm    = ['0x0400', '0x8400']
hnorm       = ['0x0401', '0x8401', '0x0455', '0x8455', '0x04AA', '0x84AA', '0x5400', '0xD400', '0x2800', '0xA800']
hmaxnorm    = ['0x7BFF', '0xFBFF']
hinfinity   = ['0x7C00', '0xFC00']
hdefaultnan = ['0x7E00', '0xFE00']
hqnan       = ['0x7E01', '0xFE01', '0x7EAA', '0xFEAA']
hsnan       = ['0x7C01', '0xFC01', '0x7D55', '0xFD55']
hone        = ['0x3C00', '0xBC00']
```

添加完成后，重新安装riscv_isac及riscv-ctg,即可对新测试用例使用riscof进行测试

