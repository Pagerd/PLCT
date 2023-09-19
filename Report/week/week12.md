# 工作报告

- 将上周openEuler 2309 x86 RC1与2303均fail的测试用例剩余的部分进行分析,暂未提交至主仓库
- 在openEuler 2309 RISCV  RC2中 对测试套集合4_2进行测试，以及在openEuler 2309 x86 RC3中进行对比测试，将测试结果进行pr提交 [pr](https://github.com/KotorinMinami/res_list/pull/47)

## 4_2测试结果

本次测试共测试了564个测试用例，其中有346个测试用例成功，186个测试用例在x86和rv上均失败,32个测试用例仅在rv上失败 [FailureCause.csv](./week12/failureCause.csv)

对比于2303的测试结果，其中新增73个失败用例[FailureCause_newfail.csv](./week12/failureCause_newfail.csv)，其中51个为x86 也fail的失败用例，22个为仅在rv上失败的用例

其中有3个测试用例从x86 fail状态变为了fail状态[failureCause_failtox86.csv](./week12/failureCause_failtox86.csv)

13个测试用例从fail状态变为了x86 fail状态[failureCause_x86tofail.csv](./week12/failureCause_x86tofail.csv)



| 测试套/软件包名 | 测试用例名                        | 状态     | 原因                                                         |
| --------------- | --------------------------------- | -------- | ------------------------------------------------------------ |
| os-basic        | oe_test_net_mtr                   | x86 fail | grep _gateway错误                                            |
|                 | oe_test_nmcli_Mgntconnect         | x86 fail | 未指定连接                                                   |
|                 | oe_test_nmcli_8023link            | x86 fail | 未指定连接                                                   |
|                 | oe_test_nmcli_con_reload          | x86 fail | 未指定连接                                                   |
|                 | oe_test_gcc_01                    | x86 fail | gcc -Wall main.c错误                                         |
|                 | oe_test_nmcli_route               | x86 fail | 未指定连接                                                   |
|                 | oe_test_net_ncat                  | x86 fail | 无法解析主机名：名称或服务未知                               |
|                 | oe_test_nmcli_add_connect         | x86 fail | 未指定连接                                                   |
|                 | oe_test_nmcli_vlan                | x86 fail | 未指定连接                                                   |
|                 | oe_test_timedatectl               | x86 fail | 不支持 NTP                                                   |
|                 | oe_test_server_httpd_tls          | x86 fail | Job for httpd.service failed because the control process exited with error code. |
|                 | oe_test_kernel_sysctl             | x86 fail | sysctl -a错误                                                |
|                 | oe_test_nmcli_bridge              | x86 fail | 未指定连接                                                   |
|                 | oe_test_nmcli_config_gw           | x86 fail | 未指定连接                                                   |
|                 | oe_test_net_setmode               | x86 fail | 复原环境时什么也没做                                         |
|                 | oe_test_net_IPVLAN                | x86 fail | 未指定连接                                                   |
|                 | oe_test_nmcli_device              | x86 fail | 未指定连接                                                   |
|                 | oe_test_net_cmd_ifconfig          | x86 fail | 复原环境时什么也没做                                         |
|                 | oe_test_net_config                | x86 fail | 复原环境时什么也没做                                         |
|                 | oe_test_server_httpd_recover      | fail     | 系统中不存在用户apache，导致启动失败                         |
|                 | oe_test_disk_tuned_disable        | fail     | 无法启动Dynamic System Tuning daemon                         |
|                 | oe_test_disk_tuned_install        | fail     | 无法启动Dynamic System Tuning daemon                         |
|                 | oe_test_disk_tuned_modify         | fail     | 没有全局TuneD配置文件“/etc/tune/Tuned-main.conf”             |
|                 | oe_test_basic_UserMgmt_permission | fail     | 用户组gid和已有gid冲突                                       |
|                 | oe_test_server_mysql              | fail     | 镜像缺少对应包                                               |
|                 | oe_test_server_httpd_restart      | fail     | 系统中不存在用户apache，导致启动失败                         |
|                 | oe_test_server_httpd_port         | fail     | 系统中不存在用户apache，导致启动失败                         |
|                 | oe_test_disk_tuned_set            | fail     | 没有文件/etc/udev/rules.d/99 scheduler.rules                 |
|                 | oe_test_home_directory            | fail     | user-testuser被其他进程占用                                  |
|                 | oe_test_uname                     | fail     | 测试用例问题，grep -E 'aarch64                               |
| lvm2            | oe_test_lvm2_vgrename_001         | x86 fail | No device found for /dev/.                                   |
|                 | oe_test_lvm2_vgchange_001         | x86 fail | No device found for /dev/.                                   |
|                 | oe_test_lvm2_pvdisplay_001        | x86 fail | No device found for /dev/.                                   |
|                 | oe_test_lvm2_vgextend_002         | x86 fail | No device found for /dev/.                                   |
|                 | oe_test_lvm2_pvremove_001         | x86 fail | No device found for /dev/.                                   |
|                 | oe_test_lvm2_vgexport_001         | x86 fail | No device found for /dev/.                                   |
|                 | oe_test_lvm2_vgextend_001         | x86 fail | No device found for /dev/.                                   |
|                 | oe_test_lvm2_vgchange_002         | x86 fail | No device found for /dev/.                                   |
|                 | oe_test_lvm2_vgdisplay_001        | x86 fail | No device found for /dev/.                                   |
|                 | oe_test_lvm2_pvchange_001         | x86 fail | No device found for /dev/.                                   |
|                 | oe_test_lvm2_vgcreate_001         | x86 fail | No device found for /dev/.                                   |
|                 | oe_test_socket_lvm2-lvmpolld      | x86 fail | No device found for /dev/.                                   |
|                 | oe_test_lvm2_pvdisplay_002        | x86 fail | No device found for /dev/.                                   |
|                 | oe_test_socket_dm-event           | x86 fail | No device found for /dev/.                                   |
| accountsservice | oe_test_service_accounts-daemon   | x86 fail | /etc/systemd/system/graphical.target.wants/accounts-daemon.service’: No such file or directory |
| dbus            | oe_test_service_dbus              | fail     | systemd unit restart failure/systemd unit runtime error      |
| asciidoc        | oe_test_asciidoc_a2x_03           | x86 fail | 测试环境未安装a2x                                            |
| ypserv          | oe_test_service_yppasswdd         | fail     | Failed to start RPC Bind导致服务开启失败                     |
|                 | oe_test_service_ypserv            | fail     | Failed to start RPC Bind导致服务开启失败                     |
|                 | oe_test_service_ypxfrd            | fail     | Failed to start RPC Bind导致服务开启失败                     |
| brltty          | oe_test_service_brltty            | x86 fail | ‘/etc/systemd/system/rescue.target.wants/brltty.service’: No such file or directory |
| lxc             | oe_test_lxc_unshare_update        | x86 fail | 连接被对等方重置 - 无法接收响应                              |
| usbmuxd         | oe_test_service_usbmuxd           | fail     | 服务重启失败                                                 |
| nspr            | oe_test_nspr_001                  | x86 fail | 未安装g++                                                    |
|                 | oe_test_nspr_002                  | x86 fail | 未安装g++                                                    |
|                 | oe_test_service_powertop          | fail     | modprobe cpufreq_stats failed                                |
|                 | oe_test_socket_acpid              | x86 fail | /etc/systemd/system/sockets.target.wants/acpid.socket’: No such file or directory |
|                 | oe_test_service_acpid             | x86 fail | /etc/systemd/system/sockets.target.wants/acpid.socket’: No such file or directory |
| hdparm          | oe_test_hdparm                    | x86 fail | 设备的 ioctl 不合适                                          |
| avahi           | oe_test_service_avahi-daemon      | x86 fail | Job for avahi-daemon.service failed because the control process exited with error code |
|                 | oe_test_socket_avahi-daemon       | x86 fail | "‘""/etc/systemd/system/sockets.target.wants/avahi-daemon.socket""’: No such file or directory" |
|                 | oe_test_service_avahi-dnsconfd    | fail     | 重启失败                                                     |
|                 | oe_test_socket_tangd              | fail     | Failed to start Tang Server key                              |
|                 | oe_test_service_tangd-update      | fail     | Failed to start Tang Server key                              |
|                 | oe_test_ndisc6_tracert6           | x86 fail | socket.gaierror:Name or service not known                    |
|                 | oe_test_ndisc6_addr2name          | x86 fail | socket.gaierror:Name or service not known                    |
|                 | oe_test_ndisc6_rltraceroute6      | x86 fail | socket.gaierror:Name or service not known                    |
|                 | oe_test_ndisc6_tcptraceroute6     | x86 fail | socket.gaierror:Name or service not known                    |
|                 | oe_test_ndisc6_ndisc6             | x86 fail | socket.gaierror:Name or service not known                    |
|                 | oe_test_gsl_histogram_01          | x86 fail | Failed option: gsl-histogram -u                              |
| netcf           | oe_test_service_netcf-transaction | x86 fail | /etc/systemd/system/multi-user.target.wants/netcf-transaction.service’: No such file or directory |
|                 | oe_test_service_memcached         | fail     | restart memcached.service failed                             |
