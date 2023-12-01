# 2309测试结果

OpenEuler2309 RV共测试了223个测试套，1042个测试用例

OpenEuler2303 RV共测试了214个测试套，1151个测试用例

OpenEuler 2309 x86共对比测试了119个测试套，719个测试用例

其中

- 139个测试用例在2309RV上失败，在2309x86上成功
- 59个测试用例在2309RV上失败，在2309x86和2303RV上成功

## 在2309RV上失败，在2309x86和2303RV上成功测试用例

| 测试套/软件包名           | 测试用例名                               | 状态 | 日志文件                                                     | 原因 |
| ------------------------- | ---------------------------------------- | ---- | ------------------------------------------------------------ | ---- |
| fetch-crl                 | oe_test_clean-crl                        | fail | ./mugen-riscv/logs/fetch-crl/oe_test_clean-crl/2023-11-24-16:19:49.log | None |
|                           | oe_test_fetch_crl_02                     | fail | ./mugen-riscv/logs/fetch-crl/oe_test_fetch_crl_02/2023-11-24-16:31:25.log | None |
|                           | oe_test_fetch_crl_03                     | fail | ./mugen-riscv/logs/fetch-crl/oe_test_fetch_crl_03/2023-11-24-16:35:16.log | None |
|                           | oe_test_fetch_crl_01                     | fail | ./mugen-riscv/logs/fetch-crl/oe_test_fetch_crl_01/2023-11-24-16:27:24.log | None |
| libvma                    | oe_test_service_vma                      | fail | ./mugen-riscv/logs/libvma/oe_test_service_vma/2023-11-25-14:43:19.log | None |
| smoke-baseinfo            | oe_test_baseinfo                         | fail | ./mugen-riscv/logs/smoke-baseinfo/oe_test_baseinfo/2023-11-23-13:34:30.log | None |
| smoke-baseinfo            | oe_test_baseinfo                         | fail | ./mugen-riscv/logs/smoke-baseinfo/oe_test_baseinfo/2023-11-23-13:34:30.log | None |
|                           | oe_test_cockpit                          | fail | ./mugen-riscv/logs/smoke-baseinfo/oe_test_cockpit/2023-11-23-14:37:48.log | None |
| easymock                  | oe_test_easymock_junit5                  | fail | ./mugen-riscv/logs/easymock/oe_test_easymock_junit5/2023-11-23-11:49:11.log | None |
|                           | oe_test_easymock_junit4                  | fail | ./mugen-riscv/logs/easymock/oe_test_easymock_junit4/2023-11-23-10:54:49.log | None |
| ltp                       | oe_test_baseinfo                         | fail | ./mugen-riscv/logs/AT/oe_test_baseinfo/2023-11-26-01:12:52.log | None |
|                           | oe_test_baseinfo                         | fail | ./mugen-riscv/logs/AT/oe_test_baseinfo/2023-11-26-01:12:52.log | None |
| docbook5-schemas          | oe_test_docbook5_schemas                 | fail | ./mugen-riscv/logs/docbook5-schemas/oe_test_docbook5_schemas/2023-11-25-12:10:47.log | None |
| eventlet                  | oe_test_eventlet                         | fail | ./mugen-riscv/logs/eventlet/oe_test_eventlet/2023-11-26-00:22:47.log | None |
| rubygem-fluentd_1.3.3     | oe_test_fluent_cat_01                    | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_cat_01/2023-11-23-03:00:20.log |      |
|                           | oe_test_fluent_plugin_config_format_2003 | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_plugin_config_format_2003/2023-11-23-04:39:05.log | None |
|                           | oe_test_fluent_plugin_generate           | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_plugin_generate/2023-11-23-04:48:05.log | None |
|                           | oe_test_fluent_plugin_generate           | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_plugin_generate/2023-11-23-04:48:05.log | None |
|                           | oe_test_fluent_plugin_generate           | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_plugin_generate/2023-11-23-04:48:05.log | None |
|                           | oe_test_fluent_plugin_generate           | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_plugin_generate/2023-11-23-04:48:05.log | None |
|                           | oe_test_fluent_ca_generate               | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_ca_generate/2023-11-23-02:51:42.log | None |
|                           | oe_test_fluent_ca_generate               | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_ca_generate/2023-11-23-02:51:42.log | None |
|                           | oe_test_fluent_ca_generate               | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_ca_generate/2023-11-23-02:51:42.log | None |
|                           | oe_test_fluent_ca_generate               | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_ca_generate/2023-11-23-02:51:42.log | None |
|                           | oe_test_fluent_binlog_reader             | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_binlog_reader/2023-11-23-02:42:58.log | None |
|                           | oe_test_fluent_binlog_reader             | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_binlog_reader/2023-11-23-02:42:58.log | None |
|                           | oe_test_fluent_binlog_reader             | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_binlog_reader/2023-11-23-02:42:58.log | None |
|                           | oe_test_fluent_binlog_reader             | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_binlog_reader/2023-11-23-02:42:58.log | None |
| rsyslog                   | oe_test_rsyslog_function_postgreSQL      | fail | ./mugen-riscv/logs/rsyslog/oe_test_rsyslog_function_postgreSQL/2023-11-22-12:32:52.log | None |
| rinetd                    | oe_test_service_rinetd                   | fail | ./mugen-riscv/logs/rinetd/oe_test_service_rinetd/2023-11-25-18:45:13.log | None |
| rubygem-fluentd_1.14.5    | oe_test_fluent_gem_03                    | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_gem_03/2023-11-22-16:23:21.log | None |
|                           | oe_test_fluent_cat_01                    | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_cat_01/2023-11-22-14:55:07.log |      |
|                           | oe_test_fluent_gem_01                    | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_gem_01/2023-11-22-16:07:58.log | None |
|                           | oe_test_fluent_plugin_generate           | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_plugin_generate/2023-11-22-16:44:21.log | None |
|                           | oe_test_fluent_plugin_generate           | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_plugin_generate/2023-11-22-16:44:21.log | None |
|                           | oe_test_fluent_plugin_generate           | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_plugin_generate/2023-11-22-16:44:21.log | None |
|                           | oe_test_fluent_plugin_generate           | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_plugin_generate/2023-11-22-16:44:21.log | None |
|                           | oe_test_fluent_ca_generate               | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_ca_generate/2023-11-22-14:48:43.log | None |
|                           | oe_test_fluent_ca_generate               | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_ca_generate/2023-11-22-14:48:43.log | None |
|                           | oe_test_fluent_ca_generate               | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_ca_generate/2023-11-22-14:48:43.log | None |
|                           | oe_test_fluent_ca_generate               | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_ca_generate/2023-11-22-14:48:43.log | None |
|                           | oe_test_fluent_gem_04                    | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_gem_04/2023-11-22-16:30:22.log | None |
|                           | oe_test_fluent_plugin_config_format      | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_plugin_config_format/2023-11-22-16:37:19.log | None |
|                           | oe_test_fluent_binlog_reader             | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_binlog_reader/2023-11-22-14:42:25.log | None |
|                           | oe_test_fluent_binlog_reader             | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_binlog_reader/2023-11-22-14:42:25.log | None |
|                           | oe_test_fluent_binlog_reader             | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_binlog_reader/2023-11-22-14:42:25.log | None |
|                           | oe_test_fluent_binlog_reader             | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_binlog_reader/2023-11-22-14:42:25.log | None |
| compile-test              | oe_test_compile                          | fail | ./mugen-riscv/logs/compile-test/oe_test_compile/2023-11-25-21:03:33.log | None |
| junit4                    | oe_test_junit4_maven                     | fail | ./mugen-riscv/logs/junit4/oe_test_junit4_maven/2023-11-23-06:37:17.log | None |
| xmvn_3.0.0-24             | oe_test_xmvn_base_mvn-local_08           | fail | ./mugen-riscv/logs/xmvn_3.0.0-24/oe_test_xmvn_base_mvn-local_08/2023-11-23-20:02:37.log | None |
|                           | oe_test_xmvn_base_mvn-local_04           | fail | ./mugen-riscv/logs/xmvn_3.0.0-24/oe_test_xmvn_base_mvn-local_04/2023-11-23-17:53:47.log | None |
| mosquitto                 | oe_test_service_mosquitto                | fail | ./mugen-riscv/logs/mosquitto/oe_test_service_mosquitto/2023-11-25-15:17:21.log | None |
| greatsql                  | oe_test_service_greatsql-mysql-router    | fail | ./mugen-riscv/logs/greatsql/oe_test_service_greatsql-mysql-router/2023-11-25-21:36:42.log | None |
| virtualization_user_guide | oe_test_manual_libcareplus_hot_patch     | fail | ./mugen-riscv/logs/virtualization_user_guide/oe_test_manual_libcareplus_hot_patch/2023-11-25-07:49:17.log | None |
|                           | oe_test_libcareplus_hot_patch_by_script  | fail | ./mugen-riscv/logs/virtualization_user_guide/oe_test_libcareplus_hot_patch_by_script/2023-11-25-07:56:43.log | None |
| netsniff-ng               | oe_test_bpfc                             | fail | ./mugen-riscv/logs/netsniff-ng/oe_test_bpfc/2023-11-22-13:29:03.log | None |
|                           | oe_test_flowtop_01                       | fail | ./mugen-riscv/logs/netsniff-ng/oe_test_flowtop_01/2023-11-22-13:40:10.log | None |
|                           | oe_test_curvetun_common                  | fail | ./mugen-riscv/logs/netsniff-ng/oe_test_curvetun_common/2023-11-22-13:34:52.log | None |
|                           | oe_test_trafgen_03                       | fail | ./mugen-riscv/logs/netsniff-ng/oe_test_trafgen_03/2023-11-22-14:23:07.log | None |



## 在2309RV上失败，在2309x86上成功测试用例

| 测试套/软件包名           | 测试用例名                                      | 状态 | 日志文件                                                     | 原因 |
| ------------------------- | ----------------------------------------------- | ---- | ------------------------------------------------------------ | ---- |
| fetch-crl                 | oe_test_clean-crl                               | fail | ./mugen-riscv/logs/fetch-crl/oe_test_clean-crl/2023-11-24-16:19:49.log | None |
|                           | oe_test_fetch_crl_02                            | fail | ./mugen-riscv/logs/fetch-crl/oe_test_fetch_crl_02/2023-11-24-16:31:25.log | None |
|                           | oe_test_fetch_crl_service                       | fail | ./mugen-riscv/logs/fetch-crl/oe_test_fetch_crl_service/2023-11-24-16:23:51.log |      |
|                           | oe_test_fetch_crl_03                            | fail | ./mugen-riscv/logs/fetch-crl/oe_test_fetch_crl_03/2023-11-24-16:35:16.log | None |
|                           | oe_test_fetch_crl_01                            | fail | ./mugen-riscv/logs/fetch-crl/oe_test_fetch_crl_01/2023-11-24-16:27:24.log | None |
| redis                     | oe_test_redis_01                                | fail | ./mugen-riscv/logs/redis/oe_test_redis_01/2023-11-25-05:13:35.log |      |
| libvma                    | oe_test_service_vma                             | fail | ./mugen-riscv/logs/libvma/oe_test_service_vma/2023-11-25-14:43:19.log | None |
| smoke-baseinfo            | oe_test_baseinfo                                | fail | ./mugen-riscv/logs/smoke-baseinfo/oe_test_baseinfo/2023-11-23-13:34:30.log | None |
| smoke-baseinfo            | oe_test_baseinfo                                | fail | ./mugen-riscv/logs/smoke-baseinfo/oe_test_baseinfo/2023-11-23-13:34:30.log | None |
|                           | oe_test_cockpit                                 | fail | ./mugen-riscv/logs/smoke-baseinfo/oe_test_cockpit/2023-11-23-14:37:48.log | None |
| java-11-openjdk           | oe_test_openjdk11_jjs_jmap                      | fail | ./mugen-riscv/logs/java-11-openjdk/oe_test_openjdk11_jjs_jmap/2023-11-23-12:59:39.log |      |
| wrk                       | oe_test_wrk                                     | fail | ./mugen-riscv/logs/wrk/oe_test_wrk/2023-11-25-20:10:37.log   |      |
| easymock                  | oe_test_easymock_junit5                         | fail | ./mugen-riscv/logs/easymock/oe_test_easymock_junit5/2023-11-23-11:49:11.log | None |
|                           | oe_test_easymock_junit4                         | fail | ./mugen-riscv/logs/easymock/oe_test_easymock_junit4/2023-11-23-10:54:49.log | None |
| ltp                       | oe_test_posix                                   | fail | ./mugen-riscv/logs/ltp/oe_test_posix/2023-11-25-16:34:54.log |      |
|                           | oe_test_grub2_mkconfig                          | fail | ./mugen-riscv/logs/AT/oe_test_grub2_mkconfig/2023-11-26-07:49:47.log |      |
|                           | oe_test_baseinfo                                | fail | ./mugen-riscv/logs/AT/oe_test_baseinfo/2023-11-26-01:12:52.log | None |
|                           | oe_test_baseinfo                                | fail | ./mugen-riscv/logs/AT/oe_test_baseinfo/2023-11-26-01:12:52.log | None |
|                           | oe_test_systemd_SCEN_10                         | fail | ./mugen-riscv/logs/AT/oe_test_systemd_SCEN_10/2023-11-26-12:22:08.log |      |
|                           | oe_test_rsyslog_04                              | fail | ./mugen-riscv/logs/AT/oe_test_rsyslog_04/2023-11-26-10:40:00.log |      |
|                           | oe_test_MEMinfo_001                             | fail | ./mugen-riscv/logs/AT/oe_test_MEMinfo_001/2023-11-26-03:41:12.log |      |
|                           | oe_test_OVS                                     | fail | ./mugen-riscv/logs/AT/oe_test_OVS/2023-11-26-00:39:38.log    |      |
|                           | oe_test_skopeo                                  | fail | ./mugen-riscv/logs/AT/oe_test_skopeo/2023-11-26-04:13:13.log |      |
|                           | oe_test_aide_init_database                      | fail | ./mugen-riscv/logs/AT/oe_test_aide_init_database/2023-11-26-13:17:54.log |      |
|                           | oe_test_aide_update_database                    | fail | ./mugen-riscv/logs/AT/oe_test_aide_update_database/2023-11-26-05:50:12.log |      |
|                           | oe_test_perf_top_01                             | fail | ./mugen-riscv/logs/AT/oe_test_perf_top_01/2023-11-26-13:58:50.log |      |
|                           | oe_test_yumgroup_001                            | fail | ./mugen-riscv/logs/AT/oe_test_yumgroup_001/2023-11-26-04:46:47.log |      |
|                           | oe_test_criu                                    | fail | ./mugen-riscv/logs/AT/oe_test_criu/2023-11-26-02:35:39.log   |      |
| clamav                    | oe_test_clamav_clamscan_3                       | fail | ./mugen-riscv/logs/clamav/oe_test_clamav_clamscan_3/2023-11-22-18:14:08.log |      |
|                           | oe_test_clamav_clamscan_2                       | fail | ./mugen-riscv/logs/clamav/oe_test_clamav_clamscan_2/2023-11-22-17:41:28.log |      |
|                           | oe_test_service_clamav-clamonacc                | fail | ./mugen-riscv/logs/clamav/oe_test_service_clamav-clamonacc/2023-11-22-15:05:54.log |      |
|                           | oe_test_clamav_clamscan_1                       | fail | ./mugen-riscv/logs/clamav/oe_test_clamav_clamscan_1/2023-11-22-17:07:32.log |      |
| docbook5-schemas          | oe_test_docbook5_schemas                        | fail | ./mugen-riscv/logs/docbook5-schemas/oe_test_docbook5_schemas/2023-11-25-12:10:47.log | None |
| eventlet                  | oe_test_eventlet                                | fail | ./mugen-riscv/logs/eventlet/oe_test_eventlet/2023-11-26-00:22:47.log | None |
| jgit                      | oe_test_jgit_01                                 | fail | ./mugen-riscv/logs/jgit/oe_test_jgit_01/2023-11-25-06:28:49.log |      |
|                           | oe_test_jgit_02                                 | fail | ./mugen-riscv/logs/jgit/oe_test_jgit_02/2023-11-25-06:32:51.log |      |
|                           | oe_test_jgit_03                                 | fail | ./mugen-riscv/logs/jgit/oe_test_jgit_03/2023-11-25-06:36:23.log |      |
| rubygem-fluentd_1.3.3     | oe_test_fluentd_02                              | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluentd_02/2023-11-23-03:30:17.log |      |
| rubygem-fluentd_1.3.3     | oe_test_fluentd_02                              | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluentd_02/2023-11-23-03:30:17.log |      |
|                           | oe_test_fluent_cat_01                           | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_cat_01/2023-11-23-03:00:20.log |      |
|                           | oe_test_fluent_debug                            | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_debug/2023-11-23-04:00:55.log |      |
|                           | oe_test_fluent_debug                            | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_debug/2023-11-23-04:00:55.log |      |
|                           | oe_test_fluent_plugin_config_format_2003        | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_plugin_config_format_2003/2023-11-23-04:39:05.log | None |
|                           | oe_test_fluent_plugin_generate                  | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_plugin_generate/2023-11-23-04:48:05.log | None |
|                           | oe_test_fluent_plugin_generate                  | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_plugin_generate/2023-11-23-04:48:05.log | None |
|                           | oe_test_fluent_ca_generate                      | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_ca_generate/2023-11-23-02:51:42.log | None |
|                           | oe_test_fluent_ca_generate                      | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_ca_generate/2023-11-23-02:51:42.log | None |
|                           | oe_test_fluent_cat_02_2003                      | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_cat_02_2003/2023-11-23-03:10:30.log |      |
|                           | oe_test_fluent_binlog_reader                    | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_binlog_reader/2023-11-23-02:42:58.log | None |
|                           | oe_test_fluent_binlog_reader                    | fail | ./mugen-riscv/logs/rubygem-fluentd_1.3.3/oe_test_fluent_binlog_reader/2023-11-23-02:42:58.log | None |
| rsyslog                   | oe_test_rsyslog_function_postgreSQL             | fail | ./mugen-riscv/logs/rsyslog/oe_test_rsyslog_function_postgreSQL/2023-11-22-12:32:52.log | None |
| ladspa                    | oe_test_ladspa_applyplugin                      | fail | ./mugen-riscv/logs/ladspa/oe_test_ladspa_applyplugin/2023-11-25-08:46:58.log |      |
|                           | oe_test_ladspa_analyseplugin                    | fail | ./mugen-riscv/logs/ladspa/oe_test_ladspa_analyseplugin/2023-11-25-08:43:18.log |      |
| hdparm                    | oe_test_hdparm                                  | fail | ./mugen-riscv/logs/hdparm/oe_test_hdparm/2023-11-25-13:23:31.log |      |
| rinetd                    | oe_test_service_rinetd                          | fail | ./mugen-riscv/logs/rinetd/oe_test_service_rinetd/2023-11-25-18:45:13.log | None |
| OpenIPMI                  | oe_test_service_ipmi                            | fail | ./mugen-riscv/logs/OpenIPMI/oe_test_service_ipmi/2023-11-25-10:02:54.log |      |
| rubygem-fluentd_1.14.5    | oe_test_fluentd_02                              | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluentd_02/2023-11-22-15:33:14.log |      |
| rubygem-fluentd_1.14.5    | oe_test_fluentd_02                              | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluentd_02/2023-11-22-15:33:14.log |      |
|                           | oe_test_fluent_gem_03                           | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_gem_03/2023-11-22-16:23:21.log | None |
|                           | oe_test_fluent_cat_01                           | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_cat_01/2023-11-22-14:55:07.log |      |
|                           | oe_test_fluent_debug                            | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_debug/2023-11-22-16:00:09.log |      |
|                           | oe_test_fluent_debug                            | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_debug/2023-11-22-16:00:09.log |      |
|                           | oe_test_fluent_gem_01                           | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_gem_01/2023-11-22-16:07:58.log | None |
|                           | oe_test_fluent_plugin_generate                  | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_plugin_generate/2023-11-22-16:44:21.log | None |
|                           | oe_test_fluent_plugin_generate                  | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_plugin_generate/2023-11-22-16:44:21.log | None |
|                           | oe_test_fluent_ca_generate                      | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_ca_generate/2023-11-22-14:48:43.log | None |
|                           | oe_test_fluent_ca_generate                      | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_ca_generate/2023-11-22-14:48:43.log | None |
|                           | oe_test_fluent_gem_04                           | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_gem_04/2023-11-22-16:30:22.log | None |
|                           | oe_test_fluent_cap_ctl                          | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_cap_ctl/2023-11-22-15:19:45.log |      |
|                           | oe_test_fluent_plugin_config_format             | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_plugin_config_format/2023-11-22-16:37:19.log | None |
|                           | oe_test_fluent_binlog_reader                    | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_binlog_reader/2023-11-22-14:42:25.log | None |
|                           | oe_test_fluent_binlog_reader                    | fail | ./mugen-riscv/logs/rubygem-fluentd_1.14.5/oe_test_fluent_binlog_reader/2023-11-22-14:42:25.log | None |
| dde-daemon                | oe_test_service_dbus-com.deepin.dde.lockservice | fail | ./mugen-riscv/logs/dde-daemon/oe_test_service_dbus-com.deepin.dde.lockservice/2023-11-25-21:18:17.log |      |
| containerd                | oe_test_containerd                              | fail | ./mugen-riscv/logs/containerd/oe_test_containerd/2023-11-25-11:00:13.log |      |
| compile-test              | oe_test_compile                                 | fail | ./mugen-riscv/logs/compile-test/oe_test_compile/2023-11-25-21:03:33.log | None |
| ipmitool                  | oe_test_service_exchange-bmc-os-info            | fail | ./mugen-riscv/logs/ipmitool/oe_test_service_exchange-bmc-os-info/2023-11-25-05:57:43.log |      |
|                           | oe_test_service_ipmitool                        | fail | ./mugen-riscv/logs/ipmitool/oe_test_service_ipmitool/2023-11-25-06:07:22.log |      |
|                           | oe_test_service_ipmievd                         | fail | ./mugen-riscv/logs/ipmitool/oe_test_service_ipmievd/2023-11-25-06:02:29.log |      |
|                           | oe_test_service_bmc-snmp-proxy                  | fail | ./mugen-riscv/logs/ipmitool/oe_test_service_bmc-snmp-proxy/2023-11-25-05:52:56.log |      |
| junit4                    | oe_test_junit4_maven                            | fail | ./mugen-riscv/logs/junit4/oe_test_junit4_maven/2023-11-23-06:37:17.log | None |
|                           | oe_test_junit4_performances                     | fail | ./mugen-riscv/logs/junit4/oe_test_junit4_performances/2023-11-23-07:14:25.log |      |
| nvml                      | oe_test_nvml_rpmemd                             | fail | ./mugen-riscv/logs/nvml/oe_test_nvml_rpmemd/2023-11-25-06:52:35.log |      |
|                           | oe_test_nvml_pmempool                           | fail | ./mugen-riscv/logs/nvml/oe_test_nvml_pmempool/2023-11-25-06:49:12.log |      |
|                           | oe_test_nvml_daxio                              | fail | ./mugen-riscv/logs/nvml/oe_test_nvml_daxio/2023-11-25-06:46:04.log |      |
| tboot_1.9.12-2            | oe_test_tboot_lcp2_crtpolelt                    | fail | ./mugen-riscv/logs/tboot_1.9.12-2/oe_test_tboot_lcp2_crtpolelt/2023-11-24-02:51:35.log |      |
|                           | oe_test_tboot_1.9.12-2_lcp2_mlehash             | fail | ./mugen-riscv/logs/tboot_1.9.12-2/oe_test_tboot_1.9.12-2_lcp2_mlehash/2023-11-24-02:48:21.log |      |
|                           | oe_test_tboot_txt-stat                          | fail | ./mugen-riscv/logs/tboot_1.9.12-2/oe_test_tboot_txt-stat/2023-11-24-02:58:57.log |      |
|                           | oe_test_tboot_1.9.12-2_lcp2_crtpol              | fail | ./mugen-riscv/logs/tboot_1.9.12-2/oe_test_tboot_1.9.12-2_lcp2_crtpol/2023-11-24-02:41:47.log |      |
|                           | oe_test_tboot_tb_polgen                         | fail | ./mugen-riscv/logs/tboot_1.9.12-2/oe_test_tboot_tb_polgen/2023-11-24-02:55:12.log |      |
| strongswan                | oe_test_service_swanctl_01                      | fail | ./mugen-riscv/logs/strongswan/oe_test_service_swanctl_01/2023-11-23-13:56:44.log |      |
| fapolicyd                 | oe_test_fapolicyd-bugfix                        | fail | ./mugen-riscv/logs/fapolicyd/oe_test_fapolicyd-bugfix/2023-11-25-09:06:11.log |      |
|                           | oe_test_fapolicyd-service                       | fail | ./mugen-riscv/logs/fapolicyd/oe_test_fapolicyd-service/2023-11-25-09:02:54.log |      |
| libwmf                    | oe_test_libwmf_wmf2x_02                         | fail | ./mugen-riscv/logs/libwmf/oe_test_libwmf_wmf2x_02/2023-11-23-06:33:07.log |      |
| mod-wsgi                  | oe_test_mod-wsgi                                | fail | ./mugen-riscv/logs/mod-wsgi/oe_test_mod-wsgi/2023-11-25-21:55:53.log |      |
| OpenEXR                   | oe_test_OpenEXR_exrenvmap                       | fail | ./mugen-riscv/logs/OpenEXR/oe_test_OpenEXR_exrenvmap/2023-11-24-00:38:52.log |      |
| blueman                   | oe_test_service_blueman-mechanism               | fail | ./mugen-riscv/logs/blueman/oe_test_service_blueman-mechanism/2023-11-25-20:57:02.log |      |
| xmvn_3.0.0-24             | oe_test_xmvn_base_mvn-local_06                  | fail | ./mugen-riscv/logs/xmvn_3.0.0-24/oe_test_xmvn_base_mvn-local_06/2023-11-23-18:58:06.log |      |
|                           | oe_test_xmvn_base_mvn-local_08                  | fail | ./mugen-riscv/logs/xmvn_3.0.0-24/oe_test_xmvn_base_mvn-local_08/2023-11-23-20:02:37.log | None |
|                           | oe_test_xmvn_base_mvn-local_01                  | fail | ./mugen-riscv/logs/xmvn_3.0.0-24/oe_test_xmvn_base_mvn-local_01/2023-11-23-15:59:24.log |      |
|                           | oe_test_xmvn_base_mvn-local_04                  | fail | ./mugen-riscv/logs/xmvn_3.0.0-24/oe_test_xmvn_base_mvn-local_04/2023-11-23-17:53:47.log | None |
|                           | oe_test_xmvn_base_mvn-local_07                  | fail | ./mugen-riscv/logs/xmvn_3.0.0-24/oe_test_xmvn_base_mvn-local_07/2023-11-23-19:30:30.log |      |
|                           | oe_test_xmvn_base_mvn-local_02                  | fail | ./mugen-riscv/logs/xmvn_3.0.0-24/oe_test_xmvn_base_mvn-local_02/2023-11-23-16:31:47.log |      |
|                           | oe_test_xmvn_base_mvn-local_05                  | fail | ./mugen-riscv/logs/xmvn_3.0.0-24/oe_test_xmvn_base_mvn-local_05/2023-11-23-18:25:57.log |      |
|                           | oe_test_xmvn_base_mvn-local_03                  | fail | ./mugen-riscv/logs/xmvn_3.0.0-24/oe_test_xmvn_base_mvn-local_03/2023-11-23-17:04:19.log |      |
| mosquitto                 | oe_test_service_mosquitto                       | fail | ./mugen-riscv/logs/mosquitto/oe_test_service_mosquitto/2023-11-25-15:17:21.log | None |
| baws-sdk-java             | oe_test_baws-sdk-java_001                       | fail | ./mugen-riscv/logs/baws-sdk-java/oe_test_baws-sdk-java_001/2023-11-25-10:32:31.log |      |
| python-kazoo              | oe_test_python-kazoo                            | fail | ./mugen-riscv/logs/python-kazoo/oe_test_python-kazoo/2023-11-25-23:47:23.log |      |
| apache-commons-daemon     | oe_test_jsvc_base                               | fail | ./mugen-riscv/logs/apache-commons-daemon/oe_test_jsvc_base/2023-11-25-10:10:47.log |      |
| greatsql                  | oe_test_service_greatsql-mysql-router           | fail | ./mugen-riscv/logs/greatsql/oe_test_service_greatsql-mysql-router/2023-11-25-21:36:42.log | None |
| activemq                  | oe_test_activemq_fun_01                         | fail | ./mugen-riscv/logs/activemq/oe_test_activemq_fun_01/2023-11-25-23:26:58.log |      |
| virtualization_user_guide | oe_test_manual_libcareplus_hot_patch            | fail | ./mugen-riscv/logs/virtualization_user_guide/oe_test_manual_libcareplus_hot_patch/2023-11-25-07:49:17.log | None |
|                           | oe_test_libcareplus_hot_patch_by_script         | fail | ./mugen-riscv/logs/virtualization_user_guide/oe_test_libcareplus_hot_patch_by_script/2023-11-25-07:56:43.log | None |
| tomcat                    | oe_test_service_tomcat-jsvc                     | fail | ./mugen-riscv/logs/tomcat/oe_test_service_tomcat-jsvc/2023-11-25-07:18:57.log |      |
| pywbem_0.12.4             | oe_test_pywbem_base_mof_compiler_01             | fail | ./mugen-riscv/logs/pywbem_0.12.4/oe_test_pywbem_base_mof_compiler_01/2023-11-24-19:05:32.log |      |
| pywbem_0.12.4             | oe_test_pywbem_base_mof_compiler_01             | fail | ./mugen-riscv/logs/pywbem_0.12.4/oe_test_pywbem_base_mof_compiler_01/2023-11-24-19:05:32.log |      |
|                           | oe_test_pywbem_base_mof_compiler_02             | fail | ./mugen-riscv/logs/pywbem_0.12.4/oe_test_pywbem_base_mof_compiler_02/2023-11-24-19:14:42.log |      |
|                           | oe_test_pywbem_base_mof_compiler_02             | fail | ./mugen-riscv/logs/pywbem_0.12.4/oe_test_pywbem_base_mof_compiler_02/2023-11-24-19:14:42.log |      |
| hbase                     | oe_test_service_hbase-regionserver              | fail | ./mugen-riscv/logs/hbase/oe_test_service_hbase-regionserver/2023-11-24-16:46:57.log |      |
|                           | oe_test_service_hbase-rest                      | fail | ./mugen-riscv/logs/hbase/oe_test_service_hbase-rest/2023-11-24-16:51:34.log |      |
|                           | oe_test_service_hbase-thrift                    | fail | ./mugen-riscv/logs/hbase/oe_test_service_hbase-thrift/2023-11-24-16:56:15.log |      |
| pywbem_1.1.3              | oe_test_pywbem_base_mof_compiler_01             | fail | ./mugen-riscv/logs/pywbem_1.1.3/oe_test_pywbem_base_mof_compiler_01/2023-11-25-06:58:38.log |      |
| pywbem_1.1.3              | oe_test_pywbem_base_mof_compiler_01             | fail | ./mugen-riscv/logs/pywbem_1.1.3/oe_test_pywbem_base_mof_compiler_01/2023-11-25-06:58:38.log |      |
|                           | oe_test_pywbem_base_mof_compiler_02             | fail | ./mugen-riscv/logs/pywbem_1.1.3/oe_test_pywbem_base_mof_compiler_02/2023-11-25-07:10:32.log |      |
|                           | oe_test_pywbem_base_mof_compiler_02             | fail | ./mugen-riscv/logs/pywbem_1.1.3/oe_test_pywbem_base_mof_compiler_02/2023-11-25-07:10:32.log |      |
| imageTailor               | oe_test_imageTailor_01                          | fail | ./mugen-riscv/logs/imageTailor/oe_test_imageTailor_01/2023-11-26-00:05:38.log |      |
| selinux                   | oe_test_identify_selinux_rejects                | fail | ./mugen-riscv/logs/selinux/oe_test_identify_selinux_rejects/2023-11-22-13:11:53.log |      |
| linuxdoc-tools_0.9.72     | oe_test_linuxdoc-tools_01                       | fail | ./mugen-riscv/logs/linuxdoc-tools_0.9.72/oe_test_linuxdoc-tools_01/2023-11-23-06:46:30.log |      |
| minimap                   | oe_test_minimap2                                | fail | ./mugen-riscv/logs/minimap/oe_test_minimap2/2023-11-25-09:46:31.log |      |
| enchant2_2.3.3            | oe_test_enchant2_base_enchant-2                 | fail | ./mugen-riscv/logs/enchant2_2.3.3/oe_test_enchant2_base_enchant-2/2023-11-25-06:18:16.log |      |
| netsniff-ng               | oe_test_bpfc                                    | fail | ./mugen-riscv/logs/netsniff-ng/oe_test_bpfc/2023-11-22-13:29:03.log | None |
|                           | oe_test_flowtop_01                              | fail | ./mugen-riscv/logs/netsniff-ng/oe_test_flowtop_01/2023-11-22-13:40:10.log | None |
|                           | oe_test_curvetun_common                         | fail | ./mugen-riscv/logs/netsniff-ng/oe_test_curvetun_common/2023-11-22-13:34:52.log | None |
|                           | oe_test_trafgen_03                              | fail | ./mugen-riscv/logs/netsniff-ng/oe_test_trafgen_03/2023-11-22-14:23:07.log | None |
| biometric-auth            | oe_test_service_biometric-authentication        | fail | ./mugen-riscv/logs/biometric-auth/oe_test_service_biometric-authentication/2023-11-25-20:50:28.log |      |
| pcp-system-tools          | oe_test_dstat_03                                | fail | ./mugen-riscv/logs/pcp-system-tools/oe_test_dstat_03/2023-11-22-16:49:27.log |      |
|                           | oe_test_pcp-uptime_pcp-verify                   | fail | ./mugen-riscv/logs/pcp-system-tools/oe_test_pcp-uptime_pcp-verify/2023-11-22-19:16:26.log |      |
|                           | oe_test_pcp-pidstat_01                          | fail | ./mugen-riscv/logs/pcp-system-tools/oe_test_pcp-pidstat_01/2023-11-22-17:25:47.log |      |
|                           | oe_test_pcp-mpstat_pcp-numastat                 | fail | ./mugen-riscv/logs/pcp-system-tools/oe_test_pcp-mpstat_pcp-numastat/2023-11-22-18:45:52.log |      |
| javapackages-tools        | oe_test_gradle-local                            | fail | ./mugen-riscv/logs/javapackages-tools/oe_test_gradle-local/2023-11-24-17:02:47.log |      |
