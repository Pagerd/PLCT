# Sail-Issue

Issue原地址：https://github.com/riscv/sail-riscv/issues/169

## 问题描述

当执行指定动态（即查看`fcsr`）舍入模式的浮点指令时，若指定的舍入模式`fcsr`是两个保留编码之一则Sail 会崩溃，

举例如

```
li t0, 0x2000
csrw mstatus, t0 # 启用浮点
li t1, 0xc0
csrw fcsr, t1 # 将 frm 设置为 0b110（无效）
fmsub.s f22, f23, f27, f29, rdyn
```

此时Sail崩溃，显示`Pattern match failure in encdec_rounding_mode_backwards`

## 问题分析

Sail崩溃的主要原因是对应的fcsr映射中没有非法编码的案例(`0b101`和`1b110`)

```
 mapping encdec_rounding_mode : rounding_mode <-> bits(3) = { 
   RM_RNE <-> 0b000, 
   RM_RTZ <-> 0b001, 
   RM_RDN <-> 0b010, 
   RM_RUP <-> 0b011, 
   RM_RMM <-> 0b100, 
   RM_DYN <-> 0b111 
 } 
```

而在2021年曾有个commit尝试修复了crash问题，在后面添加了如下代码

```
val      valid_rounding_mode : bits(3) -> bool
function valid_rounding_mode rm = (rm != 0b101 & rm != 0b110)

val      select_instr_or_fcsr_rm : rounding_mode -> option(rounding_mode) effect {rreg}
function select_instr_or_fcsr_rm instr_rm =
  if (instr_rm == RM_DYN)
  then {
    let fcsr_rm = fcsr.FRM();
    if (valid_rounding_mode(fcsr_rm) & fcsr_rm != encdec_rounding_mode(RM_DYN))
      then Some(encdec_rounding_mode(fcsr_rm)) else None()
  }
  else Some(instr_rm)
```

此处有对于非法编码的一个判定

```
function valid_rounding_mode rm = (rm != 0b101 & rm != 0b110)
```

理论上当fcsr为`0b101`和`1b110`时，会返回None，随后调用`handle_illegal`并返回`RETIRE_FAIL`显示失败

而似乎此段代码并没有正确执行，似乎在执行此代码之前就进行了映射，由于映射中没有非法编码的案例因此导致部分函数参数错误从而导致失败