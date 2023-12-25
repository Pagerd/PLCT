# 工作报告

- 分析2309独立发版镜像QEMU的原因并整合进报告 [report](./week23/mugen_readme.md)
- 将当前的分析结果提交至报告[pr](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/pulls/9)

- 将之前比较明确的由测试用例引起的失败原因提交issue
  - hwloc_2.7.1测试套中oe_test_hwloc_2.7.1_hwloc-ps下载的软件版本不为2.7.1 [I8QIWX](https://gitee.com/openeuler/mugen/issues/I8QIWX)
  - pixman测试套中oe_test_pixman未考虑未安装gcc的状态 [I8QIRH](https://gitee.com/openeuler/mugen/issues/I8QIRH)
  - openblas测试套中oe_test_openblas未考虑未安装gcc的状态[I8QINA](https://gitee.com/openeuler/mugen/issues/I8QINA)
  - bison测试套中oe_test_bison未考虑未安装gcc的状态[I8QIIN](https://gitee.com/openeuler/mugen/issues/I8QIIN)
  - amanda中的oe_test_amanda_aespipe测试用例编写不合理[I8QF53](https://gitee.com/openeuler/mugen/issues/I8QF53)



| 测试套/软件包名        | 测试用例名                                   | 状态 | 日志文件                                                     | 原因                                                         |
| --------------- | ------------------------------------------------------ | ---- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| rpcbind | oe_test_socket_rpcbind                         | fail | [log](./mugen-riscv/logs/rpcbind/oe_test_socket_rpcbind/2023-11-29-08_36_49.log)                         | rpcbind.socket无法关闭 |
| libvma             | oe_test_service_vma                            | fail | [log](./mugen-riscv/logs/libvma/oe_test_service_vma/2023-11-29-02_13_29.log)                             | 没有libvma软件包 |
| cockpit            | oe_test_service_cockpit                        | fail | [log](./mugen-riscv/logs/cockpit/oe_test_service_cockpit/2023-11-28-21_39_41.log)                        | 没有依赖软件包kexec-tools |
|                    | oe_test_socket_cockpit                         | fail | [log](./mugen-riscv/logs/cockpit/oe_test_socket_cockpit/2023-11-28-21_41_12.log)                         | 没有依赖软件包kexec-tools |
|                    | oe_test_service_cockpit-wsinstance-http        | fail | [log](./mugen-riscv/logs/cockpit/oe_test_service_cockpit-wsinstance-http/2023-11-28-21_42_44.log)        | 没有依赖软件包kexec-tools |
| lorax              | oe_test_service_lorax-composer                 | fail | [log](./mugen-riscv/logs/lorax/oe_test_service_lorax-composer/2023-11-29-02_36_26.log)                   | 清除环境时超时 |
| pcp                | oe_test_pmhostname_pmlock_pmlogger_check       | fail | [log](./mugen-riscv/logs/pcp/oe_test_pmhostname_pmlock_pmlogger_check/2023-11-29-06_57_49.log)           | get mutex lock fail |
|                    | oe_test_pmlogger_daily_01                      | x86 fail | [log](./mugen-riscv/logs/pcp/oe_test_pmlogger_daily_01/2023-11-29-07_01_13.log)                          | 使用过时的egrep |
|                    | oe_test_pmprobe_01                             | x86 fail | [log](./mugen-riscv/logs/pcp/oe_test_pmprobe_01/2023-11-29-06_34_40.log)                                 | pmprobe无法录入配置，目标文件不存在 |
|                    | oe_test_pmevent_02                             | x86 fail | [log](./mugen-riscv/logs/pcp/oe_test_pmevent_02/2023-11-29-06_10_39.log)                                 | pmevent无法录入配置，目标文件不存在 |
|                    | oe_test_pcp_atop_01                            | x86 fail | [log](./mugen-riscv/logs/pcp/oe_test_pcp_atop_01/2023-11-29-07_18_24.log)                                | grep atop_s失败 |
|                    | oe_test_pcp_pcp-import-ganglia2pcp             | fail | [log](./mugen-riscv/logs/pcp/oe_test_pcp_pcp-import-ganglia2pcp/2023-11-29-07_31_53.log)                 | x86显示qemu环境不支持此测试 |
|                    | oe_test_pcp_atop_02                            | x86 fail | [log](./mugen-riscv/logs/pcp/oe_test_pcp_atop_02/2023-11-29-07_23_53.log)                                | grep atop_o失败 |
|                    | oe_test_service_pmwebd                         | x86 fail | [log](./mugen-riscv/logs/pcp/oe_test_service_pmwebd/2023-11-29-07_52_52.log)                             | 找不到服务pmwebd.service |
|                    | oe_test_pmval_02                               | x86 fail | [log](./mugen-riscv/logs/pcp/oe_test_pmval_02/2023-11-29-06_49_47.log)                                   | pmval无法录入配置，目标文件不存在 |
|                    | oe_test_service_pmmgr                          | x86 fail | [log](./mugen-riscv/logs/pcp/oe_test_service_pmmgr/2023-11-29-07_49_31.log)                              | 没有包pcp-manager |
|                    | oe_test_pmlogcheck_pmlogmv                     | x86 fail | [log](./mugen-riscv/logs/pcp/oe_test_pmlogcheck_pmlogmv/2023-11-29-06_22_09.log)                         | pmlogmv link失败 |
| os-storage         | oe_test_storage_smb_abnormal_poweroff          | fail | [log](./mugen-riscv/logs/os-storage/oe_test_storage_smb_abnormal_poweroff/2023-11-29-07_59_50.log)       | x86显示qemu环境不支持此测试 |
|                    | oe_test_storage_nfs_repeat_restartServer       | fail | [log](./mugen-riscv/logs/os-storage/oe_test_storage_nfs_repeat_restartServer/2023-11-29-06_32_25.log)    | 超时 |
|                    | oe_test_storage_smb_cmd_smbclient              | fail | [log](./mugen-riscv/logs/os-storage/oe_test_storage_smb_cmd_smbclient/2023-11-29-08_24_03.log)           | 未预装smbclient |
|                    | oe_test_storage_fileCMD_cat                    | fail | [log](./mugen-riscv/logs/os-storage/oe_test_storage_fileCMD_cat/2023-11-29-05_38_07.log)                 | riscv用户密码文件结构与x86不同 |
|                    | oe_test_storage_fileCMD_mkfs                   | fail | [log](./mugen-riscv/logs/os-storage/oe_test_storage_fileCMD_mkfs/2023-11-29-05_40_29.log)                | 没有预装umount |
|                    | oe_test_storage_fileCMD_dd                     | fail | [log](./mugen-riscv/logs/os-storage/oe_test_storage_fileCMD_dd/2023-11-29-06_19_24.log)                  | 没有预装umount |
|                    | oe_test_storage_Mutipath_dmsetup               | fail | [log](./mugen-riscv/logs/os-storage/oe_test_storage_Mutipath_dmsetup/2023-11-29-05_31_35.log)            | qemu环境不支持此测试 |
| clevis             | oe_test_install_clevis                         | fail | [log](./mugen-riscv/logs/clevis/oe_test_install_clevis/2023-11-28-21_35_10.log)                          | 密钥不可用 |
|                    | oe_test_high_nbde                              | fail | [log](./mugen-riscv/logs/clevis/oe_test_high_nbde/2023-11-28-21_32_07.log)                               | 软件源没有包cryptsetup-reencrypt |
|                    | oe_test_tang_encrypt                           | x86 fail | [log](./mugen-riscv/logs/clevis/oe_test_tang_encrypt/2023-11-28-21_37_18.log)                            | 无法连接至目标端口 |
|                    | oe_test_service_clevis-luks-askpass            | x86 fail | [log](./mugen-riscv/logs/clevis/oe_test_service_clevis-luks-askpass/2023-11-28-21_30_36.log)             | 测试用例编写错误？ |
| initscripts        | oe_test_service_import-state                   | x86 fail | [log](./mugen-riscv/logs/initscripts/oe_test_service_import-state/2023-11-28-23_53_34.log)               |    |
|  openssh           | oe_test_openssh_locked                         | fail | [log](./mugen-riscv/logs/openssh/oe_test_openssh_locked/2023-11-29-04_47_39.log)                         | x86显示qemu环境不支持此测试 |
|                    | oe_test_sec_ssh                                | x86 fail | [log](./mugen-riscv/logs/openssh/oe_test_sec_ssh/2023-11-29-05_02_06.log)                                |    |
|                    | oe_test_service_sshd                           | x86 fail | [log](./mugen-riscv/logs/openssh/oe_test_service_sshd/2023-11-29-04_59_12.log)                           |    |
| fwupd              | oe_test_service_fwupd-offline-update           | fail | [log](./mugen-riscv/logs/fwupd/oe_test_service_fwupd-offline-update/2023-11-28-22_45_31.log)             | 超时 |
|                    | oe_test_service_fwupd-refresh                  | fail | [log](./mugen-riscv/logs/fwupd/oe_test_service_fwupd-refresh/2023-11-28-23_29_17.log)                    | 超时 |
|    systemd         | oe_test_socket_systemd-journald-audit          | fail | [log](./mugen-riscv/logs/systemd/oe_test_socket_systemd-journald-audit/2023-11-29-13_35_30.log)          | 重启systemd-journald-audit.socket服务失败 |
|systemd             | oe_test_socket_systemd-journald-dev-log        | x86 fail | [log](./mugen-riscv/logs/systemd/oe_test_socket_systemd-journald-dev-log/2023-11-29-13_36_20.log)        |    |
|                    | oe_test_target_cryptsetup-pre                  | x86 fail | [log](./mugen-riscv/logs/systemd/oe_test_target_cryptsetup-pre/2023-11-29-13_47_14.log)                  |    |
|                    | oe_test_service_systemd-fsck-root              | x86 fail | [log](./mugen-riscv/logs/systemd/oe_test_service_systemd-fsck-root/2023-11-29-12_57_34.log)              |    |
|                    | oe_test_target_cryptsetup                      | x86 fail | [log](./mugen-riscv/logs/systemd/oe_test_target_cryptsetup/2023-11-29-13_47_39.log)                      |    |
|                    | oe_test_service_systemd-vconsole-setup         | x86 fail | [log](./mugen-riscv/logs/systemd/oe_test_service_systemd-vconsole-setup/2023-11-29-13_30_06.log)         |    |
|                    | oe_test_socket_systemd-journal-gatewayd        | x86 fail | [log](./mugen-riscv/logs/systemd/oe_test_socket_systemd-journal-gatewayd/2023-11-29-13_37_48.log)        |    |
|                    | oe_test_service_systemd-udevd                  | x86 fail | [log](./mugen-riscv/logs/systemd/oe_test_service_systemd-udevd/2023-11-29-13_25_53.log)                  |    |
|                    | oe_test_socket_systemd-rfkill                  | x86 fail | [log](./mugen-riscv/logs/systemd/oe_test_socket_systemd-rfkill/2023-11-29-13_41_08.log)                  |    |
|                    | oe_test_service_systemd-journal-gatewayd       | x86 fail | [log](./mugen-riscv/logs/systemd/oe_test_service_systemd-journal-gatewayd/2023-11-29-13_04_58.log)       |    |
|                    | oe_test_service_systemd-portabled              | x86 fail | [log](./mugen-riscv/logs/systemd/oe_test_service_systemd-portabled/2023-11-29-13_14_57.log)              |    |
|                    | oe_test_target_machines                        | x86 fail | [log](./mugen-riscv/logs/systemd/oe_test_target_machines/2023-11-29-13_59_12.log)                        |    |
| ndisc6             | oe_test_ndisc6_name2addr                       | fail | [log](./mugen-riscv/logs/ndisc6/oe_test_ndisc6_name2addr/2023-11-29-04_00_07.log)                        | x86显示qemu环境不支持此测试 |
|                    | oe_test_ndisc6_rdisc6                          | fail | [log](./mugen-riscv/logs/ndisc6/oe_test_ndisc6_rdisc6/2023-11-29-04_03_17.log)                           | x86显示qemu环境不支持此测试 |
| qperf              | oe_test_qperf_01                               | x86 fail | [log](./mugen-riscv/logs/qperf/oe_test_qperf_01/2023-11-29-08_09_18.log)                                 | 安装时失败 |
| iperf3             | oe_test_iperf3_command_client                  | fail | [log](./mugen-riscv/logs/iperf3/oe_test_iperf3_command_client/2023-11-29-00_02_32.log)                   | x86显示qemu环境不支持此测试 |
| firewalld          | oe_test_service_firewalld                      | x86 fail | [log](./mugen-riscv/logs/firewalld/oe_test_service_firewalld/2023-11-29-14_22_41.log)                    | 关闭firewalld服务时失败 |
|                    | oe_test_firewalld_log_denied                   | x86 fail | [log](./mugen-riscv/logs/firewalld/oe_test_firewalld_log_denied/2023-11-29-13_44_32.log)                 | 安装nmap出错 |
|                    | oe_test_firewalld_richrule_dropipv4pak         | fail | [log](./mugen-riscv/logs/firewalld/oe_test_firewalld_richrule_dropipv4pak/2023-11-29-14_05_25.log)       | x86显示qemu环境不支持此测试 |
|                    | oe_test_firewalld_protocol_tcp                 | fail | [log](./mugen-riscv/logs/firewalld/oe_test_firewalld_protocol_tcp/2023-11-29-13_57_12.log)               | x86显示qemu环境不支持此测试 |
|                    | oe_test_firewalld_port_map                     | fail | [log](./mugen-riscv/logs/firewalld/oe_test_firewalld_port_map/2023-11-29-13_54_50.log)                   | x86显示qemu环境不支持此测试 |
|                    | oe_test_firewalld_forward_nat                  | fail | [log](./mugen-riscv/logs/firewalld/oe_test_firewalld_forward_nat/2023-11-29-13_40_38.log)                | x86显示qemu环境不支持此测试 |
|                    | oe_test_firewalld_dnat                         | fail | [log](./mugen-riscv/logs/firewalld/oe_test_firewalld_dnat/2023-11-29-13_35_02.log)                       | x86显示qemu环境不支持此测试 |
|                    | oe_test_firewalld_richrule_forwardport         | fail | [log](./mugen-riscv/logs/firewalld/oe_test_firewalld_richrule_forwardport/2023-11-29-14_07_24.log)       | x86显示qemu环境不支持此测试 |
|                    | oe_test_firewalld_set_defaultzone              | fail | [log](./mugen-riscv/logs/firewalld/oe_test_firewalld_set_defaultzone/2023-11-29-14_10_28.log)            | x86显示qemu环境不支持此测试 |
|                    | oe_test_firewalld_dropzone_service             | fail | [log](./mugen-riscv/logs/firewalld/oe_test_firewalld_dropzone_service/2023-11-29-13_38_47.log)           | x86显示qemu环境不支持此测试 |
|                    | oe_test_firewalld_default_rules                | x86 fail | [log](./mugen-riscv/logs/firewalld/oe_test_firewalld_default_rules/2023-11-29-14_23_50.log)              | qemu使用的虚拟网卡连接，与测试用例预期期望不符 |
|                    | oe_test_firewalld_richrule_allowippak          | fail | [log](./mugen-riscv/logs/firewalld/oe_test_firewalld_richrule_allowippak/2023-11-29-14_01_31.log)        | x86显示qemu环境不支持此测试 |
|                    | oe_test_firewalld_richrule_blacklist           | fail | [log](./mugen-riscv/logs/firewalld/oe_test_firewalld_richrule_blacklist/2023-11-29-14_03_14.log)         | x86显示qemu环境不支持此测试 |
| os-basic           | oe_test_nmcli_set_team                         | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_nmcli_set_team/2023-11-29-10_19_47.log)                        | 疑似为字符grep失败 |
|                    | oe_test_csplit                                 | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_csplit/2023-11-29-05_25_52.log)                                | /tmp/xx00: No such file or directory |
|                    | oe_test_server_vsftpd_transfer                 | fail | [log](./mugen-riscv/logs/os-basic/oe_test_server_vsftpd_transfer/2023-11-29-05_59_33.log)                | x86显示qemu环境不支持此测试 |
|                    | oe_test_who                                    | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_who/2023-11-29-05_24_31.log)                                   | 疑似为测试用例编写错误，grep 用户pts |
|                    | oe_test_xmlsec                                 | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_xmlsec/2023-11-29-10_42_55.log)                                | 未预装unzip |
|                    | oe_test_libsecret                              | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_libsecret/2023-11-29-11_33_55.log)                             | Cannot autolaunch D-Bus without X11 $DISPLAY |
|                    | oe_test_libidn                                 | fail | [log](./mugen-riscv/logs/os-basic/oe_test_libidn/2023-11-29-11_45_59.log)                                | 未安装gcc |
|                    | oe_test_system_log_dmesg                       | fail | [log](./mugen-riscv/logs/os-basic/oe_test_system_log_dmesg/2023-11-29-05_58_14.log)                      | rv的启动日志与x86不符 |
|                    | oe_test_count_gperftools_function              | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_count_gperftools_function/2023-11-29-11_19_38.log)             | 未预装g++ |
|                    | oe_test_cairo                                  | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_cairo/2023-11-29-11_22_11.log)                                 | 未预装gcc |
|                    | oe_test_reboot                                 | fail | [log](./mugen-riscv/logs/os-basic/oe_test_reboot/2023-11-29-08_01_30.log)                                | x86显示qemu环境不支持此测试 |
|                    | oe_test_aureport                               | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_aureport/2023-11-29-10_46_39.log)                              | 未预装aureport |
|                    | oe_test_power_measurement_internal             | fail | [log](./mugen-riscv/logs/os-basic/oe_test_power_measurement_internal/2023-11-29-08_51_01.log)            | 等待时间过短 |
|                    | oe_test_nmcli_config_connect                   | fail | [log](./mugen-riscv/logs/os-basic/oe_test_nmcli_config_connect/2023-11-29-09_00_57.log)                  | x86显示qemu环境不支持此测试 |
|                    | oe_test_server_vsftpd_NKdelay                  | fail | [log](./mugen-riscv/logs/os-basic/oe_test_server_vsftpd_NKdelay/2023-11-29-06_17_24.log)                 | x86显示qemu环境不支持此测试 |
|                    | oe_test_envsubst                               | fail | [log](./mugen-riscv/logs/os-basic/oe_test_envsubst/2023-11-29-05_27_54.log)                              | 未预装envsubst |
|                    | oe_test_kernel_kdump                           | fail | [log](./mugen-riscv/logs/os-basic/oe_test_kernel_kdump/2023-11-29-09_42_15.log)                          | rv软件源没有kexec-tools |
|                    | oe_test_pcre_use                               | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_pcre_use/2023-11-29-10_31_42.log)                              | 未预装gcc |
|                    | oe_test_libunistring                           | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_libunistring/2023-11-29-10_40_41.log)                          | 未预装gcc |
|                    | oe_test_xzcmp                                  | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_xzcmp/2023-11-29-11_29_46.log)                                 | grep中文字符 |
|                    | oe_test_kernel_sysctl                          | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_kernel_sysctl/2023-11-29-09_41_14.log)                         |    |
|                    | oe_test_timedatectl                            | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_timedatectl/2023-11-29-05_48_09.log)                           | 不支持NTP not supported |
|                    | oe_test_system_log_recorded                    | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_system_log_recorded/2023-11-29-05_57_20.log)                   | 没有目标文件 |
|                    | oe_test_enchant2                               | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_enchant2/2023-11-29-11_43_25.log)                              | 疑似为测试用例grep错误 |
|                    | oe_test_system_monitor_login                   | fail | [log](./mugen-riscv/logs/os-basic/oe_test_system_monitor_login/2023-11-29-05_54_51.log)                  | x86显示qemu环境不支持此测试 |
|                    | oe_test_logsave                                | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_logsave/2023-11-29-11_45_04.log)                               | 测试用例未更新导致下载的测试文件结构有变化 |
|                    | oe_test_power_powertop2tuned_optimize          | fail | [log](./mugen-riscv/logs/os-basic/oe_test_power_powertop2tuned_optimize/2023-11-29-08_49_22.log)         | Powertop版本不兼容 |
|                    | oe_test_gcc_01                                 | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_gcc_01/2023-11-29-11_26_08.log)                                |    |
|                    | oe_test_power_powertop_powerup                 | fail | [log](./mugen-riscv/logs/os-basic/oe_test_power_powertop_powerup/2023-11-29-08_48_03.log)                | 无法找到对应进程 |
|                    | oe_test_nmcli_set_bond                         | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_nmcli_set_bond/2023-11-29-10_17_28.log)                        | 测试用例不兼容qemu环境 |
|                    | oe_test_server_squid_blacklist                 | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_server_squid_blacklist/2023-11-29-06_24_16.log)                | 黑名单没有正确生效 |
|                    | oe_test_sos                                    | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_sos/2023-11-29-07_31_06.log)                                   | 超时 |
|                    | oe_test_awk                                    | fail | [log](./mugen-riscv/logs/os-basic/oe_test_awk/2023-11-29-05_39_49.log)                                   | rv的cpu信息不同 |
|                    | oe_test_system_monitor_share_total             | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_system_monitor_share_total/2023-11-29-10_18_38.log)            |    |
|                    | oe_test_catman                                 | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_catman/2023-11-29-05_31_02.log)                                | No such file or directory en.tmac |
|                    | oe_test_disk_graphics_card                     | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_disk_graphics_card/2023-11-29-10_19_04.log)                    | 未预装lspci |
|                    | oe_test_glibc                                  | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_glibc/2023-11-29-11_21_42.log)                                 | 未预装gcc |
|                    | oe_test_server_mariadb_compatibilty            | fail | [log](./mugen-riscv/logs/os-basic/oe_test_server_mariadb_compatibilty/2023-11-29-06_53_20.log)           | x86显示qemu环境不支持此测试 |
|                    | oe_test_net_mtr                                | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_net_mtr/2023-11-29-10_28_48.log)                               |    |
|                    | oe_test_uname                                  | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_uname/2023-11-29-05_47_43.log)                                 | 未预装hostname |
|                    | oe_test_c_stat                                 | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_c_stat/2023-11-29-11_23_31.log)                                | 未预装gcc |
|                    | oe_test_dmraid                                 | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_dmraid/2023-11-29-05_34_02.log)                                | 测试用例编写错误 |
|                    | oe_test_ar                                     | x86 fail | [log](./mugen-riscv/logs/os-basic/oe_test_ar/2023-11-29-10_33_47.log)                                    | 未预装ar |
| powertop           | oe_test_service_powertop                       | fail | [log](./mugen-riscv/logs/powertop/oe_test_service_powertop/2023-11-29-07_22_52.log)                      | modprobe cpufreq_stats failed |
| multipath-tools    | oe_test_multipath-tools_kpartx                 | fail | [log](./mugen-riscv/logs/multipath-tools/oe_test_multipath-tools_kpartx/2023-11-29-03_50_41.log)         | x86显示qemu环境不支持此测试 |
| ipmitool           | oe_test_service_exchange-bmc-os-info           | fail | [log](./mugen-riscv/logs/ipmitool/oe_test_service_exchange-bmc-os-info/2023-11-29-00_02_41.log)          | x86显示qemu环境不支持此测试 |
|                    | oe_test_service_ipmitool                       | fail | [log](./mugen-riscv/logs/ipmitool/oe_test_service_ipmitool/2023-11-29-00_06_09.log)                      | x86显示qemu环境不支持此测试 |
|                    | oe_test_service_ipmievd                        | fail | [log](./mugen-riscv/logs/ipmitool/oe_test_service_ipmievd/2023-11-29-00_04_25.log)                       | x86显示qemu环境不支持此测试 |
|                    | oe_test_service_bmc-snmp-proxy                 | fail | [log](./mugen-riscv/logs/ipmitool/oe_test_service_bmc-snmp-proxy/2023-11-29-00_00_59.log)                | x86显示qemu环境不支持此测试 |
| FS_Directory       | oe_test_FSIO_dir_access_root                   | x86 fail | [log](./mugen-riscv/logs/FS_Directory/oe_test_FSIO_dir_access_root/2023-11-28-22_33_02.log)              | /root内默认不带anaconda-ks.cfg |
|                    | oe_test_FSIO_dir_access_dev                    | fail | [log](./mugen-riscv/logs/FS_Directory/oe_test_FSIO_dir_access_dev/2023-11-28-22_29_34.log)               | /dev内与预期不符 |
|                    | oe_test_FSIO_dir_access_proc                   | fail | [log](./mugen-riscv/logs/FS_Directory/oe_test_FSIO_dir_access_proc/2023-11-28-22_32_36.log)              | rv cpu信息与x86不同 |
|                    | oe_test_FSIO_dir_create_lack_inode             | x86 fail | [log](./mugen-riscv/logs/FS_Directory/oe_test_FSIO_dir_create_lack_inode/2023-11-28-22_39_36.log)        | 测试用例无法将磁盘空间写满 |
|                    | oe_test_FSIO_dir_access_boot                   | x86 fail | [log](./mugen-riscv/logs/FS_Directory/oe_test_FSIO_dir_access_boot/2023-11-28-22_29_08.log)              | /boot内与预期不符 |
|                    | oe_test_FSIO_dir_access_var                    | fail | [log](./mugen-riscv/logs/FS_Directory/oe_test_FSIO_dir_access_var/2023-11-28-22_36_05.log)               |    |
| kpatch             | oe_test_service_kpatch                         | fail | [log](./mugen-riscv/logs/kpatch/oe_test_service_kpatch/2023-11-29-01_08_20.log)                          | 软件源内没有kpatch |
| FS_FileSystem      | oe_test_FSIO_check_fs_type                     | fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_check_fs_type/2023-11-28-22_48_22.log)               | oERV不支持ext4 |
|                    | oe_test_FSIO_mount_ext3_ro                     | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_ext3_ro/2023-11-28-22_59_07.log)               | mount测试文件失败 |
|                    | oe_test_FSIO_mount_ext4_sync                   | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_ext4_sync/2023-11-28-23_06_36.log)             | oERV不支持ext4 x86未预装lvcreate |
|                    | oe_test_FSIO_mount_xfs_nodiscard               | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_xfs_nodiscard/2023-11-28-23_14_28.log)         | 目标文件不存在 |
|                    | oe_test_FSIO_mount_xfs_discard                 | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_xfs_discard/2023-11-28-23_14_00.log)           | mount测试文件失败 |
|                    | oe_test_FSIO_mount_nonempty_dir                | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_nonempty_dir/2023-11-28-23_07_23.log)          | mount测试文件失败 |
|                    | oe_test_FSIO_mount_xfs_xfsrestore              | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_xfs_xfsrestore/2023-11-28-23_17_16.log)        | mount测试文件失败 |
|                    | oe_test_FSIO_mv_rm_mount                       | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mv_rm_mount/2023-11-28-23_17_54.log)                 | mount测试文件失败 |
|                    | oe_test_FSIO_mount_xfs_sync                    | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_xfs_sync/2023-11-28-23_15_54.log)              | mount测试文件失败 |
|                    | oe_test_FSIO_mount_ext3_to_ext4                | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_ext3_to_ext4/2023-11-28-23_01_51.log)          | oERV不支持ext4 x86未预装lvcreate |
|                    | oe_test_FSIO_xfs_resize2fs                     | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_xfs_resize2fs/2023-11-28-23_33_33.log)               | x86未预装lvextend rv xfs命令找不到目标文件 |
|                    | oe_test_FSIO_ext4_resize2fs                    | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_ext4_resize2fs/2023-11-28-22_53_10.log)              | oERV不支持ext4 x86未预装lvresize |
|                    | oe_test_FSIO_mount_ext4_delalloc               | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_ext4_delalloc/2023-11-28-23_02_50.log)         | oERV不支持ext4 x86未预装lvcreate |
|                    | oe_test_FSIO_change_fs                         | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_change_fs/2023-11-28-22_47_27.log)                   | oERV不支持ext4 x86未预装lvcreate |
|                    | oe_test_FSIO_mount_xfs_dax                     | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_xfs_dax/2023-11-28-23_13_15.log)               | oERV不支持ext4 x86未预装lvcreate |
|                    | oe_test_FSIO_mount_xfs_ro                      | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_xfs_ro/2023-11-28-23_14_57.log)                | oERV mount测试文件失败 x86未预装lvcreate |
|                    | oe_test_FSIO_umount_by_openfile                | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_umount_by_openfile/2023-11-28-23_33_02.log)          | oERV mount测试文件失败 x86未预装lvcreate |
|                    | oe_test_FSIO_mount_automount                   | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_automount/2023-11-28-22_54_16.log)             | oERV mount测试文件失败 x86未预装lvcreate |
|                    | oe_test_FSIO_mount_ext4_ro                     | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_ext4_ro/2023-11-28-23_04_42.log)               | oERV不支持ext4 x86未预装lvcreate |
|                    | oe_test_FSIO_mount_empty_dir                   | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_empty_dir/2023-11-28-22_58_36.log)             | oERV mount测试文件失败 x86未预装lvcreate |
|                    | oe_test_FSIO_create_xfs                        | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_create_xfs/2023-11-28-22_49_47.log)                  | oERV mount测试文件失败 x86未预装lvcreate |
|                    | oe_test_FSIO_mount_ext3_rw                     | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_ext3_rw/2023-11-28-22_59_37.log)               | oERV mount测试文件失败 x86未预装lvcreate |
|                    | oe_test_FSIO_mount_reboot                      | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_reboot/2023-11-28-23_07_58.log)                | oERV mount测试文件失败 x86未预装lvcreate |
|                    | oe_test_FSIO_mount_ext4_rw                     | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_ext4_rw/2023-11-28-23_05_10.log)               | oERV mount测试文件失败 x86未预装lvcreate |
|                    | oe_test_FSIO_ext4_e4defrag                     | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_ext4_e4defrag/2023-11-28-22_52_31.log)               | oERV mount测试文件失败 x86未预装lvcreate |
|                    | oe_test_FSIO_mount_ext4_discard                | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_ext4_discard/2023-11-28-23_03_17.log)          | oERV mount测试文件失败 x86未预装lvcreate |
|                    | oe_test_FSIO_create_ext4                       | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_create_ext4/2023-11-28-22_49_17.log)                 | oERV mount测试文件失败 x86未预装lvcreate |
|                    | oe_test_FSIO_umount_busy                       | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_umount_busy/2023-11-28-23_32_22.log)                 | oERV mount测试文件失败 x86未预装lvcreate |
|                    | oe_test_FSIO_mount_ext4_nodiscard              | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_ext4_nodiscard/2023-11-28-23_04_14.log)        | oERV mount测试文件失败 x86未预装lvcreate |
|                    | oe_test_FSIO_create_squashfs                   | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_create_squashfs/2023-11-28-23_34_03.log)             | mount测试文件失败 |
|                    | oe_test_FSIO_ext3_resize2fs                    | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_ext3_resize2fs/2023-11-28-22_51_58.log)              | mount测试文件失败 |
|                    | oe_test_FSIO_mount_umount_ext4                 | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_umount_ext4/2023-11-28-23_12_09.log)           | mount测试文件失败 |
|                    | oe_test_FSIO_mount_umount_xfs                  | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_umount_xfs/2023-11-28-23_12_41.log)            | oERV mount测试文件失败 x86未预装lvcreate |
|                    | oe_test_FSIO_mount_ext4_noblock_validity       | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_ext4_noblock_validity/2023-11-28-23_03_46.log) | mount测试文件失败 |
|                    | oe_test_FSIO_mount_ext4_setErrors              | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_ext4_setErrors/2023-11-28-23_06_06.log)        | mount测试文件失败 |
|                    | oe_test_FSIO_mount_umount_ext3                 | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_umount_ext3/2023-11-28-23_11_36.log)           | mount测试文件失败 |
|                    | oe_test_FSIO_remkfs                            | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_remkfs/2023-11-28-23_22_52.log)                      | mount测试文件失败 |
|                    | oe_test_FSIO_mount_remount                     | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_remount/2023-11-28-23_10_58.log)               | mount测试文件失败 |
|                    | oe_test_FSIO_mount_ext3_setErrors              | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_ext3_setErrors/2023-11-28-23_00_33.log)        | mount测试文件失败 |
|                    | oe_test_FSIO_mount_ext3_sync                   | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_ext3_sync/2023-11-28-23_01_04.log)             | mount测试文件失败 |
|                    | oe_test_FSIO_create_ext3                       | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_create_ext3/2023-11-28-22_48_48.log)                 | mount测试文件失败 |
|                    | oe_test_FSIO_mount_xfs_rw                      | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_xfs_rw/2023-11-28-23_15_26.log)                | mount测试文件失败 |
|                    | oe_test_FSIO_mount_ext4_block_validity         | x86 fail | [log](./mugen-riscv/logs/FS_FileSystem/oe_test_FSIO_mount_ext4_block_validity/2023-11-28-23_02_21.log)   | mount测试文件失败 |
| python-blivet      | oe_test_service_blivet                         | fail | [log](./mugen-riscv/logs/python-blivet/oe_test_service_blivet/2023-11-29-07_34_48.log)                   | 超时 |
| chrony             | oe_test_service_chronyd                        | fail | [log](./mugen-riscv/logs/chrony/oe_test_service_chronyd/2023-11-28-21_28_47.log)                         | chronyd.service关闭失败 |
| javapackages-tools | oe_test_gradle-local                           | fail | [log](./mugen-riscv/logs/javapackages-tools/oe_test_gradle-local/2023-11-29-01_01_37.log)                | 没有预装gradle-local |









