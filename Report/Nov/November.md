# 工作报告

#### OpenEuler

- 根据上周RC8测试分析结果，编写了测试文档[PR](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/pulls/105)
- 对OpenEuler 2303 RISCV进行了[test1](./week21/oefor2309test_2)范围的测试，得到部分测试结果并与之前进行的测试结果进行了简单的比对[Result](./week21/2303ResultReport.md)

- 对openEuler2309独立发版镜像进行lpi4a硬件测试，测得2309在lpi4a上运行正常，提交测试结果[#pr1](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/pulls/1)
- 编写了lpi4a的openEuler2309安装文档并进行提交[#pr4](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/pulls/4)
- 对openEuler2309独立发版镜像进行VF2硬件测试，测得2309在VF2上运行正常，提交测试结果[#pr6](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/pulls/6)
- 对OpenEuler 2309 RISCV qemu进行了[test1](./week21/oefor2309test_2)范围的测试，并在OpenEuler 2309 x86 及OpenEuler 2303 x86上进行对比测试，产生测试报告[report](./week22/Mugen.md)

#### RuyiSDK

- 在玮霖更新测试用例后在openeuler 2309和ubuntu上进行ruyi范围的测试，无报错
- 对玮琳在ruyi中出现的错误进行了错误复现，发现错误类型相同
- 对ruyi包管理器进行手动测试，发现未预装tar的情况下ruyi会[报错](./week22/ruyi.md)并提交issue[#12](https://github.com/ruyisdk/ruyi/issues/12)

#### SAIL QTRVSIM

- 对Qtrvsim的README文档及user下的两个文档进行了汉化，并对文档中的部分内容进行了验证并提交[pr#7](https://gitee.com/yunxiangluo/qtrvsim-test/pulls/7)[pr#2](https://gitee.com/yunxiangluo/qtrvsim-test/pulls/7)
- 在技术分享中对qtrvsim进行了简单的介绍，主要介绍了qtrvsim是怎样的软件
- 学习了仓库[Sail-RISCV](https://github.com/riscv/sail-riscv)，按照教程安装了Opam及Sail并运行了测试套并产出[log](./week18/sail_test)
- 创建了Sail学习笔记，并编写了通过Opam安装Sail的方式
- 进行了技术分享报告，分享了sail在ISA中的作用
- 继续学习Sail，更新学习笔记 [Note](https://github.com/Pagerd/PLCT/blob/main/Note/sail/README.md)

