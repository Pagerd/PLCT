# 测试用例失败研究分析



### riscv fail(x86 successd)

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

### Smoke-docker

#### oe_test_docker_custom-image

打包构建时出错

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



### nodejs-clean-css

核心转储出错 Segmentation fault (core dumped)

log内无报错日志，复现测试环境后可以得到如下结果

```
[root@openeuler-riscv64 ~]# cleancss -h
Segmentation fault (core dumped)
[root@openeuler-riscv64 ~]# cleancss --help
Segmentation fault (core dumped)
```

#### oe_test_postgresql_vacuumdb:测试套编写错误

测试套内对应代码如下

```
    su - postgres -c "vacuumdb -z -e"
    CHECK_RESULT $?
    psql testdb -U postgres -h 127.0.0.1 -c "insert into test select generate_series(1,100000),random();"
    psql testdb -U postgres -h 127.0.0.1 -c "delete from test"
    temp1=$(du /var/lib/pgsql/data/base/$oid | awk '{printf $1}')
    su - postgres -c "vacuumdb -Z -e"
    CHECK_RESULT $?
    temp2=$(du /var/lib/pgsql/data/base/$oid | awk '{printf $1}')
    [ $temp1 -eq $temp2 ]
    CHECK_RESULT $?
```

报错为此行Z大写

```
    su - postgres -c "vacuumdb -Z -e"
```

经查阅相关文档后vacuumdb无大写Z参数

改为小写后测试用例通过



### embedded_security_config_test

#### oe_test_check_user_account_008:/etc/motd内没有相关信息

对应报错log如下

```
+ egrep -v '^\s*#|^\s*$' /etc/motd
+ CHECK_RESULT 1 0 0 'not set /etc/motd hello message'
+ actual_result=1
+ expect_result=0
```

### ocaml-20.03

#### oe_test_ocaml_davail:unsafe-string is not available.

对应报错log如下

```
+ ocamlmktop -unsafe-string example.ml
/usr/bin/ocamlc: OCaml has been configured with -force-safe-string: -unsafe-string is not available.
Usage: ocamlc <options> <files>
Try 'ocamlc --help' for more information.
```

#### oe_test_ocaml_ocaml-instr-report:使用了不存在的指令进行测试

对应log报错如下

```
+ ocaml-instr-report -f cal.awk score.txt
oe_test_ocaml_ocaml-instr-report.sh: line 29: ocaml-instr-report: command not found
+ CHECK_RESULT 127
+ actual_result=127
```



### x86 fail





### embedded_os_basic_extra_test

报错log均为尝试给/bin/文件夹内文件添加权限时报错，bin内均无所需文件

例：

```
+ setcap cap_linux_immutable=eip /bin/chattr.e2fsprogs
Failed to set capabilities on file '/bin/chattr.e2fsprogs': No such file or directory
```













### rhash

#### oe_test_rhash_1.4.0_rhash:测试套出错



测试套内对应失败的测试方法如下

```
rhash --edonr512 test1K.data 2>&1 | grep "cd0f7ecf145c769e462cb3d1cda0a7fb5503c11b0e29e0fe9071c27e07a74f2448686a2e54619dcee8ffcbc1012f6b393faf5e40de01f76f8c75689684c161e2  test1K.data"
```

实际测试结果如下

```
[root@openeuler-riscv64 common]# rhash --edonr512 test1K.data
9052ac32582d303e8220b7b1d3b187b2b7a43239bbb708222346db056c852be989d4ffe00df31fe80789a568096a0c4ff6dabcf77419b66bc28db871b49386e2  test1K.data
```



### smoke-docker

#### oe_test_docker_cp_001 包不存在 

#### oe_test_docker_create_002 包不存在

#### oe_test_docker_image_history_001 包不存在 

对应报错log如下

```
+ wget -P ../common/ https://repo.openeuler.org/openEuler-23.03/docker_img/riscv64/openEuler-docker.riscv64.tar.xz
--2023-06-23 04:29:08--  https://repo.openeuler.org/openEuler-23.03/docker_img/riscv64/openEuler-docker.riscv64.tar.xz
Resolving repo.openeuler.org (repo.openeuler.org)... 49.0.230.196
Connecting to repo.openeuler.org (repo.openeuler.org)|49.0.230.196|:443... connected.
HTTP request sent, awaiting response... 404 Not Found
2023-06-23 04:29:10 ERROR 404: Not Found.
```



### itstool

#### oe_test_itstool_2.0.4:包错误

对应报错log如下

```
+ itstool -j common/IT-join-1.xml common/IT-join-1-cs.mo common/IT-join-1-de.mo
Traceback (most recent call last):
  File "/usr/bin/itstool", line 1683, in <module>
    out.write(serialized)
TypeError: write() argument must be str, not bytes
```

### FS_Docker

打包错误，对应报错log如下

```
+ image_name=openEuler-docker.x86_64.tar.xz
+ docker load -i openEuler-docker.x86_64.tar.xz
runtime: lfstack.push invalid packing: node=0xffffff7f55b9c0 cnt=0x1 packed=0xffff7f55b9c00001 -> node=0xffff7f55b9c0
fatal error: lfstack.push
```



### phodav

#### oe_test_service_spice-webdavd：service stop failed



### groovy

缺少对应的软件包

```
 DNF_INSTALL 'groovy18 tar'
+ pkgs='groovy18 tar'
+ node=1
+ '[' -z '' ']'
+ tmpfile=
++ python3 /root/mugen/libs/locallibs/rpm_manage.py install --pkgs 'groovy18 tar' --node 1 --tempfile ''
+ tmpfile2='Last metadata expiration check: 0:08:31 ago on Mon 26 Jun 2023 01:57:00 AM CST.
Package tar-2:1.34-4.oe2303.riscv64 is already installed.
Error: 
 Problem: package groovy18-1.8.9-1.oe2303.noarch requires mvn(org.codehaus.gpars:gpars), but none of the providers can be installed
  - package gpars-1.2.1-13.oe2303.noarch requires mvn(org.codehaus.groovy:groovy-all), but none of the providers can be installed
  - conflicting requests
  - nothing provides mvn(jline:jline) needed by groovy-2.4.8-11.oe2303.noarch
(try to add '\''--skip-broken'\'' to skip uninstallable packages or '\''--nobest'\'' to use not only best candidate packages)'
+ '[' -z '' ']'
+ tmpfile='Last metadata expiration check: 0:08:31 ago on Mon 26 Jun 2023 01:57:00 AM CST.
Package tar-2:1.34-4.oe2303.riscv64 is already installed.
Error: 
 Problem: package groovy18-1.8.9-1.oe2303.noarch requires mvn(org.codehaus.gpars:gpars), but none of the providers can be installed
  - package gpars-1.2.1-13.oe2303.noarch requires mvn(org.codehaus.groovy:groovy-all), but none of the providers can be installed
  - conflicting requests
  - nothing provides mvn(jline:jline) needed by groovy-2.4.8-11.oe2303.noarch
(try to add '\''--skip-broken'\'' to skip uninstallable packages or '\''--nobest'\'' to use not only best candidate packages)'
```



### postgresql_20.03

##### oe_test_postgresql-contrib_pg_qrchivecleanup:测试用例命令行参数过多

log内对应报错如下

```
+ su - postgres -c 'oid2name -t test "oid2name"'
+ grep Filenode
oid2name: too many command-line arguments (first is "oid2name")
Try "oid2name --help" for more information.
+ CHECK_RESULT 1
+ actual_result=1
+ expect_result=0
```

##### oe_test_postgresql-contrib_pg_waldump:无法解析起始 WAL 位置“-n”

log内对应报错如下

```
+ su - postgres -c 'pg_waldump 000000010000000000000001 -f -s  -n 3'
+ grep rmgr
pg_waldump: error: could not parse start WAL location "-n"
Try "pg_waldump --help" for more information.
+ CHECK_RESULT 1
+ actual_result=1
+ expect_result=0
```

##### oe_test_postgresql-devel_ecpg:测试版本无ecpg命令支持

log内对应报错如下

```
+ su - postgres -c 'ecpg -c test.sqc'
-bash: line 1: ecpg: command not found
+ CHECK_RESULT 127
+ actual_result=127
+ expect_result=0
```

##### oe_test_postgresql_pg_dump_02:测试版本pg_dump指令不支持-o参数

log内对应报错如下

```
+ su - postgres -c 'pg_dump -o testdb >testfile'
pg_dump: invalid option -- 'o'
```

##### oe_test_postgresql_pg_dumpall01:测试版本pg_dumpall指令不支持-o参数

log内对应报错如下

```
+ su - postgres -c 'pg_dumpall -o > /var/lib/pgsql/test.sql'
pg_dumpall: invalid option -- 'o'
```

##### oe_test_postgresql-server_pg_receivewal:测试套中的正则表达式错误

log内对应报错如下

```
++ pgrep -f 'pg_receivewal -D /var/lib/pgsql/pg_receivewal -h ${NODE1_IPV4} -U sstest -w -p 5432'
pgrep: regex error: Invalid preceding regular expression
+ kill -9
kill: usage: kill [-s sigspec | -n signum | -sigspec] pid | jobspec ... or kill -l [sigspec]
+ CHECK_RESULT 2
+ actual_result=2
+ expect_result=0
......
pg_receivewal: error: FATAL:  role "sstest" does not exist
```





### embedded_security_config_test

##### oe_test_check_file_sys_protect_002: 目录内没有对应文件

log内对应报错如下

```
+ find /etc/securetty -type f -user root -group root -perm 600
find: ‘/etc/securetty’: No such file or directory
+ CHECK_RESULT 1 0 0 'check /etc/securetty file right fail'
+ actual_result=1
+ expect_result=0
```

##### oe_testcheck_file_sys_protect_003:audit内没有log文件

log内对应报错如下

```
+ find /var/log/audit/audit.log -type f -user root -group root -perm 600
find: ‘/var/log/audit/audit.log’: No such file or directory
+ CHECK_RESULT 1 0 0 'check /var/log/audit/audit.log file right fail'
+ actual_result=1
```

##### oe_test_check_log_001:audit内没有rules文件

log内对应报错如下

```
+ grep '\-w /var/log/lastlog -p wa -k logins' /etc/audit/audit.rules
grep: /etc/audit/audit.rules: No such file or directory
+ CHECK_RESULT 2 0 0 'check /etc/audit/audit.rules set fail'
+ actual_result=2
+ expect_result=0
+ mode=0
+ error_log='check /etc/audit/audit.rules set fail'
+ exit_mode=0
```



##### oe_test_check_file_sys_protect_004: 目录内没有对应文件

log内对应报错如下

```
+ find /init -type l -user root -group root -perm 777
find: ‘/init’: No such file or directory
+ CHECK_RESULT 1 0 0 'check /init file right fail'
+ actual_result=1
```

##### oe_test_check_file_sys_protect_005:设置默认权限错误

log内对应报错如下

```
++ umask
+ umaskValue=0022
+ test 0022 == 0077
+ CHECK_RESULT 1 0 0 'check umask default value fail'
+ actual_result=1
+ expect_result=0
......
+ grep '[umaskUMASK][[:space:]]\+077'
+ grep -iE '^\s*umask\s+' /etc/profile
+ CHECK_RESULT 1 0 0 'check /etc/profile set umask value fail'
+ actual_result=1
+ expect_result=0
```

##### oe_test_check_network_firewall_002:版本更新测试套没有跟上

log内对应报错如下

```
+ check_version 1 net.ipv4.conf.all.accept_redirects
+ grep -q 22.03
+ grep VERSION_ID /etc/os-release
+ '[' 1 -eq 0 ']'
+ CHECK_RESULT 1 0 0 'check net.ipv4.conf.all.accept_redirects set fail'
+ actual_result=1
```

测试使用的版本为23.03而测试套检测的是22.03版本

