## 2303测试结果

截止当前2303共测试了214个测试套，1151个测试用例

与旧2303测试相比，有51个用例状态从成功变为失败，有141个测试用例从失败变为成功,同时新增了109个失败的测试用例

### 与旧测试结果相比，新增的测试失败用例

| 测试套/软件包名              | 测试用例名                             | 状态 | 原因                               |
| ---------------------------- | -------------------------------------- | ---- | ---------------------------------- |
| redis                        | oe_test_redis_01                       | fail | 超时,待重测                        |
| ansible                      | oe_test_ansible_01                     | fail | 超时,待重测                        |
| smoke-baseinfo               | oe_test_systemctl                      | fail | rsylog服务未运行                   |
| pixman                       | oe_test_pixman                         | fail | 没有errno.h文件，待进一步检查      |
| libmicrohttpd                | oe_test_libmicrohttpd                  | fail | 没有socket.h文件，待进一步检查     |
| os-storage                   | oe_test_storage_Mutipath_initramfs     | fail | 未安装dracut                       |
| net-tools                    | oe_test_net-tools_ipmaddr              | fail | addr空ip地址，疑似为环境出错       |
| rubygem-fluentd_1.3.3        | oe_test_fluent_cat_02_2003             | fail | 连接端口24454失败                  |
| rsyslog                      | oe_test_rsyslog_abnormal_config        | fail | 没有文件test.conf                  |
|                              | oe_test_rsyslog_function_facility      | fail | 没有文件test.conf                  |
|                              | oe_test_service_rsyslog                | fail | 没有文件test.conf                  |
|                              | oe_test_rsyslog_parameter01            | fail | 没有文件test.conf                  |
|                              | oe_test_rsyslog_parameter04            | fail | 没有文件test.conf                  |
|                              | oe_test_rsyslog_function_discard       | fail | 没有文件test.conf                  |
|                              | oe_test_rsyslog_parameter03            | fail | 没有文件test.conf                  |
|                              | oe_test_rsyslog_function_shell         | fail | 没有文件test.conf                  |
|                              | oe_test_rsyslog_function_priority      | fail | 没有文件test.conf                  |
|                              | oe_test_rsyslog_function_imfile        | fail | 没有文件test.conf                  |
|                              | oe_test_rsyslog_function_template      | fail | 没有文件test.conf                  |
|                              | oe_test_rsyslog_parameter02            | fail | 没有文件test.conf                  |
|                              | oe_test_rsyslog_function_rainerscript  | fail | 没有文件test.conf                  |
|                              | oe_test_rsyslog_function_wildcard      | fail | 没有文件test.conf                  |
|                              | oe_test_rsyslog_reliability_restart    | fail | 没有文件test.conf                  |
| qperf                        | oe_test_qperf_01                       | fail | 网络连接错误，待重测               |
| hdparm                       | oe_test_hdparm                         | fail | 未预装hdparm                       |
| rubygem-fluentd_1.14.5       | oe_test_fluent_cat_01                  | fail | 网络连接错误，待重测               |
| librabbitmq                  | oe_test_librabbitmq_amqp-get           | fail | 登录 AMQP 服务器失败，待进一步检查 |
|                              | oe_test_librabbitmq_amqp-delete-queue  | fail | 登录 AMQP 服务器失败，待进一步检查 |
|                              | oe_test_librabbitmq_amqp-publish       | fail | 登录 AMQP 服务器失败，待进一步检查 |
|                              | oe_test_librabbitmq_amqp-declare-queue | fail | 登录 AMQP 服务器失败，待进一步检查 |
| OpenEXR                      | oe_test_OpenEXR_exrenvmap              | fail | 超时，待重测                       |
| rabbitmq-server              | oe_test_rabbitmq-plugins               | fail | 超时，待重测                       |
|                              | oe_test_service_rabbitmq-server        | fail | 超时，待重测                       |
| openscap                     | oe_test_scanning_system                | fail | 超时，待重测                       |
| apr                          | oe_test_apr_002                        | fail | 没有socket.h文件，待进一步检查     |
|                              | oe_test_apr_001                        | fail | 没有socket.h文件，待进一步检查     |
| enchant2_2.3.3               | oe_test_enchant2_base_enchant-2        | fail | grep错误，实际上通过               |
| libtar                       | oe_test_libtar                         | fail | 没有errno.h文件，待进一步检查      |
| nspr                         | oe_test_nspr_002                       | fail | 没有socket.h文件，待进一步检查     |
|                              | oe_test_nspr_001                       | fail | 没有socket.h文件，待进一步检查     |
| embedded_os_basic_extra_test | oe_test_acl_verwrite_previous_rules    | fail | 没有less.less文件，待进一步检查    |
|                              | oe_test_acl_allow_change_ownership     | fail | 没有less.less文件，待进一步检查    |
|                              | oe_test_acl_ignore_dal_across          | fail | 没有less.less文件，待进一步检查    |
|                              | oe_test_acl_send_kill_notbelong        | fail | 没有less.less文件，待进一步检查    |
|                              | oe_test_acl_ordinary_users_setgid      | fail | 没有less.less文件，待进一步检查    |
|                              | oe_test_acl_allow_change_nochange      | fail | 没有less.less文件，待进一步检查    |
|                              | oe_test_acl_manage_net                 | fail | 没有less.less文件，待进一步检查    |

## 旧测试中不存在的新增失败测试用例

| 测试套/软件包名              | 测试用例名                                      | 状态    | 原因 |
| ---------------------------- | ----------------------------------------------- | ------- | ---- |
| sysboost                     | oe_test_sysboost_fun                            | newfail |      |
| libdap_20.03                 | oe_test_libdap_devel_dap_config                 | newfail |      |
|                              | oe_test_libdap_getdap                           | newfail |      |
|                              | oe_test_libdap_getdap4                          | newfail |      |
| oncn-bwm                     | oe_test_bwm_qos_limit_001                       | newfail |      |
| jsoncpp                      | oe_test_jsoncpp_01                              | newfail |      |
| java-11-openjdk              | oe_test_openjdk11_javap                         | newfail |      |
|                              | oe_test_openjdk11_jdb_jdeps                     | newfail |      |
|                              | oe_test_openjdk11_jjs_jmap                      | newfail |      |
|                              | oe_test_openjdk11_rmid                          | newfail |      |
|                              | oe_test_openjdk11_javac                         | newfail |      |
|                              | oe_test_openjdk11_pack200                       | newfail |      |
|                              | oe_test_openjdk11_javadoc                       | newfail |      |
| testsuite                    | oe_test_casename_02                             | newfail |      |
| wrk                          | oe_test_wrk                                     | newfail |      |
| ltp                          | oe_test_ltp                                     | newfail |      |
|                              | oe_test_posix                                   | newfail |      |
| netcdf                       | oe_test_netcdf                                  | newfail |      |
| embedded_dsoftbus_basic_test | oe_test_CreateSessionServerInterface_001        | newfail |      |
|                              | oe_test_PublishServiceInterface_001             | newfail |      |
|                              | oe_test_RemoveSessionServerInterface_001        | newfail |      |
|                              | oe_test_StopDiscoveryInterface_001              | newfail |      |
|                              | oe_test_UnPublishServiceInterface_001           | newfail |      |
|                              | oe_test_DiscoveryInterface_001                  | newfail |      |
| freetds                      | oe_test_freetds_tsql                            | newfail |      |
|                              | oe_test_freetds_fisql                           | newfail |      |
|                              | oe_test_freetds_freebcp                         | newfail |      |
|                              | oe_test_freetds_datacopy                        | newfail |      |
| libsdl2                      | oe_test_libsdl1.2                               | newfail |      |
| annobin                      | oe_test_annobin                                 | newfail |      |
| python-gitlab                | oe_test_gitlab_01                               | newfail |      |
| axel                         | oe_test_axel_01                                 | newfail |      |
|                              | oe_test_axel_02                                 | newfail |      |
|                              | oe_test_fluent_cap_ctl                          | newfail |      |
| dde-daemon                   | oe_test_service_dbus-com.deepin.dde.lockservice | newfail |      |
| criu_3.15                    | oe_test_criu_base_pre-dump_03                   | newfail |      |
|                              | oe_test_criu_base_restore_02                    | newfail |      |
|                              | oe_test_criu_base_dump_01                       | newfail |      |
|                              | oe_test_criu_base_dump_05                       | newfail |      |
|                              | oe_test_criu_base_check_02                      | newfail |      |
|                              | oe_test_criu_base_restore_05                    | newfail |      |
|                              | oe_test_criu_base_dump_04                       | newfail |      |
|                              | oe_test_criu_base_service                       | newfail |      |
|                              | oe_test_criu_base_page-server                   | newfail |      |
|                              | oe_test_criu_base_pre-dump_05                   | newfail |      |
|                              | oe_test_criu_base_pre-dump_04                   | newfail |      |
|                              | oe_test_criu_base_restore_01                    | newfail |      |
|                              | oe_test_criu_base_dump_02                       | newfail |      |
|                              | oe_test_criu_base                               | newfail |      |
|                              | oe_test_criu_base_pre-dump_01                   | newfail |      |
|                              | oe_test_criu_base_restore_03                    | newfail |      |
|                              | oe_test_criu_base_check_01                      | newfail |      |
|                              | oe_test_criu_base_dump_03                       | newfail |      |
|                              | oe_test_criu_base_restore_04                    | newfail |      |
| nvwa                         | oe_test_nvwa_redis                              | newfail |      |
|                              | oe_test_service_nvwa                            | newfail |      |
|                              | oe_test_service_nvwa-pre                        | newfail |      |
|                              | oe_test_service_ipmitool                        | newfail |      |
| libiec61883                  | oe_test_libiec61883_plugctl                     | newfail |      |
|                              | oe_test_beakerlib_01                            | newfail |      |
| nvml                         | oe_test_nvml_rpmemd                             | newfail |      |
|                              | oe_test_nvml_pmempool                           | newfail |      |
|                              | oe_test_nvml_daxio                              | newfail |      |
| psutils                      | oe_test_pstops                                  | newfail |      |
|                              | oe_test_epsffit                                 | newfail |      |
|                              | oe_test_psjoin                                  | newfail |      |
|                              | oe_test_psselect                                | newfail |      |
|                              | oe_test_psbook                                  | newfail |      |
|                              | oe_test_psresize                                | newfail |      |
|                              | oe_test_psnup_02                                | newfail |      |
|                              | oe_test_psnup_01                                | newfail |      |
| tboot_1.9.12-2               | oe_test_tboot_lcp2_crtpolelt                    | newfail |      |
|                              | oe_test_tboot_1.9.12-2_lcp2_mlehash             | newfail |      |
|                              | oe_test_tboot_txt-stat                          | newfail |      |
|                              | oe_test_tboot_1.9.12-2_lcp2_crtpollist          | newfail |      |
|                              | oe_test_tboot_1.9.12-2_lcp2_crtpol              | newfail |      |
|                              | oe_test_tboot_tb_polgen                         | newfail |      |
| fapolicyd                    | oe_test_fapolicyd-bugfix                        | newfail |      |
|                              | oe_test_fapolicyd-service                       | newfail |      |
| mod-wsgi                     | oe_test_mod-wsgi                                | newfail |      |
| blueman                      | oe_test_service_blueman-mechanism               | newfail |      |
|                              | oe_test_nasm_14                                 | newfail |      |
| cpp_httplib                  | oe_test_cpp_httplib                             | newfail |      |
| python-kazoo                 | oe_test_python-kazoo                            | newfail |      |
| flink                        | oe_test_flink-local                             | newfail |      |
| activemq                     | oe_test_activemq_fun_01                         | newfail |      |
| pywbem_0.12.4                | oe_test_pywbem_0.12.4_wbemcli_02                | newfail |      |
|                              | oe_test_pywbem_base_mof_compiler_01             | newfail |      |
|                              | oe_test_pywbem_base_mof_compiler_02             | newfail |      |
|                              | oe_test_pywbem_0.12.4_wbemcli_01                | newfail |      |
| hbase                        | oe_test_service_hbase-regionserver              | newfail |      |
|                              | oe_test_service_hbase-zookeeper                 | newfail |      |
|                              | oe_test_service_hbase-rest                      | newfail |      |
|                              | oe_test_service_hbase-master                    | newfail |      |
|                              | oe_test_service_hbase-thrift                    | newfail |      |
| pywbem_1.1.3                 | oe_test_pywbem_base_mof_compiler_01             | newfail |      |
|                              | oe_test_pywbem_base_mof_compiler_02             | newfail |      |
| imageTailor                  | oe_test_imageTailor_01                          | newfail |      |
|                              | oe_test_selinux_semanage_login                  | newfail |      |
|                              | oe_test_selinux_semanage_user                   | newfail |      |
|                              | oe_test_selinux_chcon                           | newfail |      |
|                              | oe_test_linuxdoc-tools_01                       | newfail |      |
|                              | oe_test_flatbuffers_01                          | newfail |      |
| minimap                      | oe_test_minimap2                                | newfail |      |
| biometric-auth               | oe_test_service_biometric-authentication        | newfail |      |
|                              | oe_test_curl_curl_001                           | newfail |      |
|                              | oe_test_curl_curl_006                           | newfail |      |
|                              | oe_test_curl_curl_002                           | newfail |      |





### 与旧测试结果相比，新增的测试成功用例

| 测试套/软件包名   | 测试用例名                                  | 状态    | 原因 |
| ----------------- | ------------------------------------------- | ------- | ---- |
| ant               | oe_test_ant_002                             | success | None |
| Echarts           | oe_test_Echarts                             | success | None |
| ceph              | oe_test_service_rbdmap                      | success | None |
|                   | oe_test_target_ceph                         | success | None |
|                   | oe_test_target_ceph-mds                     | success | None |
|                   | oe_test_target_ceph-mon                     | success | None |
|                   | oe_test_target_ceph-radosgw                 | success | None |
|                   | oe_test_target_ceph-rbd-mirror              | success | None |
|                   | oe_test_target_ceph-mgr                     | success | None |
|                   | oe_test_target_ceph-fuse                    | success | None |
|                   | oe_test_target_ceph-osd                     | success | None |
| rdate             | oe_test_rdate                               | success | None |
| libappstream-glib | oe_test_libappstream-glib_appstream-util_03 | success | None |
| ndisc6            | oe_test_ndisc6_name2addr                    | success | None |
|                   | oe_test_ndisc6_rdisc6                       | success | None |
| gegl04            | oe_test_gegl04_gegl-imgcmp                  | success | None |
| iperf3            | oe_test_iperf3_command_client               | success | None |
| fio               | oe_test_fio_004                             | success | None |
|                   | oe_test_fio_001                             | success | None |
| perl-Date-Manip   | oe_test_perl-Date-Manip_dm_date             | success | None |
| sbd               | oe_test_service_sbd_remote                  | success | None |
|                   | oe_test_service_sbd                         | success | None |
|                   | oe_test_ansible_04                          | success | None |
| ipvsadm           | oe_test_ipvs_SCEN_DR_06                     | success | None |
|                   | oe_test_ipvs_SAVE_01                        | success | None |
|                   | oe_test_ipvs_SCEN_TUN_05                    | success | None |
|                   | oe_test_ipvs_SCEN_TUN_06                    | success | None |
|                   | oe_test_ipvs_SCEN_DR_05                     | success | None |
| iftop             | oe_test_iftop_text_mode                     | success | None |
|                   | oe_test_iftop_config                        | success | None |
| conmon            | oe_test_conmon_04                           | success | None |
|                   | oe_test_conmon_02                           | success | None |
|                   | oe_test_conmon_03                           | success | None |
| os-storage        | oe_test_storage_lvm_raid_synchronization    | success | None |
|                   | oe_test_storage_ext3_mount_write            | success | None |
|                   | oe_test_storage_nfs_write_full              | success | None |
|                   | oe_test_storage_lvm_query_lvmsnap           | success | None |
|                   | oe_test_storage_smb_cmd_smbcontrol          | success | None |
|                   | oe_test_storage_lvm_lvdisplay_lvscan        | success | None |
|                   | oe_test_storage_DevMgmt_block_drop          | success | None |
|                   | oe_test_storage_nfs_network_latency         | success | None |
|                   | oe_test_storage_smb_abnormal_poweroff       | success | None |
|                   | oe_test_storage_DevMgmt_swap                | success | None |
|                   | oe_test_storage_longname_modify             | success | None |
|                   | oe_test_storage_nfs_restrict_hostname       | success | None |
|                   | oe_test_storage_nfs_repeat_restartServer    | success | None |
|                   | oe_test_storage_diskpartiton_create_raid5   | success | None |
|                   | oe_test_storage_lvm_set_limit               | success | None |
|                   | oe_test_storage_xfs_create                  | success | None |
|                   | oe_test_storage_lvm_create_thinSnapshot     | success | None |
|                   | oe_test_storage_lvm_create_raid             | success | None |
|                   | oe_test_storage_diskpartiton_fdisk          | success | None |
|                   | oe_test_storage_ext4_mount_write            | success | None |
|                   | oe_test_storage_lvm_activation_missing      | success | None |
|                   | oe_test_storage_smb_mount_umount            | success | None |
|                   | oe_test_storage_smb_POSIX_ACL               | success | None |
|                   | oe_test_storage_smb_cmd_smbstatus           | success | None |
|                   | oe_test_storage_diskpartiton_create_raid1   | success | None |
|                   | oe_test_storage_smb_automatically_mount     | success | None |
|                   | oe_test_storage_lvm_create_cache            | success | None |
|                   | oe_test_storage_smb_share_dir               | success | None |
|                   | oe_test_storage_smb_cmd_smbpasswd           | success | None |
|                   | oe_test_storage_smb_host_share              | success | None |
|                   | oe_test_storage_smb_guest_share             | success | None |
|                   | oe_test_storage_smb_write_full              | success | None |
|                   | oe_test_storage_smb_cmd_rpcclient           | success | None |
|                   | oe_test_storage_lvm_create_snapshot         | success | None |
|                   | oe_test_storage_mount_UUID                  | success | None |
|                   | oe_test_storage_nfs_configure_nfsv4         | success | None |
|                   | oe_test_storage_longname_list               | success | None |
|                   | oe_test_storage_lvm_set_lvconvert_raid      | success | None |
|                   | oe_test_storage_ext3_resize                 | success | None |
|                   | oe_test_storage_DevMgmt_lsblk               | success | None |
|                   | oe_test_storage_lvm_set_lvconvert_raid1     | success | None |
|                   | oe_test_storage_repair_e2fsck               | success | None |
|                   | oe_test_storage_diskpartiton_view_fdisk     | success | None |
|                   | oe_test_storage_lvm_specify_size            | success | None |
|                   | oe_test_storage_diskpartiton_parted_resize  | success | None |
|                   | oe_test_storage_lvm_replace_badraid         | success | None |
|                   | oe_test_storage_smb_cmd_smbclient           | success | None |
|                   | oe_test_storage_lvm_add_VG                  | success | None |
|                   | oe_test_storage_lvm_replace_raid            | success | None |
|                   | oe_test_storage_smb_3.0                     | success | None |
|                   | oe_test_storage_smb_repeat_restart          | success | None |
|                   | oe_test_storage_mount_findmnt               | success | None |
|                   | oe_test_storage_lvm_merge_VG                | success | None |
|                   | oe_test_storage_ext4_mount                  | success | None |
|                   | oe_test_storage_smb_cmd_testparm            | success | None |
|                   | oe_test_storage_smb_credential_files        | success | None |
|                   | oe_test_storage_nfs_v3_v4                   | success | None |
|                   | oe_test_storage_lvm_separate_raid           | success | None |
|                   | oe_test_storage_nfs_share_mount             | success | None |
|                   | oe_test_storage_mount_mobile_point          | success | None |
|                   | oe_test_storage_lvm_split_VG                | success | None |
|                   | oe_test_storage_diskpartiton_fdisk_delete   | success | None |
|                   | oe_test_storage_lvm_cling                   | success | None |
|                   | oe_test_storage_nfs_mount_readonly          | success | None |
|                   | oe_test_storage_mount_block_device          | success | None |
|                   | oe_test_storage_mount_repeat                | success | None |
|                   | oe_test_storage_diskpartiton_fdisk_settype  | success | None |
|                   | oe_test_storage_xfs_backup                  | success | None |
|                   | oe_test_storage_lvm_expand_stripeLV         | success | None |
|                   | oe_test_storage_DevMgmt_disk_operation      | success | None |
|                   | oe_test_storage_mount_copy                  | success | None |
|                   | oe_test_storage_smb_mount                   | success | None |
|                   | oe_test_storage_vfat_mount_write            | success | None |
|                   | oe_test_storage_lvm_set_label               | success | None |
|                   | oe_test_storage_ext3_create                 | success | None |
|                   | oe_test_storage_nfs_restrict_ip             | success | None |
|                   | oe_test_storage_nfs_mount_root              | success | None |
|                   | oe_test_storage_lvm_snapshot_tag            | success | None |
|                   | oe_test_storage_smb_multi-user_mount        | success | None |
|                   | oe_test_storage_xfs_Increase_size           | success | None |
|                   | oe_test_storage_lvm_change_number           | success | None |
|                   | oe_test_storage_smb_network_latency         | success | None |
|                   | oe_test_storage_diskpartiton_create_raid0   | success | None |
|                   | oe_test_storage_lvm_set_regionsize          | success | None |
|                   | oe_test_storage_mount_umount                | success | None |
|                   | oe_test_storage_nfs_repeat_mount            | success | None |
|                   | oe_test_storage_repair_xfs                  | success | None |
|                   | oe_test_storage_xfs_restore                 | success | None |
|                   | oe_test_storage_lvm_snapshot_merge          | success | None |
| clamav            | oe_test_clamav_clamdscan_scan               | success | None |
|                   | oe_test_fluent_cat_02                       | success | None |
| libwmf            | oe_test_libwmf_wmf2x_01                     | success | None |
| FS_FileSystem     | oe_test_FSIO_mount_block_dir                | success | None |
|                   | oe_test_FSIO_mount_automount                | success | None |
|                   | oe_test_FSIO_mount_reboot                   | success | None |
|                   | oe_test_FSIO_mount_character_dir            | success | None |
| xmvn_3.0.0-24     | oe_test_xmvn_base_mvn-local_08              | success | None |
|                   | oe_test_xmvn_base_mvn-local_04              | success | None |
|                   | oe_test_xmvn_base_mvn-local_04              | success | None |
|                   | oe_test_rabbitmqctl_cluster                 | success | None |
| FS_Docker         | oe_test_docker_check_overlay2fs             | success | None |
|                   | oe_test_docker_compress                     | success | None |
|                   | oe_test_docker_commit_save                  | success | None |
|                   | oe_test_docker_info                         | success | None |
| hadoop            | oe_test_service_hadoop-zkfc                 | success | None |
|                   | oe_test_service_hadoop-historyserver        | success | None |



### 