# C拓展

## c.addi4spn

| 15-13 | 12-5                   | 4-2  | 1-0  |
| ----- | ---------------------- | ---- | ---- |
| 000   | nzuimm[5:4\|9:6\|2\|3] | rd   | 00   |

- 格式 `c.addi4spn rd',uimm`
- 描述 生成指向堆栈分配变量的指针，并写入 rd, x2, nzuimm[9:2]。
- 执行 `x[8+rd'] = x[2] + nzuimm`

在sail中当前的实现

```
union clause ast = C_ADDI4SPN : (cregidx, bits(8))

mapping clause encdec_compressed = C_ADDI4SPN(rd, nz96 @ nz54 @ nz3 @ nz2)
      if nz96 @ nz54 @ nz3 @ nz2 != 0b00000000
  <-> 0b000 @ nz54 : bits(2) @ nz96 : bits(4) @ nz2 : bits(1) @ nz3 : bits(1) @ rd : cregidx @ 0b00
      if nz96 @ nz54 @ nz3 @ nz2 != 0b00000000

function clause execute (C_ADDI4SPN(rdc, nzimm)) = {
  let imm : bits(12) = (0b00 @ nzimm @ 0b00);
  let rd = creg2reg_idx(rdc);
  execute(ITYPE(imm, sp, rd, RISCV_ADDI))
}

mapping clause assembly = C_ADDI4SPN(rdc, nzimm)
      if nzimm != 0b00000000
  <-> "c.addi4spn" ^ spc() ^ creg_name(rdc) ^ sep() ^ hex_bits_10(nzimm @ 0b00)
      if nzimm != 0b00000000
```

## c.fld

| 15-13 | 12-10     | 9-7  | 6-5       | 4-2  | 1-0  |
| ----- | --------- | ---- | --------- | ---- | ---- |
| 001   | uimm[5:3] | rs1' | uimm[7:6] | rd'  | 00   |

- 格式 `c.fld rd',uimm(rs1')`
- 描述 将双精度浮点值从内存加载到浮点寄存器 rd' 中。通过将按 8 缩放的零扩展偏移量与寄存器 rs1' 中的基地址相加来计算有效地址。
- 执行 `f[8+rd'] = M[x[8+rs1'] + uimm][63:0]`

在sail中当前的实现

```
union clause ast = C_FLD : (bits(5), cregidx, cregidx)

mapping clause encdec_compressed = C_FLD(ui76 @ ui53, rs1, rd)
      if (sizeof(xlen) == 32 | sizeof(xlen) == 64) & haveRVC() & haveDExt()
  <-> 0b001 @ ui53 : bits(3) @ rs1 : cregidx @ ui76 : bits(2) @ rd : cregidx @ 0b00
      if (sizeof(xlen) == 32 | sizeof(xlen) == 64) & haveRVC() & haveDExt()

function clause execute (C_FLD(uimm, rsc, rdc)) = {
  let imm : bits(12) = zero_extend(uimm @ 0b000);
  let rd = creg2reg_idx(rdc);
  let rs = creg2reg_idx(rsc);
  execute(LOAD_FP(imm, rs, rd, DOUBLE))
}

mapping clause assembly = C_FLD(uimm, rsc, rdc)
      if (sizeof(xlen) == 32 | sizeof(xlen) == 64)
  <-> "c.fld" ^ spc() ^ creg_name(rdc) ^ sep() ^ creg_name(rsc) ^ sep() ^ hex_bits_8(uimm @ 0b000)
      if (sizeof(xlen) == 32 | sizeof(xlen) == 64)
```

## c.lw

| 15-13 | 12-10     | 9-7  | 6-5        | 4-2  | 1-0  |
| ----- | --------- | ---- | ---------- | ---- | ---- |
| 010   | uimm[5:3] | rs1' | uimm[2\|6] | rd'  | 00   |

- 格式 `c.lw rd',uimm(rs1')`
- 描述 将内存中的 32 位值加载到寄存器 rd' 中。 通过将按 4 缩放的零扩展偏移量与寄存器 rs1' 中的基地址相加来计算有效地址。
- 执行 `x[8+rd'] = sext(M[x[8+rs1'] + uimm][31:0])`

在sail中当前的实现

```
union clause ast = C_LW : (bits(5), cregidx, cregidx)

mapping clause encdec_compressed = C_LW(ui6 @ ui53 @ ui2, rs1, rd)
  <-> 0b010 @ ui53 : bits(3) @ rs1 : cregidx @ ui2 : bits(1) @ ui6 : bits(1) @ rd : cregidx @ 0b00

function clause execute (C_LW(uimm, rsc, rdc)) = {
  let imm : bits(12) = zero_extend(uimm @ 0b00);
  let rd = creg2reg_idx(rdc);
  let rs = creg2reg_idx(rsc);
  execute(LOAD(imm, rs, rd, false, WORD, false, false))
}

mapping clause assembly = C_LW(uimm, rsc, rdc)
  <-> "c.lw" ^ spc() ^ creg_name(rdc) ^ sep() ^ creg_name(rsc) ^ sep() ^ hex_bits_7(uimm @ 0b00)
```

## c.flw

| 15-13 | 12-10     | 9-7  | 6-5        | 4-2  | 1-0  |
| ----- | --------- | ---- | ---------- | ---- | ---- |
| 011   | uimm[5:3] | rs1' | uimm[2\|6] | rd'  | 00   |

- 格式 `c.flw rd',uimm(rs1')`
- 描述 将单精度浮点值从内存加载到浮点寄存器 rd' 中。它通过将按 4 缩放的零扩展偏移量与寄存器 rs1' 中的基地址相加来计算有效地址。
- 执行 `f[8+rd'] = M[x[8+rs1'] + uimm][31:0]`

```
union clause ast = C_FLWSP : (bits(6), regidx)

mapping clause encdec_compressed = C_FLWSP(ui76 @ ui5 @ ui42, rd)
      if sizeof(xlen) == 32 & haveRVC() & haveFExt()
  <-> 0b011 @ ui5 : bits(1) @ rd : regidx @ ui42 : bits(3) @ ui76 : bits(2) @ 0b10
      if sizeof(xlen) == 32 & haveRVC() & haveFExt()

function clause execute (C_FLWSP(imm, rd)) = {
  let imm : bits(12) = zero_extend(imm @ 0b00);
  execute(LOAD_FP(imm, sp, rd, WORD))
}

mapping clause assembly = C_FLWSP(imm, rd)
      if sizeof(xlen) == 32
  <-> "c.flwsp" ^ spc() ^ reg_name(rd) ^ sep() ^ hex_bits_6(imm)
      if sizeof(xlen) == 32
```

## c.ld

| 15-13 | 12-10     | 9-7  | 6-5       | 4-2  | 1-0  |
| ----- | --------- | ---- | --------- | ---- | ---- |
| 011   | uimm[5:3] | rs1' | uimm[7:6] | rd'  | 00   |

- 格式 `c.ld rd',uimm(rs1')`
- 描述 将 64 位值从内存加载到寄存器 rd' 中。。它通过将按 8 缩放的零扩展偏移量与寄存器 rs1' 中的基地址相加来计算有效地址。
- 执行 `x[8+rd'] = M[x[8+rs1'] + uimm][63:0]`

```
union clause ast = C_LD : (bits(5), cregidx, cregidx)

mapping clause encdec_compressed = C_LD(ui76 @ ui53, rs1, rd)
      if sizeof(xlen) == 64
  <-> 0b011 @ ui53 : bits(3) @ rs1 : cregidx @ ui76 : bits(2) @ rd : cregidx @ 0b00
      if sizeof(xlen) == 64

function clause execute (C_LD(uimm, rsc, rdc)) = {
  let imm : bits(12) = zero_extend(uimm @ 0b000);
  let rd = creg2reg_idx(rdc);
  let rs = creg2reg_idx(rsc);
  execute(LOAD(imm, rs, rd, false, DOUBLE, false, false))
}

mapping clause assembly = C_LD(uimm, rsc, rdc)
      if sizeof(xlen) == 64
  <-> "c.ld" ^ spc() ^ creg_name(rdc) ^ sep() ^ creg_name(rsc) ^ sep() ^ hex_bits_8(uimm @ 0b000)
      if sizeof(xlen) == 64
```

## c.fsd

| 15-13 | 12-10     | 9-7  | 6-5        | 4-2  | 1-0  |
| ----- | --------- | ---- | ---------- | ---- | ---- |
| 101   | uimm[5:3] | rs1' | uimm[2\|6] | rd'  | 00   |

- 格式 `c.fsd rd',uimm(rs1')`
- 描述 将浮点寄存器 rs2' 中的双精度浮点值存储到内存中。它通过将按 8缩放的零扩展偏移量与寄存器 rs1' 中的基地址相加来计算有效地址。
- 执行 `M[x[8+rs1'] + uimm][63:0] = f[8+rs2']`

```
union clause ast = C_FSDSP : (bits(6), regidx)

mapping clause encdec_compressed = C_FSDSP(ui86 @ ui53, rs2)
      if (sizeof(xlen) == 32 | sizeof(xlen) == 64) & haveRVC() & haveDExt()
  <-> 0b101 @ ui53 : bits(3) @ ui86 : bits(3) @ rs2 : regidx @ 0b10
      if (sizeof(xlen) == 32 | sizeof(xlen) == 64) & haveRVC() & haveDExt()

function clause execute (C_FSDSP(uimm, rs2)) = {
  let imm : bits(12) = zero_extend(uimm @ 0b000);
  execute(STORE_FP(imm, rs2, sp, DOUBLE))
}

mapping clause assembly = C_FSDSP(uimm, rs2)
      if (sizeof(xlen) == 32 | sizeof(xlen) == 64)
  <-> "c.fsdsp" ^ spc() ^ reg_name(rs2) ^ sep() ^ hex_bits_6(uimm)
      if (sizeof(xlen) == 32 | sizeof(xlen) == 64)
```

## c.sw

| 15-13 | 12-10     | 9-7  | 6-5        | 4-2  | 1-0  |
| ----- | --------- | ---- | ---------- | ---- | ---- |
| 110   | uimm[5:3] | rs1' | uimm[2\|6] | rs2  | 00   |

- 格式 `c.sw rd',uimm(rs1')`
- 描述 将寄存器 rs2' 中的 32 位值存储到内存中。它通过将按4缩放的零扩展偏移量与寄存器 rs1' 中的基地址相加来计算有效地址。
- 执行 `M[x[8+rs1'] + uimm][31:0] = x[8+rs2']`

```
union clause ast = C_SW : (bits(5), cregidx, cregidx)

mapping clause encdec_compressed = C_SW(ui6 @ ui53 @ ui2, rs1, rs2)
  <-> 0b110 @ ui53 : bits(3) @ rs1 : cregidx @ ui2 : bits(1) @ ui6 : bits(1) @ rs2 : cregidx @ 0b00

function clause execute (C_SW(uimm, rsc1, rsc2)) = {
  let imm : bits(12) = zero_extend(uimm @ 0b00);
  let rs1 = creg2reg_idx(rsc1);
  let rs2 = creg2reg_idx(rsc2);
  execute(STORE(imm, rs2, rs1, WORD, false, false))
}

mapping clause assembly = C_SW(uimm, rsc1, rsc2)
  <-> "c.sw" ^ spc() ^ creg_name(rsc1) ^ sep() ^ creg_name(rsc2) ^ sep() ^ hex_bits_7(uimm @ 0b00)
```

## c.fsw

| 15-13 | 12-10     | 9-7  | 6-5        | 4-2  | 1-0  |
| ----- | --------- | ---- | ---------- | ---- | ---- |
| 111   | uimm[5:3] | rs1' | uimm[2\|6] | rs2  | 00   |

- 格式 `c.fsw rd',uimm(rs1')`
- 描述 将浮点寄存器 rs2' 中的单精度浮点值存储到内存中。它通过将按4缩放的零扩展偏移量与寄存器 rs1' 中的基地址相加来计算有效地址。
- 执行 `M[x[8+rs1'] + uimm][31:0] = f[8+rs2']`

```
union clause ast = C_FSW : (bits(5), cregidx, cregidx)

mapping clause encdec_compressed = C_FSW(ui6 @ ui53 @ ui2, rs1, rs2)
      if sizeof(xlen) == 32 & haveRVC() & haveFExt()
  <-> 0b111 @ ui53 : bits(3) @ rs1 : cregidx @ ui2 : bits(1) @ ui6 : bits(1) @ rs2 : cregidx @ 0b00
      if sizeof(xlen) == 32 & haveRVC() & haveFExt()

function clause execute (C_FSW(uimm, rsc1, rsc2)) = {
  let imm : bits(12) = zero_extend(uimm @ 0b00);
  let rs1 = creg2reg_idx(rsc1);
  let rs2 = creg2reg_idx(rsc2);
  execute(STORE_FP(imm, rs2, rs1, WORD))
}

mapping clause assembly = C_FSW(uimm, rsc1, rsc2)
      if sizeof(xlen) == 32
  <-> "c.fsw" ^ spc() ^ creg_name(rsc1) ^ sep() ^ creg_name(rsc2) ^ sep() ^ hex_bits_7(uimm @ 0b00)
      if sizeof(xlen) == 32
```

## c.sd

| 15-13 | 12-10     | 9-7  | 6-5       | 4-2  | 1-0  |
| ----- | --------- | ---- | --------- | ---- | ---- |
| 111   | uimm[5:3] | rs1' | uimm[7:6] | rs2  | 00   |

- 格式 `c.sd rd',uimm(rs1')`
- 描述 将寄存器 rs2' 中的 64 位值存储到内存中。它通过将按4缩放的零扩展偏移量与寄存器 rs1' 中的基地址相加来计算有效地址。
- 执行 `M[x[8+rs1'] + uimm][63:0] = x[8+rs2']`

```
union clause ast = C_SD : (bits(5), cregidx, cregidx)

mapping clause encdec_compressed = C_SD(ui76 @ ui53, rs1, rs2)
      if sizeof(xlen) == 64
  <-> 0b111 @ ui53 : bits(3) @ rs1 : bits(3) @ ui76 : bits(2) @ rs2 : bits(3) @ 0b00
      if sizeof(xlen) == 64

function clause execute (C_SD(uimm, rsc1, rsc2)) = {
  let imm : bits(12) = zero_extend(uimm @ 0b000);
  let rs1 = creg2reg_idx(rsc1);
  let rs2 = creg2reg_idx(rsc2);
  execute(STORE(imm, rs2, rs1, DOUBLE, false, false))
}

mapping clause assembly = C_SD(uimm, rsc1, rsc2)
      if sizeof(xlen) == 64
  <-> "c.sd" ^ spc() ^ creg_name(rsc1) ^ sep() ^ creg_name(rsc2) ^ sep() ^ hex_bits_8(uimm @ 0b000)
      if sizeof(xlen) == 64
```

## c.sd

| 15-13 | 12-10 | 9-7  | 6-5  | 4-2  | 1-0  |
| ----- | ----- | ---- | ---- | ---- | ---- |
| 000   | 0     | 0    | 0    | 0    | 01   |

- 格式 `c.nop`
- 描述 不更改任何用户可见的状态，除了推进电脑之外。
- 执行 `addi x0, x0, 0`
