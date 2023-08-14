# Test1测试结果

Test1中共有x个测试套中的214个测试用例失败，其中

- 109个测试用例RISCV与x86报错相同

- 65个测试用例RISCV与x86报错不同

- 13个测试用例RISCV与x86报错有部分相似

  



### 测试用例问题

- oe_test_hdparm:没有进行环境搭建就开始测试
- oe_test_normal_tcpdump_01:grep错误
- oe_test_normal_tcpdump_02:grep错误
- oe_test_normal_tcpdump_03:grep错误
- oe_test_libxml2_001:少安装了一个软件包
- oe_test_libxml2_002:少安装了一个软件包
- oe_test_ip_ipv6_02:命令行不完整
- oe_test_ip_ipv6_03:命令行不完整
- oe_test_iproute_ipv6_01:命令行不完整
- oe_test_gettext：grep中文字符
- oe_test_ebtables:测试用例没有安装ebtables
- oe_test_erb:测试套grep编写错误
- oe_test_qpdf_qpdf_01：测试套grep编写错误
- oe_test_qpdf_qpdf_10：测试套grep编写错误
- oe_test_qpdf_qpdf_02:无法使用弱密码写入
- oe_test_qpdf_qpdf_03:无法使用弱密码写入
- oe_test_qpdf_qpdf_08:无法使用弱密码写入
- oe_test_pmlogger_daily_01：测试套没有更新
- oe_test_nftables_replace_counters:测试环境没有安装对应预装软件
- oe_test_nftables_anonymous_map:没有安装nftables
- oe_test_nftables_backup_rules:没有安装nftables
- oe_test_nftables_chains:没有安装nftables
- oe_test_nftables_create_counters:没有安装nftables
- oe_test_nftables_listen_package:没有安装nftables
- oe_test_nftables_name_sets:没有安装nftables
- oe_test_nftables_replace_counters:没有安装nftables
- oe_test_service_nftables:没有安装nftables



### 测试套使用了不支持的命令/部分指令未通过

- oe_test_ruby:使用不支持的参数进行测试
- oe_test_systemd_journald:journalctl错误
- oe_test_setools:seinfo错误
- oe_test_network_001:ethtool错误
- oe_test_mtr:dns错误
- oe_test_ipv6_VLAN_01:dev错误
- oe_test_ipv6_VLAN_02:dev错误
- oe_test_pcp_atop_01:nohup命令错误
- oe_test_patchutils_interdiff_01:interdiff命令错误
- oe_test_patchutils_flipdiff_01:flipdiff命令错误
- oe_test_patchutils_combinediff_01:combinediff命令错误
- oe_test_pmlogcheck_pmlogmv:pmlogmv命令出错
- oe_test_storage_diskpartiton_view_fdisk:fdisk指令错误
- oe_test_storage_Mutipath_dmsetup:-gt错误
- oe_test_openvpn:多数命令报错
- oe_test_FSIO_dir_access_boot:ls -l /boot错误
- oe_test_FSIO_dir_access_dev:ls -l /dev错误
- oe_test_FSIO_dir_access_root:ls /root错误
- oe_test_FSIO_dir_access_sbin:ls -l /usr/sbin错误

### 服务相关问题

- oe_test_service_restorecond:服务启动失败：未找到服务项
- oe_test_service_qemu-guest-agent:服务重启失败
- oe_test_service_radvd：服务启动失败
- oe_test_service_rngd：服务启动失败
- oe_test_service_samba：服务加载失败
- oe_test_service_strongswan-swanctl:服务项命令失败
- oe_test_service_strongswan_03：服务启动失败：没有对应文件
- oe_test_service_systemtap：找不到对应服务
- oe_test_service_tuned：找不到对应服务
- oe_test_openssh_port：firewalld.service服务未加载
- oe_test_service_strongswan-swanctl：服务项命令失败

### 特殊问题：

oe_test_storage_lvm_**中的所有测试用例x86均由于镜像未装pvcreate，导致测试全部出错，但预装了pvcreate的RISCV也有不同的报错且这些报错在其他的x86上的测试用例上也出现过，因此可以确认x86上即使安装了pvcreate也会出错

