## lr.w

| 13-27 | 2625 | 25   | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ---- | ---- | ----- | ----- | ----- | ---- | ----- | ---- |
| 00010 | aq   | rl   | 00000 | rs1   | 010   | rd   | 01011 | 11   |

- 格式 `lr.w rd,rs1`
- 描述 从 rs1 中的地址加载一个字，将符号扩展值放入 rd 中，并在内存地址上注册一个保留。
- 执行 `x[rd] = LoadReserved32(M[x[rs1]])`



## sc.w

| 13-27 | 2625 | 25   | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| ----- | ---- | ---- | ----- | ----- | ----- | ---- | ----- | ---- |
| 00011 | aq   | rl   | rs2   | rs1   | 010   | rd   | 01011 | 11   |

- 格式 `sc.w rd,rs1,rs2`
- 描述 将 rs2 中的一个字写入 rs1 中的地址，sc 在成功时向 rd 写入零，在失败时写入非零代码。
- 执行 `x[rd] = StoreConditional32(M[x[rs1]], x[rs2])`



## amo___

|           | 13-27 | 2625 | 25   | 24-20 | 19-15 | 14-12 | 11-7 | 6-2   | 1-0  |
| --------- | ----- | ---- | ---- | ----- | ----- | ----- | ---- | ----- | ---- |
| amoswap.w | 00001 | aq   | rl   | rs2   | rs1   | 010   | rd   | 01011 | 11   |
| amoadd.w  | 00000 | aq   | rl   | rs2   | rs1   | 010   | rd   | 01011 | 11   |
| amoxor.w  | 00100 | aq   | rl   | rs2   | rs1   | 010   | rd   | 01011 | 11   |
| amoand.w  | 01100 | aq   | rl   | rs2   | rs1   | 010   | rd   | 01011 | 11   |
| amoor.w   | 01000 | aq   | rl   | rs2   | rs1   | 010   | rd   | 01011 | 11   |
| amomin.w  | 10000 | aq   | rl   | rs2   | rs1   | 010   | rd   | 01011 | 11   |
| amomax.w  | 10100 | aq   | rl   | rs2   | rs1   | 010   | rd   | 01011 | 11   |
| amominu.w | 11000 | aq   | rl   | rs2   | rs1   | 010   | rd   | 01011 | 11   |
| amomaxu.w | 11100 | aq   | rl   | rs2   | rs1   | 010   | rd   | 01011 | 11   |

- 格式 `amo___.w rd,rs2,(rs1)`
- 描述 从 rs1 中的地址原子加载一个 32 位有符号数据值，将该值放入寄存器 rd，

1. ​      `amoswap.w`:将加载的值和 rs2 中的原始 32 位有符号值互换，然后将结果存储回 rs1 中的地址。
2. ​      `amoadd.w`将加载的值与 rs2 中的原始 32 位有符号值相加，然后将结果存储回 rs1 中的地址。
3. ​      `amoxor.w`将加载的值与 rs2 中的原始 32 位有符号值进行异或操作，然后将结果存储回 rs1 中的地址。
4. ​     ` amoand.w`将加载的值与 rs2 中的原始 32 位有符号值进行and操作，然后将结果存储回 rs1 中的地址。
5. ​      `amoor.w`将加载的值与 rs2 中的原始 32 位有符号值进行or操作，然后将结果存储回 rs1 中的地址。
6. ​      `amomin.w`对加载的值和 rs2 中的原始 32 位有符号值应用 min 运算，然后将结果存储回 rs1 中的地址。
7. ​      `amomax.w`对加载的值和 rs2 中的原始 32 位有符号值应用 max 运算，然后将结果存储回 rs1 中的地址。
8. ​      `amominu.w`,与 `amomin.w`相似，但是为无符号运算
9. ​       `amomaxu.w`,与 `amomax.w`相似，但是为无符号运算
