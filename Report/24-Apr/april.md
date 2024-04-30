## 4月工作

###  SG2380云空间测试工作

##### 基础测试

- 进行了SG2380下clang编译测试 ,产出文档 [MD](https://github.com/Pagerd/PLCT/tree/main/Report/week/week41/SG2380/SG2380下clang编译/readme.md)
- 进行了SG2380下qemu使用测试，产出文档 [MD](https://github.com/Pagerd/PLCT/tree/main/Report/week/week41/SG2380/SG2380下qemu使用/readme.md)
- 进行了SG2380下内联汇编测试，产出文档[MD](https://github.com/Pagerd/PLCT/tree/main/Report/week/week41/SG2380/SG2380下内联汇编/readme.md)
- 进行了通过SSH登录SG2380云平台测试，产出文档[MD](https://github.com/Pagerd/PLCT/tree/main/Report/week/week41/SG2380/通过SSH登录SG2380云平台/readme.md)
- 进行了通过Web端登录SG2380云平台测试，产出文档[MD](https://github.com/Pagerd/PLCT/tree/main/Report/week/week41/SG2380/通过Web端登录SG2380云平台/readme.md)

##### 性能测试

- 进行了fio测试，产出文档[MD](https://github.com/Pagerd/PLCT/tree/main/Report/week/week41/SG2380/fio/readme.md)
- 进行了libMicro测试，产出文档[MD](https://github.com/Pagerd/PLCT/tree/main/Report/week/week41/SG2380/libMicro/readme.md)
- 进行了stream测试，产出文档[MD](https://github.com/Pagerd/PLCT/tree/main/Report/week/week41/SG2380/stream/readme.md)
- 进行了unixbench测试，产出文档[MD](https://github.com/Pagerd/PLCT/tree/main/Report/week/week41/SG2380/unixbench/readme.md)

### RuyiSDK

##### v0.8

- 在Milk-V Pioneer v1.3  Fedora 38上对ruyiv0.8.0版本进行mugen测试，测试用例全部通过，编写并提交了[测试报告](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240408/fedora-SG2042-Pioneer.md)
- 在LicheePi 4A RevyOS 上对ruyi v0.8.0版本进行mugen测试，测试用例全部通过，编写并提交了[测试报告](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240408/RevyOS-LPi4A.md)

##### v0.9

- 在Milk-V Pioneer v1.3  Fedora 38上对ruyiv0.9.0版本进行mugen测试，测试用例全部通过，编写并提交了[测试报告](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240423/fedora-SG2042-Pioneer.md)
-  在LicheePi 4A RevyOS 上对ruyi v0.9.0版本进行mugen测试，测试用例全部通过，编写并提交了[测试报告](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240423/RevyOS-LPi4A.md)
-  对ruyi Lichee Console 4A镜像烧录进行了测试，成功烧录并开机，编写并提交了[测试报告](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240423/LicheeConsole4A%E9%95%9C%E5%83%8F%E7%83%A7%E5%86%99%E6%B5%8B%E8%AF%95.md)

### Sail

##### 会议

- 参加了4月2日的 RISC-V Development Partners会议并写了[会议纪要](./week38/会议纪要.md)
- 参加了4月15日 Datacenter会议，编写了[会议纪要](https://github.com/Pagerd/PLCT/tree/main/Report/week/week40/Datacenter.md)
- 参加了4月23日sail Arch Compat. Test SlG meeting会议，产出了[会议纪要](https://github.com/Pagerd/PLCT/tree/main/Report/week/week41/note.md)

##### 调研

- 结合sail调研了RISCV M拓展，并编写了笔记[RISCV-M](https://github.com/Pagerd/PLCT/tree/main/Note/sail/M-Type.md)

- 调研了riscv-isac工具的功能和使用方法，目前isac有部分功能无法使用，编写了调研文档 [调研文档](https://github.com/Pagerd/PLCT/tree/main/Report/week/week39/riscv-isac.md)
- 和黄烁一起对ACT测试当前存在的不足及改进计划进行了调研，编写了[文档](https://github.com/Pagerd/PLCT/tree/main/Report/week/week40/act.md)
- 编写了[ACT测试当前存在的不足及改进计划调研](https://github.com/Pagerd/PLCT/tree/main/Report/week/ACT测试当前存在的不足及改进计划调研.pptx) PPT，并进行分享
- 调研了RISCV  A拓展，编写了笔记[RISCV-A](https://github.com/Pagerd/PLCT/tree/main/Note/sail/A-Type.md)
- 调研了RISCV  F拓展，编写了笔记[RISCV-F](https://github.com/Pagerd/PLCT/tree/main/Note/sail/F-Type.md)

##### 其余

- 编写了第一周测试小队的sail产出[产出](./week38/sail.md)
- 编写了第二周测试小队的sail产出[产出文档](https://github.com/Pagerd/PLCT/tree/main/Report/week/week39/sail.md)
- 在RISCV-ISAC仓库下将调研发现的错误提交了Issue [#87](https://github.com/riscv-software-src/riscv-isac/issues/87)