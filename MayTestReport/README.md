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



### corosync



### corosync-qdevice



### cppcheck



### dblatex



### dbxtool



### dejagnu



### derby



### dhcp



### digest-list-tools



### dmidecode



### docker-engine



### dracut



### easymock



### ebtables



### etcd



### fastdfs



### fcgi



### fftw



### fio



### firebird



### firewalld



### freeipmi



### freeradius



### ganglia



### gradle



### groovy



### iftop



### initscrpits



### iSulad

