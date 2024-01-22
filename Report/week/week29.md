## 本周工作

#### OpenEuler

- 将剩余的仅RV失败的测试用例提交至riscv issue [#I8XL9B](https://gitee.com/openeuler/RISC-V/issues/I8XL9B)

#### RuyiSDK

- 在Lpi4A的revyos系统上进行了ruyi 20240116 mugen自动测试，测试用例全部通过，产出文档 [md](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240116/RevyOS-LPi4A.md)
- 在pioneer box SG2042的fedora系统上进行了ruyi 20240116 mugen自动测试，测试用例全部通过，产出文档 [md](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240116/fedora-SG2042-Pioneer.md)
- 对ruyi镜像烧录工具进行了测试，在Milk V duo上成功使用ruyi镜像烧录工具烧录镜像并启动 [md](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240116/MilkV-Duo-%E9%95%9C%E5%83%8F%E5%88%B7%E5%86%99%E6%B5%8B%E8%AF%95.md)
- 发现ruyi镜像烧录工具在下载镜像时出现的网络错误 [#issue46](https://github.com/ruyisdk/ruyi/issues/46)

#### 调研工作

- 继续调研 [基于 Eclipse CDT ，了解并以任一个demo走通RISC-V GDB调试过程，输出文档和视频 #4](https://github.com/ruyisdk/pmd/issues/4)，目前发现在eclipse上直接运行qemu调试时qemu会出现内存读取错误，正在查找解决办法，同时也在查看通过openocd进行gdb调试的方法。

