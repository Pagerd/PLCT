# 测试用例失败研究分析



### riscv fail(x86 successd)



### container-exception-logger

##### oe_test_container-exception-logger: 没有对应的riscv的docker包

下为对应的log文件

```
+ wget -q https://repo.openeuler.org/openEuler-23.03/docker_img/riscv64/openEuler-docker.riscv64.tar.xz
+ docker load
oe_test_container-exception-logger.sh: line 29: openEuler-docker.riscv64.tar.xz: No such file or directory
++ docker images --format '{{.Repository}}:{{.Tag}}'
```



### dnssec-trigger

##### oe_test_service_dnssec-triggerd:ModuleNotFoundError: No module named 'gi'\

下为对应的log文件

```
May 30 19:07:18 openeuler-riscv64 dnssec-trigger-script[729]: ModuleNotFoundError: No module named 'gi'
May 30 19:07:23 openeuler-riscv64 dnssec-trigger-script[735]: ModuleNotFoundError: No module named 'gi'
May 30 19:07:24 openeuler-riscv64 dnssec-triggerd[736]: ModuleNotFoundError: No module named 'gi'
May 30 19:07:35 openeuler-riscv64 dnssec-trigger-script[744]: ModuleNotFoundError: No module named 'gi'
May 30 19:07:47 openeuler-riscv64 dnssec-trigger-script[752]: ModuleNotFoundError: No module named 'gi'
May 30 19:07:51 openeuler-riscv64 dnssec-trigger-script[755]: ModuleNotFoundError: No module named 'gi'
May 30 19:07:52 openeuler-riscv64 dnssec-triggerd[756]: ModuleNotFoundError: No module named 'gi'
```

手动执行指令时出现如下错误

```
‘/etc/systemd/system/multi-user.target.wants/dnssec-triggerd.service’: No such file or directory
```



### fcoe-utils

##### oe_test_service_fcoe:fcoe启动失败

log内对应报错内容

```
+ test_restart fcoe.service
+ service=fcoe.service
+ systemctl restart fcoe.service
Job for fcoe.service failed because the control process exited with error code.
See "systemctl status fcoe.service" and "journalctl -xeu fcoe.service" for details.
```

在本地进行systemctl status之后显示的内容

```
× fcoe.service - Open-FCoE initiator daemon
     Loaded: loaded (/usr/lib/systemd/system/fcoe.service; disabled; vendor pre>
     Active: failed (Result: exit-code) since Fri 2023-06-16 18:22:31 CST; 1min>
    Process: 473 ExecStartPre=/sbin/modprobe -qa $SUPPORTED_DRIVERS (code=exite>

Jun 16 18:22:31 openeuler-riscv64 systemd[1]: Starting Open-FCoE initiator daem>
Jun 16 18:22:31 openeuler-riscv64 systemd[1]: fcoe.service: Control process exi>
Jun 16 18:22:31 openeuler-riscv64 systemd[1]: fcoe.service: Failed with result >
Jun 16 18:22:31 openeuler-riscv64 systemd[1]: Failed to start Open-FCoE initiat>


```




#### gdm

##### oe_test_service_gdm :log显示超时

```
+ systemctl start gdm.service
Wed May 31 05:55:10 2023 - ERROR - Timeout : Command 'bash -x oe_test_service_gdm.sh' timed out after 1799.998355 seconds
```

重测后依然无法通过，本地无法复现



### gegl04

##### oe_test_gegl04_gegl-imgcmp:log显示下载镜像源超时,重测后正常

下为log内对应报错的部分

```
[MIRROR] opus-1.3.1-4.oe2303.riscv64.rpm: Curl error (28): Timeout was reached for https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/testing/20230330/v0.2/repo/23.03/mainline/riscv64/opus-1.3.1-4.oe2303.riscv64.rpm [Operation too slow. Less than 1000 bytes/sec transferred the last 30 seconds]
[MIRROR] poppler-22.01.0-3.oe2303.riscv64.rpm: Curl error (28): Timeout was reached for https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/testing/20230330/v0.2/repo/23.03/mainline/riscv64/poppler-22.01.0-3.oe2303.riscv64.rpm [Operation too slow. Less than 1000 bytes/sec transferred the last 30 seconds]
[MIRROR] openblas-0.3.18-2.oe2303.riscv64.rpm: Curl error (28): Timeout was reached for https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/testing/20230330/v0.2/repo/23.03/mainline/riscv64/openblas-0.3.18-2.oe2303.riscv64.rpm [Operation too slow. Less than 1000 bytes/sec transferred the last 30 seconds]
[MIRROR] openblas-0.3.18-2.oe2303.riscv64.rpm: Curl error (28): Timeout was reached for https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/testing/20230330/v0.2/repo/23.03/mainline/riscv64/openblas-0.3.18-2.oe2303.riscv64.rpm [Operation too slow. Less than 1000 bytes/sec transferred the last 30 seconds]
[FAILED] openblas-0.3.18-2.oe2303.riscv64.rpm: No more mirrors to try - All mirrors were already tried without success
```



### geos

##### oe_test_geos_commandAndbaseFun:测试环境没有安装kernel-headers

下为log内对应报错部分

```
+ g++ geos_test.cpp -o geos_test
In file included from /usr/include/errno.h:28,
                 from /usr/include/c++/10.3.1/cerrno:42,
                 from /usr/include/c++/10.3.1/ext/string_conversions.h:44,
                 from /usr/include/c++/10.3.1/bits/basic_string.h:6545,
                 from /usr/include/c++/10.3.1/string:55,
                 from /usr/include/c++/10.3.1/bits/locale_classes.h:40,
                 from /usr/include/c++/10.3.1/bits/ios_base.h:41,
                 from /usr/include/c++/10.3.1/ios:42,
                 from /usr/include/c++/10.3.1/ostream:38,
                 from /usr/include/c++/10.3.1/iostream:39,
                 from geos_test.cpp:1:
/usr/include/bits/errno.h:26:11: fatal error: linux/errno.h: No such file or directory
   26 | # include <linux/errno.h>
      |           ^~~~~~~~~~~~~~~
compilation terminated.
```

在测试套内添加安装kernel-headers命令后测试通过

### htop

##### oe_test_htop_02:测试套编写错误,htop -V测试时v为小写导致测试失败

下为log内对应报错部分

```
 htop -v
+ grep htop
htop: invalid option -- 'v'
+ CHECK_RESULT 1 0 0 'Option test -v fails'
+ actual_result=1
+ expect_result=0
+ mode=0
+ error_log='Option test -v fails'
```

下为测试套内对应的

	htop -v | grep "htop"
	CHECK_RESULT $? 0 0 "Option test -v fails"

实际测试htop版本指令时v应为大写 

```
[root@openeuler-riscv64 ~]# htop -V
htop 3.2.1
```

修改测试套内的错误后测试通过



### FS_File

#### oe_test_FSIO_sys_fs_check:挂载硬盘时出错，显示硬盘不存在

下为log内对应报错部分

```
+ mount /dev/test_vggroup20230623013800/test_lv120230623022112 /tmp/ext420230623022112
mount: /tmp/ext420230623022112: special device /dev/test_vggroup20230623013800/test_lv120230623022112 does not exist.
+ CHECK_RESULT 32 0 0 'Mount failed.'
+ actual_result=32
+ expect_result=0
+ mode=0
+ error_log='Mount failed.'
```

#### oe_test_FSIO_modify_file



```
+ docker build -t new_euler:v1.0 .
runtime: lfstack.push invalid packing: node=0xffffff72b3e9c0 cnt=0x1 packed=0xffff72b3e9c00001 -> node=0xffff72b3e9c0
fatal error: lfstack.push

runtime stack:
runtime.throw({0xaaaaaac2e15b3e?, 0xaaaaaac1f8c078?})
	/usr/lib/golang/src/runtime/panic.go:1047 +0x44 fp=0xffffffd2a0c7c8 sp=0xffffffd2a0c7a0 pc=0xaaaaaac1f87324
runtime.(*lfstack).push(0xc00004e500?, 0xffffff72b3e9c0)
	/usr/lib/golang/src/runtime/lfstack.go:30 +0x120 fp=0xffffffd2a0c7f8 sp=0xffffffd2a0c7c8 pc=0xaaaaaac1f5b430
runtime.(*spanSetBlockAlloc).free(...)
	/usr/lib/golang/src/runtime/mspanset.go:292
runtime.(*spanSet).reset(0xaaaaaac40b9cf8)
	/usr/lib/golang/src/runtime/mspanset.go:265 +0xb0 fp=0xffffffd2a0c828 sp=0xffffffd2a0c7f8 pc=0xaaaaaac1f81148
runtime.finishsweep_m()
	/usr/lib/golang/src/runtime/mgcsweep.go:260 +0xc0 fp=0xffffffd2a0c860 sp=0xffffffd2a0c828 pc=0xaaaaaac1f75168
runtime.gcStart.func1()
	/usr/lib/golang/src/runtime/mgc.go:668 +0x20 fp=0xffffffd2a0c868 sp=0xffffffd2a0c860 pc=0xaaaaaac1f6a018
runtime.systemstack()
	/usr/lib/golang/src/runtime/asm_riscv64.s:133 +0x54 fp=0xffffffd2a0c870 sp=0xffffffd2a0c868 pc=0xaaaaaac1fb3f2c

goroutine 1 [running, locked to thread]:
runtime.systemstack_switch()
	/usr/lib/golang/src/runtime/asm_riscv64.s:96 +0x8 fp=0xc00051ee68 sp=0xc00051ee60 pc=0xaaaaaac1fb3ec0
runtime.gcStart({0xc000546000?, 0x4a000?, 0xc40c1a00?})
	/usr/lib/golang/src/runtime/mgc.go:667 +0x358 fp=0xc00051eef8 sp=0xc00051ee68 pc=0xaaaaaac1f6a390
runtime.mallocgc(0x49fa0, 0xaaaaaac32c97c0, 0x1)
	/usr/lib/golang/src/runtime/malloc.go:1148 +0x6a8 fp=0xc00051ef70 sp=0xc00051eef8 pc=0xaaaaaac1f5d048
runtime.newarray(0xd0?, 0x120000000002670?)
	/usr/lib/golang/src/runtime/malloc.go:1224 +0x6c fp=0xc00051ef90 sp=0xc00051ef70 pc=0xaaaaaac1f5d2ec
runtime.makeBucketArray(0xaaaaaac31d9e60, 0x58?, 0xaaaaaac1f63320?)
	/usr/lib/golang/src/runtime/map.go:363 +0x1b0 fp=0xc00051efb8 sp=0xc00051ef90 pc=0xaaaaaac1f5e180
runtime.hashGrow(0xaaaaaac2c20990?, 0xc0001ba7b0)
	/usr/lib/golang/src/runtime/map.go:1051 +0xa8 fp=0xc00051eff0 sp=0xc00051efb8 pc=0xaaaaaac1f5fee0
runtime.mapassign_faststr(0xaaaaaac31d9e60, 0xc0001ba7b0, {0xaaaaaac3093349, 0xb})
	/usr/lib/golang/src/runtime/map_faststr.go:276 +0xfc fp=0xc00051f058 sp=0xc00051eff0 pc=0xaaaaaac1f6338c
github.com/docker/cli/vendor/github.com/modern-go/reflect2.loadGo17Types()
	/home/abuild/rpmbuild/BUILD/components/cli/.gopath/src/github.com/docker/cli/vendor/github.com/modern-go/reflect2/type_map.go:79 +0x260 fp=0xc00051f110 sp=0xc00051f058 pc=0xaaaaaac2c20a30
github.com/docker/cli/vendor/github.com/modern-go/reflect2.init.0()
	/home/abuild/rpmbuild/BUILD/components/cli/.gopath/src/github.com/docker/cli/vendor/github.com/modern-go/reflect2/type_map.go:28 +0x130 fp=0xc00051f140 sp=0xc00051f110 pc=0xaaaaaac2c202b0
runtime.doInit(0xaaaaaac4015140)
	/usr/lib/golang/src/runtime/proc.go:6329 +0x134 fp=0xc00051f270 sp=0xc00051f140 pc=0xaaaaaac1f97084
runtime.doInit(0xaaaaaac4020d80)
	/usr/lib/golang/src/runtime/proc.go:6306 +0x74 fp=0xc00051f3a0 sp=0xc00051f270 pc=0xaaaaaac1f96fc4
runtime.doInit(0xaaaaaac401cb60)
	/usr/lib/golang/src/runtime/proc.go:6306 +0x74 fp=0xc00051f4d0 sp=0xc00051f3a0 pc=0xaaaaaac1f96fc4
runtime.doInit(0xaaaaaac4016a60)
	/usr/lib/golang/src/runtime/proc.go:6306 +0x74 fp=0xc00051f600 sp=0xc00051f4d0 pc=0xaaaaaac1f96fc4
runtime.doInit(0xaaaaaac40267a0)
	/usr/lib/golang/src/runtime/proc.go:6306 +0x74 fp=0xc00051f730 sp=0xc00051f600 pc=0xaaaaaac1f96fc4
runtime.doInit(0xaaaaaac4024320)
	/usr/lib/golang/src/runtime/proc.go:6306 +0x74 fp=0xc00051f860 sp=0xc00051f730 pc=0xaaaaaac1f96fc4
runtime.doInit(0xaaaaaac4025e00)
	/usr/lib/golang/src/runtime/proc.go:6306 +0x74 fp=0xc00051f990 sp=0xc00051f860 pc=0xaaaaaac1f96fc4
runtime.doInit(0xaaaaaac40193e0)
	/usr/lib/golang/src/runtime/proc.go:6306 +0x74 fp=0xc00051fac0 sp=0xc00051f990 pc=0xaaaaaac1f96fc4
runtime.doInit(0xaaaaaac40293e0)
	/usr/lib/golang/src/runtime/proc.go:6306 +0x74 fp=0xc00051fbf0 sp=0xc00051fac0 pc=0xaaaaaac1f96fc4
runtime.doInit(0xaaaaaac4021300)
	/usr/lib/golang/src/runtime/proc.go:6306 +0x74 fp=0xc00051fd20 sp=0xc00051fbf0 pc=0xaaaaaac1f96fc4
runtime.doInit(0xaaaaaac4021220)
	/usr/lib/golang/src/runtime/proc.go:6306 +0x74 fp=0xc00051fe50 sp=0xc00051fd20 pc=0xaaaaaac1f96fc4
runtime.doInit(0xaaaaaac401fd00)
	/usr/lib/golang/src/runtime/proc.go:6306 +0x74 fp=0xc00051ff80 sp=0xc00051fe50 pc=0xaaaaaac1f96fc4
runtime.main()
	/usr/lib/golang/src/runtime/proc.go:233 +0x1d0 fp=0xc00051ffd8 sp=0xc00051ff80 pc=0xaaaaaac1f89908
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc00051ffd8 sp=0xc00051ffd8 pc=0xaaaaaac1fb613c

goroutine 2 [force gc (idle)]:
runtime.gopark(0x0?, 0x0?, 0x0?, 0x0?, 0x0?)
	/usr/lib/golang/src/runtime/proc.go:363 +0x110 fp=0xc00005efb0 sp=0xc00005ef98 pc=0xaaaaaac1f89d40
runtime.goparkunlock(...)
	/usr/lib/golang/src/runtime/proc.go:369
runtime.forcegchelper()
	/usr/lib/golang/src/runtime/proc.go:302 +0xb0 fp=0xc00005efd8 sp=0xc00005efb0 pc=0xaaaaaac1f89bc8
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc00005efd8 sp=0xc00005efd8 pc=0xaaaaaac1fb613c
created by runtime.init.5
	/usr/lib/golang/src/runtime/proc.go:290 +0x28

goroutine 3 [GC sweep wait]:
runtime.gopark(0x1?, 0x0?, 0x0?, 0x0?, 0x0?)
	/usr/lib/golang/src/runtime/proc.go:363 +0x110 fp=0xc00005f798 sp=0xc00005f780 pc=0xaaaaaac1f89d40
runtime.goparkunlock(...)
	/usr/lib/golang/src/runtime/proc.go:369
runtime.bgsweep(0x0?)
	/usr/lib/golang/src/runtime/mgcsweep.go:297 +0x114 fp=0xc00005f7c8 sp=0xc00005f798 pc=0xaaaaaac1f75314
runtime.gcenable.func1()
	/usr/lib/golang/src/runtime/mgc.go:178 +0x2c fp=0xc00005f7d8 sp=0xc00005f7c8 pc=0xaaaaaac1f69ae4
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc00005f7d8 sp=0xc00005f7d8 pc=0xaaaaaac1fb613c
created by runtime.gcenable
	/usr/lib/golang/src/runtime/mgc.go:178 +0x70

goroutine 4 [GC scavenge wait]:
runtime.gopark(0x0?, 0x0?, 0x0?, 0x0?, 0x412e848000000000?)
	/usr/lib/golang/src/runtime/proc.go:363 +0x110 fp=0xc00005ff80 sp=0xc00005ff68 pc=0xaaaaaac1f89d40
runtime.goparkunlock(...)
	/usr/lib/golang/src/runtime/proc.go:369
runtime.(*scavengerState).park(0xaaaaaac4091880)
	/usr/lib/golang/src/runtime/mgcscavenge.go:389 +0x68 fp=0xc00005ffa8 sp=0xc00005ff80 pc=0xaaaaaac1f73240
runtime.bgscavenge(0x0?)
	/usr/lib/golang/src/runtime/mgcscavenge.go:622 +0x6c fp=0xc00005ffc8 sp=0xc00005ffa8 pc=0xaaaaaac1f737ac
runtime.gcenable.func2()
	/usr/lib/golang/src/runtime/mgc.go:179 +0x2c fp=0xc00005ffd8 sp=0xc00005ffc8 pc=0xaaaaaac1f69a84
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc00005ffd8 sp=0xc00005ffd8 pc=0xaaaaaac1fb613c
created by runtime.gcenable
	/usr/lib/golang/src/runtime/mgc.go:179 +0xb0

goroutine 18 [finalizer wait]:
runtime.gopark(0x3000?, 0x18000?, 0x0?, 0x30?, 0x3000?)
	/usr/lib/golang/src/runtime/proc.go:363 +0x110 fp=0xc00005e5a8 sp=0xc00005e590 pc=0xaaaaaac1f89d40
runtime.goparkunlock(...)
	/usr/lib/golang/src/runtime/proc.go:369
runtime.runfinq()
	/usr/lib/golang/src/runtime/mfinal.go:180 +0x110 fp=0xc00005e7d8 sp=0xc00005e5a8 pc=0xaaaaaac1f68cd8
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc00005e7d8 sp=0xc00005e7d8 pc=0xaaaaaac1fb613c
created by runtime.createfing
	/usr/lib/golang/src/runtime/mfinal.go:157 +0x64

goroutine 35 [GC worker (idle)]:
runtime.gopark(0x0?, 0xaaaaaac1f56790?, 0xf4?, 0x41?, 0xaaaaaac1f56dc8?)
	/usr/lib/golang/src/runtime/proc.go:363 +0x110 fp=0xc00005a748 sp=0xc00005a730 pc=0xaaaaaac1f89d40
runtime.gcBgMarkWorker()
	/usr/lib/golang/src/runtime/mgc.go:1235 +0x100 fp=0xc00005a7d8 sp=0xc00005a748 pc=0xaaaaaac1f6bcd0
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc00005a7d8 sp=0xc00005a7d8 pc=0xaaaaaac1fb613c
created by runtime.gcBgMarkStartWorkers
	/usr/lib/golang/src/runtime/mgc.go:1159 +0x2c

goroutine 36 [GC worker (idle)]:
runtime.gopark(0xaaaaaac40c1ae0?, 0x3?, 0xb5?, 0x26?, 0x0?)
	/usr/lib/golang/src/runtime/proc.go:363 +0x110 fp=0xc0004de748 sp=0xc0004de730 pc=0xaaaaaac1f89d40
runtime.gcBgMarkWorker()
	/usr/lib/golang/src/runtime/mgc.go:1235 +0x100 fp=0xc0004de7d8 sp=0xc0004de748 pc=0xaaaaaac1f6bcd0
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc0004de7d8 sp=0xc0004de7d8 pc=0xaaaaaac1fb613c
created by runtime.gcBgMarkStartWorkers
	/usr/lib/golang/src/runtime/mgc.go:1159 +0x2c

goroutine 5 [GC worker (idle)]:
runtime.gopark(0xaaaaaac33e7f60?, 0xc0002e6bc0?, 0x18?, 0x14?, 0x0?)
	/usr/lib/golang/src/runtime/proc.go:363 +0x110 fp=0xc000060748 sp=0xc000060730 pc=0xaaaaaac1f89d40
runtime.gcBgMarkWorker()
	/usr/lib/golang/src/runtime/mgc.go:1235 +0x100 fp=0xc0000607d8 sp=0xc000060748 pc=0xaaaaaac1f6bcd0
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc0000607d8 sp=0xc0000607d8 pc=0xaaaaaac1fb613c
created by runtime.gcBgMarkStartWorkers
	/usr/lib/golang/src/runtime/mgc.go:1159 +0x2c

goroutine 20 [GC worker (idle)]:
runtime.gopark(0x436bf80d153?, 0x1?, 0x3a?, 0xa9?, 0x0?)
	/usr/lib/golang/src/runtime/proc.go:363 +0x110 fp=0xc00005af48 sp=0xc00005af30 pc=0xaaaaaac1f89d40
runtime.gcBgMarkWorker()
	/usr/lib/golang/src/runtime/mgc.go:1235 +0x100 fp=0xc00005afd8 sp=0xc00005af48 pc=0xaaaaaac1f6bcd0
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc00005afd8 sp=0xc00005afd8 pc=0xaaaaaac1fb613c
created by runtime.gcBgMarkStartWorkers
	/usr/lib/golang/src/runtime/mgc.go:1159 +0x2c

goroutine 6 [chan receive]:
runtime.gopark(0x50000001000e18?, 0xffffff712d5b08?, 0xa4?, 0x57?, 0xc0000b3a00?)
	/usr/lib/golang/src/runtime/proc.go:363 +0x110 fp=0xc0000616d8 sp=0xc0000616c0 pc=0xaaaaaac1f89d40
runtime.chanrecv(0xc00012a240, 0xc0000617b0, 0x40?)
	/usr/lib/golang/src/runtime/chan.go:583 +0x498 fp=0xc000061768 sp=0xc0000616d8 pc=0xaaaaaac1f57348
runtime.chanrecv2(0x6fc23ac00?, 0x0?)
	/usr/lib/golang/src/runtime/chan.go:447 +0x14 fp=0xc000061788 sp=0xc000061768 pc=0xaaaaaac1f56e9c
github.com/docker/cli/vendor/github.com/golang/glog.(*loggingT).flushDaemon(0x0?)
	/home/abuild/rpmbuild/BUILD/components/cli/.gopath/src/github.com/docker/cli/vendor/github.com/golang/glog/glog.go:882 +0x6c fp=0xc0000617c8 sp=0xc000061788 pc=0xaaaaaac2824d84
github.com/docker/cli/vendor/github.com/golang/glog.init.0.func1()
	/home/abuild/rpmbuild/BUILD/components/cli/.gopath/src/github.com/docker/cli/vendor/github.com/golang/glog/glog.go:410 +0x2c fp=0xc0000617d8 sp=0xc0000617c8 pc=0xaaaaaac2822f4c
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc0000617d8 sp=0xc0000617d8 pc=0xaaaaaac1fb613c
created by github.com/docker/cli/vendor/github.com/golang/glog.init.0
	/home/abuild/rpmbuild/BUILD/components/cli/.gopath/src/github.com/docker/cli/vendor/github.com/golang/glog/glog.go:410 +0x1e4
+ CHECK_RESULT 2 0 0 'Failed to create a mirror from Dockerfile'
+ actual_result=2
+ expect_result=0
+ mode=0
+ error_log='Failed to create a mirror from Dockerfile'
+ exit_mode=0
+ '[' -z 2 ']'
+ '[' 0 -eq 0 ']'
+ test 2x '!=' 0x
+ test -n 'Failed to create a mirror from Dockerfile'
+ LOG_ERROR 'Failed to create a mirror from Dockerfile'
+ message='Failed to create a mirror from Dockerfile'
+ python3 /root/mugen/libs/locallibs/mugen_log.py --level error --message 'Failed to create a mirror from Dockerfile'
Fri Jun 23 05:41:00 2023 - ERROR - Failed to create a mirror from Dockerfile
+ (( exec_result++ ))
+ LOG_ERROR 'oe_test_docker_custom-image.sh line 35'
+ message='oe_test_docker_custom-image.sh line 35'
+ python3 /root/mugen/libs/locallibs/mugen_log.py --level error --message 'oe_test_docker_custom-image.sh line 35'
Fri Jun 23 05:41:02 2023 - ERROR - oe_test_docker_custom-image.sh line 35
+ '[' 0 -eq 1 ']'
+ return 0
+ docker images
+ grep new_euler
runtime: lfstack.push invalid packing: node=0xffffff883819c0 cnt=0x1 packed=0xffff883819c00001 -> node=0xffff883819c0
fatal error: lfstack.push

runtime stack:
runtime.throw({0xaaaaaad6208b3e?, 0xaaaaaad537f078?})
	/usr/lib/golang/src/runtime/panic.go:1047 +0x44 fp=0xfffffff2a737e8 sp=0xfffffff2a737c0 pc=0xaaaaaad537a324
runtime.(*lfstack).push(0xc000050f00?, 0xffffff883819c0)
	/usr/lib/golang/src/runtime/lfstack.go:30 +0x120 fp=0xfffffff2a73818 sp=0xfffffff2a737e8 pc=0xaaaaaad534e430
runtime.(*spanSetBlockAlloc).free(...)
	/usr/lib/golang/src/runtime/mspanset.go:292
runtime.(*spanSet).reset(0xaaaaaad74accf8)
	/usr/lib/golang/src/runtime/mspanset.go:265 +0xb0 fp=0xfffffff2a73848 sp=0xfffffff2a73818 pc=0xaaaaaad5374148
runtime.finishsweep_m()
	/usr/lib/golang/src/runtime/mgcsweep.go:260 +0xc0 fp=0xfffffff2a73880 sp=0xfffffff2a73848 pc=0xaaaaaad5368168
runtime.gcStart.func1()
	/usr/lib/golang/src/runtime/mgc.go:668 +0x20 fp=0xfffffff2a73888 sp=0xfffffff2a73880 pc=0xaaaaaad535d018
runtime.systemstack()
	/usr/lib/golang/src/runtime/asm_riscv64.s:133 +0x54 fp=0xfffffff2a73890 sp=0xfffffff2a73888 pc=0xaaaaaad53a6f2c

goroutine 1 [running, locked to thread]:
runtime.systemstack_switch()
	/usr/lib/golang/src/runtime/asm_riscv64.s:96 +0x8 fp=0xc00051ee68 sp=0xc00051ee60 pc=0xaaaaaad53a6ec0
runtime.gcStart({0xc0002fc000?, 0x600?, 0xd5c366b4?})
	/usr/lib/golang/src/runtime/mgc.go:667 +0x358 fp=0xc00051eef8 sp=0xc00051ee68 pc=0xaaaaaad535d390
runtime.mallocgc(0x600, 0xaaaaaad6721de0, 0x1)
	/usr/lib/golang/src/runtime/malloc.go:1148 +0x6a8 fp=0xc00051ef70 sp=0xc00051eef8 pc=0xaaaaaad5350048
runtime.growslice(0xaaaaaad6721de0, {0xc0002f4c00?, 0x0?, 0xaaaaaad5350030?}, 0xaaaaaad74b4ae0?)
	/usr/lib/golang/src/runtime/slice.go:290 +0x524 fp=0xc00051efc8 sp=0xc00051ef70 pc=0xaaaaaad5391d8c
github.com/docker/cli/vendor/k8s.io/apimachinery/pkg/runtime.(*Scheme).AddKnownTypeWithName(0xc00012aae0, {{0xaaaaaad620a645, 0xd}, {0xaaaaaad62007cf, 0x7}, {0xaaaaaad6498814, 0xd}}, {0xaaaaaad67e6ed8?, 0xc00034aa40})
	/home/abuild/rpmbuild/BUILD/components/cli/.gopath/src/github.com/docker/cli/vendor/k8s.io/apimachinery/pkg/runtime/scheme.go:213 +0x324 fp=0xc00051f218 sp=0xc00051efc8 pc=0xaaaaaad5c316ec
github.com/docker/cli/vendor/k8s.io/apimachinery/pkg/runtime.(*Scheme).AddKnownTypes(0xc00012aae0, {{0xaaaaaad620a645?, 0xd?}, {0xaaaaaad62007cf?, 0xa?}}, {0xc00051f468, 0x4, 0xaaaaaad67e6f50?})
	/home/abuild/rpmbuild/BUILD/components/cli/.gopath/src/github.com/docker/cli/vendor/k8s.io/apimachinery/pkg/runtime/scheme.go:180 +0x1f8 fp=0xc00051f318 sp=0xc00051f218 pc=0xaaaaaad5c311d8
github.com/docker/cli/vendor/k8s.io/apimachinery/pkg/apis/meta/v1.AddToGroupVersion(0xc00012aae0?, {{0xaaaaaad620a645?, 0xaaaaaad67e5d30?}, {0xaaaaaad62007cf?, 0xaaaaaad67e5d58?}})
	/home/abuild/rpmbuild/BUILD/components/cli/.gopath/src/github.com/docker/cli/vendor/k8s.io/apimachinery/pkg/apis/meta/v1/register.go:50 +0x1fc fp=0xc00051f4f8 sp=0xc00051f318 pc=0xaaaaaad5c69734
github.com/docker/cli/vendor/k8s.io/api/events/v1beta1.addKnownTypes(0xc0001674c0?)
	/home/abuild/rpmbuild/BUILD/components/cli/.gopath/src/github.com/docker/cli/vendor/k8s.io/api/events/v1beta1/register.go:51 +0xd4 fp=0xc00051f570 sp=0xc00051f4f8 pc=0xaaaaaad5f424e4
github.com/docker/cli/vendor/k8s.io/apimachinery/pkg/runtime.(*SchemeBuilder).AddToScheme(0xc000167500?, 0xaaaaaad67e6e38?)
	/home/abuild/rpmbuild/BUILD/components/cli/.gopath/src/github.com/docker/cli/vendor/k8s.io/apimachinery/pkg/runtime/scheme_builder.go:29 +0x88 fp=0xc00051f5a0 sp=0xc00051f570 pc=0xaaaaaad5c35100
github.com/docker/cli/vendor/k8s.io/apimachinery/pkg/runtime.(*SchemeBuilder).AddToScheme-fm(0xaaaaaad67e6e88?)
	<autogenerated>:1 +0x3c fp=0xc00051f5b8 sp=0xc00051f5a0 pc=0xaaaaaad5c7b04c
github.com/docker/cli/vendor/k8s.io/client-go/kubernetes/scheme.AddToScheme(0xc000140100?)
	/home/abuild/rpmbuild/BUILD/components/cli/.gopath/src/github.com/docker/cli/vendor/k8s.io/client-go/kubernetes/scheme/register.go:97 +0x178 fp=0xc00051f5d0 sp=0xc00051f5b8 pc=0xaaaaaad606ab90
github.com/docker/cli/vendor/k8s.io/client-go/kubernetes/scheme.init.0()
	/home/abuild/rpmbuild/BUILD/components/cli/.gopath/src/github.com/docker/cli/vendor/k8s.io/client-go/kubernetes/scheme/register.go:63 +0x48 fp=0xc00051f600 sp=0xc00051f5d0 pc=0xaaaaaad606a9f8
runtime.doInit(0xaaaaaad74197a0)
	/usr/lib/golang/src/runtime/proc.go:6329 +0x134 fp=0xc00051f730 sp=0xc00051f600 pc=0xaaaaaad538a084
runtime.doInit(0xaaaaaad7417320)
	/usr/lib/golang/src/runtime/proc.go:6306 +0x74 fp=0xc00051f860 sp=0xc00051f730 pc=0xaaaaaad5389fc4
runtime.doInit(0xaaaaaad7418e00)
	/usr/lib/golang/src/runtime/proc.go:6306 +0x74 fp=0xc00051f990 sp=0xc00051f860 pc=0xaaaaaad5389fc4
runtime.doInit(0xaaaaaad740c3e0)
	/usr/lib/golang/src/runtime/proc.go:6306 +0x74 fp=0xc00051fac0 sp=0xc00051f990 pc=0xaaaaaad5389fc4
runtime.doInit(0xaaaaaad741c3e0)
	/usr/lib/golang/src/runtime/proc.go:6306 +0x74 fp=0xc00051fbf0 sp=0xc00051fac0 pc=0xaaaaaad5389fc4
runtime.doInit(0xaaaaaad7414300)
	/usr/lib/golang/src/runtime/proc.go:6306 +0x74 fp=0xc00051fd20 sp=0xc00051fbf0 pc=0xaaaaaad5389fc4
runtime.doInit(0xaaaaaad7414220)
	/usr/lib/golang/src/runtime/proc.go:6306 +0x74 fp=0xc00051fe50 sp=0xc00051fd20 pc=0xaaaaaad5389fc4
runtime.doInit(0xaaaaaad7412d00)
	/usr/lib/golang/src/runtime/proc.go:6306 +0x74 fp=0xc00051ff80 sp=0xc00051fe50 pc=0xaaaaaad5389fc4
runtime.main()
	/usr/lib/golang/src/runtime/proc.go:233 +0x1d0 fp=0xc00051ffd8 sp=0xc00051ff80 pc=0xaaaaaad537c908
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc00051ffd8 sp=0xc00051ffd8 pc=0xaaaaaad53a913c

goroutine 2 [force gc (idle)]:
runtime.gopark(0x0?, 0x0?, 0x0?, 0x0?, 0x0?)
	/usr/lib/golang/src/runtime/proc.go:363 +0x110 fp=0xc00005cfb0 sp=0xc00005cf98 pc=0xaaaaaad537cd40
runtime.goparkunlock(...)
	/usr/lib/golang/src/runtime/proc.go:369
runtime.forcegchelper()
	/usr/lib/golang/src/runtime/proc.go:302 +0xb0 fp=0xc00005cfd8 sp=0xc00005cfb0 pc=0xaaaaaad537cbc8
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc00005cfd8 sp=0xc00005cfd8 pc=0xaaaaaad53a913c
created by runtime.init.5
	/usr/lib/golang/src/runtime/proc.go:290 +0x28

goroutine 3 [GC sweep wait]:
runtime.gopark(0x1?, 0x0?, 0x0?, 0x0?, 0x0?)
	/usr/lib/golang/src/runtime/proc.go:363 +0x110 fp=0xc00005d798 sp=0xc00005d780 pc=0xaaaaaad537cd40
runtime.goparkunlock(...)
	/usr/lib/golang/src/runtime/proc.go:369
runtime.bgsweep(0x0?)
	/usr/lib/golang/src/runtime/mgcsweep.go:297 +0x114 fp=0xc00005d7c8 sp=0xc00005d798 pc=0xaaaaaad5368314
runtime.gcenable.func1()
	/usr/lib/golang/src/runtime/mgc.go:178 +0x2c fp=0xc00005d7d8 sp=0xc00005d7c8 pc=0xaaaaaad535cae4
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc00005d7d8 sp=0xc00005d7d8 pc=0xaaaaaad53a913c
created by runtime.gcenable
	/usr/lib/golang/src/runtime/mgc.go:178 +0x70

goroutine 4 [GC scavenge wait]:
runtime.gopark(0x0?, 0x0?, 0x0?, 0x0?, 0x412e848000000000?)
	/usr/lib/golang/src/runtime/proc.go:363 +0x110 fp=0xc00005df80 sp=0xc00005df68 pc=0xaaaaaad537cd40
runtime.goparkunlock(...)
	/usr/lib/golang/src/runtime/proc.go:369
runtime.(*scavengerState).park(0xaaaaaad7484880)
	/usr/lib/golang/src/runtime/mgcscavenge.go:389 +0x68 fp=0xc00005dfa8 sp=0xc00005df80 pc=0xaaaaaad5366240
runtime.bgscavenge(0x0?)
	/usr/lib/golang/src/runtime/mgcscavenge.go:622 +0x6c fp=0xc00005dfc8 sp=0xc00005dfa8 pc=0xaaaaaad53667ac
runtime.gcenable.func2()
	/usr/lib/golang/src/runtime/mgc.go:179 +0x2c fp=0xc00005dfd8 sp=0xc00005dfc8 pc=0xaaaaaad535ca84
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc00005dfd8 sp=0xc00005dfd8 pc=0xaaaaaad53a913c
created by runtime.gcenable
	/usr/lib/golang/src/runtime/mgc.go:179 +0xb0

goroutine 18 [finalizer wait]:
runtime.gopark(0x3000?, 0x18000?, 0x0?, 0x30?, 0x3000?)
	/usr/lib/golang/src/runtime/proc.go:363 +0x110 fp=0xc00005c5a8 sp=0xc00005c590 pc=0xaaaaaad537cd40
runtime.goparkunlock(...)
	/usr/lib/golang/src/runtime/proc.go:369
runtime.runfinq()
	/usr/lib/golang/src/runtime/mfinal.go:180 +0x110 fp=0xc00005c7d8 sp=0xc00005c5a8 pc=0xaaaaaad535bcd8
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc00005c7d8 sp=0xc00005c7d8 pc=0xaaaaaad53a913c
created by runtime.createfing
	/usr/lib/golang/src/runtime/mfinal.go:157 +0x64

goroutine 21 [GC worker (idle)]:
runtime.gopark(0x0?, 0xaaaaaad5349790?, 0xf4?, 0x71?, 0xaaaaaad5349dc8?)
	/usr/lib/golang/src/runtime/proc.go:363 +0x110 fp=0xc000058748 sp=0xc000058730 pc=0xaaaaaad537cd40
runtime.gcBgMarkWorker()
	/usr/lib/golang/src/runtime/mgc.go:1235 +0x100 fp=0xc0000587d8 sp=0xc000058748 pc=0xaaaaaad535ecd0
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc0000587d8 sp=0xc0000587d8 pc=0xaaaaaad53a913c
created by runtime.gcBgMarkStartWorkers
	/usr/lib/golang/src/runtime/mgc.go:1159 +0x2c

goroutine 5 [GC worker (idle)]:
runtime.gopark(0xaaaaaad67daf60?, 0xc000400820?, 0x18?, 0x14?, 0x0?)
	/usr/lib/golang/src/runtime/proc.go:363 +0x110 fp=0xc00005e748 sp=0xc00005e730 pc=0xaaaaaad537cd40
runtime.gcBgMarkWorker()
	/usr/lib/golang/src/runtime/mgc.go:1235 +0x100 fp=0xc00005e7d8 sp=0xc00005e748 pc=0xaaaaaad535ecd0
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc00005e7d8 sp=0xc00005e7d8 pc=0xaaaaaad53a913c
created by runtime.gcBgMarkStartWorkers
	/usr/lib/golang/src/runtime/mgc.go:1159 +0x2c

goroutine 22 [GC worker (idle)]:
runtime.gopark(0x4384cdf9172?, 0x3?, 0xea?, 0xa2?, 0x0?)
	/usr/lib/golang/src/runtime/proc.go:363 +0x110 fp=0xc000058f48 sp=0xc000058f30 pc=0xaaaaaad537cd40
runtime.gcBgMarkWorker()
	/usr/lib/golang/src/runtime/mgc.go:1235 +0x100 fp=0xc000058fd8 sp=0xc000058f48 pc=0xaaaaaad535ecd0
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc000058fd8 sp=0xc000058fd8 pc=0xaaaaaad53a913c
created by runtime.gcBgMarkStartWorkers
	/usr/lib/golang/src/runtime/mgc.go:1159 +0x2c

goroutine 23 [GC worker (idle)]:
runtime.gopark(0x4384bc5bf85?, 0x0?, 0x0?, 0x0?, 0x0?)
	/usr/lib/golang/src/runtime/proc.go:363 +0x110 fp=0xc000059748 sp=0xc000059730 pc=0xaaaaaad537cd40
runtime.gcBgMarkWorker()
	/usr/lib/golang/src/runtime/mgc.go:1235 +0x100 fp=0xc0000597d8 sp=0xc000059748 pc=0xaaaaaad535ecd0
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc0000597d8 sp=0xc0000597d8 pc=0xaaaaaad53a913c
created by runtime.gcBgMarkStartWorkers
	/usr/lib/golang/src/runtime/mgc.go:1159 +0x2c

goroutine 6 [chan receive]:
runtime.gopark(0x50000001000e68?, 0xffffffafff74b8?, 0xa4?, 0x87?, 0xc000493d40?)
	/usr/lib/golang/src/runtime/proc.go:363 +0x110 fp=0xc000059ed8 sp=0xc000059ec0 pc=0xaaaaaad537cd40
runtime.chanrecv(0xc000088060, 0xc000059fb0, 0x60?)
	/usr/lib/golang/src/runtime/chan.go:583 +0x498 fp=0xc000059f68 sp=0xc000059ed8 pc=0xaaaaaad534a348
runtime.chanrecv2(0x6fc23ac00?, 0x0?)
	/usr/lib/golang/src/runtime/chan.go:447 +0x14 fp=0xc000059f88 sp=0xc000059f68 pc=0xaaaaaad5349e9c
github.com/docker/cli/vendor/github.com/golang/glog.(*loggingT).flushDaemon(0x0?)
	/home/abuild/rpmbuild/BUILD/components/cli/.gopath/src/github.com/docker/cli/vendor/github.com/golang/glog/glog.go:882 +0x6c fp=0xc000059fc8 sp=0xc000059f88 pc=0xaaaaaad5c17d84
github.com/docker/cli/vendor/github.com/golang/glog.init.0.func1()
	/home/abuild/rpmbuild/BUILD/components/cli/.gopath/src/github.com/docker/cli/vendor/github.com/golang/glog/glog.go:410 +0x2c fp=0xc000059fd8 sp=0xc000059fc8 pc=0xaaaaaad5c15f4c
runtime.goexit()
	/usr/lib/golang/src/runtime/asm_riscv64.s:516 +0x4 fp=0xc000059fd8 sp=0xc000059fd8 pc=0xaaaaaad53a913c
created by github.com/docker/cli/vendor/github.com/golang/glog.init.0
	/home/abuild/rpmbuild/BUILD/components/cli/.gopath/src/github.com/docker/cli/vendor/github.com/golang/glog/glog.go:410 +0x1e4
```



## x86 fail

### auter

##### oe_test_auter:log显示开启服务失败，无法复现

下为log内对应报错部分

```
+ auter --enable
+ grep enabled
+ CHECK_RESULT 1 0 0 'Enable the failure'
+ actual_result=1
+ expect_result=0
+ mode=0
+ error_log='Enable the failure'

+ auter --prep
+ grep downloaded
Wed Jun  7 11:42:17 2023 - ERROR - Timeout : Command 'bash -x oe_test_auter.sh' timed out after 1799.997856011 seconds
```

在本地测试时的结果

```
[root@localhost ~]# auter --enable
INFO: auter enabled

[root@localhost ~]# auter --prep
INFO: Running with: /usr/bin/auter --prep
INFO: Running in an interactive shell, disabling all random sleeps
INFO: Updates downloaded


```

### autofs

##### oe_test_autofs:



##### oe_test_service_autofs:



### ceph

##### oe_test_service_rbdmap:rbdmap.service被屏蔽

log内对应报错内容

```
+ test_restart rbdmap.service
+ service=rbdmap.service
+ systemctl restart rbdmap.service
Failed to restart rbdmap.service: Unit rbdmap.service is masked.
+ CHECK_RESULT 1 0 0 'rbdmap.service restart failed'
+ actual_result=1
+ expect_result=0
```

##### oe_test_target_ceph:ceph.target被屏蔽

log内对应报错内容

```
 service=ceph.target
+ systemctl restart ceph.target
Failed to restart ceph.target: Unit ceph.target is masked.
+ CHECK_RESULT 1 0 0 'ceph.target restart failed'
+ actual_result=1
+ expect_result=0
+ mode=0
+ error_log='ceph.target restart failed'
```

### chrony

##### oe_test_service_chrony_wait:

### clamav

##### oe_test_clamav_clamdtop:



### clevis

##### oe_test_high_nbde:缺少cryptsetup-reencrypt

对应log如下

```
+ DNF_INSTALL 'tang clevis clevis-dracut cryptsetup-reencrypt clevis-udisks2'
+ pkgs='tang clevis clevis-dracut cryptsetup-reencrypt clevis-udisks2'
+ node=1
+ '[' -z '' ']'
+ tmpfile=
++ python3 /root/mugen/libs/locallibs/rpm_manage.py install --pkgs 'tang clevis clevis-dracut cryptsetup-reencrypt clevis-udisks2' --node 1 --tempfile ''
+ tmpfile2='Last metadata expiration check: 0:31:47 ago on Wed 07 Jun 2023 06:21:20 PM UTC.
No match for argument: cryptsetup-reencrypt
Error: Unable to find a match: cryptsetup-reencrypt'
```

##### oe_test_install_clevis:

对应log如下

```
+ clevis encrypt tang '{"url":"http://127.0.0.1:8009","adv":"adv.jws"}'
Advertisement file '' is malformed!
+ CHECK_RESULT 1 0 0 'Failed to encrypt file'
+ actual_result=1
+ expect_result=0
+ mode=0
+ error_log='Failed to encrypt file'
+ exit_mode=0
+ '[' -z 1 ']'
```

##### oe_test_service_clevis-luks-askpass:

对应log如下

```
+ service=clevis-luks-askpass.service
+ status='inactive (dead)'
+ systemctl status clevis-luks-askpass.service
+ grep Active
+ grep -v 'inactive (dead)'
     Active: active (running) since Wed 2023-06-07 18:59:28 UTC; 3s ago
+ CHECK_RESULT 0 0 1 'There is an error for the status of clevis-luks-askpass.service'
+ actual_result=0
+ expect_result=0
+ mode=1
+ error_log='There is an error for the status of clevis-luks-askpass.service'
+ exit_mode=0
+ '[' -z 0 ']'
+ '[' 1 -eq 0 ']'
```

##### oe_test_tang_encrypt:

对应log如下

```
+ tang-show-keys 8009
curl: (22) The requested URL returned error: 404
+ CHECK_RESULT 22 0 0 'Failed to check whether the Tang server advertises the signature key from the new key pair'
+ actual_result=22
+ expect_result=0
+ mode=0
```



### cmake

##### oe_test_ccmake:

对应log如下

```
spawn ccmake -B ../buildccmake -S ../../common/
Error opening terminal: unknown.
expect: spawn id exp3 not open
    while executing
"expect "*" {send "\r"}"
+ test -d ../buildccmake/CMakeFiles
+ CHECK_RESULT 1
+ actual_result=1
+ expect_result=0
```

##### oe_test_ccmake3:

对应log如下

```
+ expect
spawn ccmake3 -B ../buildccmake3 -S ../../common/
Error opening terminal: unknown.
expect: spawn id exp3 not open
    while executing
"expect "*" {send "\r"}"
+ test -d ../buildccmake3/CMakeFiles
+ CHECK_RESULT 1
+ actual_result=1
```



### cobbler

##### 所有测试套

对应log如下

```
+ cobbler distro add --name=OpenEuler1 --owners=root --boot-loader=grub --initrd=/mnt/images/pxeboot/initrd.img --kernel=/mnt/isolinux/vmlinuz
cobblerd does not appear to be running/accessible: ConnectionRefusedError(111, 'Connection refused')
Traceback (most recent call last):
  File "/usr/bin/cobbler", line 35, in <module>
    sys.exit(app.main())
  File "/usr/lib/python3.10/site-packages/cobbler/cli.py", line 852, in main
    rc = cli.run(sys.argv)
  File "/usr/lib/python3.10/site-packages/cobbler/cli.py", line 418, in run
    self.token = self.remote.login("", self.shared_secret)
  File "/usr/lib64/python3.10/xmlrpc/client.py", line 1122, in __call__
    return self.__send(self.__name, args)
  File "/usr/lib64/python3.10/xmlrpc/client.py", line 1464, in __request
    response = self.__transport.request(
  File "/usr/lib64/python3.10/xmlrpc/client.py", line 1166, in request
    return self.single_request(host, handler, request_body, verbose)
  File "/usr/lib64/python3.10/xmlrpc/client.py", line 1196, in single_request
    raise ProtocolError(
xmlrpc.client.ProtocolError: <ProtocolError for 127.0.0.1:80/cobbler_api: 503 Service Unavailable>
+ CHECK_RESULT 1 0 0 'Failed option: distro add'
```



### cockpit

##### oe_test_service_cockpit:

对应log报错内容如下：

```
+ DNF_INSTALL cockpit
+ pkgs=cockpit
+ node=1
+ '[' -z '' ']'
+ tmpfile=
++ python3 /root/mugen/libs/locallibs/rpm_manage.py install --pkgs cockpit --node 1 --tempfile ''
+ tmpfile2='Last metadata expiration check: 0:02:33 ago on Tue 30 May 2023 04:29:18 PM CST.
Error: 
 Problem: package libvirt-6.2.0-52.oe2303.riscv64 requires libvirt-daemon-driver-storage = 6.2.0-52.oe2303, but none of the providers can be installed
  - package cockpit-285-1.oe2303.riscv64 requires libvirt, but none of the providers can be installed
  - package libvirt-daemon-driver-storage-6.2.0-52.oe2303.riscv64 requires libvirt-daemon-driver-storage-rbd = 6.2.0-52.oe2303, but none of the providers can be installed
  - conflicting requests
  - nothing provides librados.so.2()(64bit) needed by libvirt-daemon-driver-storage-rbd-6.2.0-52.oe2303.riscv64
  - nothing provides librbd.so.1()(64bit) needed by libvirt-daemon-driver-storage-rbd-6.2.0-52.oe2303.riscv64
  - nothing provides librados.so.2(LIBRADOS_14.2.0)(64bit) needed by libvirt-daemon-driver-storage-rbd-6.2.0-52.oe2303.riscv64
(try to add '\''--skip-broken'\'' to skip uninstallable packages or '\''--nobest'\'' to use not only best candidate packages)'
+ '[' -z '' ']'
+ tmpfile='Last metadata expiration check: 0:02:33 ago on Tue 30 May 2023 04:29:18 PM CST.
Error: 
 Problem: package libvirt-6.2.0-52.oe2303.riscv64 requires libvirt-daemon-driver-storage = 6.2.0-52.oe2303, but none of the providers can be installed
  - package cockpit-285-1.oe2303.riscv64 requires libvirt, but none of the providers can be installed
  - package libvirt-daemon-driver-storage-6.2.0-52.oe2303.riscv64 requires libvirt-daemon-driver-storage-rbd = 6.2.0-52.oe2303, but none of the providers can be installed
  - conflicting requests
  - nothing provides librados.so.2()(64bit) needed by libvirt-daemon-driver-storage-rbd-6.2.0-52.oe2303.riscv64
  - nothing provides librbd.so.1()(64bit) needed by libvirt-daemon-driver-storage-rbd-6.2.0-52.oe2303.riscv64
  - nothing provides librados.so.2(LIBRADOS_14.2.0)(64bit) needed by libvirt-daemon-driver-storage-rbd-6.2.0-52.oe2303.riscv64
(try to add '\''--skip-broken'\'' to skip uninstallable packages or '\''--nobest'\'' to use not only best candidate packages)'
```



### conntrack-tools

##### oe_test_service_conntracked

```
+ journalctl --since '2023-05-30 16:41:38' -u conntrackd.service
+ grep -i 'fail\|error'
+ grep -v -i 'DEBUG\|INFO\|WARNING'
May 30 16:41:39 openeuler-riscv64 conntrackd[504]: [Tue May 30 16:41:39 2023] (pid=504) [ERROR] parsing config file in line (123), symbol 'SndSocketBuffer': syntax error
May 30 16:41:39 openeuler-riscv64 systemd[1]: conntrackd.service: Main process exited, code=exited, status=1/FAILURE
May 30 16:41:39 openeuler-riscv64 systemd[1]: conntrackd.service: Failed with result 'exit-code'.
May 30 16:42:03 openeuler-riscv64 conntrackd[520]: [Tue May 30 16:42:03 2023] (pid=520) [ERROR] parsing config file in line (123), symbol 'SndSocketBuffer': syntax error
May 30 16:42:03 openeuler-riscv64 systemd[1]: conntrackd.service: Main process exited, code=exited, status=1/FAILURE
May 30 16:42:03 openeuler-riscv64 systemd[1]: conntrackd.service: Failed with result 'exit-code'.
+ CHECK_RESULT 0 0 1 'There is an error message for the log of conntrackd.service'
```



### corosync

##### oe_test_service_corosync



### corosync-qdevice



### cppcheck

##### oe_test_cppcheck:

对应log如下

```
+ cppcheck -DA --force file.c
+ grep A=1
file.c:5:6: error: Array 'a[10]' accessed at index 10, which is out of bounds. [arrayIndexOutOfBounds]
    a[10] = 0;
     ^
Checking file.c: A=1...
+ CHECK_RESULT 0 1
+ actual_result=0
+ expect_result=1
+ mode=0
+ error_log=
+ exit_mode=0
+ '[' -z 0 ']'
+ '[' 0 -eq 0 ']'
+ test 0x '!=' 1x
+ test -n ''
+ (( exec_result++ ))
+ LOG_ERROR 'oe_test_cppcheck.sh line 95'
+ message='oe_test_cppcheck.sh line 95'
+ python3 /root/mugen/libs/locallibs/mugen_log.py --level error --message 'oe_test_cppcheck.sh line 95'
Tue May 30 17:01:24 2023 - ERROR - oe_test_cppcheck.sh line 95
```

测试用例内如下

```
if [ $VERSION_ID != "22.03" ]; then
        cppcheck -DA --force file.c | grep "A=1"
        CHECK_RESULT $? 1
    else
        cppcheck -DA --force file.c | grep "A=1"
        CHECK_RESULT $?
    fi
```

根据输出结果疑似为测试时23.03特性与22.03相符但是测试套没有更新

### dblatex



### dbxtool

##### oe_test_service_dbxtool:服务不存在





### dejagnu



### derby



### dhcp

服务启动不了

### digest-list-tools

服务启动不了

### dmidecode

测试套没有安装dmidecode就开始测试

### docker-engine

服务启动不了

### dracut

服务启动不了

### easymock

##### oe_test_easymock_spring

缺乏对应包

```
++ python3 /root/mugen/libs/locallibs/rpm_manage.py install --pkgs springframework-test --node 1 --tempfile ''
Fri May 26 01:04:51 2023 - ERROR - pkgs:(springframework-test) not found
```



### ebtables

服务启动不了

### etcd

服务启动不了

### fastdfs



### fcgi



### fftw



### fio



### firebird

服务启动不了

### firewalld

服务启动不了

### freeipmi

重启错误

### freeradius

超时

### ganglia



```
+ journalctl --since '2023-05-31 05:16:25' -u gmetad.service
+ grep -i 'fail\|error'
+ grep -v -i 'DEBUG\|INFO\|WARNING'
May 31 05:16:27 openeuler-riscv64 gmetad[531]: Process XML (my cluster): XML_ParseBuffer() error at line 91:
May 31 05:16:42 openeuler-riscv64 gmetad[549]: Process XML (my cluster): XML_ParseBuffer() error at line 91:
May 31 05:16:57 openeuler-riscv64 gmetad[549]: Process XML (my cluster): XML_ParseBuffer() error at line 91:
+ CHECK_RESULT 0 0 1 'There is an error message for the log of gmetad.service'
+ actual_result=0
+ expect_result=0
+ mode=1
+ error_log='There is an error message for the log of gmetad.service'
+ exit_mode=0
+ '[' -z 0 ']'
+ '[' 1 -eq 0 ']'
+ test 0x == 0x
+ test -n 'There is an error message for the log of gmetad.service'
+ LOG_ERROR 'There is an error message for the log of gmetad.service'
+ message='There is an error message for the log of gmetad.service'
+ python3 /root/mugen/libs/locallibs/mugen_log.py --level error --message 'There is an error message for the log of gmetad.service'
Wed May 31 05:17:13 2023 - ERROR - There is an error message for the log of gmetad.service
```



### gradle

gradle安装失败

### groovy

groovy安装失败

### iftop



```
+ grep :22
+ iftop -t -s 1 -P -c ./iftoprc
Wed May 31 08:08:06 2023 - ERROR - Timeout : Command 'bash -x oe_test_iftop_config.sh' timed out after 1799.9985311 seconds
```





### initscrpits

服务启动不了

### iSulad



```
+ journalctl --since '2023-05-31 07:49:33' -u isulad.service
+ grep -i 'fail\|error'
+ grep -v -i 'DEBUG\|INFO\|WARNING'
May 31 07:49:35 openeuler-riscv64 isulad[535]:          isulad 20230530234935.230 ERROR    /home/abuild/rpmbuild/BUILD/iSulad-v2.1.1/src/utils/cutils/utils_file.c:util_list_all_subdir:953 - Failed to open directory: /var/lib/isulad/engines error:No such file or directory
May 31 07:49:35 openeuler-riscv64 isulad[535]:          isulad 20230530234935.234 ERROR    /home/abuild/rpmbuild/BUILD/iSulad-v2.1.1/src/daemon/modules/container/restore/restore.c:containers_restore:549 - Failed to list engines
May 31 07:49:51 openeuler-riscv64 isulad[561]:          isulad 20230530234951.703 ERROR    /home/abuild/rpmbuild/BUILD/iSulad-v2.1.1/src/utils/cutils/utils_file.c:util_list_all_subdir:953 - Failed to open directory: /var/lib/isulad/engines error:No such file or directory
May 31 07:49:51 openeuler-riscv64 isulad[561]:          isulad 20230530234951.705 ERROR    /home/abuild/rpmbuild/BUILD/iSulad-v2.1.1/src/daemon/modules/container/restore/restore.c:containers_restore:549 - Failed to list engines
+ CHECK_RESULT 0 0 1 'There is an error message for the log of isulad.service'
+ actual_result=0
+ expect_result=0
+ mode=1
```

