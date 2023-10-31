# RC8测试结果

RC8相比RC7共出现61个新增fail测试用例

### 服务项在关闭/启动时显示找不到对应文件，从而导致失败

| 测试套/软件包名 | 测试用例名                        | 状态 | 日志文件                                                     | 原因                              |
| --------------- | --------------------------------- | ---- | ------------------------------------------------------------ | --------------------------------- |
| lvm2            | oe_test_socket_lvm2-lvmpolld      | fail | ./mugen-riscv/logs/lvm2/oe_test_socket_lvm2-lvmpolld/2023-10-22-20:47:06.log | lvm2service关闭失败               |
|                 | oe_test_socket_dm-event           | fail | ./mugen-riscv/logs/lvm2/oe_test_socket_dm-event/2023-10-22-20:45:41.log | lvm2service关闭失败               |
|                 | oe_test_service_lvm2-monitor      | fail | ./mugen-riscv/logs/lvm2/oe_test_service_lvm2-monitor/2023-10-22-20:36:04.log | lvm2service关闭失败               |
| rtkit           | oe_test_service_rtkit-daemon      | fail | ./mugen-riscv/logs/rtkit/oe_test_service_rtkit-daemon/2023-10-20-03_59_54.log | rtkit-daemon关闭失败              |
| accountsservice | oe_test_service_accounts-daemon   | fail | ./mugen-riscv/logs/accountsservice/oe_test_service_accounts-daemon/2023-10-20-03_15_15.log | accounts-daemon关闭失败           |
| chrony          | oe_test_service_chronyd           | fail | ./mugen-riscv/logs/chrony/oe_test_service_chronyd/2023-10-22-14:44:42.log | chronyd关闭失败                   |
| haveged         | oe_test_service_haveged           | fail | ./mugen-riscv/logs/haveged/oe_test_service_haveged/2023-10-22-16:13:45.log | haveged关闭失败                   |
| nfs-utils       | oe_test_target_nfs-client         | fail | ./mugen-riscv/logs/nfs-utils/oe_test_target_nfs-client/2023-10-23-01:44:47.log | nfs-utils关闭失败                 |
| ceph            | oe_test_target_ceph-mon           | fail | ./mugen-riscv/logs/ceph/oe_test_target_ceph-mon/2023-10-20-01_12_53.log | ceph-mon服务关闭失败              |
|                 | oe_test_target_ceph               | fail | ./mugen-riscv/logs/ceph/oe_test_target_ceph/2023-10-20-01_30_31.log | ceph-mon服务关闭失败              |
| smartmontools   | oe_test_service_smartd            | fail | ./mugen-riscv/logs/smartmontools/oe_test_service_smartd/2023-10-20-04_01_35.log | smartmontools service服务关闭失败 |
| util-linux      | oe_test_socket_uuidd              | fail | ./mugen-riscv/logs/util-linux/oe_test_socket_uuidd/2023-10-20-02_28_19.log | 启动uuid服务失败                  |
| netcf           | oe_test_service_netcf-transaction | fail | ./mugen-riscv/logs/netcf/oe_test_service_netcf-transaction/2023-10-22-16:30:05.log | netcf service服务关闭失败         |
| open-iscsi      | oe_test_service_iscsi             | fail | ./mugen-riscv/logs/open-iscsi/oe_test_service_iscsi/2023-10-20-01_25_56.log | open-iscsi service服务关闭失败    |
|                 | oe_test_socket_iscsid             | fail | ./mugen-riscv/logs/open-iscsi/oe_test_socket_iscsid/2023-10-20-01_29_08.log | open-iscsi service服务关闭失败    |
|                 | oe_test_target_ceph-radosgw       | fail | ./mugen-riscv/logs/ceph/oe_test_target_ceph-radosgw/2023-10-20-01_22_02.log | ceph-mon服务关闭失败              |
|                 | oe_test_target_ceph-rbd-mirror    | fail | ./mugen-riscv/logs/ceph/oe_test_target_ceph-rbd-mirror/2023-10-20-01_26_26.log | ceph-mon服务关闭失败              |
|                 | oe_test_target_ceph-mgr           | fail | ./mugen-riscv/logs/ceph/oe_test_target_ceph-mgr/2023-10-20-01_00_15.log | ceph-mon服务关闭失败              |
|                 | oe_test_target_ceph-mds           | fail | ./mugen-riscv/logs/ceph/oe_test_target_ceph-mds/2023-10-20-00_55_54.log | ceph-mon服务关闭失败              |
| avahi           | oe_test_service_avahi-daemon      | fail | ./mugen-riscv/logs/avahi/oe_test_service_avahi-daemon/2023-10-20-02_18_53.log | avahi service服务关闭失败         |
|                 | oe_test_socket_avahi-daemon       | fail | ./mugen-riscv/logs/avahi/oe_test_socket_avahi-daemon/2023-10-20-02_22_06.log | avahi service服务关闭失败         |
| systemtap       | oe_test_service_systemtap         | fail | ./mugen-riscv/logs/systemtap/oe_test_service_systemtap/2023-10-20-02_31_46.log | systemtap service服务关闭失败     |
| acpid           | oe_test_socket_acpid              | fail | ./mugen-riscv/logs/acpid/oe_test_socket_acpid/2023-10-20-01_41_46.log | acpid service服务关闭失败         |
|                 | oe_test_service_acpid             | fail | ./mugen-riscv/logs/acpid/oe_test_service_acpid/2023-10-20-01_40_16.log | acpid service服务关闭失败         |
| rsyslog         | oe_test_service_rsyslog           | fail | ./mugen-riscv/logs/rsyslog/oe_test_service_rsyslog/2023-10-19-23_22_40.log | rsyslog service服务关闭失败       |
| upower          | oe_test_service_upower            | fail | ./mugen-riscv/logs/upower/oe_test_service_upower/2023-10-22-17:00:46.log | upower service服务关闭失败        |
|                 | oe_test_target_ceph-osd           | fail | ./mugen-riscv/logs/ceph/oe_test_target_ceph-osd/2023-10-20-01_17_17.log | ceph-mon服务关闭失败              |
| pcsc-lite       | oe_test_socket_pcscd              | fail | ./mugen-riscv/logs/pcsc-lite/oe_test_socket_pcscd/2023-10-22-15:02:39.log | socket_pcscd服务关闭失败          |
| libstoragemgmt  | oe_test_service_libstoragemgmt    | fail | ./mugen-riscv/logs/libstoragemgmt/oe_test_service_libstoragemgmt/2023-10-20-03_43_49.log | libstoragemgmt关闭失败            |



### SSH连接失败

| 测试套/软件包名 | 测试用例名                    | 状态 | 日志文件                                                     | 原因        |
| --------------- | ----------------------------- | ---- | ------------------------------------------------------------ | ----------- |
| os-basic        | oe_test_expect                | fail | ./mugen-riscv/logs/os-basic/oe_test_expect/2023-10-20-08_57_14.log | ssh连接失败 |
|                 | oe_test_reboot                | fail | ./mugen-riscv/logs/os-basic/oe_test_reboot/2023-10-20-05_34_59.log | ssh连接失败 |
|                 | oe_test_net_ncat              | fail | ./mugen-riscv/logs/os-basic/oe_test_net_ncat/2023-10-20-08_42_59.log | ssh连接失败 |
|                 | oe_test_system_monitor_login  | fail | ./mugen-riscv/logs/os-basic/oe_test_system_monitor_login/2023-10-20-03_48_08.log | ssh连接失败 |
|                 | oe_test_net_cmd_scp           | fail | ./mugen-riscv/logs/os-basic/oe_test_net_cmd_scp/2023-10-20-08_40_34.log | ssh连接失败 |
|                 | oe_test_hostnamectl           | fail | ./mugen-riscv/logs/os-basic/oe_test_hostnamectl/2023-10-20-08_14_08.log | ssh连接失败 |
|                 | oe_test_net_config            | fail | ./mugen-riscv/logs/os-basic/oe_test_net_config/2023-10-20-08_41_35.log | ssh连接失败 |
|                 | oe_test_system_monitor_reboot | fail | ./mugen-riscv/logs/os-basic/oe_test_system_monitor_reboot/2023-10-20-03_17_21.log | ssh连接失败 |
| FS_Directory    | oe_test_FSIO_dir_umask_exit   | fail | ./mugen-riscv/logs/FS_Directory/oe_test_FSIO_dir_umask_exit/2023-10-22-17:56:49.log | ssh连接失败 |



### 剩余失败测试用例

| 测试套/软件包名 | 测试用例名                         | 状态 | 日志文件                                                     | 原因                                                         |      |
| --------------- | ---------------------------------- | ---- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---- |
| os-basic        | oe_test_server_mariadb_backup      | fail | ./mugen-riscv/logs/os-basic/oe_test_server_mariadb_backup/2023-10-20-04_53_13.log | 没有软件包checkpolicy-3.5-1.oe2309.riscv64                   |      |
|                 | oe_test_server_httpd_tls           | fail | ./mugen-riscv/logs/os-basic/oe_test_server_httpd_tls/2023-10-20-04_54_16.log | 没有软件包apr-1.7.0-5.oe2309.riscv64                         |      |
|                 | oe_test_server_httpd_restart       | fail | ./mugen-riscv/logs/os-basic/oe_test_server_httpd_restart/2023-10-20-04_56_13.log | 没有软件包apr-1.7.0-5.oe2309.riscv64                         |      |
|                 | oe_test_lsusb                      | fail | ./mugen-riscv/logs/os-basic/oe_test_lsusb/2023-10-20-08_59_20.log | 没有挂载usb工具                                              |      |
|                 | oe_test_USBinfo                    | fail | ./mugen-riscv/logs/os-basic/oe_test_USBinfo/2023-10-20-07_47_08.log |                                                              |      |
|                 | oe_test_uname                      | fail | ./mugen-riscv/logs/os-basic/oe_test_uname/2023-10-20-03_17_03.log | 测试用例编写错误，grep错误                                   |      |
|                 | oe_test_net_config                 | fail | ./mugen-riscv/logs/os-basic/oe_test_net_config/2023-10-20-08_41_35.log | ssh连接失败                                                  |      |
| fio             | oe_test_fio_003                    | fail | ./mugen-riscv/logs/fio/oe_test_fio_003/2023-10-22-14:16:43.log |                                                              |      |
| initscripts     | oe_test_service_network            | fail | ./mugen-riscv/logs/initscripts/oe_test_service_network/2023-10-22-13:23:34.log |                                                              |      |
|                 | oe_test_service_netconsole         | fail | ./mugen-riscv/logs/initscripts/oe_test_service_netconsole/2023-10-22-13:25:11.log |                                                              |      |
| gdm             | oe_test_service_gdm                | fail | ./mugen-riscv/logs/gdm/oe_test_service_gdm/2023-10-20-03_29_42.log | 没有包ModemManager-glib-1.20.6-1.oe2309.riscv64              |      |
| os-storage      | oe_test_storage_Mutipath_initramfs | fail | ./mugen-riscv/logs/os-storage/oe_test_storage_Mutipath_initramfs/2023-10-23-02:06:26.log | 超时                                                         |      |
| rasdaemon       | oe_test_service_ras-mc-ctl         | fail | ./mugen-riscv/logs/rasdaemon/oe_test_service_ras-mc-ctl/2023-10-20-03_01_29.log | 没有包perl-DBD-SQLite-1.72-1.oe2309.riscv64                  |      |
|                 | oe_test_service_rasdaemon          | fail | ./mugen-riscv/logs/rasdaemon/oe_test_service_rasdaemon/2023-10-20-02_59_49.log | 没有包perl-DBD-SQLite-1.72-1.oe2309.riscv64                  |      |
| PackageKit      | oe_test_packagekit_pkcon           | fail | ./mugen-riscv/logs/PackageKit/oe_test_packagekit_pkcon/2023-10-20-02_38_41.log | 测试环境已安装git导致出现误报                                |      |
| httpd           | oe_test_service_htcacheclean       | fail | ./mugen-riscv/logs/httpd/oe_test_service_htcacheclean/2023-10-19-22_42_22.log | Invalid argument                                             |      |
| iperf3          | oe_test_iperf3_command_client      | fail | ./mugen-riscv/logs/iperf3/oe_test_iperf3_command_client/2023-10-20-02_03_19.log | ./oe-rv2309/mugen-riscv_rc5/logs/iperf3/oe_test_iperf3_command_client/2023-10-10-20_03_44.log |      |
| openssh         | oe_test_openssh_locked             | fail | ./mugen-riscv/logs/openssh/oe_test_openssh_locked/2023-10-19-21_05_57.log | ./oe-rv2309/mugen-riscv_rc5/logs/openssh/oe_test_openssh_locked/2023-10-11-16:38:44.log |      |
| kmod            | oe_test_weak-modules               | fail | ./mugen-riscv/logs/kmod/oe_test_weak-modules/2023-10-22-12:59:32.log |                                                              |      |
| hdparm          | oe_test_hdparm                     | fail | ./mugen-riscv/logs/hdparm/oe_test_hdparm/2023-10-19-23_20_25.log | HDIO_GET_MULTCOUNT failed: Inappropriate ioctl for device    |      |
| smoke-basic-os  | oe_test_python_pip_install         | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_python_pip_install/2023-10-19-23_43_33.log | pip安装失败 疑似为网络问题                                   |      |
| dnf             | oe_test_dnf_help_history_info      | fail | ./mugen-riscv/logs/dnf/oe_test_dnf_help_history_info/2023-10-19-23_57_49.log | 目前软件源没有everything                                     |      |
| firewalld       | oe_test_firewalld_block_all_icmp   | fail | ./mugen-riscv/logs/firewalld/oe_test_firewalld_block_all_icmp/2023-10-19-21_56_55.log | 超时                                                         |      |
| chrony          | oe_test_service_chrony-wait        | fail | ./mugen-riscv/logs/chrony/oe_test_service_chrony-wait/2023-10-22-14:46:06.log | 配置环境出现错误                                             |      |