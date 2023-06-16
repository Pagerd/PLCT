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
