# 工作报告

- 对OpenEuler 2303 RISCV进行了[test1](./week21/oefor2309test_2)范围的测试，得到部分测试结果并与之前进行的测试结果进行了简单的比对[Result](./week21/2303ResultReport.md)

- 对Qtrvsim的README文档及user下的两个文档进行了汉化，并对文档中的部分内容进行了验证并提交[pr#7](https://gitee.com/yunxiangluo/qtrvsim-test/pulls/7)[pr#2](https://gitee.com/yunxiangluo/qtrvsim-test/pulls/7)

- 周三在技术分享中对qtrvsim进行了简单的介绍，主要介绍了qtrvsim是怎样的软件

- 对玮琳在ruyi中出现的错误进行了错误复现，发现错误类型相同

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

  

  



