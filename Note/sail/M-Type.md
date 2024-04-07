## mul 乘法运算

| 31-25   | 24-20 | 19-15 | 14-12      | 11-7 | 6-0     |
| ------- | ----- | ----- | ---------- | ---- | ------- |
| funct7  | rs2   | rs1   | funct3     | rd   | opcode  |
| 0000001 | 乘数  | 乘数  | mul/000    | 结果 | 0110011 |
| 0000001 | 乘数  | 乘数  | mulh/001   | 结果 | 0110011 |
| 0000001 | 乘数  | 乘数  | mulhsu/010 | 结果 | 0110011 |
| 0000001 | 乘数  | 乘数  | mulhu/011  | 结果 | 0110011 |



mul执行有符号 rs1 与有符号 rs2 的 XLEN 位乘法，并将低 XLEN 位放入目标寄存器。

- mul rd,rs1,rs2  ===》x[rd] = x[rs1] × x[rs2]

mulh执行有符号 rs1 与有符号 rs2 的 XLEN 位乘法，并将高 XLEN 位放入目标寄存器。

- mulh rd,rs1,rs2 ===》x[rd] = (x[rs1] s×s x[rs2]) >>s XLEN

mulhsu执行有符号 rs1 与无符号 rs2 的 XLEN 位乘法，并将高 XLEN 位放入目标寄存器。

- mulhsu rd,rs1,rs2 ===》x[rd] = (x[rs1] s × x[rs2]) >>s XLEN

mulhu执行无符号 rs1 与无符号 rs2 的 XLEN 位乘法，并将高 XLEN 位放入目标寄存器中。

- mulhu rd,rs1,rs2 ===》x[rd] = (x[rs1] u × x[rs2]) >>u XLEN



对应在sail中的实现：

```
union clause ast = MUL : (regidx, regidx, regidx, bool, bool, bool)

mapping encdec_mul_op : (bool, bool, bool) <-> bits(3) = {
  (false, true, true)  <-> 0b000,
  (true, true, true)   <-> 0b001,
  (true, true, false)  <-> 0b010,
  (true, false, false) <-> 0b011
}

/* for some reason the : bits(3) here is still necessary - BUG */
mapping clause encdec = MUL(rs2, rs1, rd, high, signed1, signed2)
  <-> 0b0000001 @ rs2 @ rs1 @ encdec_mul_op(high, signed1, signed2) : bits(3) @ rd @ 0b0110011

function clause execute (MUL(rs2, rs1, rd, high, signed1, signed2)) = {
  if haveMulDiv() | haveZmmul() then {
    let rs1_val = X(rs1);
    let rs2_val = X(rs2);
    let rs1_int : int = if signed1 then signed(rs1_val) else unsigned(rs1_val);
    let rs2_int : int = if signed2 then signed(rs2_val) else unsigned(rs2_val);
    let result_wide = to_bits(2 * sizeof(xlen), rs1_int * rs2_int);
    let result = if   high
                 then result_wide[(2 * sizeof(xlen) - 1) .. sizeof(xlen)]
                 else result_wide[(sizeof(xlen) - 1) .. 0];
    X(rd) = result;
    RETIRE_SUCCESS
  } else {
    handle_illegal();
    RETIRE_FAIL
  }
}

mapping mul_mnemonic : (bool, bool, bool) <-> string = {
  (false, true, true)  <-> "mul",
  (true, true, true)   <-> "mulh",
  (true, true, false)  <-> "mulhsu",
  (true, false, false) <-> "mulhu"
}

mapping clause assembly = MUL(rs2, rs1, rd, high, signed1, signed2)
  <-> mul_mnemonic(high, signed1, signed2) ^ spc() ^ reg_name(rd) ^ sep() ^ reg_name(rs1) ^ sep() ^ reg_name(rs2)

```

## div除法运算

| 31-25   | 24-20 | 19-15  | 14-12    | 11-7 | 6-0     |
| ------- | ----- | ------ | -------- | ---- | ------- |
| funct7  | rs2   | rs1    | funct3   | rd   | opcode  |
| 0000001 | 除数  | 被除数 | div/100  | 结果 | 0110011 |
| 0000001 | 除数  | 被除数 | divu/101 | 结果 | 0110011 |

div执行 XLEN 位乘 XLEN 位的 rs1 除以 rs2 的有符号整数除法，向零舍入。

- div rd,rs1,rs2 ===> x[rd] = x[rs1] / x[rs2]

divu执行 XLEN 位乘 XLEN 位无符号整数除法 rs1 除以 rs2，向零舍入。

- divu rd,rs1,rs2 ===> x[rd] = x[rs1] /u x[rs2]



对应在sail中的实现

```
union clause ast = DIV : (regidx, regidx, regidx, bool)

mapping clause encdec = DIV(rs2, rs1, rd, s)
  <-> 0b0000001 @ rs2 @ rs1 @ 0b10 @ bool_not_bits(s) @ rd @ 0b0110011

function clause execute (DIV(rs2, rs1, rd, s)) = {
  if haveMulDiv() then {
    let rs1_val = X(rs1);
    let rs2_val = X(rs2);
    let rs1_int : int = if s then signed(rs1_val) else unsigned(rs1_val);
    let rs2_int : int = if s then signed(rs2_val) else unsigned(rs2_val);
    let q : int = if rs2_int == 0 then -1 else quot_round_zero(rs1_int, rs2_int);
    /* check for signed overflow */
    let q': int = if s & q > xlen_max_signed then xlen_min_signed else q;
    X(rd) = to_bits(sizeof(xlen), q');
    RETIRE_SUCCESS
  } else {
    handle_illegal();
    RETIRE_FAIL
  }
}

mapping maybe_not_u : bool <-> string = {
  false <-> "u",
  true  <-> ""
}

mapping clause assembly = DIV(rs2, rs1, rd, s)
  <-> "div" ^ maybe_not_u(s) ^ spc() ^ reg_name(rd) ^ sep() ^ reg_name(rs1) ^ sep() ^ reg_name(rs2)

```



## rem求余运算

| 31-25   | 24-20  | 19-15    | 14-12     | 11-7 | 6-0     |
| ------- | ------ | -------- | --------- | ---- | ------- |
| funct7  | rs2    | rs1      | funct3    | rd   | opcode  |
| 0000001 | 求余数 | 被求余数 | rem/110   | 结果 | 0110011 |
| 0000001 | 求余数 | 被求余数 | remu/1111 | 结果 | 0110011 |

对 rs1 和 rs2 执行 XLEN 位乘 XLEN 位求余运算。

- rem rd,rs1,rs2 ===>x[rd] = x[rs1] %s x[rs2]

对 rs1 和 rs2 执行 XLEN 位乘 XLEN 位无符号求余运算。

- remu rd,rs1,rs2===>x[rd] = x[rs1] %u x[rs2]

```
union clause ast = REM : (regidx, regidx, regidx, bool)

mapping clause encdec = REM(rs2, rs1, rd, s)
  <-> 0b0000001 @ rs2 @ rs1 @ 0b11 @ bool_not_bits(s) @ rd @ 0b0110011

function clause execute (REM(rs2, rs1, rd, s)) = {
  if haveMulDiv() then {
    let rs1_val = X(rs1);
    let rs2_val = X(rs2);
    let rs1_int : int = if s then signed(rs1_val) else unsigned(rs1_val);
    let rs2_int : int = if s then signed(rs2_val) else unsigned(rs2_val);
    let r : int = if rs2_int == 0 then rs1_int else rem_round_zero(rs1_int, rs2_int);
    /* signed overflow case returns zero naturally as required due to -1 divisor */
    X(rd) = to_bits(sizeof(xlen), r);
    RETIRE_SUCCESS
  } else {
    handle_illegal();
    RETIRE_FAIL
  }
}

mapping clause assembly = REM(rs2, rs1, rd, s)
  <-> "rem" ^ maybe_not_u(s) ^ spc() ^ reg_name(rd) ^ sep() ^ reg_name(rs1) ^ sep() ^ reg_name(rs2)

/* ****************************************************************** */
union clause ast = MULW : (regidx, regidx, regidx)

mapping clause encdec = MULW(rs2, rs1, rd)
      if sizeof(xlen) == 64
  <-> 0b0000001 @ rs2 @ rs1 @ 0b000 @ rd @ 0b0111011
      if sizeof(xlen) == 64

function clause execute (MULW(rs2, rs1, rd)) = {
  if haveMulDiv() | haveZmmul() then {
    let rs1_val = X(rs1)[31..0];
    let rs2_val = X(rs2)[31..0];
    let rs1_int : int = signed(rs1_val);
    let rs2_int : int = signed(rs2_val);
    /* to_bits requires expansion to 64 bits followed by truncation */
    let result32 = to_bits(64, rs1_int * rs2_int)[31..0];
    let result : xlenbits = sign_extend(result32);
    X(rd) = result;
    RETIRE_SUCCESS
  } else {
    handle_illegal();
    RETIRE_FAIL
  }
}

mapping clause assembly = MULW(rs2, rs1, rd)
      if sizeof(xlen) == 64
  <-> "mulw" ^ spc() ^ reg_name(rd) ^ sep() ^ reg_name(rs1) ^ sep() ^ reg_name(rs2)
      if sizeof(xlen) == 64
```

