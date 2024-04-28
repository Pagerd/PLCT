##  操作步骤

在SG2380 web端上依次输入以下代码,创建一个c文件

```
$cat > sg.c
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main() {
    int16_t a[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
    int16_t b[15] = {0};
    asm volatile("sg.mset tilem, %0" :: "r"(3));
    asm volatile("sg.mset tilen, %0" :: "r"(5));
    asm volatile("sg.mset strc, %0" :: "r"(5));
    asm volatile("sg.mld m0, %0, e16, c" :: "r"(a));
    asm volatile("sg.mst %0, m0, e16, c" :: "r"(b));
    // succeed if b is equal to a.
    for (int i = 0; i < 15; i++) {
        printf("%d ", b[i]);
    }
    printf("\n");
    return 0;
}
```

随后使用clang将该C文件进行编译

```
clang -static sg.c -o vc_mls -march=rv64imafdcv_zicsr_zifencei_zfh_zba_zbb_zvfh_xsfvfnrclipxfqf_xsfvfwmaccqqq_xsfvqmaccqoq_xsfvcp_xsgmat --gcc-toolchain=/opt/riscv --sysroot=/opt/riscv/sysroot/ -g
```

随后使用qemu指令对生成的汇编文件进行运行

```
qemu-riscv64 -cpu max,vlen=512 vc_mls
```

##  预期结果

正常编译及启动，输入如下

```
1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
```

##  实际结果

正常编译及启动，内联汇编结果与汇编文件和C文件一起编译结果相同，输入如下

![1](.\image\3.png)