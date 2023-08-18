# 2309Test3Test4测试结果

测试共测试了个测试用例，共有419个测试用例成功，398个测试用例失败,其中

- 372个成功测试用例在2303上也为成功
- 47个测试用例在2303上失败，为测试用例修复
- 133个测试用例在2303上成功，在09上失败，为新增fail测试用例
- 248个测试用例在2303及2309上均失败，但失败原因相同
- 15个测试用例在2303及2309上均失败，且失败原因不同

对于2309中新增的fail及不同的fail测试用例分析结果如下

## 软件包依赖问题

-  cockpit/oe_test_service_cockpit-wsinstance-http：软件源中没有 cockpit-285-2.oe2309.riscv64 所需的 kexec-tools
- lxc/oe_test_lxc_unshare_update：软件源中没有 iSulad-2.1.2-4.oe2309.riscv64 所需的 libabsl_synchronization.so.2206.0.0(64bit)
- qemu
  - oe_test_socket_qemu-pr-helper：没有提供 qemu 所需的 libfdt.so
  - oe_test_service_qemu-pr-helper：没有提供 qemu 所需的 libfdt.so

## 镜像预装软件问题

-  rsyslog/oe_test_rsyslog_parameter03：准备环境时没有安装rsylog
- rsyslog/oe_test_rsyslog_parameter01：准备环境时没有安装rsylog
- os-storage/oe_test_storage_nfs_repeat_restart：没有安装iptables
- os-storage/oe_test_storage_nfs_mount_RW：没有安装iptables
- os-storage/oe_test_storage_diskpartiton_parted_view：没有安装parted
- os-storage/oe_test_storage_diskpartiton_parted_delete：没有安装parted
- os-storage/oe_test_storage_diskpartiton_parted_create：没有安装parted

## 分区问题

- os-storage/oe_test_storage_lvm_rename_VG:未找到卷组“openeulertest”
- os-storage/oe_test_storage_lvm_print_history:未找到卷组“openeulertest”
- os-storage/oe_test_storage_lvm_VG_transfer:未找到卷组“openeulertest”
- os-storage/oe_test_storage_lvm_activation:未找到卷组“openeulertest”
- os-storage/oe_test_storage_lvm_rename:未找到卷组“openeulertest”
- os-storage/oe_test_storage_lvm_set_lvconvert_volume:未找到卷组“openeulertest”
- os-storage/oe_test_storage_lvm_print:未找到卷组“openeulertest”
- os-storage/oe_test_storage_lvm_pvs:未找到卷组“openeulertest”
- os-storage/oe_test_storage_ext4_resize:"目标分区无效"
- os-storage/oe_test_storage_mount_private:"目标分区无效"
- os-storage/oe_test_storage_ext3_mount:"目标分区无效"
- os-storage/oe_test_storage_ext4_create:"目标分区无效"
- os-storage/oe_test_storage_DevMgmt_fstrim:"目标分区无效"

### 服务项问题

- pcp/oe_test_service_pmlogger:服务pmlogger.service 停止失败
- iperf3/oe_test_iperf3_command_serverAndBase:没有服务项socket.gaierror
- iperf3/oe_test_iperf3_command_clientAndShared:没有服务项socket.gaierror

### 缺少对应文件

- systemd/全部：cannot open shared object file: No such file or directory
- pcp/oe_test_pcp_pcp-import-iostat2pcp:未找到对应文件/usr/lib64/perl5/DynaLoader.pm
- pcp/oe_test_pcp_pcp-import-mrtg2pcp:未找到对应文件/usr/lib64/perl5/DynaLoader.pm
- pcp/oe_test_pcp_pcp-import-sar2pcp:未找到对应文件/usr/lib64/perl5/DynaLoader.pm

### 内核问题

- ipvsadm/oe_test_service_ipvsadm:没有内核模块ip_vs
- amanda/oe_test_amanda_ambackup:缺少对应内核模模块:libperl.so.5.34

### 其他问题

- asciidoc/oe_test_asciidoc_a2x_03:在测试指令时出错，显示指令不存在

```
+ a2x -f xhtml '--xsltproc-opts=--stringparam page.margin.inner 10cm' -D ./tmp/ common/test.adoc
+ ' '
oe_test_asciidoc_a2x_03.sh: line 37:  : command not found
```

- libvma/oe_test_service_vma:测试时使用了错误的参数

```
++ python3 /root/mugen/libs/locallibs/rpm_manage.py install --pkgs libvma --node 1 --tempfile ''
+ tmpfile2='Last metadata expiration check: 0:00:40 ago on Sun Aug 13 03:33:51 2023.
No match for argument: libvma
Error: Unable to find a match: libvma'
```

- lorax/oe_test_service_lorax-composer:测试log超时，手动测试后测试通过
- blivet/oe_test_service_blivet:测试log超时，手动测试后测试通过

- rsyslog:未安装rsylog导致所有rsylog测试用例失败，手动安装之后均报错

```
/etc/rsyslog.d/test.conf: No such file or directory
```

## Test3Test4新增fail测试用例总表

| 测试套/软件包名 | 测试用例名                                     | 状态   | 与2303对比 | 日志文件                                                     | 原因                                                         |
| --------------- | ---------------------------------------------- | ------ | ---------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| cockpit         | oe_test_service_cockpit-wsinstance-http        | failed | 09fail     | ./mugen-riscv/logs/cockpit/oe_test_service_cockpit-wsinstance-http/2023-08-08-10:39:01.log | 没有提供 cockpit-285-2.oe2309.riscv64 所需的 kexec-tools     |
| asciidoc        | oe_test_asciidoc_a2x_03                        | failed | 09fail     | ./mugen-riscv/logs/asciidoc/oe_test_asciidoc_a2x_03/2023-08-08-10:35:01.log | 测试套编写错误                                               |
| lxc             | oe_test_lxc_unshare_update                     | failed | 09fail     | ./mugen-riscv/logs/lxc/oe_test_lxc_unshare_update/2023-08-08-03:30:15.log | 没有提供 iSulad-2.1.2-4.oe2309.riscv64 所需的 libabsl_synchronization.so.2206.0.0()(64bit) |
| rsyslog         | oe_test_rsyslog_parameter02                    | failed | 09fail     | ./mugen-riscv/logs/rsyslog/oe_test_rsyslog_parameter02/2023-08-08-01:27:22.log | 没有服务项rsyslog.service                                    |
|                 | oe_test_rsyslog_abnormal_config                | failed | 09fail     | ./mugen-riscv/logs/rsyslog/oe_test_rsyslog_abnormal_config/2023-08-08-00:45:57.log | /etc/rsyslog.d/test.conf: No such file or directory          |
|                 | oe_test_rsyslog_parameter03                    | failed | 09fail     | ./mugen-riscv/logs/rsyslog/oe_test_rsyslog_parameter03/2023-08-08-01:27:35.log | 准备环境时没有安装rsylog                                     |
|                 | oe_test_rsyslog_function_rainerscript          | failed | 09fail     | ./mugen-riscv/logs/rsyslog/oe_test_rsyslog_function_rainerscript/systemctl_for_2023-08-08-00:52:45.log | 准备环境时没有安装rsylog                                     |
|                 | oe_test_rsyslog_function_template              | failed | 09fail     | ./mugen-riscv/logs/rsyslog/oe_test_rsyslog_function_template/2023-08-08-01:25:45.log | 没有服务项rsyslog.service                                    |
|                 | oe_test_rsyslog_parameter01                    | failed | 09fail     | ./mugen-riscv/logs/rsyslog/oe_test_rsyslog_parameter01/2023-08-08-01:27:07.log | 没有服务项rsyslog.service/准备环境时没有安装rsylog           |
|                 | oe_test_service_rsyslog                        | failed | 09fail     | ./mugen-riscv/logs/rsyslog/oe_test_service_rsyslog/2023-08-08-02:32:23.log | 没有服务项rsyslog.service                                    |
|                 | oe_test_rsyslog_function_imfile                | failed | 09fail     | ./mugen-riscv/logs/rsyslog/oe_test_rsyslog_function_imfile/2023-08-08-00:50:06.log | /etc/rsyslog.d/test: No such file or directory               |
|                 | oe_test_rsyslog_function_wildcard              | failed | 09fail     | ./mugen-riscv/logs/rsyslog/oe_test_rsyslog_function_wildcard/2023-08-08-01:26:41.log | 没有服务项rsyslog.service                                    |
|                 | oe_test_rsyslog_reliability_restart            | failed | 09fail     | ./mugen-riscv/logs/rsyslog/oe_test_rsyslog_reliability_restart/2023-08-08-02:28:55.log | 没有服务项rsyslog.service                                    |
|                 | oe_test_rsyslog_function_facility              | failed | 09fail     | ./mugen-riscv/logs/rsyslog/oe_test_rsyslog_function_facility/2023-08-08-00:47:50.log | /etc/rsyslog.d/test.conf: No such file or directory          |
|                 | oe_test_rsyslog_function_priority              | failed | 09fail     | ./mugen-riscv/logs/rsyslog/oe_test_rsyslog_function_priority/systemctl_for_2023-08-08-00:51:49.log | /etc/rsyslog.d/test.conf: No such file or directory          |
|                 | oe_test_rsyslog_function_discard               | failed | 09fail     | ./mugen-riscv/logs/rsyslog/oe_test_rsyslog_function_discard/2023-08-08-00:47:34.log | /etc/rsyslog.d/test.conf: No such file or directory          |
|                 | oe_test_rsyslog_parameter04                    | failed | 09fail     | ./mugen-riscv/logs/rsyslog/oe_test_rsyslog_parameter04/2023-08-08-01:57:42.log | /etc/rsyslog.d/test.conf: No such file or directory          |
|                 | oe_test_rsyslog_function_shell                 | failed | 09fail     | ./mugen-riscv/logs/rsyslog/oe_test_rsyslog_function_shell/2023-08-08-00:54:10.log | /etc/rsyslog.d/test.conf: No such file or directory          |
| systemd         | oe_test_service_systemd-machined               | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-machined/2023-08-08-00:26:01.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-timedated              | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-timedated/2023-08-08-00:33:18.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_machines                        | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_machines/2023-08-08-00:56:27.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_boot-complete                   | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_boot-complete/2023-08-08-00:48:46.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_umount                          | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_umount/2023-08-08-01:10:27.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-udev-trigger           | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-udev-trigger/2023-08-08-00:37:08.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_dbus-org.freedesktop.login1    | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_dbus-org.freedesktop.login1/2023-08-08-00:06:50.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_runlevel4                       | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_runlevel4/2023-08-08-01:03:55.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-tmpfiles-setup-dev     | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-tmpfiles-setup-dev/2023-08-08-00:35:10.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-localed                | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-localed/2023-08-08-00:24:53.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-tmpfiles-setup         | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-tmpfiles-setup/2023-08-08-00:35:44.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_first-boot-complete             | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_first-boot-complete/2023-08-08-01:12:43.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_nss-lookup                      | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_nss-lookup/2023-08-08-00:58:35.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-journald               | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-journald/2023-08-08-00:20:50.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_local-fs                        | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_local-fs/2023-08-08-00:55:53.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-random-seed            | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-random-seed/2023-08-08-00:29:43.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-logind                 | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-logind/2023-08-08-00:25:27.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_network-online                  | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_network-online/2023-08-08-00:57:36.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_socket_systemd-udevd-kernel            | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_socket_systemd-udevd-kernel/2023-08-08-00:47:37.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_dbus-org.freedesktop.locale1   | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_dbus-org.freedesktop.locale1/2023-08-08-00:06:16.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_dbus-org.freedesktop.machine1  | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_dbus-org.freedesktop.machine1/2023-08-08-00:07:23.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-hwdb-update            | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-hwdb-update/2023-08-08-00:18:15.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_network-pre                     | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_network-pre/2023-08-08-00:58:10.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-time-wait-sync         | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-time-wait-sync/2023-08-08-00:34:25.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-vconsole-setup         | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-vconsole-setup/2023-08-08-00:39:08.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_rescue                          | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_rescue/2023-08-08-01:01:16.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_initrd-root-fs                  | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_initrd-root-fs/2023-08-08-00:54:36.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-tmpfiles-clean         | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-tmpfiles-clean/2023-08-08-00:34:59.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-sysusers               | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-sysusers/2023-08-08-00:32:42.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_getty                           | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_getty/2023-08-08-00:51:46.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_sockets                         | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_sockets/2023-08-08-01:06:41.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_debug-shell                    | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_debug-shell/2023-08-08-00:09:13.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_dbus-org.freedesktop.timedate1 | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_dbus-org.freedesktop.timedate1/2023-08-08-00:08:39.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_runlevel5                       | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_runlevel5/2023-08-08-01:04:29.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-timesyncd              | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-timesyncd/2023-08-08-00:33:52.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-journal-catalog-update | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-journal-catalog-update/2023-08-08-00:20:15.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-update-utmp            | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-update-utmp/2023-08-08-00:38:01.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_swap                            | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_swap/2023-08-08-01:07:34.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_ldconfig                       | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_ldconfig/2023-08-08-00:11:31.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_system-update-cleanup          | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_system-update-cleanup/2023-08-08-00:39:51.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-udev-settle            | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-udev-settle/2023-08-08-00:36:34.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_timers                          | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_timers/2023-08-08-01:09:29.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_runlevel2                       | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_runlevel2/2023-08-08-01:02:48.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_socket_systemd-coredump                | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_socket_systemd-coredump/2023-08-08-00:41:07.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-remount-fs             | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-remount-fs/2023-08-08-00:30:26.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-user-sessions          | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-user-sessions/2023-08-08-00:38:35.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_socket_systemd-journald-audit          | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_socket_systemd-journald-audit/2023-08-08-00:42:14.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_rpcbind                         | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_rpcbind/2023-08-08-01:01:50.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_basic                           | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_basic/2023-08-08-00:48:12.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_initrd-root-device              | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_initrd-root-device/2023-08-08-00:54:01.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_system-update-pre               | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_system-update-pre/2023-08-08-01:08:42.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_system-update                   | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_system-update/2023-08-08-01:08:54.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_remote-fs                       | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_remote-fs/2023-08-08-01:00:42.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_hwclock-save                   | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_hwclock-save/2023-08-08-00:09:47.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-update-done            | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-update-done/2023-08-08-00:37:22.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_paths                           | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_paths/2023-08-08-00:58:59.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_runlevel3                       | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_runlevel3/2023-08-08-01:03:22.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_initrd-fs                       | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_initrd-fs/2023-08-08-00:53:25.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_slices                          | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_slices/2023-08-08-01:06:07.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_runlevel1                       | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_runlevel1/2023-08-08-01:02:13.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_socket_systemd-udevd-control           | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_socket_systemd-udevd-control/2023-08-08-00:47:01.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_sigpwr                          | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_sigpwr/2023-08-08-01:05:23.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_kmod-static-nodes              | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_kmod-static-nodes/2023-08-08-00:10:58.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-hostnamed              | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-hostnamed/2023-08-08-00:17:42.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_time-sync                       | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_time-sync/2023-08-08-01:10:15.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_graphical                       | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_graphical/2023-08-08-00:52:21.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-journal-flush          | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-journal-flush/2023-08-08-00:21:26.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_rc-local                       | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_rc-local/2023-08-08-00:13:07.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_local-fs-pre                    | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_local-fs-pre/2023-08-08-00:55:41.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_nss-user-lookup                 | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_nss-user-lookup/2023-08-08-00:58:47.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_default                         | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_default/2023-08-08-00:50:17.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_socket_systemd-journald                | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_socket_systemd-journald/2023-08-08-00:43:24.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_rescue                         | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_rescue/2023-08-08-00:13:42.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_time-set                        | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_time-set/2023-08-08-01:10:03.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-sysctl                 | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-sysctl/2023-08-08-00:32:09.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_multi-user                      | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_multi-user/2023-08-08-00:57:02.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_sysinit                         | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_sysinit/2023-08-08-01:08:08.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_network                         | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_network/2023-08-08-00:58:22.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_remote-fs-pre                   | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_remote-fs-pre/2023-08-08-01:00:29.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_socket_systemd-initctl                 | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_socket_systemd-initctl/2023-08-08-00:41:40.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_target_getty-pre                       | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_target_getty-pre/2023-08-08-00:51:11.log | cannot open shared object file: No such file or directory    |
|                 | oe_test_service_systemd-ask-password-console   | failed | 09fail     | ./mugen-riscv/logs/systemd/oe_test_service_systemd-ask-password-console/2023-08-08-00:14:16.log | cannot open shared object file: No such file or directory    |
| os-storage      | oe_test_storage_lvm_resize_PV                  | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_lvm_resize_PV/2023-08-13-13:12:42.log | 找不到目标设备                                               |
|                 | oe_test_storage_lvm_rename_VG                  | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_lvm_rename_VG/2023-08-13-12:35:27.log | 未找到卷组“openeulertest”                                    |
|                 | oe_test_storage_nfs_mount_RW                   | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_nfs_mount_RW/2023-08-13-13:53:46.log | 没有服务项firewalld.service/没有安装iptables                 |
|                 | oe_test_storage_ext4_resize                    | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_ext4_resize/2023-08-13-15:02:33.log | 分区无效                                                     |
|                 | oe_test_storage_lvm_print_history              | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_lvm_print_history/2023-08-13-14:38:30.log | 未找到卷组“openeulertest”                                    |
|                 | oe_test_storage_nfs_repeat_restart             | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_nfs_repeat_restart/2023-08-13-12:31:03.log | 没有服务项firewalld.service/没有安装iptables                 |
|                 | oe_test_storage_lvm_VG_transfer                | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_lvm_VG_transfer/2023-08-13-14:28:00.log | 未找到卷组“openeulertest”                                    |
|                 | oe_test_storage_lvm_activation                 | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_lvm_activation/2023-08-13-15:15:47.log | 未找到卷组“openeulertest”                                    |
|                 | oe_test_storage_mount_private                  | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_mount_private/2023-08-13-15:21:16.log | 分区无效                                                     |
|                 | oe_test_storage_diskpartiton_parted_view       | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_diskpartiton_parted_view/2023-08-13-13:22:52.log | 没有安装parted                                               |
|                 | oe_test_storage_diskpartiton_parted_delete     | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_diskpartiton_parted_delete/2023-08-13-12:23:42.log | 没有安装parted                                               |
|                 | oe_test_storage_lvm_rename                     | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_lvm_rename/2023-08-13-14:08:27.log | 未找到卷组“openeulertest”                                    |
|                 | oe_test_storage_lvm_set_lvconvert_volume       | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_lvm_set_lvconvert_volume/2023-08-13-12:59:36.log | 未找到卷组“openeulertest”                                    |
|                 | oe_test_storage_lvm_print                      | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_lvm_print/2023-08-13-13:20:47.log | 未找到卷组“openeulertest”                                    |
|                 | oe_test_storage_ext3_mount                     | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_ext3_mount/2023-08-13-12:04:03.log | 分区无效                                                     |
|                 | oe_test_storage_ext4_create                    | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_ext4_create/2023-08-13-12:41:01.log | 分区无效                                                     |
|                 | oe_test_storage_diskpartiton_parted_create     | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_diskpartiton_parted_create/2023-08-13-15:14:52.log | 没有安装parted                                               |
|                 | oe_test_storage_DevMgmt_fstrim                 | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_DevMgmt_fstrim/2023-08-13-13:29:38.log | 分区无效                                                     |
|                 | oe_test_storage_lvm_pvs                        | failed | 09fail     | ./oe-rv2309/mugen-riscv/logs/os-storage/oe_test_storage_lvm_pvs/2023-08-13-12:30:02.log | 未找到卷组“openeulertest”                                    |
| pcp             | oe_test_service_pmlogger                       | failed | 09fail     | ./mugen-riscv/logs/pcp/oe_test_service_pmlogger/2023-08-12-14:47:09.log | 服务pmlogger.service 停止失败                                |
|                 | oe_test_pcp_pcp-import-iostat2pcp              | failed | 09fail     | ./mugen-riscv/logs/pcp/oe_test_pcp_pcp-import-iostat2pcp/2023-08-12-14:30:36.log | 未找到对应文件/usr/lib64/perl5/DynaLoader.pm                 |
|                 | oe_test_pcp_pcp-import-mrtg2pcp                | failed | 09fail     | ./mugen-riscv/logs/pcp/oe_test_pcp_pcp-import-mrtg2pcp/2023-08-12-14:35:02.log | 未找到对应文件/usr/lib64/perl5/DynaLoader.pm                 |
|                 | oe_test_pcp_pcp-import-sar2pcp                 | failed | 09fail     | ./mugen-riscv/logs/pcp/oe_test_pcp_pcp-import-sar2pcp/2023-08-12-14:39:43.log | 未找到对应文件/usr/lib64/perl5/DynaLoader.pm                 |
| amanda          | oe_test_amanda_amssl                           | failed | 09fail     | ./mugen-riscv/logs/amanda/oe_test_amanda_amssl/2023-08-12-20:46:05.log | 未找到对应文件'/amanda/tmp'                                  |
|                 | oe_test_amanda_ambackup                        | failed | 09fail     | ./mugen-riscv/logs/amanda/oe_test_amanda_ambackup/2023-08-12-20:44:00.log | 缺少对应模块:libperl.so.5.34                                 |
| qemu            | oe_test_socket_qemu-pr-helper                  | failed | 09fail     | ./mugen-riscv/logs/qemu/oe_test_socket_qemu-pr-helper/2023-08-12-23:58:56.log | 没有提供 qemu 所需的 libfdt.so                               |
|                 | oe_test_service_qemu-pr-helper                 | failed | 09fail     | ./mugen-riscv/logs/qemu/oe_test_service_qemu-pr-helper/2023-08-12-23:56:29.log | 没有提供 qemu 所需的 libfdt.so                               |
| lorax           | oe_test_service_lorax-composer                 | failed | 09fail     | ./mugen-riscv/logs/lorax/oe_test_service_lorax-composer/2023-08-13-01:05:10.log | 超时                                                         |
| ipvsadm         | oe_test_service_ipvsadm                        | failed | 09fail     | ./mugen-riscv/logs/ipvsadm/oe_test_service_ipvsadm/journelctl_for_2023-08-12-16:57:22.log | 无法找到模块ip_vs                                            |
| net-tools       | oe_test_net-tools_ipmaddr                      | failed | 09fail     | ./mugen-riscv/logs/net-tools/oe_test_net-tools_ipmaddr/2023-08-12-22:21:35.log | 使用了不支持的指令集                                         |
| libvma          | oe_test_service_vma                            | failed | 09fail     | ./mugen-riscv/logs/libvma/oe_test_service_vma/2023-08-13-03:31:57.log | 参数不匹配：libvma                                           |
| iperf3          | oe_test_iperf3_command_serverAndBase           | failed | 09fail     | ./mugen-riscv/logs/iperf3/oe_test_iperf3_command_serverAndBase/2023-08-12-22:29:59.log | 没有服务项socket.gaierror                                    |
|                 | oe_test_iperf3_command_clientAndShared         | failed | 09fail     | ./mugen-riscv/logs/iperf3/oe_test_iperf3_command_clientAndShared/2023-08-12-22:28:55.log | 没有服务项socket.gaierror                                    |
| python-blivet   | oe_test_service_blivet                         | failed | 09fail     | ./mugen-riscv/logs/python-blivet/oe_test_service_blivet/2023-08-13-04:05:37.log | 超时                                                         |