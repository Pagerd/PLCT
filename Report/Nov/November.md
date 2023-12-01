# 工作报告

#### OpenEuler

- 根据上周RC8测试分析结果，编写了测试文档[PR](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/pulls/105)
- 对OpenEuler 2303 RISCV进行了[test1](./week21/oefor2309test_2)范围的测试，得到部分测试结果并与之前进行的测试结果进行了简单的比对[Result](./week21/2303ResultReport.md)

- 对openEuler2309独立发版镜像进行lpi4a硬件测试，测得2309在lpi4a上运行正常，提交测试结果[#pr1](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/pulls/1)
- 编写了lpi4a的openEuler2309安装文档并进行提交[#pr4](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/pulls/4)
- 对openEuler2309独立发版镜像进行VF2硬件测试，测得2309在VF2上运行正常，提交测试结果[#pr6](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/pulls/6)
- 对OpenEuler 2309 RISCV qemu进行了[test1](./week21/oefor2309test_2)范围的测试，并在OpenEuler 2309 x86 及OpenEuler 2303 x86上进行对比测试，产生初步测试报告[report](./week22/Mugen.md)，遗漏部分测试套正在重新测试

#### RuyiSDK

- 11月7日在玮霖更新测试用例后在openeuler 2309和ubuntu上进行ruyi范围的测试，无报错

- 在20231107 版本中对ruyi在Ubuntu及OpenEuler 2303 2309上进行验证测试，测试通过[log](./week18/ruyi)

- 11月22日在对玮琳在ruyi23031107中出现的错误进行了错误复现，发现错误类型相同

  ```
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-addr2line -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-ar -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-as -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-c++ -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-cc -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-c++filt -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-cpp -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-elfedit -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-g++ -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-gcc -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-gcc-ar -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-gccgo -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-gcc-nm -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-gcc-ranlib -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-gcov -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-gcov-dump -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-gcov-tool -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-gdb -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-gdb-add-index -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-gfortran -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-gprof -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-ld -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-ld.bfd -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-ldd -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-lto-dump -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-nm -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-objcopy -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-objdump -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-ranlib -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-readelf -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-size -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-strings -> /tmp/onefile_300597_1700793347_544281/__main__.py
  lrwxrwxrwx 1 Pagerd   49 Nov 24 10:35 riscv64-plct-linux-gnu-strip -> /tmp/onefile_300597_1700793347_544281/__main__.py
  -rw-r--r-- 1 Pagerd 1264 Nov 24 10:35 ruyi-activate
  
  «Ruyi milkv-venv» $ ls /tmp/onefile_300597_1700793347_544281/__main__.py
  ls: cannot access '/tmp/onefile_300597_1700793347_544281/__main__.py': No such file or directory
  ```

  

- 对ruyi包管理器20231126进行手动测试，发现在OpenEuler 2303 x86下下ruyi会[报错](./week22/ruyi.md)(未预装tar)并提交issue[#12](https://github.com/ruyisdk/ruyi/issues/12)

#### SAIL QTRVSIM

- 对Qtrvsim的README文档及user下的两个文档进行了汉化，并对文档中的部分内容进行了验证并提交[pr#7](https://gitee.com/yunxiangluo/qtrvsim-test/pulls/7)[pr#2](https://gitee.com/yunxiangluo/qtrvsim-test/pulls/7)
- 在技术分享中对qtrvsim进行了简单的介绍，主要介绍了qtrvsim是怎样的软件
- 学习了仓库[Sail-RISCV](https://github.com/riscv/sail-riscv)，按照教程安装了Opam及Sail并运行了测试套并产出[log](./week18/sail_test)
- 创建了Sail学习笔记，并编写了通过Opam安装Sail的方式
- 进行了技术分享报告，分享了sail在ISA中的作用
- 继续学习Sail，更新学习笔记 [Note](https://github.com/Pagerd/PLCT/blob/main/Note/sail/README.md)

