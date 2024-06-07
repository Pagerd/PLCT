# D拓展

## fadd.d

| 31-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| 00000 | 01    | rs2   | rs1   | rm    | rd   | 10100 | 11   |

- 格式 `fadd.d rd,rs1,rs2`
- 描述 执行双精度加法。
- 执行 `f[rd] = f[rs1] + f[rs2]`

## fsub.d

| 31-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| 00001 | 01    | rs2   | rs1   | rm    | rd   | 10100 | 11   |

- 格式 `fsub.d rd,rs1,rs2`
- 描述 执行双精度减法。
- 执行 `f[rd] = f[rs1] - f[rs2]`

## fmul.d

| 31-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| 00010 | 01    | rs2   | rs1   | rm    | rd   | 10100 | 11   |

- 格式 `fmul.d rd,rs1,rs2`
- 描述 执行双精度乘法。
- 执行 `f[rd] = f[rs1] x f[rs2]`

## fdiv.d

| 31-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| 00011 | 01    | rs2   | rs1   | rm    | rd   | 10100 | 11   |

- 格式 `fmul.d rd,rs1,rs2`
- 描述 执行双精度除法。
- 执行 `f[rd] = f[rs1] / f[rs2]`

对应sail中的实现

```
function clause execute (F_BIN_RM_TYPE_D(rs2, rs1, rm, rd, op)) = {
  let rs1_val_64b = F_or_X_D(rs1);
  let rs2_val_64b = F_or_X_D(rs2);
  match (select_instr_or_fcsr_rm (rm)) {
    None() => { handle_illegal(); RETIRE_FAIL },
    Some(rm') => {
      let rm_3b = encdec_rounding_mode(rm');
      let (fflags, rd_val_64b) : (bits(5), bits(64)) = match op {
        FADD_D  => riscv_f64Add (rm_3b, rs1_val_64b, rs2_val_64b),
        FSUB_D  => riscv_f64Sub (rm_3b, rs1_val_64b, rs2_val_64b),
        FMUL_D  => riscv_f64Mul (rm_3b, rs1_val_64b, rs2_val_64b),
        FDIV_D  => riscv_f64Div (rm_3b, rs1_val_64b, rs2_val_64b)
      };
      accrue_fflags(fflags);
      F_or_X_D(rd) = rd_val_64b;
      RETIRE_SUCCESS
    }
  }
}
```

## fmadd.d

| 31-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| rs3   | 01    | rs2   | rs1   | rm    | rd   | 10000 | 11   |

- 格式 `fmadd.d rd,rs1,rs2,rs3`
- 描述 执行单精度融合乘法加法。
- 执行 `f[rd] = f[rs1]×f[rs2]+f[rs3]`



## fmsub.d

| 31-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| rs3   | 01    | rs2   | rs1   | rm    | rd   | 10001 | 11   |

- 格式 `fmsub.d rd,rs1,rs2,rs3`
- 描述 执行单精度融合乘法减法。
- 执行 `f[rd] = f[rs1]×f[rs2]-f[rs3]`

## fnmsub.d

| 31-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| rs3   | 01    | rs2   | rs1   | rm    | rd   | 10010 | 11   |

- 格式 `fnmsub.d rd,rs1,rs2,rs3`
- 描述 执行负单精度融合乘法加法。
- 执行 `f[rd] = -f[rs1]×f[rs2+f[rs3]`

## fnmadd.d

| 31-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| rs3   | 01    | rs2   | rs1   | rm    | rd   | 10011 | 11   |

- 格式 `fnmadd.d rd,rs1,rs2,rs3`
- 描述 执行负单精度融合乘法减法。
- 执行 `f[rd] = -f[rs1]×f[rs2]-f[rs3]`

对应sail中的实现

```
function clause execute (F_MADD_TYPE_D(rs3, rs2, rs1, rm, rd, op)) = {
  let rs1_val_64b = F_or_X_D(rs1);
  let rs2_val_64b = F_or_X_D(rs2);
  let rs3_val_64b = F_or_X_D(rs3);

  match (select_instr_or_fcsr_rm (rm)) {
    None() => { handle_illegal(); RETIRE_FAIL },
    Some(rm') => {
      let rm_3b = encdec_rounding_mode(rm');
      let (fflags, rd_val_64b) : (bits(5), bits(64)) =
        match op {
          FMADD_D  => riscv_f64MulAdd (rm_3b, rs1_val_64b, rs2_val_64b, rs3_val_64b),
          FMSUB_D  => riscv_f64MulAdd (rm_3b, rs1_val_64b, rs2_val_64b, negate_D (rs3_val_64b)),
          FNMSUB_D => riscv_f64MulAdd (rm_3b, negate_D (rs1_val_64b), rs2_val_64b, rs3_val_64b),
          FNMADD_D => riscv_f64MulAdd (rm_3b, negate_D (rs1_val_64b), rs2_val_64b, negate_D (rs3_val_64b))
        };
      accrue_fflags(fflags);
      F_or_X_D(rd) = rd_val_64b;
      RETIRE_SUCCESS
    }
  }
}

```

## fsqrt.d

| 31-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| 01011 | 01    | 00000 | rs1   | 000   | rd   | 10100 | 11   |

- 格式 `fsqrt.d rd,rs1`
- 描述 执行执行单精度平方根运算。
- 执行 `f[rd] = sqrt(f[rs1])`

对应sail中实现

```
function clause execute (F_UN_RM_TYPE_D(rs1, rm, rd, FSQRT_D)) = {
  let rs1_val_D = F_or_X_D(rs1);
  match (select_instr_or_fcsr_rm (rm)) {
    None() => { handle_illegal(); RETIRE_FAIL },
    Some(rm') => {
      let rm_3b = encdec_rounding_mode(rm');
      let (fflags, rd_val_D) = riscv_f64Sqrt   (rm_3b, rs1_val_D);

      accrue_fflags(fflags);
      F_or_X_D(rd) = rd_val_D;
      RETIRE_SUCCESS
    }
  }
}
```

## fsgnj.d

| 31-27  | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ------ | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| 000100 | 01    | rs2   | rs1   | 000   | rd   | 10100 | 11   |

- 格式 `fsgnj.d rd,rs1,rs2`
- 描述 产生一个结果，该结果取自 rs1 中除符号位之外的所有位。结果的符号位是 rs2 的符号位。
- 执行 `f[rd] = {f[rs2][63]，f[rs1][62:0]}`

对应sail中实现

```
function clause execute (F_BIN_TYPE_D(rs2, rs1, rd, FSGNJ_D)) = {
  let rs1_val_D    = F_or_X_D(rs1);
  let rs2_val_D    = F_or_X_D(rs2);

  let (s1, e1, m1) = fsplit_D (rs1_val_D);
  let (s2, e2, m2) = fsplit_D (rs2_val_D);
  let rd_val_D     = fmake_D (s2, e1, m1);

  F_or_X_D(rd) = rd_val_D;
  RETIRE_SUCCESS
}

function clause execute (F_BIN_TYPE_D(rs2, rs1, rd, FSGNJN_D)) = {
  let rs1_val_D    = F_or_X_D(rs1);
  let rs2_val_D    = F_or_X_D(rs2);
  let (s1, e1, m1) = fsplit_D (rs1_val_D);
  let (s2, e2, m2) = fsplit_D (rs2_val_D);
  let rd_val_D     = fmake_D (0b1 ^ s2, e1, m1);

  F_or_X_D(rd) = rd_val_D;
  RETIRE_SUCCESS
}

function clause execute (F_BIN_TYPE_D(rs2, rs1, rd, FSGNJX_D)) = {
  let rs1_val_D    = F_or_X_D(rs1);
  let rs2_val_D    = F_or_X_D(rs2);
  let (s1, e1, m1) = fsplit_D (rs1_val_D);
  let (s2, e2, m2) = fsplit_D (rs2_val_D);
  let rd_val_D     = fmake_D (s1 ^ s2, e1, m1);

  F_or_X_D(rd) = rd_val_D;
  RETIRE_SUCCESS
}
```

## fsgnjn.d

| 31-27  | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ------ | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| 000100 | 01    | rs2   | rs1   | 001   | rd   | 10100 | 11   |

- 格式 `fsgnjn.d rd,rs1,rs2`
- 描述 产生一个结果，该结果取自 rs1 中除符号位之外的所有位。结果的符号位与 rs2 的符号位相反。
- 执行 `f[rd] = {~f[rs2][63], f[rs1][62:0]}`

对应sail中实现

```
function clause execute (F_BIN_TYPE_D(rs2, rs1, rd, FSGNJ_D)) = {
  let rs1_val_D    = F_or_X_D(rs1);
  let rs2_val_D    = F_or_X_D(rs2);

  let (s1, e1, m1) = fsplit_D (rs1_val_D);
  let (s2, e2, m2) = fsplit_D (rs2_val_D);
  let rd_val_D     = fmake_D (s2, e1, m1);

  F_or_X_D(rd) = rd_val_D;
  RETIRE_SUCCESS
}

function clause execute (F_BIN_TYPE_D(rs2, rs1, rd, FSGNJN_D)) = {
  let rs1_val_D    = F_or_X_D(rs1);
  let rs2_val_D    = F_or_X_D(rs2);
  let (s1, e1, m1) = fsplit_D (rs1_val_D);
  let (s2, e2, m2) = fsplit_D (rs2_val_D);
  let rd_val_D     = fmake_D (0b1 ^ s2, e1, m1);

  F_or_X_D(rd) = rd_val_D;
  RETIRE_SUCCESS
}

function clause execute (F_BIN_TYPE_D(rs2, rs1, rd, FSGNJX_D)) = {
  let rs1_val_D    = F_or_X_D(rs1);
  let rs2_val_D    = F_or_X_D(rs2);
  let (s1, e1, m1) = fsplit_D (rs1_val_D);
  let (s2, e2, m2) = fsplit_D (rs2_val_D);
  let rd_val_D     = fmake_D (s1 ^ s2, e1, m1);

  F_or_X_D(rd) = rd_val_D;
  RETIRE_SUCCESS
}
```

## fsgnjx.d

| 31-27  | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ------ | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| 000100 | 01    | rs2   | rs1   | 010   | rd   | 10100 | 11   |

- 格式 `fsgnjx.d rd,rs1,rs2`
- 描述 产生一个结果，该结果取自 rs1 中除符号位之外的所有位。结果的符号是 rs1 和 rs2 的符号位的异或。
- 执行 `f[rd] = {f[rs1][63] ^ f[rs2][63], f[rs1][62:0]}`

对应sail中实现

```
function clause execute (F_BIN_TYPE_D(rs2, rs1, rd, FSGNJ_D)) = {
  let rs1_val_D    = F_or_X_D(rs1);
  let rs2_val_D    = F_or_X_D(rs2);

  let (s1, e1, m1) = fsplit_D (rs1_val_D);
  let (s2, e2, m2) = fsplit_D (rs2_val_D);
  let rd_val_D     = fmake_D (s2, e1, m1);

  F_or_X_D(rd) = rd_val_D;
  RETIRE_SUCCESS
}

function clause execute (F_BIN_TYPE_D(rs2, rs1, rd, FSGNJN_D)) = {
  let rs1_val_D    = F_or_X_D(rs1);
  let rs2_val_D    = F_or_X_D(rs2);
  let (s1, e1, m1) = fsplit_D (rs1_val_D);
  let (s2, e2, m2) = fsplit_D (rs2_val_D);
  let rd_val_D     = fmake_D (0b1 ^ s2, e1, m1);

  F_or_X_D(rd) = rd_val_D;
  RETIRE_SUCCESS
}

function clause execute (F_BIN_TYPE_D(rs2, rs1, rd, FSGNJX_D)) = {
  let rs1_val_D    = F_or_X_D(rs1);
  let rs2_val_D    = F_or_X_D(rs2);
  let (s1, e1, m1) = fsplit_D (rs1_val_D);
  let (s2, e2, m2) = fsplit_D (rs2_val_D);
  let rd_val_D     = fmake_D (s1 ^ s2, e1, m1);

  F_or_X_D(rd) = rd_val_D;
  RETIRE_SUCCESS
}
```

## fcvt.s.d

| 31-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| 01000 | 00    | 00001 | rs1   | rm    | rd   | 10100 | 11   |

- 格式 `fcvt.sd rd,rs1`
- 描述 将 rs1 中的双精度浮点寄存器转换为浮点寄存器 rd 中的单精度浮点数。
- 执行 `f[rd] = f32_{f64}(f[rs1])`

对应sail中实现

```
function clause execute (F_UN_RM_TYPE_D(rs1, rm, rd, FCVT_S_D)) = {
  let rs1_val_D = F_or_X_D(rs1);
  match (select_instr_or_fcsr_rm (rm)) {
    None() => { handle_illegal(); RETIRE_FAIL },
    Some(rm') => {
      let rm_3b = encdec_rounding_mode(rm');
      let (fflags, rd_val_S) = riscv_f64ToF32 (rm_3b, rs1_val_D);

      accrue_fflags(fflags);
      F_or_X_S(rd) = rd_val_S;
      RETIRE_SUCCESS
    }
  }
}
```

## fcvt.d.s

| 31-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| 01000 | 00    | 00000 | rs1   | rm    | rd   | 10100 | 11   |

- 格式 `fcvt.ds rd,rs1`
- 描述 将 rs1 中的单精度浮点寄存器转换为浮点寄存器 rd 中的双精度浮点数。
- 执行 `f[rd] = f32_{f64}(f[rs1])`

对应sail中实现

```
function clause execute (F_UN_RM_TYPE_D(rs1, rm, rd, FCVT_D_S)) = {
  let rs1_val_S = F_or_X_S(rs1);
  match (select_instr_or_fcsr_rm (rm)) {
    None() => { handle_illegal(); RETIRE_FAIL },
    Some(rm') => {
      let rm_3b = encdec_rounding_mode(rm');
      let (fflags, rd_val_D) = riscv_f32ToF64 (rm_3b, rs1_val_S);

      accrue_fflags(fflags);
      F_or_X_D(rd) = rd_val_D;
      RETIRE_SUCCESS
    }
  }
}
```

