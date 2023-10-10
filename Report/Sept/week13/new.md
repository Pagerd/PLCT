## RISCV 2309 RC3测试与RC1对比结果

下为相比RC1为新增fail的测试用例

| 测试套/软件包名    | 测试用例名                                                   | 状态 | 日志文件                                                     | 原因 |
| ------------------ | ------------------------------------------------------------ | ---- | ------------------------------------------------------------ | ---- |
| ntp                | oe_test_service_ntp-wait                                     | fail | ./mugen-riscv/logs/ntp/oe_test_service_ntp-wait/2023-09-22-00_29_40.log |      |
|                    | oe_test_service_ntpdate                                      | fail | ./mugen-riscv/logs/ntp/oe_test_service_ntpdate/2023-09-22-00_24_00.log |      |
|                    | oe_test_service_ntpd                                         | fail | ./mugen-riscv/logs/ntp/oe_test_service_ntpd/2023-09-22-00_27_08.log |      |
|                    | oe_test_service_sntp                                         | fail | ./mugen-riscv/logs/ntp/oe_test_service_sntp/2023-09-22-00_32_13.log |      |
|                    | oe_test_chrony_Manuall                                       | fail | ./mugen-riscv/logs/os-basic/oe_test_chrony_Manuall/2023-09-22-08_54_16.log |      |
|                    | oe_test_server_httpd_recover                                 | fail | ./mugen-riscv/logs/os-basic/oe_test_server_httpd_recover/2023-09-22-05_56_06.log |      |
|                    | oe_test_power_powertop_powerup                               | fail | ./mugen-riscv/logs/os-basic/oe_test_power_powertop_powerup/2023-09-22-08_28_59.log |      |
|                    | oe_test_disk_tuned_disable                                   | fail | ./mugen-riscv/logs/os-basic/oe_test_disk_tuned_disable/2023-09-22-08_50_35.log |      |
|                    | oe_test_disk_tuned_install                                   | fail | ./mugen-riscv/logs/os-basic/oe_test_disk_tuned_install/2023-09-22-08_49_03.log |      |
|                    | oe_test_disk_tuned_modify                                    | fail | ./mugen-riscv/logs/os-basic/oe_test_disk_tuned_modify/2023-09-22-08_50_00.log |      |
|                    | oe_test_chrony_chronyc_ntpstat                               | fail | ./mugen-riscv/logs/os-basic/oe_test_chrony_chronyc_ntpstat/2023-09-22-08_53_08.log |      |
|                    | oe_test_server_mysql                                         | fail | ./mugen-riscv/logs/os-basic/oe_test_server_mysql/2023-09-22-05_12_50.log |      |
|                    | oe_test_chrony_chronyd                                       | fail | ./mugen-riscv/logs/os-basic/oe_test_chrony_chronyd/2023-09-22-08_53_53.log |      |
|                    | oe_test_server_httpd_tls                                     | fail | ./mugen-riscv/logs/os-basic/oe_test_server_httpd_tls/2023-09-22-05_50_38.log |      |
|                    | oe_test_server_httpd_restart                                 | fail | ./mugen-riscv/logs/os-basic/oe_test_server_httpd_restart/2023-09-22-05_51_27.log |      |
|                    | oe_test_performance_monitor_pcp                              | fail | ./mugen-riscv/logs/os-basic/oe_test_performance_monitor_pcp/2023-09-22-08_31_09.log |      |
|                    | oe_test_power_measurement_internal                           | fail | ./mugen-riscv/logs/os-basic/oe_test_power_measurement_internal/2023-09-22-08_30_48.log |      |
|                    | oe_test_chrony_chronyc_cmd                                   | fail | ./mugen-riscv/logs/os-basic/oe_test_chrony_chronyc_cmd/2023-09-22-08_52_23.log |      |
|                    | oe_test_chrony_chronyc_hardwaretime                          | fail | ./mugen-riscv/logs/os-basic/oe_test_chrony_chronyc_hardwaretime/2023-09-22-08_52_45.log |      |
|                    | oe_test_uname                                                | fail | ./mugen-riscv/logs/os-basic/oe_test_uname/2023-09-22-04_43_14.log |      |
|                    | oe_test_service_pmlogger                                     | fail | ./mugen-riscv/logs/pcp/oe_test_service_pmlogger/2023-09-22-08_48_44.log |      |
|                    | oe_test_pmconfig_pmie_check                                  | fail | ./mugen-riscv/logs/pcp/oe_test_pmconfig_pmie_check/2023-09-22-05_47_50.log |      |
|                    | oe_test_pmstore_install-sh                                   | fail | ./mugen-riscv/logs/pcp/oe_test_pmstore_install-sh/2023-09-22-05_37_05.log |      |
|                    | oe_test_pmdumplog_01                                         | fail | ./mugen-riscv/logs/pcp/oe_test_pmdumplog_01/2023-09-22-04_58_32.log |      |
|                    | oe_test_pmevent_01                                           | fail | ./mugen-riscv/logs/pcp/oe_test_pmevent_01/2023-09-22-05_02_56.log |      |
|                    | oe_test_service_pmcd                                         | fail | ./mugen-riscv/logs/pcp/oe_test_service_pmcd/2023-09-22-08_43_49.log |      |
|                    | oe_test_pcp_pcp-import-iostat2pcp                            | fail | ./mugen-riscv/logs/pcp/oe_test_pcp_pcp-import-iostat2pcp/2023-09-22-07_41_32.log |      |
|                    | oe_test_service_pmproxy                                      | fail | ./mugen-riscv/logs/pcp/oe_test_service_pmproxy/2023-09-22-08_53_58.log |      |
|                    | oe_test_pminfo_03                                            | fail | ./mugen-riscv/logs/pcp/oe_test_pminfo_03/2023-09-22-05_11_57.log |      |
|                    | oe_test_pmlogconf_pmlogsize                                  | fail | ./mugen-riscv/logs/pcp/oe_test_pmlogconf_pmlogsize/2023-09-22-05_17_55.log |      |
|                    | oe_test_pmfind_pmgenmap_pmie2col_pminfo_01                   | fail | ./mugen-riscv/logs/pcp/oe_test_pmfind_pmgenmap_pmie2col_pminfo_01/2023-09-22-05_07_19.log |      |
|                    | oe_test_pmprobe_02                                           | fail | ./mugen-riscv/logs/pcp/oe_test_pmprobe_02/2023-09-22-05_30_06.log |      |
|                    | oe_test_pmlogreduce_pmpause_pmpost_pmsleep                   | fail | ./mugen-riscv/logs/pcp/oe_test_pmlogreduce_pmpause_pmpost_pmsleep/2023-09-22-06_31_45.log |      |
|                    | oe_test_pmlogger_daily_02                                    | fail | ./mugen-riscv/logs/pcp/oe_test_pmlogger_daily_02/2023-09-22-05_56_31.log |      |
|                    | oe_test_pmloglabel                                           | fail | ./mugen-riscv/logs/pcp/oe_test_pmloglabel/2023-09-22-05_20_09.log |      |
|                    | oe_test_pcp_pcp-import-mrtg2pcp                              | fail | ./mugen-riscv/logs/pcp/oe_test_pcp_pcp-import-mrtg2pcp/2023-09-22-08_11_46.log |      |
|                    | oe_test_pmlogsummary_01                                      | fail | ./mugen-riscv/logs/pcp/oe_test_pmlogsummary_01/2023-09-22-05_22_13.log |      |
|                    | oe_test_service_pmie                                         | fail | ./mugen-riscv/logs/pcp/oe_test_service_pmie/2023-09-22-08_45_49.log |      |
|                    | oe_test_pcp                                                  | fail | ./mugen-riscv/logs/pcp/oe_test_pcp/2023-09-22-04_54_18.log   |      |
|                    | oe_test_pcp-summary_pcp-vmstat_pmcd_wait                     | fail | ./mugen-riscv/logs/pcp/oe_test_pcp-summary_pcp-vmstat_pmcd_wait/2023-09-22-05_43_20.log |      |
|                    | oe_test_pcp_pcp-import-collectl2pcp                          | fail | ./mugen-riscv/logs/pcp/oe_test_pcp_pcp-import-collectl2pcp/2023-09-22-06_41_03.log |      |
|                    | oe_test_pminfo_02                                            | fail | ./mugen-riscv/logs/pcp/oe_test_pminfo_02/2023-09-22-05_09_52.log |      |
|                    | oe_test_pmlogsummary_02                                      | fail | ./mugen-riscv/logs/pcp/oe_test_pmlogsummary_02/2023-09-22-05_25_20.log |      |
|                    | oe_test_pmval_01                                             | fail | ./mugen-riscv/logs/pcp/oe_test_pmval_01/2023-09-22-05_39_02.log |      |
|                    | oe_test_pmpython_mkaf_pcp-python                             | fail | ./mugen-riscv/logs/pcp/oe_test_pmpython_mkaf_pcp-python/2023-09-22-05_32_03.log |      |
|                    | oe_test_pmstat                                               | fail | ./mugen-riscv/logs/pcp/oe_test_pmstat/2023-09-22-05_33_56.log |      |
|                    | oe_test_pmlogger_merge_pmlogger_rewrite                      | fail | ./mugen-riscv/logs/pcp/oe_test_pmlogger_merge_pmlogger_rewrite/2023-09-22-06_29_26.log |      |
| geoclue2           | oe_test_service_geoclue                                      | fail | ./mugen-riscv/logs/geoclue2/oe_test_service_geoclue/2023-09-21-23_04_38.log |      |
| fio                | oe_test_fio_003                                              | fail | ./mugen-riscv/logs/fio/oe_test_fio_003/2023-09-21-23:49:12.log |      |
|                    | oe_test_fio_002                                              | fail | ./mugen-riscv/logs/fio/oe_test_fio_002/2023-09-21-23:18:45.log |      |
| javapackages-tools | oe_test_javapackages-local                                   | fail | ./mugen-riscv/logs/javapackages-tools/oe_test_javapackages-local/2023-09-21-22:44:47.log |      |
|                    | oe_test_build-classpath                                      | fail | ./mugen-riscv/logs/javapackages-tools/oe_test_build-classpath/2023-09-21-22:37:24.log |      |
|                    | oe_test_build-jar-repository                                 | fail | ./mugen-riscv/logs/javapackages-tools/oe_test_build-jar-repository/2023-09-21-22:39:13.log |      |
|                    | oe_test_binary_files_operation                               | fail | ./mugen-riscv/logs/javapackages-tools/oe_test_binary_files_operation/2023-09-21-22:35:12.log |      |
|                    | oe_test_find-shade-jar                                       | fail | ./mugen-riscv/logs/javapackages-tools/oe_test_find-shade-jar/2023-09-21-22:41:02.log |      |
|                    | oe_test_libreswan_ipsec_addconn                              | fail | ./mugen-riscv/logs/libreswan/oe_test_libreswan_ipsec_addconn/2023-09-22-04_45_37.log |      |
| libvirt            | oe_test_socket_virtsecretd-ro                                | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtsecretd-ro/2023-09-21-17:26:42.log |      |
|                    | oe_test_socket_virtinterfaced-admin                          | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtinterfaced-admin/2023-09-21-17:09:46.log |      |
|                    | oe_test_socket_virtstoraged                                  | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtstoraged/2023-09-21-17:29:25.log |      |
|                    | oe_test_socket_libvirtd-tcp                                  | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_libvirtd-tcp/2023-09-21-17:08:25.log |      |
|                    | oe_test_socket_virtproxyd-admin                              | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtproxyd-admin/2023-09-21-17:20:34.log |      |
|                    | oe_test_service_virtqemud                                    | fail | ./mugen-riscv/logs/libvirt/oe_test_service_virtqemud/2023-09-21-17:04:06.log |      |
|                    | oe_test_target_virt-guest-shutdown                           | fail | ./mugen-riscv/logs/libvirt/oe_test_target_virt-guest-shutdown/2023-09-21-17:30:05.log |      |
|                    | oe_test_service_virtnodedevd                                 | fail | ./mugen-riscv/logs/libvirt/oe_test_service_virtnodedevd/2023-09-21-17:01:49.log |      |
|                    | oe_test_socket_virtstoraged-admin                            | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtstoraged-admin/2023-09-21-17:28:04.log |      |
|                    | oe_test_socket_virtproxyd-tcp                                | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtproxyd-tcp/2023-09-21-17:22:37.log |      |
|                    | oe_test_socket_virtnodedevd-admin                            | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtnodedevd-admin/2023-09-21-17:16:29.log |      |
|                    | oe_test_socket_virtnodedevd-ro                               | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtnodedevd-ro/2023-09-21-17:17:10.log |      |
|                    | oe_test_service_virtnetworkd                                 | fail | ./mugen-riscv/logs/libvirt/oe_test_service_virtnetworkd/2023-09-21-17:01:03.log |      |
|                    | oe_test_socket_virtqemud                                     | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtqemud/2023-09-21-17:25:21.log |      |
|                    | oe_test_socket_virtnetworkd-ro                               | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtnetworkd-ro/2023-09-21-17:15:10.log |      |
|                    | oe_test_socket_virtnwfilterd-admin                           | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtnwfilterd-admin/2023-09-21-17:18:30.log |      |
|                    | oe_test_service_virtsecretd                                  | fail | ./mugen-riscv/logs/libvirt/oe_test_service_virtsecretd/2023-09-21-17:04:51.log |      |
|                    | oe_test_socket_virtproxyd-tls                                | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtproxyd-tls/2023-09-21-17:23:18.log |      |
|                    | oe_test_socket_virtnetworkd                                  | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtnetworkd/2023-09-21-17:15:49.log |      |
|                    | oe_test_socket_virtinterfaced                                | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtinterfaced/2023-09-21-17:11:06.log |      |
|                    | oe_test_service_virtlockd                                    | fail | ./mugen-riscv/logs/libvirt/oe_test_service_virtlockd/2023-09-21-16:59:32.log |      |
|                    | oe_test_socket_virtsecretd-admin                             | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtsecretd-admin/2023-09-21-17:26:02.log |      |
|                    | oe_test_socket_virtproxyd                                    | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtproxyd/2023-09-21-17:21:57.log |      |
|                    | oe_test_service_virtnwfilterd                                | fail | ./mugen-riscv/logs/libvirt/oe_test_service_virtnwfilterd/2023-09-21-17:02:36.log |      |
|                    | oe_test_service_virtlogd                                     | fail | ./mugen-riscv/logs/libvirt/oe_test_service_virtlogd/2023-09-21-17:00:18.log |      |
|                    | oe_test_socket_virtnodedevd                                  | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtnodedevd/2023-09-21-17:17:50.log |      |
|                    | oe_test_service_virtproxyd                                   | fail | ./mugen-riscv/logs/libvirt/oe_test_service_virtproxyd/2023-09-21-17:03:21.log |      |
|                    | oe_test_service_libvirt-guests                               | fail | ./mugen-riscv/logs/libvirt/oe_test_service_libvirt-guests/2023-09-21-16:58:07.log |      |
|                    | oe_test_socket_virtsecretd                                   | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtsecretd/2023-09-21-17:27:24.log |      |
|                    | oe_test_socket_libvirtd-admin                                | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_libvirtd-admin/2023-09-21-17:06:23.log |      |
|                    | oe_test_socket_virtproxyd-ro                                 | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtproxyd-ro/2023-09-21-17:21:16.log |      |
|                    | oe_test_socket_virtnetworkd-admin                            | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtnetworkd-admin/2023-09-21-17:14:30.log |      |
|                    | oe_test_socket_virtqemud-admin                               | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtqemud-admin/2023-09-21-17:23:59.log |      |
|                    | oe_test_socket_virtqemud-ro                                  | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtqemud-ro/2023-09-21-17:24:40.log |      |
|                    | oe_test_service_virtinterfaced                               | fail | ./mugen-riscv/logs/libvirt/oe_test_service_virtinterfaced/2023-09-21-16:58:47.log |      |
|                    | oe_test_socket_virtnwfilterd-ro                              | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtnwfilterd-ro/2023-09-21-17:19:11.log |      |
|                    | oe_test_socket_virtlogd-admin                                | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtlogd-admin/2023-09-21-17:13:09.log |      |
|                    | oe_test_socket_virtnwfilterd                                 | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtnwfilterd/2023-09-21-17:19:53.log |      |
|                    | oe_test_socket_virtlockd-admin                               | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtlockd-admin/2023-09-21-17:11:46.log |      |
|                    | oe_test_socket_virtinterfaced-ro                             | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtinterfaced-ro/2023-09-21-17:10:26.log |      |
|                    | oe_test_socket_virtstoraged-ro                               | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_virtstoraged-ro/2023-09-21-17:28:44.log |      |
|                    | oe_test_service_virtstoraged                                 | fail | ./mugen-riscv/logs/libvirt/oe_test_service_virtstoraged/2023-09-21-17:05:38.log |      |
|                    | oe_test_socket_libvirtd-tls                                  | fail | ./mugen-riscv/logs/libvirt/oe_test_socket_libvirtd-tls/2023-09-21-17:09:05.log |      |
| ypbind             | oe_test_service_ypbind                                       | fail | ./mugen-riscv/logs/ypbind/oe_test_service_ypbind/2023-09-22-03:09:31.log |      |
|                    | oe_test_amanda_amssl                                         | fail | ./mugen-riscv/logs/amanda/oe_test_amanda_amssl/2023-09-21-17:39:54.log |      |
|                    | oe_test_service_amanda-udp                                   | fail | ./mugen-riscv/logs/amanda/oe_test_service_amanda-udp/2023-09-21-17:40:22.log |      |
|                    | oe_test_amanda_aespipe                                       | fail | ./mugen-riscv/logs/amanda/oe_test_amanda_aespipe/2023-09-21-17:41:41.log |      |
|                    | oe_test_service_dbus                                         | fail | ./mugen-riscv/logs/dbus/oe_test_service_dbus/2023-09-21-19:12:47.log |      |
|                    | oe_test_asciidoc_a2x_02                                      | fail | ./mugen-riscv/logs/asciidoc/oe_test_asciidoc_a2x_02/2023-09-21-18:08:08.log |      |
|                    | oe_test_asciidoc_a2x_01                                      | fail | ./mugen-riscv/logs/asciidoc/oe_test_asciidoc_a2x_01/2023-09-21-18:06:55.log |      |
| ypserv             | oe_test_service_yppasswdd                                    | fail | ./mugen-riscv/logs/ypserv/oe_test_service_yppasswdd/2023-09-22-00:47:11.log |      |
|                    | oe_test_service_ypserv                                       | fail | ./mugen-riscv/logs/ypserv/oe_test_service_ypserv/2023-09-22-01:06:32.log |      |
|                    | oe_test_service_ypxfrd                                       | fail | ./mugen-riscv/logs/ypserv/oe_test_service_ypxfrd/2023-09-22-01:07:41.log |      |
| cups-filters       | oe_test_service_cups-browsed                                 | fail | ./mugen-riscv/logs/cups-filters/oe_test_service_cups-browsed/2023-09-22-01:37:38.log |      |
|                    | oe_test_service_ctdb                                         | fail | ./mugen-riscv/logs/samba/oe_test_service_ctdb/2023-09-21-23:04:50.log |      |
| freeradius         | oe_test_freeradius_freeradius-utils_rlm_ippool_toolAndSmbencrypt | fail | ./mugen-riscv/logs/freeradius/oe_test_freeradius_freeradius-utils_rlm_ippool_toolAndSmbencrypt/2023-09-21-20_32_21.log |      |
|                    | oe_test_freeradius_freeradius-utils_radsqlrelay              | fail | ./mugen-riscv/logs/freeradius/oe_test_freeradius_freeradius-utils_radsqlrelay/2023-09-21-19_58_25.log |      |
|                    | oe_test_freeradius_freeradius_radiusdAndRadmin               | fail | ./mugen-riscv/logs/freeradius/oe_test_freeradius_freeradius_radiusdAndRadmin/2023-09-21-19_13_14.log |      |
|                    | oe_test_freeradius_freeradius-utils_radclient                | fail | ./mugen-riscv/logs/freeradius/oe_test_freeradius_freeradius-utils_radclient/2023-09-21-19_13_47.log |      |
|                    | oe_test_freeradius_freeradius_radiusd                        | fail | ./mugen-riscv/logs/freeradius/oe_test_freeradius_freeradius_radiusd/2023-09-21-19_12_35.log |      |
|                    | oe_test_freeradius_freeradius-utils_rad_counter              | fail | ./mugen-riscv/logs/freeradius/oe_test_freeradius_freeradius-utils_rad_counter/2023-09-21-19_19_44.log |      |
| nfs-utils          | oe_test_service_nfs-lock                                     | fail | ./mugen-riscv/logs/nfs-utils/oe_test_service_nfs-lock/2023-09-21-17:25:02.log |      |
|                    | oe_test_service_rpc-statd                                    | fail | ./mugen-riscv/logs/nfs-utils/oe_test_service_rpc-statd/2023-09-21-17:30:37.log |      |
|                    | oe_test_service_nfs-idmap                                    | fail | ./mugen-riscv/logs/nfs-utils/oe_test_service_nfs-idmap/2023-09-21-17:24:23.log |      |
|                    | oe_test_service_nfs-server                                   | fail | ./mugen-riscv/logs/nfs-utils/oe_test_service_nfs-server/2023-09-21-17:27:03.log |      |
|                    | oe_test_service_nfs-mountd                                   | fail | ./mugen-riscv/logs/nfs-utils/oe_test_service_nfs-mountd/2023-09-21-17:25:46.log |      |
|                    | oe_test_service_nfs                                          | fail | ./mugen-riscv/logs/nfs-utils/oe_test_service_nfs/2023-09-21-17:28:00.log |      |
|                    | oe_test_service_nfs-idmapd                                   | fail | ./mugen-riscv/logs/nfs-utils/oe_test_service_nfs-idmapd/2023-09-21-17:23:45.log |      |
| squid              | oe_test_service_squid                                        | fail | ./mugen-riscv/logs/squid/oe_test_service_squid/2023-09-21-23_58_18.log |      |
|                    | oe_test_ipvs_SCEN_DR_08                                      | fail | ./mugen-riscv/logs/ipvsadm/oe_test_ipvs_SCEN_DR_08/2023-09-22-07_08_37.log |      |
| colord             | oe_test_service_colord                                       | fail | ./mugen-riscv/logs/colord/oe_test_service_colord/2023-09-21-23_03_20.log |      |
|                    | oe_test_storage_nfs_repeat_restart                           | fail | ./mugen-riscv/logs/os-storage/oe_test_storage_nfs_repeat_restart/2023-09-22-06_23_40.log |      |
|                    | oe_test_storage_nfs_rpcinfo                                  | fail | ./mugen-riscv/logs/os-storage/oe_test_storage_nfs_rpcinfo/2023-09-22-06_55_52.log |      |
|                    | oe_test_storage_nfs_RPC                                      | fail | ./mugen-riscv/logs/os-storage/oe_test_storage_nfs_RPC/2023-09-22-06_54_49.log |      |
|                    | oe_test_storage_nfs_showmount                                | fail | ./mugen-riscv/logs/os-storage/oe_test_storage_nfs_showmount/2023-09-22-06_47_11.log |      |
|                    | oe_test_storage_nfs_start_server                             | fail | ./mugen-riscv/logs/os-storage/oe_test_storage_nfs_start_server/2023-09-22-08_06_18.log |      |
|                    | oe_test_storage_nfs_modify_port                              | fail | ./mugen-riscv/logs/os-storage/oe_test_storage_nfs_modify_port/2023-09-22-06_46_01.log |      |
|                    | oe_test_service_kadmin                                       | fail | ./mugen-riscv/logs/krb5/oe_test_service_kadmin/2023-09-22-00_24_08.log |      |
|                    | oe_test_audit_monitor_security_event                         | fail | ./mugen-riscv/logs/audit/oe_test_audit_monitor_security_event/2023-09-22-00:48:54.log |      |
| usbmuxd            | oe_test_service_usbmuxd                                      | fail | ./mugen-riscv/logs/usbmuxd/oe_test_service_usbmuxd/2023-09-22-02:33:43.log |      |
| nspr               | oe_test_nspr_001                                             | fail | ./mugen-riscv/logs/nspr/oe_test_nspr_001/2023-09-21-19:29:07.log |      |
|                    | oe_test_nspr_002                                             | fail | ./mugen-riscv/logs/nspr/oe_test_nspr_002/2023-09-21-19:30:15.log |      |
| pesign             | oe_test_pesign_pesign-client_01                              | fail | ./mugen-riscv/logs/pesign/oe_test_pesign_pesign-client_01/2023-09-21-22:03:50.log |      |
|                    | oe_test_pesign_pesign-client_02                              | fail | ./mugen-riscv/logs/pesign/oe_test_pesign_pesign-client_02/2023-09-21-22:04:28.log |      |
|                    | oe_test_service_pesign                                       | fail | ./mugen-riscv/logs/pesign/oe_test_service_pesign/2023-09-21-21:59:07.log |      |
| postfix            | oe_test_service_postfix                                      | fail | ./mugen-riscv/logs/postfix/oe_test_service_postfix/2023-09-22-01:06:33.log |      |
|                    | oe_test_postfix_configuration                                | fail | ./mugen-riscv/logs/postfix/oe_test_postfix_configuration/2023-09-22-01:11:00.log |      |
|                    | oe_test_service_htcacheclean                                 | fail | ./mugen-riscv/logs/httpd/oe_test_service_htcacheclean/2023-09-21-18:27:22.log |      |
|                    | oe_test_service_httpd                                        | fail | ./mugen-riscv/logs/httpd/oe_test_service_httpd/2023-09-21-18:29:04.log |      |
|                    | oe_test_service_powertop                                     | fail | ./mugen-riscv/logs/powertop/oe_test_service_powertop/2023-09-21-19:34:36.log |      |
| authz              | oe_test_service_authz                                        | fail | ./mugen-riscv/logs/authz/oe_test_service_authz/2023-09-22-01:28:54.log |      |
|                    | oe_test_service_ovsdb-server                                 | fail | ./mugen-riscv/logs/openvswitch/oe_test_service_ovsdb-server/2023-09-21-20_38_20.log |      |
| python-blivet      | oe_test_service_blivet                                       | fail | ./mugen-riscv/logs/python-blivet/oe_test_service_blivet/2023-09-22-02:18:55.log |      |
| qperf              | oe_test_qperf_01                                             | fail | ./mugen-riscv/logs/qperf/oe_test_qperf_01/2023-09-22-04_46_10.log |      |
|                    | oe_test_service_multipathd                                   | fail | ./mugen-riscv/logs/multipath-tools/oe_test_service_multipathd/2023-09-22-05_15_44.log |      |
|                    | oe_test_socket_multipathd                                    | fail | ./mugen-riscv/logs/multipath-tools/oe_test_socket_multipathd/2023-09-22-05_17_38.log |      |
|                    | oe_test_nbd                                                  | fail | ./mugen-riscv/logs/kernel/oe_test_nbd/2023-09-21-20:34:21.log |      |
| hdparm             | oe_test_hdparm                                               | fail | ./mugen-riscv/logs/hdparm/oe_test_hdparm/2023-09-22-01:49:39.log |      |
| openscap           | oe_test_scanning_system                                      | fail | ./mugen-riscv/logs/openscap/oe_test_scanning_system/2023-09-21-22:54:41.log |      |
|                    | oe_test_openscap_01                                          | fail | ./mugen-riscv/logs/openscap/oe_test_openscap_01/2023-09-21-22:24:34.log |      |
|                    | oe_test_service_avahi-dnsconfd                               | fail | ./mugen-riscv/logs/avahi/oe_test_service_avahi-dnsconfd/2023-09-22-00:10:17.log |      |
| tang               | oe_test_socket_tangd                                         | fail | ./mugen-riscv/logs/tang/oe_test_socket_tangd/2023-09-22-04_31_20.log |      |
|                    | oe_test_service_tangd-update                                 | fail | ./mugen-riscv/logs/tang/oe_test_service_tangd-update/2023-09-22-04_30_53.log |      |
| lxcfs              | oe_test_service_lxcfs                                        | fail | ./mugen-riscv/logs/lxcfs/oe_test_service_lxcfs/2023-09-22-02:00:25.log |      |
| arpwatch           | oe_test_service_arpwatch                                     | fail | ./mugen-riscv/logs/arpwatch/oe_test_service_arpwatch/2023-09-22-01:26:33.log |      |
|                    | oe_test_service_cloud-config                                 | fail | ./mugen-riscv/logs/cloud-init/oe_test_service_cloud-config/2023-09-21-17:52:33.log |      |
|                    | oe_test_service_cloud-init                                   | fail | ./mugen-riscv/logs/cloud-init/oe_test_service_cloud-init/2023-09-21-17:55:09.log |      |
|                    | oe_test_service_rpc-rquotad                                  | fail | ./mugen-riscv/logs/quota/oe_test_service_rpc-rquotad/2023-09-22-01:11:59.log |      |
| perl-DBI           | oe_test_perl-DBI                                             | fail | ./mugen-riscv/logs/perl-DBI/oe_test_perl-DBI/2023-09-22-09:12:50.log |      |
|                    | oe_test_service_named-chroot                                 | fail | ./mugen-riscv/logs/bind/oe_test_service_named-chroot/2023-09-21-18:21:46.log |      |
|                    | oe_test_service_named-chroot-setup                           | fail | ./mugen-riscv/logs/bind/oe_test_service_named-chroot-setup/2023-09-21-18:20:12.log |      |
|                    | oe_test_service_named                                        | fail | ./mugen-riscv/logs/bind/oe_test_service_named/2023-09-21-18:23:47.log |      |
|                    | oe_test_ntp_01                                               | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_ntp_01/2023-09-22-00:06:30.log |      |
|                    | oe_test_nfs_03                                               | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_nfs_03/2023-09-21-23:59:14.log |      |
|                    | oe_test_httpd                                                | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_httpd/2023-09-21-21:03:41.log |      |
|                    | oe_test_aide_compare_database                                | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_aide_compare_database/2023-09-21-22:04:53.log |      |
|                    | oe_test_aide_config_cfgfile                                  | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_aide_config_cfgfile/2023-09-21-17:22:42.log |      |
|                    | oe_test_rollback                                             | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_rollback/2023-09-21-22:00:28.log |      |
|                    | oe_test_chroncy_001                                          | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_chroncy_001/2023-09-21-21:59:29.log |      |
|                    | oe_test_rpcbind                                              | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_rpcbind/2023-09-22-00:29:28.log |      |
|                    | oe_test_nfs                                                  | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_nfs/2023-09-21-21:15:25.log |      |
|                    | oe_test_aide_update_database                                 | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_aide_update_database/2023-09-21-22:35:01.log |      |
|                    | oe_test_ntp_02                                               | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_ntp_02/2023-09-22-00:07:36.log |      |
|                    | oe_test_curl_02                                              | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_curl_02/2023-09-21-23:12:09.log |      |
|                    | oe_test_tcpdump                                              | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_tcpdump/2023-09-21-17:03:33.log |      |
|                    | oe_test_python_urllib3_urlopen_01                            | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_python_urllib3_urlopen_01/2023-09-22-00:25:34.log |      |
|                    | oe_test_nfs_02                                               | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_nfs_02/2023-09-21-23:57:35.log |      |
|                    | oe_test_systemd_SCEN_09                                      | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_systemd_SCEN_09/2023-09-21-17:15:09.log |      |
|                    | oe_test_dhclient_01                                          | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_dhclient_01/2023-09-21-23:17:17.log |      |
|                    | oe_test_haproxy                                              | fail | ./mugen-riscv/logs/smoke-basic-os/oe_test_haproxy/2023-09-21-21:01:41.log |      |
|                    | oe_test_dnf_check_diffenert-packages                         | fail | ./mugen-riscv/logs/dnf/oe_test_dnf_check_diffenert-packages/2023-09-21-21:17:13.log |      |
|                    | oe_test_service_systemd-time-wait-sync                       | fail | ./mugen-riscv/logs/systemd/oe_test_service_systemd-time-wait-sync/2023-09-22-11_21_23.log |      |
|                    | oe_test_service_systemd-tmpfiles-clean                       | fail | ./mugen-riscv/logs/systemd/oe_test_service_systemd-tmpfiles-clean/2023-09-22-11_21_58.log |      |
|                    | oe_test_service_systemd-modules-load                         | fail | ./mugen-riscv/logs/systemd/oe_test_service_systemd-modules-load/2023-09-22-11_13_52.log |      |
| memcached          | oe_test_service_memcached                                    | fail | ./mugen-riscv/logs/memcached/oe_test_service_memcached/2023-09-21-18:48:02.log |      |
|                    | oe_test_service_sm-client                                    | fail | ./mugen-riscv/logs/sendmail/oe_test_service_sm-client/2023-09-22-04_31_46.log |      |
| clevis             | oe_test_tang_encrypt                                         | fail | ./mugen-riscv/logs/clevis/oe_test_tang_encrypt/2023-09-22-05_03_14.log |      |
|                    | oe_test_tang_nbde                                            | fail | ./mugen-riscv/logs/clevis/oe_test_tang_nbde/2023-09-22-05_04_51.log |      |
|                    | oe_test_firewalld_block_all_icmp                             | fail | ./mugen-riscv/logs/firewalld/oe_test_firewalld_block_all_icmp/2023-09-21-20:26:09.log |      |
|                    | oe_test_firewalld_default_rules                              | fail | ./mugen-riscv/logs/firewalld/oe_test_firewalld_default_rules/2023-09-21-21:15:41.log |      |
|                    | oe_test_libnetfilter_conntrack                               | fail | ./mugen-riscv/logs/NetworkManager/oe_test_libnetfilter_conntrack/2023-09-21-20_57_01.log |      |





下为mugen更新的新测试用例中的失败的测试用例

| 测试套/软件包名 | 测试用例名                  | 状态    | 日志文件                                                     | 原因 |
| --------------- | --------------------------- | ------- | ------------------------------------------------------------ | ---- |
| nss-pam-ldapd   | oe_test_service_nslcd       | newfail | ./mugen-riscv/logs/nss-pam-ldapd/oe_test_service_nslcd/2023-09-22-02:05:00.log |      |
|                 | oe_test_dbus_dbus-tools_002 | newfail | ./mugen-riscv/logs/dbus/oe_test_dbus_dbus-tools_002/2023-09-21-19:15:11.log |      |
|                 | oe_test_dbus_dbus-daemon    | newfail | ./mugen-riscv/logs/dbus/oe_test_dbus_dbus-daemon/2023-09-21-19:13:56.log |      |
| ipvsadm         | oe_test_ipvs_SCEN_TUN_07    | newfail | ./mugen-riscv/logs/ipvsadm/oe_test_ipvs_SCEN_TUN_07/2023-09-22-08_32_33.log |      |
|                 | oe_test_ipvs_SCEN_TUN_04    | newfail | ./mugen-riscv/logs/ipvsadm/oe_test_ipvs_SCEN_TUN_04/2023-09-22-07_56_01.log |      |
|                 | oe_test_ipvs_SCEN_TUN_08    | newfail | ./mugen-riscv/logs/ipvsadm/oe_test_ipvs_SCEN_TUN_08/2023-09-22-08_45_20.log |      |
|                 | oe_test_ipvs_SCEN_TUN_06    | newfail | ./mugen-riscv/logs/ipvsadm/oe_test_ipvs_SCEN_TUN_06/2023-09-22-08_20_15.log |      |
|                 | oe_test_ipvs_SCEN_TUN_02    | newfail | ./mugen-riscv/logs/ipvsadm/oe_test_ipvs_SCEN_TUN_02/2023-09-22-07_32_51.log |      |
|                 | oe_test_ipvs_SCEN_TUN_01    | newfail | ./mugen-riscv/logs/ipvsadm/oe_test_ipvs_SCEN_TUN_01/2023-09-22-07_18_40.log |      |
|                 | oe_test_ipvs_SCEN_TUN_03    | newfail | ./mugen-riscv/logs/ipvsadm/oe_test_ipvs_SCEN_TUN_03/2023-09-22-07_43_40.log |      |
|                 | oe_test_ipvs_SCEN_TUN_05    | newfail | ./mugen-riscv/logs/ipvsadm/oe_test_ipvs_SCEN_TUN_05/2023-09-22-08_07_34.log |      |
|                 | oe_test_tcm_loop            | newfail | ./mugen-riscv/logs/kernel/oe_test_tcm_loop/2023-09-21-20:36:05.log |      |