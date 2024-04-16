## fmadd.s

| 13-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| rs3   | 00    | rs2   | rs1   | rm    | rd   | 10000 | 11   |

- 格式 `fmadd.s rd,rs1,rs2,rs3`
- 描述 执行单精度融合乘法加法。
- 执行 `f[rd] = f[rs1]×f[rs2]+f[rs3]`



## fmsub.s

| 13-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| rs3   | 00    | rs2   | rs1   | rm    | rd   | 10001 | 11   |

- 格式 `fmsub.s rd,rs1,rs2,rs3`
- 描述 执行单精度融合乘法减法。
- 执行` f[rd] = f[rs1]×f[rs2]-f[rs3]`



## fnmsub.s

| 13-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| rs3   | 00    | rs2   | rs1   | rm    | rd   | 10010 | 11   |

- 格式 `fnmsub.s rd,rs1,rs2,rs3`
- 描述 执行单精度负数融合乘法加法。
- 执行` f[rd] = -f[rs1]×f[rs2]+f[rs3]`





## fnmadd.s

| 13-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| rs3   | 00    | rs2   | rs1   | rm    | rd   | 10011 | 11   |

- 格式 `fnmadd.s rd,rs1,rs2,rs3`
- 描述 执行单精度负数融合乘法减法。
- 执行` f[rd] = -f[rs1]×f[rs2]-f[rs3]`



```
function clause execute (F_MADD_TYPE_S(rs3, rs2, rs1, rm, rd, op)) = {
  let rs1_val_32b = F_or_X_S(rs1);
  let rs2_val_32b = F_or_X_S(rs2);
  let rs3_val_32b = F_or_X_S(rs3);
  match (select_instr_or_fcsr_rm (rm)) {
    None() => { handle_illegal(); RETIRE_FAIL },
    Some(rm') => {
      let rm_3b = encdec_rounding_mode(rm');
      let (fflags, rd_val_32b) : (bits(5), bits(32)) =
        match op {
          FMADD_S  => riscv_f32MulAdd (rm_3b, rs1_val_32b, rs2_val_32b, rs3_val_32b),
          FMSUB_S  => riscv_f32MulAdd (rm_3b, rs1_val_32b, rs2_val_32b, negate_S (rs3_val_32b)),
          FNMSUB_S => riscv_f32MulAdd (rm_3b, negate_S (rs1_val_32b), rs2_val_32b, rs3_val_32b),
          FNMADD_S => riscv_f32MulAdd (rm_3b, negate_S (rs1_val_32b), rs2_val_32b, negate_S (rs3_val_32b))
        };
      accrue_fflags(fflags);
      F_or_X_S(rd) = rd_val_32b;
      RETIRE_SUCCESS
    }
  }
}

/* AST -> Assembly notation ================================ */

mapping f_madd_type_mnemonic_S : f_madd_op_S <-> string = {
    FMADD_S  <-> "fmadd.s",
    FMSUB_S  <-> "fmsub.s",
    FNMSUB_S <-> "fnmsub.s",
    FNMADD_S <-> "fnmadd.s"
}

mapping clause assembly = F_MADD_TYPE_S(rs3, rs2, rs1, rm, rd, op)
                      <-> f_madd_type_mnemonic_S(op)
                          ^ spc() ^ freg_or_reg_name(rd)
                          ^ sep() ^ freg_or_reg_name(rs1)
                          ^ sep() ^ freg_or_reg_name(rs2)
                          ^ sep() ^ freg_or_reg_name(rs3)
                          ^ sep() ^ frm_mnemonic(rm)

```



## fadd.s

| 13-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| 00000 | 00    | rs2   | rs1   | rm    | rd   | 10100 | 11   |

- 格式 `fadd.s rd,rs1,rs2`
- 描述 执行单精度浮点加法。
- 执行` f[rd] = f[rs1] + f[rs2]`



## fsub.s

| 13-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| 00001 | 00    | rs2   | rs1   | rm    | rd   | 10100 | 11   |

- 格式 `fsub.s rd,rs1,rs2`
- 描述 执行单精度浮点减法。
- 执行` f[rd] = f[rs1] - f[rs2]`



## fmul.s

| 13-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| 00010 | 00    | rs2   | rs1   | rm    | rd   | 10100 | 11   |

- 格式 `fmul.s rd,rs1,rs2`
- 描述 执行单精度浮点乘法。
- 执行` f[rd] = f[rs1] x f[rs2]`



## fdiv.s

| 13-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| 00011 | 00    | rs2   | rs1   | rm    | rd   | 10100 | 11   |

- 格式 `fdiv.s rd,rs1,rs2`
- 描述 执行单精度浮点除法。
- 执行` f[rd] = f[rs1] / f[rs2]`



```
function clause execute (F_BIN_RM_TYPE_S(rs2, rs1, rm, rd, op)) = {
  let rs1_val_32b = F_or_X_S(rs1);
  let rs2_val_32b = F_or_X_S(rs2);
  match (select_instr_or_fcsr_rm (rm)) {
    None() => { handle_illegal(); RETIRE_FAIL },
    Some(rm') => {
      let rm_3b = encdec_rounding_mode(rm');
      let (fflags, rd_val_32b) : (bits(5), bits(32)) = match op {
        FADD_S  => riscv_f32Add (rm_3b, rs1_val_32b, rs2_val_32b),
        FSUB_S  => riscv_f32Sub (rm_3b, rs1_val_32b, rs2_val_32b),
        FMUL_S  => riscv_f32Mul (rm_3b, rs1_val_32b, rs2_val_32b),
        FDIV_S  => riscv_f32Div (rm_3b, rs1_val_32b, rs2_val_32b)
      };
      accrue_fflags(fflags);
      F_or_X_S(rd) = rd_val_32b;
      RETIRE_SUCCESS
    }
  }
}

/* AST -> Assembly notation ================================ */

mapping f_bin_rm_type_mnemonic_S : f_bin_rm_op_S <-> string = {
  FADD_S  <-> "fadd.s",
  FSUB_S  <-> "fsub.s",
  FMUL_S  <-> "fmul.s",
  FDIV_S  <-> "fdiv.s"
}

mapping clause assembly = F_BIN_RM_TYPE_S(rs2, rs1, rm, rd, op)
                      <-> f_bin_rm_type_mnemonic_S(op)
                          ^ spc() ^ freg_or_reg_name(rd)
                          ^ sep() ^ freg_or_reg_name(rs1)
                          ^ sep() ^ freg_or_reg_name(rs2)
                          ^ sep() ^ frm_mnemonic(rm)

```



## fsqrt.s

| 13-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| 01011 | 00    | 00000 | rs1   | rm    | rd   | 10100 | 11   |

- 格式 `fsqrt.s rd,rs1,rs2`
- 描述 执行单精度平方根。
- 执行` f[rd] = sqrt(f[rs1])`



## fmin.s

| 13-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| 00101 | 00    | rs2   | rs1   | 000   | rd   | 10100 | 11   |

- 格式 `fmin.s rd,rs1,rs2`
- 描述 将 rs1 和 rs2 中的单精度数据中较小的写入到 rd。
- 执行` f[rd] = min(f[rs1], f[rs2])`



## fmax.s

| 13-27 | 26-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ----- | ----- | ----- | ----- | ---- | ----- | ---- |
| 00101 | 00    | rs2   | rs1   | 001   | rd   | 10100 | 11   |

- 格式 `fmax.s rd,rs1,rs2`
- 描述 将 rs1 和 rs2 中的单精度数据中较大的写入到 rd。
- 执行` f[rd] = max(f[rs1], f[rs2])`

