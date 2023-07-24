# 工作报告

- 和玮霖老师商量了x86也失败的测试用例的测试分析分配工作，并认领了[list1](https://github.com/weilinfox/PLCT-Working/tree/master/Done/Week9/lists)的分析工作
- 对[list1](https://github.com/weilinfox/PLCT-Working/tree/master/Done/Week9/lists)中的部分测试用例进行了分析
- 将遗漏的FS_FileSystem测试套进行了测试并提交

# 测试分析

### oe_test_pyyaml：测试用例没有更新测试方法

riscv与x86均报相同错误，具体log如下：

```
Traceback (most recent call last):
  File "/root/mugen/testcases/cli-test/pyyaml/test2.py", line 21, in <module>
    get_yaml_data(yaml_path)
  File "/root/mugen/testcases/cli-test/pyyaml/test2.py", line 15, in get_yaml_data
    data = yaml.load(file_data)
TypeError: load() missing 1 required positional argument: 'Loader'

+ CHECK_RESULT 1 0 0 'Conversion to dictionary failed'
```

错误原因为Yaml 5.1版本后就舍弃了 yaml.load(file) 这个用法。Yaml 5.1版本之后为使得load函数的安全性得以提高，就修改了需要指定Loader，通过默认加载器（FullLoader）禁止执行任意函数。而测试用例并没有更新

### oe_test_tpm-tools_01

riscv与x86均报相同错误：

```
spawn tpm_getpubek
Tspi_Context_Connect failed: 0x00003011 - layer=tsp, code=0011 (17), Communication failure
expect: spawn id exp4 not open
    while executing
"expect eof"
+ grep -i '[0-9a-z]' log_getpubek1
```

推测原因为未开启tpmd和tcsd

### oe_test_hwloc_1.11.9_hwloc-assembler:不支持hwloc-assembler命令

riscv与x86报错相同，对应log如下

```
+ hwloc-assembler ./tmp/output.xml --name host1 ./common/host1.xml --name host2 ./common/host2.xml
oe_test_hwloc_1.11.9_hwloc-assembler.sh: line 31: hwloc-assembler: command not found
+ CHECK_RESULT 127 0 0 'hwloc-assembler --name  failed'
+ actual_result=127
```

推测为当前版本不支持hwloc-assembler命令

### oe_test_hwloc_1.11.9_hwloc-distances_01:不支持hwloc-distances命令

riscv与x86报错相同，log如下

```
+ hwloc-distances -l -i ./common/distances_test.xml
oe_test_hwloc_1.11.9_hwloc-distances_01.sh: line 30: hwloc-distances: command not found
+ grep 'below Machine L#0'
+ CHECK_RESULT 1 0 0 'hwloc-distances -l  failed'
```

### oe_test_hwloc_1.11.9_hwloc-distances_02:不支持hwloc-distances命令

riscv与x86报错相同，log如下

```
+ hwloc-distances --logical -i ./common/distances_test.xml
oe_test_hwloc_1.11.9_hwloc-distances_02.sh: line 30: hwloc-distances: command not found
+ CHECK_RESULT 1 0 0 'hwloc-distances --logical failed'
```

### oe_test_yajl:缺乏对应的软件包

x86与riscv报错均相同

在安装软件时显示没有对应软件包

报错内容如下

```
+ DNF_INSTALL 'yaji yaji-devel'
+ pkgs='yaji yaji-devel'
+ node=1
+ '[' -z '' ']'
+ tmpfile=
++ python3 /root/mugen/libs/locallibs/rpm_manage.py install --pkgs 'yaji yaji-devel' --node 1 --tempfile ''
+ tmpfile2='Last metadata expiration check: 3:15:40 ago on Fri 16 Jun 2023 01:09:39 AM CST.
No match for argument: yaji
No match for argument: yaji-devel
Error: Unable to find a match: yaji yaji-devel'
+ '[' -z '' ']'
+ tmpfile='Last metadata expiration check: 3:15:40 ago on Fri 16 Jun 2023 01:09:39 AM CST.
No match for argument: yaji
No match for argument: yaji-devel
Error: Unable to find a match: yaji yaji-devel'
+ LOG_INFO 'End of environmental preparation!'
+ message='End of environmental preparation!'
```

### oe_test_openssh_port:firewalld.service服务未加载

在尝试关闭firewalld.service时出错，firewalld.service服务未加载

riscv与x86报错均相同，如下

```
+ bash /root/mugen/libs/locallibs/sshcmd.sh -c '
    sed -i '\''s/#Port 22/Port 50000/g'\'' /etc/ssh/sshd_config
    systemctl restart sshd
    systemctl stop firewalld
    ' -i 10.198.114.6 -u root -p 'openEuler12#$' -t 300 -o 22
Fri Jun 16 04:14:42 2023 - WARN  - the remote user uses the default configuration.
Fri Jun 16 04:14:42 2023 - WARN  - the remote password uses the default configuration.
Fri Jun 16 04:14:43 2023 - WARN  - the connect port using the default configuration
spawn ssh -o ConnectTimeout=300 -p 22 root@10.198.114.6 
    sed -i 's/#Port 22/Port 50000/g' /etc/ssh/sshd_config
    systemctl restart sshd
    systemctl stop firewalld
    

root@10.198.114.6's password: 
Failed to stop firewalld.service: Unit firewalld.service not loaded.
```

### oe_test_openssh_port:SELinux 策略不受管理或无法访问存储。

在尝试使用semanage port --delete命令时出错

riscv与x86报错均相同，如下

```
+ semanage port --delete -t ssh_port_t -p tcp 36
ValueError: SELinux policy is not managed or store cannot be accessed.
```

同时测试用例的部分命令所需要的软件包未安装

riscv与x86报错均相同，如下

```
+ firewall-cmd --remove-port 36/tcp
oe_test_sec_ssh.sh: line 36: firewall-cmd: command not found
+ firewall-cmd --add-port 36/tcp
oe_test_sec_ssh.sh: line 37: firewall-cmd: command not found
```

### oe_test_hdparm:没有进行环境搭建就开始测试

mugen与riscv报错均相同

下为报错部分log

```
+ hdparm -h
+ grep -i Usage
oe_test_hdparm.sh: line 27: hdparm: command not found
+ CHECK_RESULT 1 0 0 'hdparm -h fail'
```

检查测试用例编写时发现并无环境搭建函数

```
source "$OET_PATH/libs/locallibs/common_lib.sh"


function run_test() {
    LOG_INFO "Start testing..."
    lsblk >> lsblk.txt
```

### oe_test_cvs_cvs_02:测试用例没有权限执行操作

### oe_test_cvs_cvs_03:测试用例没有权限执行操作,初始化失败

### oe_test_cvs_cvs_04:测试用例初始化失败

### oe_test_cvs_cvs_05:测试用例初始化失败

### oe_test_cvs_cvs_06:测试用例初始化失败

 riscv与x86报错均相同

在配置环境时报出以下错误

```
++ su cvsroot
cvs init: cannot open /root/mugen/testcases/cli-test/cvs/cvs_test/cvs_init_dir/CVSROOT/config: Permission denied
cvs [init aborted]: cannot make directory /root/mugen/testcases/cli-test/cvs/cvs_test/cvs_init_dir: Permission denied
cvs [import aborted]: /root/mugen/testcases/cli-test/cvs/cvs_test/cvs_init_dir/CVSROOT: Permission denied
++ cvs -d /root/mugen/testcases/cli-test/cvs/cvs_test/cvs_init_dir checkout myProject
cvs [checkout aborted]: /root/mugen/testcases/cli-test/cvs/cvs_test/cvs_init_dir/CVSROOT: No such file or directory
++ chown -R cvsroot.cvs myProject
chown: cannot access 'myProject': No such file or directory
++ chmod -R 775 myProject
chmod: cannot access 'myProject': No such file or directory
++ cd myProject
./init/cvs_complex.sh: line 37: cd: myProject: No such file or directory
++ chown -R cvsroot.cvs tmp.txt
chown: cannot access 'tmp.txt': No such file or directory
++ su cvsroot
cvs [commit aborted]: /root/mugen/testcases/cli-test/cvs/cvs_test/cvs_init_dir/CVSROOT: Permission denied
bash: line 2: tmp.txt: Permission denied
bash: line 3: 1.txt: Permission denied
mkdir: cannot create directory ‘dir’: Permission denied
touch: cannot touch 'dir/2.txt': No such file or directory
bash: line 4: dir/2.txt: No such file or directory
cvs [add aborted]: /root/mugen/testcases/cli-test/cvs/cvs_test/cvs_init_dir/CVSROOT: Permission denied
cvs [add aborted]: /root/mugen/testcases/cli-test/cvs/cvs_test/cvs_init_dir/CVSROOT: Permission denied
cvs [commit aborted]: /root/mugen/testcases/cli-test/cvs/cvs_test/cvs_init_dir/CVSROOT: Permission denied
```

在随后的测试中对应报错log为

```
+ su cvsroot -c 'cvs tag rel-1-0 | grep '\''T tmp.txt'\'''
cvs [tag aborted]: /root/mugen/testcases/cli-test/cvs/cvs_test/cvs_init_dir/CVSROOT: Permission denied
+ CHECK_RESULT 1 0 0 'test cvs tag failed'
```

### oe_test_chrpath:路径下没有对应文件

riscv与x86报错相同

对应报错log如下

```
+ chrpath -r /usr/lib64/ man
man: no rpath or runpath tag found.
+ grep PATH=/usr/lib64/
+ chrpath -l man
+ CHECK_RESULT 1 0 0 'Failed to change search path'
```

### oe_test_fio_001:核心转储错误

riscv与x86报错均相同

下为报错log

```
+ fio-genzipf -i zipf theta -o 2 -c
oe_test_fio_001.sh: line 28:  2145 Segmentation fault      (core dumped) fio-genzipf -i zipf theta -o 2 -c
+ CHECK_RESULT 139 0 0 'fio-genzipf -i zipf theta -o 2 -c failed '
```

### oe_test_fio_004:核心转储错误

riscv与x86报错均相同

log内无对应报错log，本地尝试复现时出现如下信息

```
Segmentation fault(core dumped)
```

### oe_test_high_nbde:没有相关的软件包

riscv与x86均为相同错误

安装时没有对应软件包

对应log如下

```
++ python3 /root/mugen/libs/locallibs/rpm_manage.py install --pkgs tang --node 2 --tempfile ''
Traceback (most recent call last):
  File "/root/mugen/libs/locallibs/rpm_manage.py", line 176, in <module>
    exitcode, output = rpm_install(args.pkgs, args.node, args.tempfile)
  File "/root/mugen/libs/locallibs/rpm_manage.py", line 66, in rpm_install
    conn = ssh_cmd.pssh_conn(
  File "/root/mugen/libs/locallibs/ssh_cmd.py", line 53, in pssh_conn
    conn.connect(ip, port, user, password, timeout=timeout)
  File "/usr/lib/python3.10/site-packages/paramiko/client.py", line 340, in connect
    to_try = list(self._families_and_addresses(hostname, port))
  File "/usr/lib/python3.10/site-packages/paramiko/client.py", line 203, in _families_and_addresses
    addrinfos = socket.getaddrinfo(
  File "/usr/lib64/python3.10/socket.py", line 955, in getaddrinfo
    for res in _socket.getaddrinfo(host, port, family, type, proto, flags):
socket.gaierror: [Errno -2] Name or service not known
```

### oe_test_service_unbound-keygen：service无法启动

riscv中没有对应服务项

```
× unbound-keygen.service
     Loaded: not-found (Reason: Unit unbound-keygen.service not found.)
     Active: failed (Result: exit-code) since Thu 2023-04-27 04:48:46 CST; 42s ago
  Condition: start condition failed at Thu 2023-04-27 04:49:06 CST; 22s ago
   Main PID: 1576 (code=exited, status=203/EXEC)
```

x86中，缺乏对应文件导致测试失败

```
May 05 05:41:00 localhost.localdomain unbound-control-setup[4676]: Setup success. Certificates created. Enable in unbound.conf file to use
May 05 05:41:00 localhost.localdomain systemd[4688]: unbound-keygen.service: Failed to locate executable /sbin/restorecon: No such file or directory
░░ Subject: Process /sbin/restorecon could not be executed
░░ Defined-By: systemd
░░ Support: https://lists.freedesktop.org/mailman/listinfo/systemd-devel
░░ 
░░ The process /sbin/restorecon could not be executed and failed.
░░ 
░░ The error number returned by this process is ERRNO.
May 05 05:41:00 localhost.localdomain systemd[4688]: unbound-keygen.service: Failed at step EXEC spawning /sbin/restorecon: No such file or directory
░░ Subject: Process /sbin/restorecon could not be executed
░░ Defined-By: systemd
░░ Support: https://lists.freedesktop.org/mailman/listinfo/systemd-devel
░░ 
░░ The process /sbin/restorecon could not be executed and failed.
░░ 
░░ The error number returned by this process is ERRNO.
May 05 05:41:00 localhost.localdomain systemd[1]: unbound-keygen.service: Main process exited, code=exited, status=203/EXEC
░░ Subject: Unit process exited
░░ Defined-By: systemd
░░ Support: https://lists.freedesktop.org/mailman/listinfo/systemd-devel
░░ 
░░ An ExecStart= process belonging to unit unbound-keygen.service has exited.
```

### oe_test_service_tuned：找不到对应服务

尝试测试服务时出错，显示找不到服务项

riscv与x86报错相同

下为对应log

```
+ systemctl restart tuned.service
Failed to restart tuned.service: Unit tuned.service not found.
```

### oe_test_service_systemtap:找不到对应服务

尝试测试服务时出错，显示找不到服务项

riscv与x86报错相同

下为对应log

```
+ systemctl restart systemtap.service
Failed to restart systemtap.service: Unit systemtap.service not found.
```

### oe_test_service_strongswan:服务启动失败：没有对应文件

riscv与x86报错相同

x86报错内容为

```
+ systemctl disable strongswan.service
Removed /etc/systemd/system/multi-user.target.wants/strongswan.service.
Removed /etc/systemd/system/strongswan-swanctl.service.
+ find /etc/systemd/system/strongswan-swanctl.service /etc/systemd/system/multi-user.target.wants/strongswan.service
find: ‘/etc/systemd/system/strongswan-swanctl.service’: No such file or directory
find: ‘/etc/systemd/system/multi-user.target.wants/strongswan.service’: No such file or directory
+ CHECK_RESULT 1 0 1 'strongswan.service disable failed'
```

而riscv有更详细的报错log

```
Apr 27 03:23:46 openeuler-riscv64 charon-systemd[1398]: PKCS11 module '<name>' lacks library path
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: OpenSSL FIPS mode(2) - enabled
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: failed to open /dev/net/tun: No such file or directory
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: failed to create TUN device
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: plugin 'kernel-libipsec': failed to load - kernel_libipsec_plugin_create returned NULL
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: received netlink error: Operation not supported (95)
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: unable to create IPv4 routing table rule
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: received netlink error: Operation not supported (95)
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: unable to create IPv6 routing table rule
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: loading ca certificates from '/etc/strongswan/ipsec.d/cacerts'
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: loading aa certificates from '/etc/strongswan/ipsec.d/aacerts'
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: loading ocsp signer certificates from '/etc/strongswan/ipsec.d/ocspcerts'
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: loading attribute certificates from '/etc/strongswan/ipsec.d/acerts'
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: loading crls from '/etc/strongswan/ipsec.d/crls'
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: loading secrets from '/etc/strongswan/ipsec.secrets'
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: sql plugin: database URI not set
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: opening triplet file /etc/strongswan/ipsec.d/triplets.dat failed: No such file or directory
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: loaded 0 RADIUS server configurations
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: MAP server certificate not defined
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: TNC recommendation policy is 'default'
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: loading IMVs from '/etc/tnc_config'
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: opening configuration file '/etc/tnc_config' failed: No such file or directory
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: missing PDP server name, PDP disabled
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: loading IMCs from '/etc/tnc_config'
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: opening configuration file '/etc/tnc_config' failed: No such file or directory
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: HA config misses local/remote address
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: no script for ext-auth script defined, disabled
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: loaded plugins: charon-systemd pkcs11 tpm aes des rc2 sha2 sha1 md4 md5 mgf1 random nonce x509 revocation constraints acert pubkey pkcs1 pkcs7 pkcs12 pgp dnskey sshkey pem openssl gcrypt pkcs8 fips-prf gmp curve25519 chapoly xcbc cmac hmac kdf ctr ccm gcm drbg newhope curl sqlite attr kernel-netlink resolve socket-default farp stroke vici updown eap-identity eap-sim eap-aka eap-aka-3gpp eap-aka-3gpp2 eap-md5 eap-gtc eap-mschapv2 eap-dynamic eap-radius eap-tls eap-ttls eap-peap eap-tnc xauth-generic xauth-eap xauth-pam xauth-noauth tnc-imc tnc-imv tnc-tnccs tnccs-20 tnccs-11 tnccs-dynamic dhcp led duplicheck unity counters
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: spawning 16 worker threads
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: thread 5 received 11
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: thread 6 received 11
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]: thread 7 received 11
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]:  dumping 7 stack frame addresses:
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]:  dumping 7 stack frame addresses:
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]:   linux-vdso.so.1 @ 0xffffff8d60a000 (__vdso_rt_sigreturn+0x0) [0xffffff8d60a800]
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1398]:   linux-vdso.so.1 @ 0xffffff8d60a000 (__vdso_rt_sigreturn+0x0) [0xffffff8d60a800]
Apr 27 03:23:47 openeuler-riscv64 charon-systemd[1417]: addr2line: 'linux-vdso.so.1': No such file
Apr 27 03:23:47 openeuler-riscv64 systemd[1]: Started Process Core Dump (PID 1418/UID 0).
░░ Subject: A start job for unit systemd-coredump@45-1418-0.service has finished successfully
```

### oe_test_service_strongswan_01:riscv堆栈错误，x86unroute shared命令失败

riscv中在使用stop命令时出现错误

```
+ podman stop -all
runtime: lfstack.push invalid packing: node=0xffffff92bc1520 cnt=0x1 packed=0xffff92bc15200001 -> node=0xffff92bc1520
fatal error: lfstack.push

runtime stack:
runtime.throw({0xaaaaaad9223310?, 0xaaaaaad8321f40?})
	/usr/lib/golang/src/runtime/panic.go:1047 +0x44 fp=0xffffffcdb54808 sp=0xffffffcdb547e0 pc=0xaaaaaad831d1ec
runtime.(*lfstack).push(0xc000052f00?, 0xffffff92bc1520)
	/usr/lib/golang/src/runtime/lfstack.go:30 +0x120 fp=0xffffffcdb54838 sp=0xffffffcdb54808 pc=0xaaaaaad82f0d98
runtime.(*spanSetBlockAlloc).free(...)
	/usr/lib/golang/src/runtime/mspanset.go:292
runtime.(*spanSet).reset(0xaaaaaada5d0ff8)
	/usr/lib/golang/src/runtime/mspanset.go:265 +0xb0 fp=0xffffffcdb54868 sp=0xffffffcdb54838 pc=0xaaaaaad8317010
runtime.finishsweep_m()
	/usr/lib/golang/src/runtime/mgcsweep.go:260 +0xc0 fp=0xffffffcdb548a0 sp=0xffffffcdb54868 pc=0xaaaaaad830aa58
runtime.gcStart.func1()
	/usr/lib/golang/src/runtime/mgc.go:668 +0x20 fp=0xffffffcdb548a8 sp=0xffffffcdb548a0 pc=0xaaaaaad82ff908
runtime.systemstack()
	/usr/lib/golang/src/runtime/asm_riscv64.s:133 +0x54 fp=0xffffffcdb548b0 sp=0xffffffcdb548a8 pc=0xaaaaaad834b484


```

x86为使用x86unroute shared命令时失败，无更多报错信息

### oe_test_service_strongswan_01:riscv堆栈错误，x86 openssl加载失败

riscv中在使用stop命令时出现错误

```
+ podman stop -all
runtime: lfstack.push invalid packing: node=0xffffff92bc1520 cnt=0x1 packed=0xffff92bc15200001 -> node=0xffff92bc1520
fatal error: lfstack.push

runtime stack:
runtime.throw({0xaaaaaad9223310?, 0xaaaaaad8321f40?})
	/usr/lib/golang/src/runtime/panic.go:1047 +0x44 fp=0xffffffcdb54808 sp=0xffffffcdb547e0 pc=0xaaaaaad831d1ec
runtime.(*lfstack).push(0xc000052f00?, 0xffffff92bc1520)
	/usr/lib/golang/src/runtime/lfstack.go:30 +0x120 fp=0xffffffcdb54838 sp=0xffffffcdb54808 pc=0xaaaaaad82f0d98
runtime.(*spanSetBlockAlloc).free(...)
	/usr/lib/golang/src/runtime/mspanset.go:292
runtime.(*spanSet).reset(0xaaaaaada5d0ff8)
	/usr/lib/golang/src/runtime/mspanset.go:265 +0xb0 fp=0xffffffcdb54868 sp=0xffffffcdb54838 pc=0xaaaaaad8317010
runtime.finishsweep_m()
	/usr/lib/golang/src/runtime/mgcsweep.go:260 +0xc0 fp=0xffffffcdb548a0 sp=0xffffffcdb54868 pc=0xaaaaaad830aa58
runtime.gcStart.func1()
	/usr/lib/golang/src/runtime/mgc.go:668 +0x20 fp=0xffffffcdb548a8 sp=0xffffffcdb548a0 pc=0xaaaaaad82ff908
runtime.systemstack()
	/usr/lib/golang/src/runtime/asm_riscv64.s:133 +0x54 fp=0xffffffcdb548b0 sp=0xffffffcdb548a8 pc=0xaaaaaad834b484
```

x86在加载pki时出错，对应log如下

```
+ strongswan pki
unable to set OpenSSL FIPS mode(2) from (0)
plugin 'openssl': failed to load - openssl_plugin_create returned NULL
+ grep 'strongSwan 5.7.2 PKI tool' strongswan_test_pki.log
+ CHECK_RESULT 1 0 0 'Failed to check the pki'
```

### oe_test_service_strongswan-swanctl:服务项命令失败

riscv与x86报错均相同

下为报错log

```
+ systemctl restart strongswan-swanctl.service
Failed to restart strongswan-swanctl.service: Unit strongswan-swanctl.service not found.
+ CHECK_RESULT 5 0 0 'strongswan-swanctl.service restart failed'
```

