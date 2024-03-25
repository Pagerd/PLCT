### Sail中有大量的冗余代码

Issue原地址[#429](https://github.com/riscv/sail-riscv/issues/429) [#423](https://github.com/riscv/sail-riscv/issues/423) [#402](https://github.com/riscv/sail-riscv/issues/402)

在`model/riscv_types.sail`中，有如下代码用来映射word_width_bytes

```
val word_width_bytes : word_width -> {'s, 's == 1 | 's == 2 | 's == 4 | 's == 8 . atom('s)}
function word_width_bytes width = match width {
  BYTE   => 1,
  HALF   => 2,
  WORD   => 4,
  DOUBLE => 8
}
```

而在`model/riscv_insts_vext_mem.sail`中，有如下代码用来映射bytes_wordwidth

```
mapping bytes_wordwidth : {|1, 2, 4, 8|} <-> word_width = {
  1 <-> BYTE,
  2 <-> HALF,
  4 <-> WORD,
  8 <-> DOUBLE
}
```

很明显这两个映射有些重合，并且映射bytes_wordwidth的方法更为简洁,基于简单性的考量可以把riscv_insts_vext_mem.sail`中的映射删除，并在``riscv_types.sai`中更改为

```
mapping word_width_bytes : word_width <-> {1, 2, 4, 8} = {
  BYTE <-> 1,
  HALF <-> 2,
  WORD <-> 4,
  DOUBLE <-> 8,
}
```

同样在函数`is_CSR_defined`中，有大量的`p == Machine`等权限检查内容

```
function is_CSR_defined (csr : csreg, p : Privilege) -> bool =
  match (csr) {
    /* machine mode: informational */
    0xf11 => p == Machine, // mvendorid
    0xf12 => p == Machine, // marchdid
    0xf13 => p == Machine, // mimpid
    0xf14 => p == Machine, // mhartid
    /* machine mode: trap setup */
    0x300 => p == Machine, // mstatus
    0x301 => p == Machine, // misa
    0x302 => p == Machine & (haveSupMode() | haveNExt()), // medeleg
    0x303 => p == Machine & (haveSupMode() | haveNExt()), // mideleg
    0x304 => p == Machine, // mie
    0x305 => p == Machine, // mtvec
    0x306 => p == Machine & haveUsrMode(), // mcounteren
    0x30A => p == Machine & haveUsrMode(), // menvcfg
    0x310 => p == Machine & (sizeof(xlen) == 32), // mstatush
    0x31A => p == Machine & haveUsrMode() & (sizeof(xlen) == 32), // menvcfgh
    0x320 => p == Machine, // mcountinhibit
    /* machine mode: trap handling */
    0x340 => p == Machine, // mscratch
    0x341 => p == Machine, // mepc
    0x342 => p == Machine, // mcause
    0x343 => p == Machine, // mtval
    0x344 => p == Machine, // mip
  ......
```

而这些权限检查已经被通用方式检查处理过：

```
function check_CSR(csr : csreg, p : Privilege, isWrite : bool) -> bool =
    is_CSR_defined(csr, p)
  & check_CSR_access(csrAccess(csr), csrPriv(csr), p, isWrite)
  & check_TVM_SATP(csr, p)
  & check_Counteren(csr, p)
  & check_seed_CSR(csr, p, isWrite)
```

因此删除掉冗余的检查会使得功能变得更简单易读



另一个例子在`riscv_inst_base.sail`中，有如下代码

```
let res : MemoryOpResult(bool) = match (width) {
                BYTE => mem_write_value(paddr, 1, rs2_val[7..0],  aq, rl, false),
                HALF => mem_write_value(paddr, 2, rs2_val[15..0], aq, rl, false),
                WORD => mem_write_value(paddr, 4, rs2_val[31..0], aq, rl, false),
                DOUBLE if sizeof(xlen) >= 64
                     => mem_write_value(paddr, 8, rs2_val,        aq, rl, false),
                _    => report_invalid_width(__FILE__, __LINE__, width, "store"),
              };
              match (res) {
```

这里并不需要`if sizeof(xlen) >= 64`检查，因为相关的检查早已在解码器中完成，且此处根据位数编写了重复代码，因此该issue提出者给出一个更好的方法：

```
  let width_bytes = word_width_bytes(width);
  assert(width_bytes <= sizeof(xlen_bytes));
...
              match mem_write_value(paddr, width_bytes, rs2_val[width_bytes * 8 - 1 .. 0], aq, rl, false) {
```



大家好，我是第三测试小队的朱旭昌，今天呢简短的介绍一下测试小队当前对Sail-RISCV官方仓库进行的调研成果

首先还是说一下什么是Sail

而Sail作为规范化模型对于许多指令解释有一些问题和不合理的地方，官方仓库目前有约100多个issue，接下来我会选取出一些典型的issue进行介绍



### C.SRAI 和 C.SRLI 缺少 RV32 解码限制

Issue原地址[#356](https://github.com/riscv/sail-riscv/issues/356)

C.SRAI 和 C.SRLI是两个对rd的值进行处理的指令，

在RISCV 规范中，对C.SRLI和C.SRAI这两个指令有以下这个限制要求：

```
 C.SRLI isaCB-format instructionthatperformsa logical right shiftof thevalue inregister rd
 thenwritestheresulttord.Theshiftamountisencodedintheshamt eld,whereshamt[5]must
 bezeroforRV32C.ForRV32CandRV64C, theshiftamountmustbenon-zero. ForRV128C,a
 shiftamountofzeroisusedtoencodeashiftof64.Furthermore,theshiftamountissign-extended
 forRV128C,andsothelegal shiftamountsare131,64,and96127. C.SRLIexpands intosrli
 rd,rd,shamt[5:0],exceptforRV128Cwithshamt=0,whichexpandstosrlird,rd,64.
 C.SRAI isde nedanalogouslytoC.SRLI,but insteadperformsanarithmeticrightshift.C.SRAI
 expandstosraird,rd,shamt[5:0]
```

即C.SRLI对rd中的值进行逻辑右移,C.SRAI对rd中的值进行算数右移，移位量是编码在shamt字段中，而在RV32C中，shamtt[5]必须是0，而且在RV32C和RV64C中，移位量必须非零

但是在sail对应的文件riscv_insts_cext.sail中，关于C.SRLI和C.SRAI的解码却并没有对此进行限限制，仅仅有一个 !=0b000000的一个检测,这不符合RISCV ISA规范

而在另一个规定与C.SRLI和C.SRAI相同的指令C.SLLI上面，sail-RISCV则正确的进行了限制

因此可以推断此处C.SRLI和C.SRAI为编写错误，修复这个问题也很简单，在这两个指令的解码器上使用与C.SLLI相同的限制即可

因此C_SLLI和C_SRAI可以通过相同的代码进行正确的限制

```
mapping clause encdec_compressed = C_SLLI(nzui5 @ nzui40, rsd)
      if nzui5 @ nzui40 != 0b000000 & rsd != zreg & (sizeof(xlen) == 64 | nzui5 == 0b0)
  <-> 0b000 @ nzui5 : bits(1) @ rsd : regidx @ nzui40 : bits(5) @ 0b10
      if nzui5 @ nzui40 != 0b000000 & rsd != zreg & (sizeof(xlen) == 64 | nzui5 == 0b0)
      
...

mapping clause encdec_compressed = C_SRAI(nzui5 @ nzui40, rsd)
      if nzui5 @ nzui40 != 0b000000 & (sizeof(xlen) == 64 | nzui5 == 0b0)
  <-> 0b100 @ nzui5 : bits(1) @ 0b01 @ rsd : cregidx @ nzui40 : bits(5) @ 0b01
      if nzui5 @ nzui40 != 0b000000 & (sizeof(xlen) == 64 | nzui5 == 0b0)
```

### pmpcfg允许非法值R=0, W=1

Issue原地址[#296](https://github.com/riscv/sail-riscv/issues/296)

在规范中，对于pmpcfg有如下要求

```
The R, W, and X fields form a collective WARL field for which the combinations with R=0 and W=1 are reserved.
```

即规范要求WARL字段不允许有R=0 W=1的组合

而当前Sail代码中负责实现此部分的函数允许你在写入任何值且不会使 RWX 合法化以防止R=0 W=1出现

因为在Sail中负责的相关文件riscv_pmp_control中对应的pmpCheckRWX检查权限函数为

此时你可以发现此函数在检查write权限时仅检查W来确定write写权限，忽视了R，因此会导致给予R=0，W=1这个组合write权限，而这种情况是规范所不允许的

此时函数应该添加一个额外的判断来规避R=0 W=1的情况出现

```
val pmpCheckRWX: (Pmpcfg_ent, AccessType(ext_access_type)) -> bool
function pmpCheckRWX(ent, acc) = {
  match acc {
    Read(_)      => ent[R] == 0b1,
    Write(_)     => ent[W] == 0b1 & ent[R] != 0b0,
    ReadWrite(_) => ent[R] == 0b1 & ent[W] == 0b1,
    Execute()    => ent[X] == 0b1
  }
}
```

