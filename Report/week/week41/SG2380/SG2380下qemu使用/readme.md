##  操作步骤

在SG2380 web端上依次输入以下代码,创建一个c文件

```
$cat > sg_mls.c
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

// Use extern method to use the assembly function.
extern void vcix_mls_asm(int m, int n, void *a, void *b);

int main() {
    int16_t a[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
    int16_t b[15] = {0};
    vcix_mls_asm(3, 5, a, b);
    // succeed if b is equal to a.
    for (int i = 0; i < 15; i++) {
        printf("%d ", b[i]);
    }
    printf("\n");
    return 0;
}
```

随后输入以下代码创建汇编文件

```
$cat > sg_mls_asm.S
.global vcix_mls_asm
.section .text.vcix_mls_asm

vcix_mls_asm:
    sg.mset tilem, a0
    sg.mset tilen, a1
    sg.mset strc, a1
    sg.mld m0, a2, e16, c
    sg.mst a3, m0, e16, c
    ret
```

使用clang将汇编文件和C文件一起编译

```
clang -static sg_mls.c sg_mls_asm.S -o vcix_mls -march=rv64imafdcv_zicsr_zifencei_zfh_zba_zbb_zvfh_xsfvfnrclipxfqf_xsfvfwmaccqqq_xsfvqmaccqoq_xsfvcp_xsgmat --gcc-toolchain=/opt/riscv --sysroot=/opt/riscv/sysroot/ -g
```

随后使用qemu指令对生成的汇编文件进行运行

```
qemu-riscv64 -cpu max,vlen=512 vcix_mls
```

##  预期结果

正常编译及启动，且命令行输出以下信息

```
1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
```

##  实际结果

云空间正常编译及qemu启动，且结果正常

![1](.\image\1.png)