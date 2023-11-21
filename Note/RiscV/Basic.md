#### Word 处理器中最常用的数据单位

在RISCV中，一个word有4个bytes，32个bits

#### lw读取数据

从内存中读取数据放到寄存器

#### sw存储数据

从寄存器中将数据存放到内存



### R-Type指令

add t0,s7,s5

add t0, s7, s5

其中 t0为x5 s7为x23 s5为x21

| func7 | rs2  | rs1  | func3 | rd   | op   |
| ----- | ---- | ---- | ----- | ---- | ---- |
| 0x00  | 21   | 23   | 0x0   | 5    | 0x33 |

op: Opcode to specify the operation and format of an instruction

rd :register destination operand

funct3: function code:partially,specifies the variant of the instruction to be executed

rs1: first register source operand

rs2: second register source operand

funct7: function code specifies the variant of the instruction to be executed



#### 加法add

add a,b,c #a = b + c

#### 常量加法addi

add a ,b ,20 # a = b+20

#### 减法sub

sub a, b, c #a = b - c

同样可以通过加负数来表达

addi a, b, -20 #a = b + -20

#### if-else语句

C语言中

```
if (i == j)
   f = g + h;
else
   f = g - h;
```

在RISCV中

```
                 bne s3 , s4 ,Subtract #if i != j goto Subtract
                 add s0 ,s1 ,s2        #f = g + h
                 jal zero , Exit       #goto Exit
 Subtract:       sub s0, s1 ,s2        #f = g - h
 Exit:    ...
```



#### 向左唯一sllli

slli t2 , s0, 4

```
s0 0x000002 = 2(10)
s0 00000000000000000000000000000010
t2 00000000000000000000000000100000
```

约等于

2x16 = 32

#### 逻辑运算and



