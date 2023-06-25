### 修订记录

| 日期      | 修订版本 | 修改描述 | 作者  |
| --------- | -------- | -------- | ----- |
| 2023-6-24 | 0.0.1    | Demo     | Pagerd |

# 目录

- 摘要
- 工作内容
  - 测试配置
  - 测试套遴选
  - 分级测试策略
  - 运行测试
  - 分析测试用例失败原因
- mugen测试结果
  - 测试未通过原因分析和归类说明
  - 测试未通过原因类型说明
  - riscv fail
  - x86 fail
  - success

# 摘要

openEuler 是一款开源操作系统。当前 openEuler 内核源于 Linux ，支持多种处理器架构，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统。 

本文主要描述 openEuler RISC-V 23.03 版本自动化mugen测试策略，展现目前mugen测试结果，并为下一步工作提供一个较为详细的文档

**关键词**：RISC-V，自动化测试，mugen



# 工作内容

本章主要完成对测试套和测试用例的遴选以及测试环境的配置，并对对应的测试套测试用例进行测试，对于未通过的重点测试套测试用例进行失败原因分析

## 测试配置

#### 测试框架和测试方法

测试框架：mugen-riscv

测试方式：测试环境自动复原，测试套间隔离以及自动分配硬盘外设资源的自动化测试

使用qemu_test.py，利用qemu qcow2快照实现在测试每个测试套时单独建立qemu虚拟机进行测试，保证了测试套间不会相互干扰。测试程序运行时会根据测试套文件中"add disk"字段的信息，自动创建硬盘资源并分配给对应的虚拟机。

测试用例代码位置：https://gitee.com/src-oerv/mugen/tree/riscv/testcases/cli-test/对应测试套名/对应测试用例名.sh

#### 测试环境

- RISCV镜像：https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/testing/20230331_openEuler-23.03-V1-riscv64/QEMU/

- 2303 x86 的镜像https://mirror.iscas.ac.cn/openeuler/openEuler-23.03/virtual_machine_img/x86_64/

- kernel和initrd对应文件https://mirror.iscas.ac.cn/openeuler/openEuler-23.03/OS/x86_64/images/pxeboot/

- host上mugen使用https://github.com/brsf11/mugen-riscv

- guest上mugen使用上游仓库版本(revision [9577098](https://gitee.com/openeuler/mugen/commit/95770982e86665a2beffa90c07b031da937333ac))

- 软件源：默认

- CPU核数：4

- 内存大小：4G

- qemu启动参数：


```
qemu-system-riscv64 \
-nographic -machine virt  \
-smp 4 -m 4G \
-audiodev pa,id=snd0 \
-bios fw_payload_oe_uboot_2304.bin \
-drive file=mugen_ready.qcow2,format=qcow2,id=hd0 \
-object rng-random,filename=/dev/urandom,id=rng0 \
-device virtio-rng-device,rng=rng0 \
-device virtio-blk-device,drive=hd0 \
-device virtio-net-device,netdev=usernet \
-netdev user,id=usernet,hostfwd=tcp::"ssh_port"-:22 \
-device qemu-xhci -usb -device usb-kbd -device usb-tablet -device usb-audio,audiodev=snd0 \ 
```

- 附加硬盘qemu参数：


```
-drive file=disk"self.id-i".qcow2,format=qcow2,id=hd"i" -device virtio-blk-pci,drive=hd"i"
```

- self.id：测试时为对应虚拟机的id

- i：测试时为某一虚拟机的硬盘序号

- mugen_ready.qcow2处理
  mugen_ready.qcow2由原始镜像openEuler-23.03-V1-base-qemu-preview.qcow2安装git和mugen依赖而来

## 测试套遴选

由于BaseOS是本次测试的重点，因此首先从openEuler23.03版本分级中选取包含BaseOS软件包分级的mugen测试用例，在BaseOS覆盖的测试套全部结束后，根据情况继续进行everything和EPOL的测试

| 测试类     | 描述                                 | 当前状态     |
| ---------- | ------------------------------------ | ------------ |
| BaseOS     | 软件包分级BaseOS中所覆盖的软件包     | 基本完成测试 |
| everything | 软件包分级everything中所覆盖的软件包 |              |
| EPOL       | 软件包分级EPOL中所覆盖的软件包       |              |

## 分级测试策略

在进行测试的时候需要进行对比测试，因此会对不通过的测试套在x86上进行对比测试，分级测试阶段如下

测试阶段1：

1. 在riscv上将需要进行测试的测试套进行mugen测试

2. 在x86上将在riscv上失败的所有测试套进行对比测试


测试阶段2：

1. 对在x86上成功 riscv上失败的测试套进行测试失败原因分析


测试阶段3：

1. 对在x86和riscv上均失败的测试套进行测试失败原因分析



## 运行测试

基于分发好的测试套列表[cli](https://github.com/brsf11/Tarsier-Internship/tree/main/Testing/mugenTestcase)进行测试，提交产出log到[res_list](https://github.com/KotorinMinami/res_list/tree/master)

## 分析测试用例失败原因

通过对log文件的分析，将未通过的测试用例的分析的原因汇总到[failureCause.csv](https://github.com/KotorinMinami/res_list/blob/master/failureCause.csvhttps://github.com/KotorinMinami/res_list/blob/master/failureCause.csv)

# mugen测试结果

## 测试未通过原因分析和归类说明

- 由于未通过测试较多，我们仅先对重点fail的测试用例进行原因分析，具体见下文，若需要查看更具体的log文件，在[此仓库](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/tree/master/23.09/mugen)中
- 测试未通过原因分析和归类由自动化程序完成，基本的原理为对log文件进行字符串匹配
- 本次测试中，测试未通过原因或者用例未通过原因有以下类型：
  - 测试用例不能（完全）执行: broken testcase
  - 软件包缺失: pkg not found
  - 预装缺失: preinstall absent
  - 内核模块缺失: kernel module absent
  - 文件缺失（软件包已安装）: file missing
  - systemd单元错误
    - 重启错误: systemd unit restart failure
    - 运行时错误: systemd unit runtime error
    - 使能错误: systemd unit enable failure
  - 超时: timeout
  - 无效参数: invalid argument
  - 其他（未被归类）
- 一个用例可能会有多个类型的测试未通过原因或者未被归类（其他）

## 测试未通过原因类型说明

### 较大概率为软件缺陷造成

- 文件缺失（软件包已安装）: file missing
  - 判断标准：用例有执行软件包安装操作，遇到command not found/.service not found/No such file or directory的情况
  - 说明:可能为安装的软件包中缺少对应文件，软件打包存在问题
- systemd单元错误
  - 重启错误: systemd unit restart failure
    - 用例中测试systemd单元重启操作失败
  - 运行时错误: systemd unit runtime error
    - 测试中systemd单元的日志中有报错信息
  - 使能错误: systemd unit enable failure
    - 用例中测试systemd单元使能操作失败
- 其他（未被归类）
  - 其他（未被归类）的测试未通过原因中，大部分为被测软件运行出错，但无法被归为某一特定类型，较大概率为软件bug

### 较小概率或并非为软件缺陷造成

- 超时: timeout
  - 可能为软件缺陷造成
  - 判断标准：日志中出现timeout等关键词
- 测试用例不能（完全）执行: broken testcase
  - 可能为软件缺陷造成
  - 判断标准：测试用例没有执行主体测试代码（run_test函数）
  - 说明:一般为用例运行时在环境准备阶段出错退出
- 无效参数: invalid argument
  - 小概率为软件缺陷造成
  - 判断标准：日志中出现invalid option/invalid argument等关键词
  - 说明:测试中执行了被测程序的无效参数，可能为用例编写有问题或程序更新后参数变化
- 软件包缺失: pkg not found
  - 并非软件缺陷造成
  - 判断标准：用例运行时软件包安装操作（DNF_INSTALL函数）遇到软件包缺失
  - 说明:由于测试的测试套都有软件源中对应的软件包，运行测试时遇到的软件包缺失为与测试套对应软件包相关的软件包缺失（如相关的库等）
- 预装缺失: preinstall absent
  - 并非为软件缺陷造成
  - 判断标准：用例没有执行软件包安装操作，遇到command not found/.service not found/No such file or directory的情况
  - 说明:一般为用例将某些软件包视为预装但被测镜像中并未预装
- 内核模块缺失: kernel module absent
  - 并非为软件缺陷造成
  - 判断标准：modprobe时报错xxx module not found
  - 说明:缺失对应的内核模块



## riscv fail

此表内的测试套及测试用例均为在x86上成功，在riscv上fail的测试用例，部分测试用例已分析原因

共52个测试套189个测试用例

| 测试套/软件包名    | 测试用例名                                                   | 原因                                                         | 状态 |
| ------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ---- |
| os-basic           | oe_test_accessdb                                             | preinstall absent                                            | fail |
|                    | oe_test_aureport                                             | timeout                                                      | fail |
|                    | oe_test_awk                                                  |                                                              | fail |
|                    | oe_test_c++                                                  | file missing                                                 | fail |
|                    | oe_test_chsh                                                 |                                                              | fail |
|                    | oe_test_count_gperftools_function                            | file missing                                                 | fail |
|                    | oe_test_disk_graphics_card                                   | file missing                                                 | fail |
|                    | oe_test_disk_io_sched                                        | preinstall absent                                            | fail |
|                    | oe_test_disk_schedule_specific                               |                                                              | fail |
|                    | oe_test_disk_schedule_udev                                   | preinstall absent                                            | fail |
|                    | oe_test_ethtool                                              | file missing                                                 | fail |
|                    | oe_test_expect                                               |                                                              | fail |
|                    | oe_test_fuse                                                 |                                                              | fail |
|                    | oe_test_gmp                                                  | file missing                                                 | fail |
|                    | oe_test_hostnamectl                                          |                                                              | fail |
|                    | oe_test_kernel_kdump                                         | preinstall absent                                            | fail |
|                    | oe_test_kernel_module_operation                              | kernel module absent                                         | fail |
|                    | oe_test_lastb                                                |                                                              | fail |
|                    | oe_test_libffi                                               | file missing                                                 | fail |
|                    | oe_test_net_VRF                                              |                                                              | fail |
|                    | oe_test_net_cmd_scp                                          | timeout                                                      | fail |
|                    | oe_test_nmcli_set_bond                                       | preinstall absent                                            | fail |
|                    | oe_test_nmcli_set_team                                       |                                                              | fail |
|                    | oe_test_power_measurement_internal                           |                                                              | fail |
|                    | oe_test_system_log_dmesg                                     |                                                              | fail |
|                    | oe_test_system_log_view                                      | preinstall absent                                            | fail |
|                    | oe_test_system_monitor_share_total                           |                                                              | fail |
|                    | oe_test_who                                                  |                                                              | fail |
|                    | oe_test_xmlsec                                               | file missing                                                 | fail |
|                    | oe_test_xzcmp                                                |                                                              | fail |
|                    | oe_test_zlib                                                 | file missing                                                 | fail |
| NetworkManager     | oe_test_libnetfilter_conntrack                               | 镜像没有预装测试所需的 kernel-headers                        | fail |
| OpenIPMI           | oe_test_service_ipmi                                         |                                                              | fail |
| acl                | oe_test_acl_default_kernel_setting                           | 未打开 CONFIG_XFS_POSIX_ACL=y                                | fail |
| arptables          | oe_test_service_arptables                                    |                                                              | fail |
| cachefilesd        | oe_test_service_cachefilesd                                  |                                                              | fail |
| ceph               | oe_test_target_ceph-fuse                                     | pkg not found/file missing                                   | fail |
|                    | oe_test_target_ceph-mds                                      | pkg not found/file missing                                   | fail |
|                    | oe_test_target_ceph-mgr                                      | pkg not found/file missing                                   | fail |
|                    | oe_test_target_ceph-mon                                      | pkg not found/file missing                                   | fail |
|                    | oe_test_target_ceph-osd                                      | pkg not found/file missing                                   | fail |
|                    | oe_test_target_ceph-radosgw                                  | pkg not found/file missing                                   | fail |
|                    | oe_test_target_ceph-rbd-mirror                               | pkg not found/file missing                                   | fail |
| chrony             | oe_test_service_chronyd                                      | preinstall absent/systemd unit restart failure/systemd unit runtime error | fail |
| cryptsetup         | oe_test_encrypt_data                                         |                                                              | fail |
|                    | oe_test_luks_encrypted                                       |                                                              | fail |
|                    | oe_test_use_luks                                             |                                                              | fail |
| dhcp               | oe_test_service_dhcrelay                                     | preinstall absent/systemd unit restart failure/systemd unit runtime error | fail |
| dnf                | oe_test_dnf_all-repos                                        | oerv 和 x86 的软件源结构不同                                 | fail |
|                    | oe_test_dnf_enhancement_exclude                              | oerv 和 x86 的软件源结构不同                                 | fail |
|                    | oe_test_dnf_makecache_clean                                  | oerv 和 x86 的软件源结构不同                                 | fail |
|                    | oe_test_dnf_nobest_nodocs_nogpgcheck                         | oerv 和 x86 的软件源结构不同                                 | fail |
|                    | oe_test_dnf_priority                                         | oerv 和 x86 的软件源结构不同                                 | fail |
|                    | oe_test_dnf_provides_randomwait                              | oerv 和 x86 的软件源结构不同                                 | fail |
|                    | oe_test_dnf_repeat-install                                   | oerv 和 x86 的软件源结构不同                                 | fail |
| dracut             | oe_test_service_dracut-shutdown                              | preinstall absent/systemd unit restart failure/systemd unit runtime error | fail |
| fcoe-utils         | oe_test_service_fcoe                                         | Job for fcoe.service failed because the control process exited with error code. | fail |
| freeradius         | oe_test_freeradius_freeradius-utils_rad_counter              |                                                              | fail |
|                    | oe_test_freeradius_freeradius-utils_radclient                |                                                              | fail |
|                    | oe_test_freeradius_freeradius-utils_radclient2               |                                                              | fail |
|                    | oe_test_freeradius_freeradius-utils_radeapclient             | timeout                                                      | fail |
|                    | oe_test_freeradius_freeradius-utils_radwho                   | file missing                                                 | fail |
|                    | oe_test_freeradius_freeradius-utils_radzap                   | file missing                                                 | fail |
|                    | oe_test_freeradius_freeradius-utils_rlm_ippool_toolAndSmbencrypt | file missing                                                 | fail |
|                    | oe_test_freeradius_freeradius_raddebugAndCheckrad            |                                                              | fail |
|                    | oe_test_freeradius_freeradius_radiusd                        |                                                              | fail |
|                    | oe_test_freeradius_freeradius_radiusdAndRadmin               |                                                              | fail |
|                    | oe_test_service_radiusd                                      | file missing/systemd unit restart failure/systemd unit runtime error/systemd unit enable failure | fail |
| gdm                | oe_test_service_gdm                                          | 下载超时                                                     | fail |
| glib2              | oe_test_glib2                                                | 镜像没有预装测试所需的 kernel-headers                        | fail |
| graphviz           | oe_test_service_zvbid                                        |                                                              | fail |
| initscripts        | oe_test_service_import-state                                 | preinstall absent/systemd unit restart failure/systemd unit runtime error | fail |
|                    | oe_test_service_loadmodules                                  | preinstall absent/systemd unit restart failure/systemd unit runtime error | fail |
| kernel             | oe_test_hqlogic                                              | 内核模块缺失 qla2xxx                                         | fail |
|                    | oe_test_ipip                                                 | 内核模块缺失 ipip                                            | fail |
|                    | oe_test_kernel_cmd_01                                        | 测试使用 hostnamectl                                         | fail |
|                    | oe_test_lpfc                                                 | 内核模块缺失 lpfc                                            | fail |
|                    | oe_test_qxl                                                  | 内核模块缺失 qxl                                             | fail |
|                    | oe_test_service_cpupower                                     | 测试使用 hostnamectl                                         | fail |
|                    | oe_test_snd_aloop                                            | 内核模块缺失 snd-aloop                                       | fail |
|                    | oe_test_softdog                                              | 内核模块缺失 softdog                                         | fail |
|                    | oe_test_vport-geneve                                         | 内核模块缺失 vport-geneve                                    | fail |
|                    | oe_test_wangxun                                              | 内核模块缺失 ngbe.ko txgbe.ko                                | fail |
|                    | oe_test_xfs                                                  | 内核模块缺失 xfs                                             | fail |
| kmod               | oe_test_rmmod                                                | 内核模块缺失 dm_log dm_mirror dm_region_hash                 | fail |
|                    | oe_test_weak-modules                                         | 镜像没有预装测试所需的 dracut （引入后 Unable to decompress /boot/initramfs-6.1.8-3.oe2303.riscv64.img: Unknown format） | fail |
| libarchive         | oe_test_libarchive_bsdcpio                                   |                                                              | fail |
| lvm2               | oe_test_service_lvmlockd                                     | oerv 缺失软件包 lvm2-locked                                  | fail |
|                    | oe_test_service_lvmlocks                                     | oerv 缺失软件包 lvm2-locked                                  | fail |
| systemd            | oe_test_socket_syslog                                        | 镜像没有预装测试所需的 rsyslog                               | fail |
| ipset              | oe_test_service_ipset_02                                     |                                                              | fail |
|                    | oe_test_ipset_01                                             |                                                              | fail |
| javapackages-tools | oe_test_binary_files_operation                               | file missing                                                 | fail |
|                    | oe_test_build-jar-repository                                 |                                                              | fail |
| libreswan          | oe_test_libreswan_ipsec_addconn                              | timeout                                                      | fail |
|                    | oe_test_libreswan_ipsec_auto_1                               | timeout                                                      | fail |
| libvirt            | oe_test_socket_virtinterfaced-ro                             |                                                              | fail |
|                    | oe_test_socket_virtnetworkd-admin                            |                                                              | fail |
| lksctp-tools       | oe_test_lksctp-tools_checksctp                               |                                                              | fail |
|                    | oe_test_lksctp-tools_sctp_darn_02                            |                                                              | fail |
|                    | oe_test_lksctp-tools_sctp_status                             |                                                              | fail |
|                    | oe_test_lksctp-tools_sctp_test                               |                                                              | fail |
|                    | oe_test_lksctp-tools_sctp_darn_01                            |                                                              | fail |
| lldpad             | oe_test_service_lldpad                                       |                                                              | fail |
| multipath-tools    | oe_test_multipath-tools_kpartx                               |                                                              | fail |
|                    | oe_test_multipath-tools_mpathconf                            |                                                              | fail |
|                    | oe_test_multipath-tools_mpathpersist                         |                                                              | fail |
|                    | oe_test_multipath-tools_multipath_01                         |                                                              | fail |
|                    | oe_test_multipath-tools_multipath_02                         |                                                              | fail |
|                    | oe_test_service_multipathd                                   |                                                              | fail |
| FS_Directory       | oe_test_FSIO_dir_access_etc                                  | /etc文件夹内容与x86不符合                                    | fail |
|                    | oe_test_FSIO_dir_access_proc                                 | /proc/cpuinfo中正常显示cpu信息但无'CPU'关键字                | fail |
|                    | oe_test_FSIO_dir_access_var                                  | /var文件夹内容与x86不符合                                    | fail |
| numad              | oe_test_service_numad                                        | systemd启动失败，原因未知                                    | fail |
| open-iscsi         | oe_test_service_iscsid                                       | systemd unit restart failure/systemd unit runtime error/systemd unit enable failure | fail |
| openvswitch        | oe_test_service_openvswitch                                  | file missing systemd unit restart failure systemd unit runtime error | fail |
|                    | oe_test_service_ovs-vswitchd                                 | file missing systemd unit restart failure systemd unit runtime error | fail |
|                    | oe_test_service_ovsdb-server                                 | file missing systemd unit restart failure systemd unit runtime error | fail |
| os-storage         | oe_test_storage_Mutipath_configure_blacklist                 | kernel module absent                                         | fail |
|                    | oe_test_storage_Mutipath_configure_defaults                  | kernel module absent                                         | fail |
|                    | oe_test_storage_Mutipath_configure_device                    | kernel module absent                                         | fail |
|                    | oe_test_storage_Mutipath_configure_section                   | kernel module absent                                         | fail |
|                    | oe_test_storage_Mutipath_mpathconf                           | kernel module absent                                         | fail |
|                    | oe_test_storage_Mutipath_various_fields                      | kernel module absent                                         | fail |
|                    | oe_test_storage_Mutipath_view_info                           | kernel module absent                                         | fail |
|                    | oe_test_storage_ext3_mount_write                             |                                                              | fail |
|                    | oe_test_storage_ext4_mount                                   |                                                              | fail |
|                    | oe_test_storage_fileCMD_mkfs                                 |                                                              | fail |
|                    | oe_test_storage_fileCMD_pwd                                  | 文件系统中并没有选择测试的目录，使用mkdir事先建立对应目录可过，建议加入pre_test中 | fail |
|                    | oe_test_storage_lvm_set_regionsize                           | kernel module absent                                         | fail |
|                    | oe_test_storage_smb_cmd_smbcontrol                           | 运行软件时需要加载libmessages-util-samba4.so，在LD_LIBRARY_PATH环境变量相同时，x86环境下运行可自动找到对应文件，但riscv下无法找到，只有将对应lib的文件路径赋值到环境变量时才可正常运行 | fail |
|                    | oe_test_storage_smb_cmd_smbpasswd                            | 运行软件时需要加载libmessages-util-samba4.so，在LD_LIBRARY_PATH环境变量相同时，x86环境下运行可自动找到对应文件，但riscv下无法找到，只有将对应lib的文件路径赋值到环境变量时才可正常运行 | fail |
|                    | oe_test_storage_smb_cmd_smbstatus                            | 运行软件时需要加载libmessages-util-samba4.so，在LD_LIBRARY_PATH环境变量相同时，x86环境下运行可自动找到对应文件，但riscv下无法找到，只有将对应lib的文件路径赋值到环境变量时才可正常运行 | fail |
|                    | oe_test_storage_smb_cmd_testparm                             | 运行软件时需要加载libserver-role-samba4.so，在LD_LIBRARY_PATH环境变量相同时，x86环境下运行可自动找到对应文件，但riscv下无法找到，只有将对应lib的文件路径赋值到环境变量时才可正常运行 | fail |
|                    | oe_test_storage_smb_guest_share                              | 同上缺失lib文件，不过上面两个lib文件都需加载                 | fail |
|                    | oe_test_storage_xfs_restore                                  | xfsdemp error                                                | fail |
| pcp                | oe_test_service_pmmgr                                        | file missing systemd unit restart failure systemd unit runtime error | fail |
|                    | oe_test_service_pmwebd                                       | file missing systemd unit restart failure systemd unit runtime error | fail |
| pigz               | oe_test_pigz                                                 |                                                              | fail |
| psacct             | oe_test_psacct                                               |                                                              | fail |
|                    | oe_test_service_psacct                                       |                                                              | fail |
| quota              | oe_test_service_quota_nld                                    |                                                              | fail |
| rasdaemon          | oe_test_service_ras-mc-ctl                                   |                                                              | fail |
| rdma-core          | oe_test_socket_ibacm                                         |                                                              | fail |
| realmd             | oe_test_service_realmd                                       |                                                              | fail |
| rpmdevtools        | oe_test_rpmdevtools_rpmdev-wipetree                          | Broken testcase/preinstall absent/timeout                    | fail |
| samba              | oe_test_service_nmb                                          | systemd unit restart failure/systemd unit runtime error/systemd unit enable failure | fail |
|                    | oe_test_service_smb                                          | systemd unit restart failure/systemd unit runtime error/systemd unit enable failure | fail |
|                    | oe_test_service_winbind                                      | systemd unit restart failure/systemd unit runtime error/systemd unit enable failure | fail |
| sanlock            | oe_test_sanlock_wdmd                                         | Module softdog not found                                     | fail |
| security-tool      | oe_test_security_tool                                        |                                                              | fail |
|                    | oe_test_service_openEuler-security                           |                                                              | fail |
| smoke-basic-os     | oe_test_CPUinfo_001                                          | file missing/timeout                                         | fail |
|                    | oe_test_bbr_02                                               | preinstall absent                                            | fail |
|                    | oe_test_bbr_04                                               | kernel module absent                                         | fail |
|                    | oe_test_bonding_SCEN_05                                      | preinstall absent kernel module absent                       | fail |
|                    | oe_test_criu                                                 | file missing                                                 | fail |
|                    | oe_test_gcc_001                                              | file missing                                                 | fail |
|                    | oe_test_ip_rule_01                                           |                                                              | fail |
|                    | oe_test_ip_rule_02                                           |                                                              | fail |
|                    | oe_test_iscsi                                                |                                                              | fail |
|                    | oe_test_iscsid                                               |                                                              | fail |
|                    | oe_test_libcgroup_04                                         |                                                              | fail |
|                    | oe_test_ncurses                                              |                                                              | fail |
|                    | oe_test_numactl                                              |                                                              | fail |
|                    | oe_test_perf                                                 | timeout                                                      | fail |
|                    | oe_test_pwd_001                                              | preinstall absent                                            | fail |
|                    | oe_test_rollback                                             |                                                              | fail |
|                    | oe_test_rule_ipv6                                            |                                                              | fail |
|                    | oe_test_service                                              | preinstall absent                                            | fail |
|                    | oe_test_skopeo                                               | choosing image instance: no image found in manifest list for architecture riscv64 | fail |
|                    | oe_test_syslog_logrotate_001                                 | preinstall absent                                            | fail |
|                    | oe_test_user_debug_iotop_03                                  | file missing                                                 | fail |
|                    | oe_test_yumgroup_001                                         |                                                              | fail |
|                    | oe_test_MEMinfo_001                                          | file missing                                                 | fail |
|                    | oe_test_perf_top_01                                          | file missing                                                 | fail |
| strongswan         | oe_test_service_strongswan_02                                | pre_test时podman出现堆栈错误导致后续软件运行错误             | fail |
|                    | oe_test_service_swanctl_01                                   | pre_test时podman出现堆栈错误导致后续软件运行错误             | fail |
|                    | oe_test_service_swanctl_02                                   | pre_test时podman出现堆栈错误导致后续软件运行错误             | fail |
| udisks2            | oe_test_service_udisks2                                      | Failed to load module: /usr/lib64/gio/modules/libgvfsdbus.so | fail |
| vdo                | oe_test_service_vdo                                          | nothing provides kmod-kvdo                                   | fail |
| amanda             | oe_test_amanda_amcheck                                       |                                                              | fail |
| openssh            | oe_test_openssh_cipher                                       |                                                              | fail |
|                    | oe_test_openssh_locked                                       | preinstall absent/timeout                                    | fail |
|                    | oe_test_openssh_no_password                                  | preinstall absent/timeout                                    | fail |
|                    | oe_test_openssh_scp                                          | preinstall absent/timeout                                    | fail |
|                    | oe_test_openssh_scp_P                                        | preinstall absent/timeout                                    | fail |
|                    | oe_test_openssh_scp_q                                        | preinstall absent/timeout                                    | fail |
| python-rtslib      | oe_test_service_target                                       |                                                              | fail |



#### 

## x86 fail

此表内的测试套和测试用例均为在x86上和riscv上均失败的测试用例

| 测试套/软件包名                    | 测试用例名                                              | 状态     | 原因     |
| ---------------------------------- | ------------------------------------------------------- | -------- | -------- |
| os-basic                           | oe_test_auditctl                                        | x86 fail | x86 fail |
|                                    | oe_test_catman                                          | x86 fail | x86 fail |
|                                    | oe_test_dmraid                                          | x86 fail | x86 fail |
|                                    | oe_test_nmcli_config_connect                            | x86 fail | x86 fail |
|                                    | oe_test_nmcli_macsec                                    | x86 fail | x86 fail |
|                                    | oe_test_power_powertop2tuned_optimize                   | x86 fail | x86 fail |
|                                    | oe_test_power_powertop_powerup                          | x86 fail | x86 fail |
|                                    | oe_test_reboot                                          | x86 fail | x86 fail |
|                                    | oe_test_server_mariadb_compatibilty                     | x86 fail | x86 fail |
|                                    | oe_test_server_openssh_verifykey                        | x86 fail | x86 fail |
|                                    | oe_test_server_squid_blacklist                          | x86 fail | x86 fail |
|                                    | oe_test_server_vsftpd_NKdelay                           | x86 fail | x86 fail |
|                                    | oe_test_server_vsftpd_transfer                          | x86 fail | x86 fail |
|                                    | oe_test_sos                                             | x86 fail | x86 fail |
|                                    | oe_test_system_log_recorded                             | x86 fail | x86 fail |
|                                    | oe_test_system_monitor_login                            | x86 fail | x86 fail |
|                                    | oe_test_system_monitor_reboot                           | x86 fail | x86 fail |
|                                    | oe_test_uname                                           | x86 fail | x86 fail |
|                                    | oe_test_whereis                                         | x86 fail | x86 fail |
| AT                                 | oe_test_cat_001                                         | x86 fail | x86 fail |
|                                    | oe_test_dmesg_messages_log                              | x86 fail | x86 fail |
|                                    | oe_test_docker_custom_image                             | x86 fail | x86 fail |
|                                    | oe_test_firewalld                                       | x86 fail | x86 fail |
|                                    | oe_test_network_001                                     | x86 fail | x86 fail |
|                                    | oe_test_partition                                       | x86 fail | x86 fail |
| acl                                | oe_test_access_providepam                               | x86 fail | x86 fail |
| alsa-utils                         | oe_test_service_alsa-restore                            | x86 fail | x86 fail |
| anaconda                           | oe_test_service_zram                                    | x86 fail | x86 fail |
| ansible                            | oe_test_ansible_04                                      | x86 fail | x86 fail |
| aspell                             | oe_test_aspell_01                                       | x86 fail | x86 fail |
| aspell                             | oe_test_service_atuned                                  | x86 fail | x86 fail |
|                                    | oe_test_service_atuned_01                               | x86 fail | x86 fail |
|                                    | oe_test_service_atuned_02                               | x86 fail | x86 fail |
|                                    | oe_test_service_atuned_03                               | x86 fail | x86 fail |
|                                    | oe_test_service_atuned_04                               | x86 fail | x86 fail |
|                                    | oe_test_service_atuned_05                               | x86 fail | x86 fail |
|                                    | oe_test_service_atuned_06                               | x86 fail | x86 fail |
|                                    | oe_test_service_atuned_07                               | x86 fail | x86 fail |
|                                    | oe_test_service_atuned_08                               | x86 fail | x86 fail |
|                                    | oe_test_service_atuned_09                               | x86 fail | x86 fail |
| audit                              | oe_test_audit_ausearch                                  | x86 fail | x86 fail |
|                                    | oe_test_audit_available_disk_space                      | x86 fail | x86 fail |
|                                    | oe_test_audit_count_number_of_event                     | x86 fail | x86 fail |
|                                    | oe_test_audit_count_time                                | x86 fail | x86 fail |
|                                    | oe_test_audit_event_log                                 | x86 fail | x86 fail |
|                                    | oe_test_audit_fetch_file_in_order                       | x86 fail | x86 fail |
|                                    | oe_test_audit_max_log_file_ignore                       | x86 fail | x86 fail |
|                                    | oe_test_audit_max_log_file_keep_logs                    | x86 fail | x86 fail |
|                                    | oe_test_audit_max_log_file_rotate                       | x86 fail | x86 fail |
|                                    | oe_test_audit_max_log_file_suspend                      | x86 fail | x86 fail |
|                                    | oe_test_audit_max_log_file_syslog                       | x86 fail | x86 fail |
|                                    | oe_test_audit_monitor_dictionary_access                 | x86 fail | x86 fail |
|                                    | oe_test_audit_monitor_do_command                        | x86 fail | x86 fail |
|                                    | oe_test_audit_monitor_file_access                       | x86 fail | x86 fail |
|                                    | oe_test_audit_monitor_network_visit                     | x86 fail | x86 fail |
|                                    | oe_test_audit_monitor_system_use                        | x86 fail | x86 fail |
|                                    | oe_test_audit_other                                     | x86 fail | x86 fail |
|                                    | oe_test_audit_rule_conflict_strategy                    | x86 fail | x86 fail |
|                                    | oe_test_audit_rule_contact_strategy                     | x86 fail | x86 fail |
|                                    | oe_test_audit_rule_fetch_from_rule                      | x86 fail | x86 fail |
|                                    | oe_test_audit_show_event_list                           | x86 fail | x86 fail |
|                                    | oe_test_audit_track_designated_access                   | x86 fail | x86 fail |
|                                    | oe_test_audit_use_d_audit                               | x86 fail | x86 fail |
|                                    | oe_test_audit_use_w_audit                               | x86 fail | x86 fail |
|                                    | oe_test_audit_user_build_connection                     | x86 fail | x86 fail |
|                                    | oe_test_aulastlog                                       | x86 fail | x86 fail |
|                                    | oe_test_inject_time_fault                               | x86 fail | x86 fail |
|                                    | oe_test_service_auditd                                  | x86 fail | x86 fail |
|                                    | oe_test_start_audit                                     | x86 fail | x86 fail |
| auter                              | oe_test_auter                                           | x86 fail | x86 fail |
| autofs                             | oe_test_autofs                                          | x86 fail | x86 fail |
|                                    | oe_test_service_autofs                                  | x86 fail | x86 fail |
| ceph                               | oe_test_service_rbdmap                                  | x86 fail | x86 fail |
|                                    | oe_test_target_ceph                                     | x86 fail | x86 fail |
| chrony                             | oe_test_service_chrony-wait                             | x86 fail | x86 fail |
| clamav                             | oe_test_clamav_clamdtop                                 | x86 fail | x86 fail |
|                                    | oe_test_clamav_clamonacc                                | x86 fail | x86 fail |
|                                    | oe_test_clamav_clamscan_1                               | x86 fail | x86 fail |
|                                    | oe_test_clamav_clamscan_2                               | x86 fail | x86 fail |
|                                    | oe_test_clamav_clamscan_3                               | x86 fail | x86 fail |
|                                    | oe_test_service_clamav-clamonacc                        | x86 fail | x86 fail |
| cmake                              | oe_test_ccmake                                          | x86 fail | x86 fail |
|                                    | oe_test_ccmake3                                         | x86 fail | x86 fail |
| cobbler                            | oe_test_cobbler_distro                                  | x86 fail | x86 fail |
|                                    | oe_test_cobbler_file                                    | x86 fail | x86 fail |
|                                    | oe_test_cobbler_image                                   | x86 fail | x86 fail |
|                                    | oe_test_cobbler_mgmtclass                               | x86 fail | x86 fail |
|                                    | oe_test_cobbler_other                                   | x86 fail | x86 fail |
|                                    | oe_test_cobbler_package                                 | x86 fail | x86 fail |
|                                    | oe_test_cobbler_profile                                 | x86 fail | x86 fail |
|                                    | oe_test_cobbler_repo                                    | x86 fail | x86 fail |
|                                    | oe_test_cobbler_system                                  | x86 fail | x86 fail |
| cockpit                            | oe_test_service_cockpit                                 | x86 fail | x86 fail |
|                                    | oe_test_socket_cockpit                                  | x86 fail | x86 fail |
| conntrack-tools                    | oe_test_service_conntrackd                              | x86 fail | x86 fail |
| corosync-qdevice                   | oe_test_service_corosync-qdevice                        | x86 fail | x86 fail |
| corosync                           | oe_test_service_corosync-notifyd                        | x86 fail | x86 fail |
|                                    | oe_test_service_corosync                                | x86 fail | x86 fail |
|                                    | oe_test_service_spausedd                                | x86 fail | x86 fail |
| cppcheck                           | oe_test_cppcheck                                        | x86 fail | x86 fail |
| crontabs                           | oe_test_crontabs                                        | x86 fail | x86 fail |
| dblatex                            | oe_test_dblatex_dblatex_01                              | x86 fail | x86 fail |
|                                    | oe_test_dblatex_dblatex_02                              | x86 fail | x86 fail |
|                                    | oe_test_dblatex_dblatex_03                              | x86 fail | x86 fail |
|                                    | oe_test_dblatex_dblatex_04                              | x86 fail | x86 fail |
|                                    | oe_test_dblatex_dblatex_05                              | x86 fail | x86 fail |
|                                    | oe_test_dblatex_dblatex_06                              | x86 fail | x86 fail |
| dbxtool                            | oe_test_service_dbxtool                                 | x86 fail | x86 fail |
| dejagnu                            | oe_test_dejagnu_runtest_01                              | x86 fail | x86 fail |
| derby                              | oe_test_service_derby                                   | x86 fail | x86 fail |
| dhcp                               | oe_test_service_dhcpd                                   | x86 fail | x86 fail |
|                                    | oe_test_service_dhcpd6                                  | x86 fail | x86 fail |
| digest-list-tools                  | oe_test_service_setup-ima-digest-lists                  | x86 fail | x86 fail |
| dmidecode                          | oe_test_dmidecode                                       | x86 fail | x86 fail |
| dnf                                | oe_test_dnf_enabled_enablerepo                          | x86 fail | x86 fail |
|                                    | oe_test_dnf_list_mark                                   | x86 fail | x86 fail |
|                                    | oe_test_dnf_reinstall_repoinfo                          | x86 fail | x86 fail |
|                                    | oe_test_dnf_repeat-upgrade-downgrade                    | x86 fail | x86 fail |
| docker-engine                      | oe_test_service_docker                                  | x86 fail | x86 fail |
| easymock                           | oe_test_easymock_spring                                 | x86 fail | x86 fail |
| ebtables                           | oe_test_service_ebtables                                | x86 fail | x86 fail |
| etcd                               | oe_test_etcd_03                                         | x86 fail | x86 fail |
|                                    | oe_test_etcd_05                                         | x86 fail | x86 fail |
| fastdfs                            | oe_test_fastdfs_01                                      | x86 fail | x86 fail |
|                                    | oe_test_fastdfs_02                                      | x86 fail | x86 fail |
|                                    | oe_test_fastdfs_03                                      | x86 fail | x86 fail |
|                                    | oe_test_fastdfs_04                                      | x86 fail | x86 fail |
| fcgi                               | oe_test_fcgi                                            | x86 fail | x86 fail |
| fftw                               | oe_test_fftw_fftw-wisdom-to-conf                        | x86 fail | x86 fail |
|                                    | oe_test_fftw_fftw-wisdom_02                             | x86 fail | x86 fail |
|                                    | oe_test_fftw_fftwf-wisdom_02                            | x86 fail | x86 fail |
|                                    | oe_test_fftw_fftwl-wisdom_02                            | x86 fail | x86 fail |
| firebird                           | oe_test_service_firebird-superserver                    | x86 fail | x86 fail |
| firewalld                          | oe_test_firewalld_add_newservice                        | x86 fail | x86 fail |
|                                    | oe_test_firewalld_add_port                              | x86 fail | x86 fail |
|                                    | oe_test_firewalld_add_service                           | x86 fail | x86 fail |
|                                    | oe_test_firewalld_add_sourceip                          | x86 fail | x86 fail |
|                                    | oe_test_firewalld_add_sourceport                        | x86 fail | x86 fail |
|                                    | oe_test_firewalld_addport_udp                           | x86 fail | x86 fail |
|                                    | oe_test_firewalld_allow_zones                           | x86 fail | x86 fail |
|                                    | oe_test_firewalld_block_icmp                            | x86 fail | x86 fail |
|                                    | oe_test_firewalld_change_interface                      | x86 fail | x86 fail |
|                                    | oe_test_firewalld_change_xml                            | x86 fail | x86 fail |
|                                    | oe_test_firewalld_directrule_acceptdport                | x86 fail | x86 fail |
|                                    | oe_test_firewalld_dnat                                  | x86 fail | x86 fail |
|                                    | oe_test_firewalld_dropzone_service                      | x86 fail | x86 fail |
|                                    | oe_test_firewalld_forward_nat                           | x86 fail | x86 fail |
|                                    | oe_test_firewalld_getzone                               | x86 fail | x86 fail |
|                                    | oe_test_firewalld_ip_camouflage                         | x86 fail | x86 fail |
|                                    | oe_test_firewalld_list                                  | x86 fail | x86 fail |
|                                    | oe_test_firewalld_lockdown                              | x86 fail | x86 fail |
|                                    | oe_test_firewalld_log_denied                            | x86 fail | x86 fail |
|                                    | oe_test_firewalld_new_zone                              | x86 fail | x86 fail |
|                                    | oe_test_firewalld_panic_on                              | x86 fail | x86 fail |
|                                    | oe_test_firewalld_port_map                              | x86 fail | x86 fail |
|                                    | oe_test_firewalld_protocol_tcp                          | x86 fail | x86 fail |
|                                    | oe_test_firewalld_richrule_acceptsource                 | x86 fail | x86 fail |
|                                    | oe_test_firewalld_richrule_allowippak                   | x86 fail | x86 fail |
|                                    | oe_test_firewalld_richrule_blacklist                    | x86 fail | x86 fail |
|                                    | oe_test_firewalld_richrule_dropicmppack                 | x86 fail | x86 fail |
|                                    | oe_test_firewalld_richrule_dropipv4pak                  | x86 fail | x86 fail |
|                                    | oe_test_firewalld_richrule_forwardport                  | x86 fail | x86 fail |
|                                    | oe_test_firewalld_runtime_permanent                     | x86 fail | x86 fail |
|                                    | oe_test_firewalld_set_defaultzone                       | x86 fail | x86 fail |
|                                    | oe_test_firewalld_set_ipset                             | x86 fail | x86 fail |
|                                    | oe_test_firewalld_set_target                            | x86 fail | x86 fail |
|                                    | oe_test_firewalld_start_check                           | x86 fail | x86 fail |
|                                    | oe_test_firewalld_start_status                          | x86 fail | x86 fail |
|                                    | oe_test_firewalld_start_stop                            | x86 fail | x86 fail |
|                                    | oe_test_firewalld_whitelist_command                     | x86 fail | x86 fail |
|                                    | oe_test_firewalld_whitelist_contexts                    | x86 fail | x86 fail |
|                                    | oe_test_firewalld_whitelist_uids                        | x86 fail | x86 fail |
|                                    | oe_test_firewalld_whitelist_user                        | x86 fail | x86 fail |
|                                    | oe_test_firewalld_zone_add_service                      | x86 fail | x86 fail |
|                                    | oe_test_firewalld_zone_migration                        | x86 fail | x86 fail |
|                                    | oe_test_service_firewalld                               | x86 fail | x86 fail |
| freeipmi                           | oe_test_service_bmc-watchdog                            | x86 fail | x86 fail |
|                                    | oe_test_service_ipmidetectd                             | x86 fail | x86 fail |
|                                    | oe_test_service_ipmiseld                                | x86 fail | x86 fail |
| freeradius                         | oe_test_freeradius_freeradius-utils_radlast             | x86 fail | x86 fail |
|                                    | oe_test_freeradius_freeradius-utils_radlastAndRadsniff  | x86 fail | x86 fail |
|                                    | oe_test_freeradius_freeradius-utils_radsniff            | x86 fail | x86 fail |
|                                    | oe_test_freeradius_freeradius-utils_radsniff2           | x86 fail | x86 fail |
|                                    | oe_test_freeradius_freeradius-utils_radsqlrelay         | x86 fail | x86 fail |
|                                    | oe_test_freeradius_freeradius-utils_radtestAndRadwho    | x86 fail | x86 fail |
| gradle                             | oe_test_gradle_01                                       | x86 fail | x86 fail |
|                                    | oe_test_gradle_02                                       | x86 fail | x86 fail |
|                                    | oe_test_gradle_03                                       | x86 fail | x86 fail |
|                                    | oe_test_gradle_04                                       | x86 fail | x86 fail |
| groovy                             | oe_test_groovy_01                                       | x86 fail | x86 fail |
|                                    | oe_test_groovy_02                                       | x86 fail | x86 fail |
| hostname                           | oe_test_service_nis-domainname                          | x86 fail | x86 fail |
| iSulad                             | oe_test_service_isulad                                  | x86 fail | x86 fail |
| iftop                              | oe_test_iftop_config                                    | x86 fail | x86 fail |
|                                    | oe_test_iftop_gui                                       | x86 fail | x86 fail |
|                                    | oe_test_iftop_text_mode                                 | x86 fail | x86 fail |
| initscripts                        | oe_test_service_netconsole                              | x86 fail | x86 fail |
|                                    | oe_test_service_network                                 | x86 fail | x86 fail |
| iputils                            | oe_test_service_ninfod                                  | x86 fail | x86 fail |
|                                    | oe_test_service_rdisc                                   | x86 fail | x86 fail |
| kernel                             | oe_test_check_huge_task                                 | x86 fail | x86 fail |
|                                    | oe_test_cifs                                            | x86 fail | x86 fail |
|                                    | oe_test_cpu_rand                                        | x86 fail | x86 fail |
|                                    | oe_test_hinic                                           | x86 fail | x86 fail |
|                                    | oe_test_io_sched                                        | x86 fail | x86 fail |
|                                    | oe_test_swap_compress                                   | x86 fail | x86 fail |
| kmod                               | oe_test_depmod                                          | x86 fail | x86 fail |
|                                    | oe_test_insmod-lsmod                                    | x86 fail | x86 fail |
|                                    | oe_test_modinfo                                         | x86 fail | x86 fail |
|                                    | oe_test_modprobe                                        | x86 fail | x86 fail |
| lvm2                               | oe_test_lvm2_pvchange_001                               | x86 fail | x86 fail |
|                                    | oe_test_lvm2_pvcreate_001                               | x86 fail | x86 fail |
|                                    | oe_test_lvm2_pvcreate_002                               | x86 fail | x86 fail |
|                                    | oe_test_lvm2_pvdisplay_001                              | x86 fail | x86 fail |
|                                    | oe_test_lvm2_pvdisplay_002                              | x86 fail | x86 fail |
|                                    | oe_test_lvm2_pvmove_001                                 | x86 fail | x86 fail |
|                                    | oe_test_lvm2_pvmove_002                                 | x86 fail | x86 fail |
|                                    | oe_test_lvm2_pvremove_001                               | x86 fail | x86 fail |
|                                    | oe_test_lvm2_pvresize_001                               | x86 fail | x86 fail |
|                                    | oe_test_lvm2_vgchange_001                               | x86 fail | x86 fail |
|                                    | oe_test_lvm2_vgchange_002                               | x86 fail | x86 fail |
|                                    | oe_test_lvm2_vgcreate_001                               | x86 fail | x86 fail |
|                                    | oe_test_lvm2_vgdisplay_001                              | x86 fail | x86 fail |
|                                    | oe_test_lvm2_vgexport_001                               | x86 fail | x86 fail |
|                                    | oe_test_lvm2_vgextend_001                               | x86 fail | x86 fail |
|                                    | oe_test_lvm2_vgextend_002                               | x86 fail | x86 fail |
|                                    | oe_test_lvm2_vgrename_001                               | x86 fail | x86 fail |
|                                    | oe_test_service_lvm2-lvmpolld                           | x86 fail | x86 fail |
|                                    | oe_test_service_lvm2-monitor                            | x86 fail | x86 fail |
| net-tools                          | oe_test_net-tools_ipmaddr                               | x86 fail | x86 fail |
|                                    | oe_test_net-tools_route                                 | x86 fail | x86 fail |
| openssl                            | oe_test_openssl_DSA_algorithm                           | x86 fail | x86 fail |
|                                    | oe_test_openssl_Diffie_Hellman                          | x86 fail | x86 fail |
|                                    | oe_test_openssl_Implements_https                        | x86 fail | x86 fail |
|                                    | oe_test_openssl_RSA_algorithm                           | x86 fail | x86 fail |
|                                    | oe_test_openssl_create_CA_applying_certificate          | x86 fail | x86 fail |
|                                    | oe_test_openssl_delete_configuration_file               | x86 fail | x86 fail |
|                                    | oe_test_openssl_empty_private_key                       | x86 fail | x86 fail |
|                                    | oe_test_openssl_empty_public_key                        | x86 fail | x86 fail |
|                                    | oe_test_openssl_encrypt_decrypt_file_asymmetrically     | x86 fail | x86 fail |
|                                    | oe_test_openssl_encrypte_decrypte_emails                | x86 fail | x86 fail |
|                                    | oe_test_openssl_expired_certificate                     | x86 fail | x86 fail |
|                                    | oe_test_openssl_file_signature_verification             | x86 fail | x86 fail |
|                                    | oe_test_openssl_generate_key_pair                       | x86 fail | x86 fail |
|                                    | oe_test_openssl_generate_password                       | x86 fail | x86 fail |
|                                    | oe_test_openssl_incorrect_public_private_key            | x86 fail | x86 fail |
|                                    | oe_test_openssl_rc4_encryption_file                     | x86 fail | x86 fail |
|                                    | oe_test_openssl_reliability                             | x86 fail | x86 fail |
|                                    | oe_test_openssl_remove_mod_ssl                          | x86 fail | x86 fail |
|                                    | oe_test_openssl_repeat_restart                          | x86 fail | x86 fail |
|                                    | oe_test_openssl_speed                                   | x86 fail | x86 fail |
| osc                                | oe_test_osc_04                                          | x86 fail | x86 fail |
|                                    | oe_test_osc_build                                       | x86 fail | x86 fail |
| systemd                            | oe_test_service_console-getty                           | x86 fail | x86 fail |
|                                    | oe_test_service_dbus-org.freedesktop.import1            | x86 fail | x86 fail |
|                                    | oe_test_service_dbus-org.freedesktop.portable1          | x86 fail | x86 fail |
|                                    | oe_test_service_initrd-switch-root                      | x86 fail | x86 fail |
|                                    | oe_test_service_quotaon                                 | x86 fail | x86 fail |
|                                    | oe_test_service_systemd-ask-password-wall               | x86 fail | x86 fail |
|                                    | oe_test_service_systemd-fsck-root                       | x86 fail | x86 fail |
|                                    | oe_test_service_systemd-importd                         | x86 fail | x86 fail |
|                                    | oe_test_service_systemd-initctl                         | x86 fail | x86 fail |
|                                    | oe_test_service_systemd-journal-gatewayd                | x86 fail | x86 fail |
|                                    | oe_test_service_systemd-journal-remote                  | x86 fail | x86 fail |
|                                    | oe_test_service_systemd-journal-upload                  | x86 fail | x86 fail |
|                                    | oe_test_service_systemd-network-generator               | x86 fail | x86 fail |
|                                    | oe_test_service_systemd-networkd-wait-online            | x86 fail | x86 fail |
|                                    | oe_test_service_systemd-networkd                        | x86 fail | x86 fail |
|                                    | oe_test_service_systemd-portabled                       | x86 fail | x86 fail |
|                                    | oe_test_service_systemd-quotacheck                      | x86 fail | x86 fail |
|                                    | oe_test_service_systemd-resolved                        | x86 fail | x86 fail |
|                                    | oe_test_service_systemd-sysext                          | x86 fail | x86 fail |
|                                    | oe_test_service_systemd-udevd                           | x86 fail | x86 fail |
|                                    | oe_test_service_systemd-userdbd                         | x86 fail | x86 fail |
|                                    | oe_test_socket_systemd-journal-gatewayd                 | x86 fail | x86 fail |
|                                    | oe_test_socket_systemd-journal-remote                   | x86 fail | x86 fail |
|                                    | oe_test_socket_systemd-journald-dev-log                 | x86 fail | x86 fail |
|                                    | oe_test_socket_systemd-networkd                         | x86 fail | x86 fail |
|                                    | oe_test_socket_systemd-rfkill                           | x86 fail | x86 fail |
|                                    | oe_test_socket_systemd-userdbd                          | x86 fail | x86 fail |
|                                    | oe_test_target_cryptsetup-pre                           | x86 fail | x86 fail |
|                                    | oe_test_target_cryptsetup                               | x86 fail | x86 fail |
|                                    | oe_test_target_initrd-switch-root                       | x86 fail | x86 fail |
|                                    | oe_test_target_remote-cryptsetup                        | x86 fail | x86 fail |
|                                    | oe_test_target_remote-veritysetup                       | x86 fail | x86 fail |
|                                    | oe_test_target_usb-gadget                               | x86 fail | x86 fail |
|                                    | oe_test_target_veritysetup-pre                          | x86 fail | x86 fail |
|                                    | oe_test_target_veritysetup                              | x86 fail | x86 fail |
| iperf3                             | oe_test_iperf3_command_client                           | x86 fail | x86 fail |
|                                    | oe_test_iperf3_command_clientAndShared                  | x86 fail | x86 fail |
|                                    | oe_test_iperf3_command_serverAndBase                    | x86 fail | x86 fail |
| ipmitool                           | oe_test_service_bmc-snmp-proxy                          | x86 fail | x86 fail |
|                                    | oe_test_service_exchange-bmc-os-info                    | x86 fail | x86 fail |
|                                    | oe_test_service_ipmievd                                 | x86 fail | x86 fail |
| iprutils                           | oe_test_service_iprdump                                 | x86 fail | x86 fail |
|                                    | oe_test_service_iprinit                                 | x86 fail | x86 fail |
|                                    | oe_test_service_iprupdate                               | x86 fail | x86 fail |
|                                    | oe_test_target_iprutils                                 | x86 fail | x86 fail |
| ipset                              | oe_test_service_ipset                                   | x86 fail | x86 fail |
| iptables                           | oe_test_service_ip6tables                               | x86 fail | x86 fail |
|                                    | oe_test_service_iptables                                | x86 fail | x86 fail |
|                                    | oe_test_iptables-restore                                | x86 fail | x86 fail |
|                                    | oe_test_ip6tables-save                                  | x86 fail | x86 fail |
|                                    | oe_test_ip6tables-restore_01                            | x86 fail | x86 fail |
| ipvsadm                            | oe_test_ipvs_ADD_01                                     | x86 fail | x86 fail |
|                                    | oe_test_ipvs_DEL_01                                     | x86 fail | x86 fail |
|                                    | oe_test_ipvs_MOD_01                                     | x86 fail | x86 fail |
|                                    | oe_test_ipvs_SAVE_01                                    | x86 fail | x86 fail |
|                                    | oe_test_ipvs_SCEN_DR_05                                 | x86 fail | x86 fail |
|                                    | oe_test_ipvs_SCEN_DR_06                                 | x86 fail | x86 fail |
|                                    | oe_test_ipvs_SCEN_TUN_05                                | x86 fail | x86 fail |
|                                    | oe_test_ipvs_SCEN_TUN_06                                | x86 fail | x86 fail |
|                                    | oe_test_ipvs_WRONG_COMMAND_01                           | x86 fail | x86 fail |
| irqbalance                         | oe_test_service_irqbalance                              | x86 fail | x86 fail |
| java-1.8.0-openjdk                 | oe_test_openjdk_appletviewer_clhsdb                     | x86 fail | x86 fail |
|                                    | oe_test_openjdk_java_javac                              | x86 fail | x86 fail |
| javapackages-tools                 | oe_test_build-classpath                                 | x86 fail | x86 fail |
|                                    | oe_test_find-shade-jar                                  | x86 fail | x86 fail |
|                                    | oe_test_gradle-local                                    | x86 fail | x86 fail |
| jetty                              | oe_test_jetty_start                                     | x86 fail | x86 fail |
|                                    | oe_test_service_jetty                                   | x86 fail | x86 fail |
| junit5                             | oe_test_junit5_gradle                                   | x86 fail | x86 fail |
|                                    | oe_test_junit5_kotlin_maven                             | x86 fail | x86 fail |
|                                    | oe_test_junit5_noimport                                 | x86 fail | x86 fail |
| jython                             | oe_test_jython_01                                       | x86 fail | x86 fail |
|                                    | oe_test_jython_02                                       | x86 fail | x86 fail |
|                                    | oe_test_jython_03                                       | x86 fail | x86 fail |
| keepalived                         | oe_test_service_keepalived                              | x86 fail | x86 fail |
| kexec-tools                        | oe_test_service_kdump                                   | x86 fail | x86 fail |
| keyutils                           | oe_test_keyutils-api                                    | x86 fail | x86 fail |
| kubernetes                         | oe_test_service_kube-controller-manager                 | x86 fail | x86 fail |
| libappstream-glib                  | oe_test_libappstream-glib_appstream-util_03             | x86 fail | x86 fail |
| libfabric                          | oe_test_libfabric_fi_info_01                            | x86 fail | x86 fail |
|                                    | oe_test_libfabric_fi_info_02                            | x86 fail | x86 fail |
| libosinfo                          | oe_test_osinfo-detect                                   | x86 fail | x86 fail |
|                                    | oe_test_osinfo-db-import                                | x86 fail | x86 fail |
| libreswan                          | oe_test_libreswan_ipsec_auto_2                          | x86 fail | x86 fail |
|                                    | oe_test_libreswan_ipsec_setup                           | x86 fail | x86 fail |
|                                    | oe_test_libreswan_ipsec_showhostkey_nss                 | x86 fail | x86 fail |
|                                    | oe_test_libreswan_ipsec_systemctl                       | x86 fail | x86 fail |
|                                    | oe_test_service_ipsec                                   | x86 fail | x86 fail |
|                                    | oe_test_host_to_host_vpn                                | x86 fail | x86 fail |
|                                    | oe_test_site_to_site_vpn                                | x86 fail | x86 fail |
| libwmf                             | oe_test_libwmf_libwmf-fontmap                           | x86 fail | x86 fail |
|                                    | oe_test_libwmf_wmf2x_02                                 | x86 fail | x86 fail |
| linuxptp                           | oe_test_service_phc2sys                                 | x86 fail | x86 fail |
|                                    | oe_test_service_ptp4l                                   | x86 fail | x86 fail |
|                                    | oe_test_pmc                                             | x86 fail | x86 fail |
|                                    | oe_test_ptp4l_01                                        | x86 fail | x86 fail |
|                                    | oe_test_ptp4l_02                                        | x86 fail | x86 fail |
|                                    | oe_test_timemaster                                      | x86 fail | x86 fail |
| lm_sensors                         | oe_test_service_fancontrol                              | x86 fail | x86 fail |
|                                    | oe_test_service_lm_sensors                              | x86 fail | x86 fail |
| lxc                                | oe_test_service_lxc-net                                 | x86 fail | x86 fail |
|                                    | oe_test_lxc_create_attach                               | x86 fail | x86 fail |
|                                    | oe_test_lxc_ls_monitor                                  | x86 fail | x86 fail |
|                                    | oe_test_lxc_unfreeze_destroy                            | x86 fail | x86 fail |
|                                    | oe_test_lxc_autostart_cgroup                            | x86 fail | x86 fail |
|                                    | oe_test_lxc_device_copy                                 | x86 fail | x86 fail |
|                                    | oe_test_lxc_snapshot_start                              | x86 fail | x86 fail |
|                                    | oe_test_lxc_stop_top                                    | x86 fail | x86 fail |
|                                    | oe_test_lxc_info                                        | x86 fail | x86 fail |
| mailman                            | oe_test_service_mailman                                 | x86 fail | x86 fail |
| mc                                 | oe_test_mc_base_01                                      | x86 fail | x86 fail |
|                                    | oe_test_mcedit_base_01                                  | x86 fail | x86 fail |
|                                    | oe_test_mcview_base_01                                  | x86 fail | x86 fail |
| mcstrans                           | oe_test_service_mcstransd                               | x86 fail | x86 fail |
|                                    | oe_test_service_mcstrans                                | x86 fail | x86 fail |
| mdadm                              | oe_test_service_mdmonitor                               | x86 fail | x86 fail |
| mikmod                             | oe_test_mikmod_mikmod_02                                | x86 fail | x86 fail |
|                                    | oe_test_mikmod_mikmod_01                                | x86 fail | x86 fail |
|                                    | oe_test_mikmod_mikmod_03                                | x86 fail | x86 fail |
|                                    | oe_test_mikmod_mikmod_04                                | x86 fail | x86 fail |
|                                    | oe_test_mikmod_mikmod_05                                | x86 fail | x86 fail |
|                                    | oe_test_mikmod_mikmod_06                                | x86 fail | x86 fail |
|                                    | oe_test_mikmod_mikmod_07                                | x86 fail | x86 fail |
| mpg123                             | oe_test_mpg123                                          | x86 fail | x86 fail |
| mrtg                               | oe_test_service_mrtg                                    | x86 fail | x86 fail |
| mtx                                | oe_test_mtx_loaderinfo                                  | x86 fail | x86 fail |
|                                    | oe_test_mtx_tapeinfo                                    | x86 fail | x86 fail |
|                                    | oe_test_mtx_mtx                                         | x86 fail | x86 fail |
|                                    | oe_test_mtx_scsieject                                   | x86 fail | x86 fail |
|                                    | oe_test_mtx_scsitape                                    | x86 fail | x86 fail |
| mysql                              | oe_test_service_mysql                                   | x86 fail | x86 fail |
| nasm                               | oe_test_nasm_13                                         | x86 fail | x86 fail |
| nasm                               | oe_test_rsyslog_abnormal_template                       | x86 fail | x86 fail |
|                                    | oe_test_rsyslog_function_attribute                      | x86 fail | x86 fail |
|                                    | oe_test_rsyslog_function_httpd                          | x86 fail | x86 fail |
|                                    | oe_test_rsyslog_function_relp                           | x86 fail | x86 fail |
|                                    | oe_test_rsyslog_function_tcp                            | x86 fail | x86 fail |
|                                    | oe_test_rsyslog_function_tcp_firewall                   | x86 fail | x86 fail |
|                                    | oe_test_rsyslog_function_udp                            | x86 fail | x86 fail |
|                                    | oe_test_rsyslog_reliability_lenght                      | x86 fail | x86 fail |
|                                    | oe_test_rsyslog_reliability_network                     | x86 fail | x86 fail |
|                                    | oe_test_rsyslog_reliability_tcp                         | x86 fail | x86 fail |
| FS_Device                          | oe_test_dm_create                                       | x86 fail | x86 fail |
|                                    | oe_test_dm_info                                         | x86 fail | x86 fail |
|                                    | oe_test_raid_auto_mount                                 | x86 fail | x86 fail |
|                                    | oe_test_raid_compress                                   | x86 fail | x86 fail |
|                                    | oe_test_raid_react                                      | x86 fail | x86 fail |
|                                    | oe_test_raid_rm_ko                                      | x86 fail | x86 fail |
|                                    | oe_test_snapshot_dump                                   | x86 fail | x86 fail |
|                                    | oe_test_snapshot_lvconvert                              | x86 fail | x86 fail |
|                                    | oe_test_snapshot_rw                                     | x86 fail | x86 fail |
|                                    | oe_test_swap_auto_mount                                 | x86 fail | x86 fail |
|                                    | oe_test_swap_close                                      | x86 fail | x86 fail |
|                                    | oe_test_swap_close_temp                                 | x86 fail | x86 fail |
| FS_Directory                       | oe_test_FSIO_dir_access_boot                            | x86 fail | x86 fail |
|                                    | oe_test_FSIO_dir_access_dev                             | x86 fail | x86 fail |
|                                    | oe_test_FSIO_dir_access_root                            | x86 fail | x86 fail |
|                                    | oe_test_FSIO_dir_access_sbin                            | x86 fail | x86 fail |
|                                    | oe_test_FSIO_dir_create_lack_inode                      | x86 fail | x86 fail |
|                                    | oe_test_FSIO_dir_modify_name                            | x86 fail | x86 fail |
|                                    | oe_test_FSIO_dir_umask_exit                             | x86 fail | x86 fail |
| FS_Negative                        | oe_test_FSIO_create_same_name_dir_file                  | x86 fail | x86 fail |
|                                    | oe_test_FSIO_destory_block                              | x86 fail | x86 fail |
|                                    | oe_test_FSIO_etc_full_data                              | x86 fail | x86 fail |
| FS_Raw                             | oe_test_raw_create                                      | x86 fail | x86 fail |
|                                    | oe_test_raw_disk                                        | x86 fail | x86 fail |
|                                    | oe_test_raw_lvm                                         | x86 fail | x86 fail |
|                                    | oe_test_raw_mknod                                       | x86 fail | x86 fail |
|                                    | oe_test_raw_reboot                                      | x86 fail | x86 fail |
|                                    | oe_test_raw_reraw                                       | x86 fail | x86 fail |
|                                    | oe_test_raw_service                                     | x86 fail | x86 fail |
| FS_iSula                           | oe_test_isula_compress                                  | x86 fail | x86 fail |
|                                    | oe_test_isula_cp                                        | x86 fail | x86 fail |
|                                    | oe_test_isula_mergedir                                  | x86 fail | x86 fail |
|                                    | oe_test_isula_mount                                     | x86 fail | x86 fail |
|                                    | oe_test_isula_mount_system_isula                        | x86 fail | x86 fail |
|                                    | oe_test_isula_write_in_isula                            | x86 fail | x86 fail |
| embedded_application_develop_tests | oe_test_cpp_hello_world_test                            | x86 fail | x86 fail |
|                                    | oe_test_hello_world_test                                | x86 fail | x86 fail |
|                                    | oe_test_kernel_hello_world_test                         | x86 fail | x86 fail |
| embedded_os_basic_test             | oe_test_basic_cmd_cat                                   | x86 fail | x86 fail |
|                                    | oe_test_basic_cmd_shopt                                 | x86 fail | x86 fail |
|                                    | oe_test_os_release                                      | x86 fail | x86 fail |
|                                    | oe_test_system_service_sshd                             | x86 fail | x86 fail |
| embedded_tiny_image_test           | oe_test_check_aarch_tiny_image_001                      | x86 fail | x86 fail |
| nbdkit                             | oe_test_nbdkit_02                                       | x86 fail | x86 fail |
| ndisc6                             | oe_test_ndisc6_name2addr                                | x86 fail | x86 fail |
|                                    | oe_test_ndisc6_rdisc6                                   | x86 fail | x86 fail |
| net-snmp                           | oe_test_net-snmp_01                                     | x86 fail | x86 fail |
|                                    | oe_test_net-snmp_02                                     | x86 fail | x86 fail |
| netlabel_tools                     | oe_test_netlabel_tools_netlabelctl_03                   | x86 fail | x86 fail |
| nftables                           | oe_test_nftables_anonymous_map                          | x86 fail | x86 fail |
|                                    | oe_test_nftables_backup_rules                           | x86 fail | x86 fail |
|                                    | oe_test_nftables_chains                                 | x86 fail | x86 fail |
|                                    | oe_test_nftables_create_counters                        | x86 fail | x86 fail |
|                                    | oe_test_nftables_listen_package                         | x86 fail | x86 fail |
|                                    | oe_test_nftables_name_sets                              | x86 fail | x86 fail |
|                                    | oe_test_nftables_replace_counters                       | x86 fail | x86 fail |
|                                    | oe_test_nftables_variable_map                           | x86 fail | x86 fail |
|                                    | oe_test_service_nftables                                | x86 fail | x86 fail |
| nginx                              | oe_test_nginx_concurrent                                | x86 fail | x86 fail |
| nmon                               | oe_test_nmon_01                                         | x86 fail | x86 fail |
|                                    | oe_test_nmon_02                                         | x86 fail | x86 fail |
|                                    | oe_test_nmon_04                                         | x86 fail | x86 fail |
| nodejs                             | oe_test_nodejs_04                                       | x86 fail | x86 fail |
| novnc                              | oe_test_novnc                                           | x86 fail | x86 fail |
| ntfs-3g                            | oe_test_ntfs-3g_lowntfs-3g_01                           | x86 fail | x86 fail |
|                                    | oe_test_ntfs-3g_lowntfs-3g_02                           | x86 fail | x86 fail |
|                                    | oe_test_ntfs-3g_lowntfs-3g_03                           | x86 fail | x86 fail |
|                                    | oe_test_ntfs-3g_ntfs-3g_01                              | x86 fail | x86 fail |
|                                    | oe_test_ntfs-3g_ntfs-3g_02                              | x86 fail | x86 fail |
|                                    | oe_test_ntfs-3g_ntfs-3g_03                              | x86 fail | x86 fail |
|                                    | oe_test_ntfs-3g_ntfscluster                             | x86 fail | x86 fail |
|                                    | oe_test_ntfs-3g_ntfscp                                  | x86 fail | x86 fail |
|                                    | oe_test_ntfs-3g_ntfsfallocate                           | x86 fail | x86 fail |
|                                    | oe_test_ntfs-3g_ntfsinfo                                | x86 fail | x86 fail |
|                                    | oe_test_ntfs-3g_ntfsls                                  | x86 fail | x86 fail |
|                                    | oe_test_ntfs-3g_ntfsmove                                | x86 fail | x86 fail |
|                                    | oe_test_ntfs-3g_ntfsresize                              | x86 fail | x86 fail |
|                                    | oe_test_ntfs-3g_ntfssecaudit                            | x86 fail | x86 fail |
|                                    | oe_test_ntfs-3g_ntfsundelete_01                         | x86 fail | x86 fail |
|                                    | oe_test_ntfs-3g_ntfsundelete_02                         | x86 fail | x86 fail |
| obs-server                         | oe_test_obs-server                                      | x86 fail | x86 fail |
|                                    | oe_test_service_obs-clockwork                           | x86 fail | x86 fail |
|                                    | oe_test_service_obs-delayedjob-queue-consistency_check  | x86 fail | x86 fail |
|                                    | oe_test_service_obs-delayedjob-queue-default            | x86 fail | x86 fail |
|                                    | oe_test_service_obs-delayedjob-queue-issuetracking      | x86 fail | x86 fail |
|                                    | oe_test_service_obs-delayedjob-queue-mailers            | x86 fail | x86 fail |
|                                    | oe_test_service_obs-delayedjob-queue-project_log_rotate | x86 fail | x86 fail |
|                                    | oe_test_service_obs-delayedjob-queue-releasetracking    | x86 fail | x86 fail |
|                                    | oe_test_service_obs-delayedjob-queue-staging            | x86 fail | x86 fail |
|                                    | oe_test_service_obs-sphinx                              | x86 fail | x86 fail |
| open-iscsi                         | oe_test_open-iscsi_iscsiadm                             | x86 fail | x86 fail |
|                                    | oe_test_open-iscsi_iscsistart_iscsiuio                  | x86 fail | x86 fail |
|                                    | oe_test_service_iscsiuio                                | x86 fail | x86 fail |
|                                    | oe_test_socket_iscsiuio                                 | x86 fail | x86 fail |
| openmpi                            | oe_test_openmpi_cluster                                 | x86 fail | x86 fail |
|                                    | oe_test_openmpi_single_01                               | x86 fail | x86 fail |
|                                    | oe_test_openmpi_single_02                               | x86 fail | x86 fail |
| openscap                           | oe_test_assess_safety_compliance                        | x86 fail | x86 fail |
|                                    | oe_test_scanning_remote_system                          | x86 fail | x86 fail |
| openvpn                            | oe_test_openvpn                                         | x86 fail | x86 fail |
| openvswitch                        | oe_test_service_openvswitch-ipsec                       | x86 fail | x86 fail |
|                                    | oe_test_service_ovn-controller                          | x86 fail | x86 fail |
|                                    | oe_test_service_ovn-controller-vtep                     | x86 fail | x86 fail |
|                                    | oe_test_service_ovn-northd                              | x86 fail | x86 fail |
| os-storage                         | oe_test_storage_DevMgmt_block_drop                      | x86 fail | x86 fail |
|                                    | oe_test_storage_DevMgmt_disk_operation                  | x86 fail | x86 fail |
|                                    | oe_test_storage_DevMgmt_lsblk                           | x86 fail | x86 fail |
|                                    | oe_test_storage_DevMgmt_swap                            | x86 fail | x86 fail |
|                                    | oe_test_storage_Mutipath_dmsetup                        | x86 fail | x86 fail |
|                                    | oe_test_storage_diskpartiton_create_raid0               | x86 fail | x86 fail |
|                                    | oe_test_storage_diskpartiton_create_raid1               | x86 fail | x86 fail |
|                                    | oe_test_storage_diskpartiton_create_raid5               | x86 fail | x86 fail |
|                                    | oe_test_storage_diskpartiton_fdisk                      | x86 fail | x86 fail |
|                                    | oe_test_storage_diskpartiton_fdisk_delete               | x86 fail | x86 fail |
|                                    | oe_test_storage_diskpartiton_fdisk_settype              | x86 fail | x86 fail |
|                                    | oe_test_storage_diskpartiton_parted_resize              | x86 fail | x86 fail |
|                                    | oe_test_storage_diskpartiton_view_fdisk                 | x86 fail | x86 fail |
|                                    | oe_test_storage_ext3_create                             | x86 fail | x86 fail |
|                                    | oe_test_storage_ext3_mount                              | x86 fail | x86 fail |
|                                    | oe_test_storage_ext3_resize                             | x86 fail | x86 fail |
|                                    | oe_test_storage_ext4_mount_write                        | x86 fail | x86 fail |
|                                    | oe_test_storage_fileCMD_cat                             | x86 fail | x86 fail |
|                                    | oe_test_storage_fileCMD_dd                              | x86 fail | x86 fail |
|                                    | oe_test_storage_longname_list                           | x86 fail | x86 fail |
|                                    | oe_test_storage_longname_modify                         | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_activation_missing                  | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_add_VG                              | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_change_number                       | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_cling                               | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_create_cache                        | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_create_raid                         | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_create_snapshot                     | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_create_thinSnapshot                 | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_expand_stripeLV                     | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_lvdisplay_lvscan                    | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_merge_VG                            | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_query_lvmsnap                       | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_raid_synchronization                | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_replace_badraid                     | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_replace_raid                        | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_separate_raid                       | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_set_label                           | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_set_limit                           | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_set_lvconvert_raid                  | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_set_lvconvert_raid1                 | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_snapshot_merge                      | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_snapshot_tag                        | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_specify_size                        | x86 fail | x86 fail |
|                                    | oe_test_storage_lvm_split_VG                            | x86 fail | x86 fail |
|                                    | oe_test_storage_mount_UUID                              | x86 fail | x86 fail |
|                                    | oe_test_storage_mount_block_device                      | x86 fail | x86 fail |
|                                    | oe_test_storage_mount_copy                              | x86 fail | x86 fail |
|                                    | oe_test_storage_mount_findmnt                           | x86 fail | x86 fail |
|                                    | oe_test_storage_mount_mobile_point                      | x86 fail | x86 fail |
|                                    | oe_test_storage_mount_repeat                            | x86 fail | x86 fail |
|                                    | oe_test_storage_mount_umount                            | x86 fail | x86 fail |
|                                    | oe_test_storage_nfs_configure_nfsv4                     | x86 fail | x86 fail |
|                                    | oe_test_storage_nfs_mount_readonly                      | x86 fail | x86 fail |
|                                    | oe_test_storage_nfs_mount_root                          | x86 fail | x86 fail |
|                                    | oe_test_storage_nfs_network_latency                     | x86 fail | x86 fail |
|                                    | oe_test_storage_nfs_repeat_mount                        | x86 fail | x86 fail |
|                                    | oe_test_storage_nfs_repeat_restartServer                | x86 fail | x86 fail |
|                                    | oe_test_storage_nfs_restrict_hostname                   | x86 fail | x86 fail |
|                                    | oe_test_storage_nfs_restrict_ip                         | x86 fail | x86 fail |
|                                    | oe_test_storage_nfs_share_mount                         | x86 fail | x86 fail |
|                                    | oe_test_storage_nfs_v3_v4                               | x86 fail | x86 fail |
|                                    | oe_test_storage_nfs_write_full                          | x86 fail | x86 fail |
|                                    | oe_test_storage_repair_e2fsck                           | x86 fail | x86 fail |
|                                    | oe_test_storage_repair_xfs                              | x86 fail | x86 fail |
|                                    | oe_test_storage_smb_3.0                                 | x86 fail | x86 fail |
|                                    | oe_test_storage_smb_POSIX_ACL                           | x86 fail | x86 fail |
|                                    | oe_test_storage_smb_abnormal_poweroff                   | x86 fail | x86 fail |
|                                    | oe_test_storage_smb_automatically_mount                 | x86 fail | x86 fail |
|                                    | oe_test_storage_smb_cmd_rpcclient                       | x86 fail | x86 fail |
|                                    | oe_test_storage_smb_cmd_smbclient                       | x86 fail | x86 fail |
|                                    | oe_test_storage_smb_credential_files                    | x86 fail | x86 fail |
|                                    | oe_test_storage_smb_host_share                          | x86 fail | x86 fail |
|                                    | oe_test_storage_smb_mount                               | x86 fail | x86 fail |
|                                    | oe_test_storage_smb_mount_umount                        | x86 fail | x86 fail |
|                                    | oe_test_storage_smb_multi-user_mount                    | x86 fail | x86 fail |
|                                    | oe_test_storage_smb_network_latency                     | x86 fail | x86 fail |
|                                    | oe_test_storage_smb_repeat_restart                      | x86 fail | x86 fail |
|                                    | oe_test_storage_smb_share_dir                           | x86 fail | x86 fail |
|                                    | oe_test_storage_smb_write_full                          | x86 fail | x86 fail |
|                                    | oe_test_storage_vfat_mount_write                        | x86 fail | x86 fail |
|                                    | oe_test_storage_xfs_Increase_size                       | x86 fail | x86 fail |
|                                    | oe_test_storage_xfs_backup                              | x86 fail | x86 fail |
|                                    | oe_test_storage_xfs_create                              | x86 fail | x86 fail |
| patchutils                         | oe_test_patchutils_combinediff_01                       | x86 fail | x86 fail |
|                                    | oe_test_patchutils_flipdiff_01                          | x86 fail | x86 fail |
|                                    | oe_test_patchutils_interdiff_01                         | x86 fail | x86 fail |
| pcp                                | oe_test_pcp_atop_01                                     | x86 fail | x86 fail |
|                                    | oe_test_pcp_atop_02                                     | x86 fail | x86 fail |
|                                    | oe_test_pcp_pcp-import-ganglia2pcp                      | x86 fail | x86 fail |
|                                    | oe_test_pmevent_02                                      | x86 fail | x86 fail |
|                                    | oe_test_pmhostname_pmlock_pmlogger_check                | x86 fail | x86 fail |
|                                    | oe_test_pmlogcheck_pmlogmv                              | x86 fail | x86 fail |
|                                    | oe_test_pmlogger_daily_01                               | x86 fail | x86 fail |
|                                    | oe_test_pmlogger_daily_report                           | x86 fail | x86 fail |
|                                    | oe_test_pmprobe_01                                      | x86 fail | x86 fail |
|                                    | oe_test_pmval_02                                        | x86 fail | x86 fail |
| pcp-system-tools                   | oe_test_pcp-iostat                                      | x86 fail | x86 fail |
|                                    | oe_test_pcp-mpstat_pcp-numastat                         | x86 fail | x86 fail |
|                                    | oe_test_pcp-pidstat_01                                  | x86 fail | x86 fail |
|                                    | oe_test_pcp-pidstat_02_pcp-ipcs                         | x86 fail | x86 fail |
|                                    | oe_test_pcp_collectl                                    | x86 fail | x86 fail |
| perl-Date-Manip                    | oe_test_perl-Date-Manip_dm_date                         | x86 fail | x86 fail |
| pesign                             | oe_test_pesign_base_02                                  | x86 fail | x86 fail |
|                                    | oe_test_pesign_efikeygen                                | x86 fail | x86 fail |
|                                    | oe_test_pesign_efisiglist                               | x86 fail | x86 fail |
|                                    | oe_test_pesign_pesigcheck                               | x86 fail | x86 fail |
| podman                             | oe_test_podman_01                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_02                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_03                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_04                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_05                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_06                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_07                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_08                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_09                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_10                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_11                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_12                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_13                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_14                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_15                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_16                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_17                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_18                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_19                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_20                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_21                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_22                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_23                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_24                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_26                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_27                                       | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_01                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_02                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_03                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_04                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_05                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_06                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_07                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_08                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_09                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_10                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_11                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_12                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_13                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_14                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_15                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_16                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_17                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_18                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_19                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_20                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_21                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_22                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_23                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_24                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_26                                    | x86 fail | x86 fail |
|                                    | oe_test_podman_DK_27                                    | x86 fail | x86 fail |
|                                    | oe_test_service_podman                                  | x86 fail | x86 fail |
|                                    | oe_test_socket_podman                                   | x86 fail | x86 fail |
| policycoreutils                    | oe_test_service_restorecond                             | x86 fail | x86 fail |
| pps-tools                          | oe_test_pps-tools                                       | x86 fail | x86 fail |
| procinfo                           | oe_test_procinfo_01                                     | x86 fail | x86 fail |
|                                    | oe_test_procinfo_02                                     | x86 fail | x86 fail |
| qemu                               | oe_test_service_qemu-guest-agent                        | x86 fail | x86 fail |
| qpdf                               | oe_test_qpdf_qpdf_01                                    | x86 fail | x86 fail |
|                                    | oe_test_qpdf_qpdf_02                                    | x86 fail | x86 fail |
|                                    | oe_test_qpdf_qpdf_03                                    | x86 fail | x86 fail |
|                                    | oe_test_qpdf_qpdf_08                                    | x86 fail | x86 fail |
|                                    | oe_test_qpdf_qpdf_10                                    | x86 fail | x86 fail |
| rabbitmq-server                    | oe_test_rabbitmqctl_app                                 | x86 fail | x86 fail |
|                                    | oe_test_rabbitmqctl_cluster                             | x86 fail | x86 fail |
| radvd                              | oe_test_service_radvd                                   | x86 fail | x86 fail |
| rdate                              | oe_test_rdate                                           | x86 fail | x86 fail |
| redis                              | oe_test_redis_02                                        | x86 fail | x86 fail |
| redis5                             | oe_test_redis5_02                                       | x86 fail | x86 fail |
| redis6                             | oe_test_redis6_02                                       | x86 fail | x86 fail |
| rng-tools                          | oe_test_service_rngd                                    | x86 fail | x86 fail |
| rootsh                             | oe_test_rootsh01                                        | x86 fail | x86 fail |
|                                    | oe_test_rootsh02                                        | x86 fail | x86 fail |
| rpmdevtools                        | oe_test_rpmdevtools_rpmargs                             | x86 fail | x86 fail |
| ruby                               | oe_test_erb                                             | x86 fail | x86 fail |
|                                    | oe_test_irb_01                                          | x86 fail | x86 fail |
|                                    | oe_test_irb_03                                          | x86 fail | x86 fail |
|                                    | oe_test_rdoc_01                                         | x86 fail | x86 fail |
|                                    | oe_test_ruby                                            | x86 fail | x86 fail |
| rubygem-bundler                    | oe_test_rubygem-bundler_bundle_02                       | x86 fail | x86 fail |
|                                    | oe_test_rubygem-bundler_bundle_06                       | x86 fail | x86 fail |
| samba                              | oe_test_service_samba                                   | x86 fail | x86 fail |
| samtools                           | oe_test_samtools_samtools_01                            | x86 fail | x86 fail |
| sbd                                | oe_test_service_sbd                                     | x86 fail | x86 fail |
|                                    | oe_test_service_sbd_remote                              | x86 fail | x86 fail |
| scala                              | oe_test_scala                                           | x86 fail | x86 fail |
|                                    | oe_test_scala_fsc_01                                    | x86 fail | x86 fail |
|                                    | oe_test_scala_fsc_02                                    | x86 fail | x86 fail |
|                                    | oe_test_scala_fsc_03                                    | x86 fail | x86 fail |
|                                    | oe_test_scala_fsc_04                                    | x86 fail | x86 fail |
|                                    | oe_test_scala_scalac_01                                 | x86 fail | x86 fail |
|                                    | oe_test_scala_scalac_02                                 | x86 fail | x86 fail |
|                                    | oe_test_scala_scalac_03                                 | x86 fail | x86 fail |
|                                    | oe_test_scala_scaladoc_01                               | x86 fail | x86 fail |
|                                    | oe_test_scala_scaladoc_02                               | x86 fail | x86 fail |
|                                    | oe_test_scala_scaladoc_03                               | x86 fail | x86 fail |
|                                    | oe_test_scala_scaladoc_04                               | x86 fail | x86 fail |
|                                    | oe_test_scala_scaladoc_05                               | x86 fail | x86 fail |
|                                    | oe_test_scala_scaladoc_06                               | x86 fail | x86 fail |
|                                    | oe_test_scala_scalap                                    | x86 fail | x86 fail |
| security_guide                     | oe_test_access_sudo_commands                            | x86 fail | x86 fail |
|                                    | oe_test_delete_global_writable_property                 | x86 fail | x86 fail |
|                                    | oe_test_lock_after_login_fail                           | x86 fail | x86 fail |
|                                    | oe_test_ssh_RSA_auth                                    | x86 fail | x86 fail |
|                                    | oe_test_ssh_allow_public_key                            | x86 fail | x86 fail |
|                                    | oe_test_ssh_server_reinforcement_suggestions            | x86 fail | x86 fail |
|                                    | oe_test_ssh_sftp_across_updir                           | x86 fail | x86 fail |
|                                    | oe_test_ssh_system_reinforcement                        | x86 fail | x86 fail |
|                                    | oe_test_umask_default                                   | x86 fail | x86 fail |
| smoke-baseinfo                     | oe_test_dmesg_messages_log                              | x86 fail | x86 fail |
|                                    | oe_test_firewalld                                       | x86 fail | x86 fail |
|                                    | oe_test_partition                                       | x86 fail | x86 fail |
| smoke-basic-os                     | oe_test_IPV6_traceroute6_02                             | x86 fail | x86 fail |
|                                    | oe_test_arping                                          | x86 fail | x86 fail |
|                                    | oe_test_audit_fixed_memory_02                           | x86 fail | x86 fail |
|                                    | oe_test_cat_001                                         | x86 fail | x86 fail |
|                                    | oe_test_ebtables                                        | x86 fail | x86 fail |
|                                    | oe_test_ethtool_01                                      | x86 fail | x86 fail |
|                                    | oe_test_firewalld_server                                | x86 fail | x86 fail |
|                                    | oe_test_gettext                                         | x86 fail | x86 fail |
|                                    | oe_test_glibc_getaddrinfo_01                            | x86 fail | x86 fail |
|                                    | oe_test_grub2_mkconfig                                  | x86 fail | x86 fail |
|                                    | oe_test_ifconfig_ipv6_01                                | x86 fail | x86 fail |
|                                    | oe_test_ima_v2_manual_gen_digest_01                     | x86 fail | x86 fail |
|                                    | oe_test_ip6tables_01                                    | x86 fail | x86 fail |
|                                    | oe_test_ip_ipv6_01                                      | x86 fail | x86 fail |
|                                    | oe_test_ip_ipv6_02                                      | x86 fail | x86 fail |
|                                    | oe_test_ip_ipv6_03                                      | x86 fail | x86 fail |
|                                    | oe_test_ip_ipv6_04                                      | x86 fail | x86 fail |
|                                    | oe_test_iproute_ipv6_01                                 | x86 fail | x86 fail |
|                                    | oe_test_iptables-save                                   | x86 fail | x86 fail |
|                                    | oe_test_ipv6_VLAN_01                                    | x86 fail | x86 fail |
|                                    | oe_test_ipv6_VLAN_02                                    | x86 fail | x86 fail |
|                                    | oe_test_libxml2_001                                     | x86 fail | x86 fail |
|                                    | oe_test_libxml2_002                                     | x86 fail | x86 fail |
|                                    | oe_test_mtr                                             | x86 fail | x86 fail |
|                                    | oe_test_network_001                                     | x86 fail | x86 fail |
|                                    | oe_test_normal_tcpdump_02                               | x86 fail | x86 fail |
|                                    | oe_test_normal_tcpdump_03                               | x86 fail | x86 fail |
|                                    | oe_test_normal_tcpdump_04                               | x86 fail | x86 fail |
|                                    | oe_test_route_ipv6                                      | x86 fail | x86 fail |
|                                    | oe_test_setools                                         | x86 fail | x86 fail |
|                                    | oe_test_sevice_001                                      | x86 fail | x86 fail |
|                                    | oe_test_stat                                            | x86 fail | x86 fail |
|                                    | oe_test_systemd_journald                                | x86 fail | x86 fail |
|                                    | oe_test_tftp_ipv6                                       | x86 fail | x86 fail |
| smoke-iSulad                       | oe_test_iSula_exec_cmd_001                              | x86 fail | x86 fail |
| socat                              | oe_test_socat_filan                                     | x86 fail | x86 fail |
| sos                                | oe_test_sosreport_02                                    | x86 fail | x86 fail |
|                                    | oe_test_sosreport_04                                    | x86 fail | x86 fail |
| strongswan                         | oe_test_service_strongswan                              | x86 fail | x86 fail |
|                                    | oe_test_service_strongswan-swanctl                      | x86 fail | x86 fail |
|                                    | oe_test_service_strongswan_01                           | x86 fail | x86 fail |
|                                    | oe_test_service_strongswan_03                           | x86 fail | x86 fail |
| systemtap                          | oe_test_service_systemtap                               | x86 fail | x86 fail |
| tomcat                             | oe_test_service_tomcat-jsvc                             | x86 fail | x86 fail |
| tuned                              | oe_test_service_tuned                                   | x86 fail | x86 fail |
| unbound                            | oe_test_service_unbound-keygen                          | x86 fail | x86 fail |
| wireshark                          | oe_test_captype                                         | x86 fail | x86 fail |
|                                    | oe_test_dumpcap_01                                      | x86 fail | x86 fail |
|                                    | oe_test_dumpcap_02                                      | x86 fail | x86 fail |
|                                    | oe_test_editcap_01                                      | x86 fail | x86 fail |
|                                    | oe_test_editcap_02                                      | x86 fail | x86 fail |
| wsmancli                           | oe_test_wsmancli_wseventmgr_02                          | x86 fail | x86 fail |
|                                    | oe_test_wsmancli_wsman_03                               | x86 fail | x86 fail |
| yelp-tools                         | oe_test_yelp-build                                      | x86 fail | x86 fail |
|                                    | oe_test_yelp-new                                        | x86 fail | x86 fail |
| clevis                             | oe_test_high_nbde                                       | x86 fail | x86 fail |
|                                    | oe_test_install_clevis                                  | x86 fail | x86 fail |
|                                    | oe_test_service_clevis-luks-askpass                     | x86 fail | x86 fail |
| fio                                | oe_test_fio_001                                         | x86 fail | x86 fail |
|                                    | oe_test_fio_004                                         | x86 fail | x86 fail |
| chrpath                            | oe_test_chrpath                                         | x86 fail | x86 fail |
| cvs                                | oe_test_cvs_cvs_02                                      | x86 fail | x86 fail |
|                                    | oe_test_cvs_cvs_03                                      | x86 fail | x86 fail |
|                                    | oe_test_cvs_cvs_04                                      | x86 fail | x86 fail |
|                                    | oe_test_cvs_cvs_05                                      | x86 fail | x86 fail |
|                                    | oe_test_cvs_cvs_06                                      | x86 fail | x86 fail |
| hdparm                             | oe_test_hdparm                                          | x86 fail | x86 fail |
| openssh                            | oe_test_openssh_port                                    | x86 fail | x86 fail |
|                                    | oe_test_sec_ssh                                         | x86 fail | x86 fail |
| pbzip2                             | oe_test_pbzip2_03                                       | x86 fail | x86 fail |
| yajl                               | oe_test_yajl                                            | x86 fail | x86 fail |






## success

此表中的测试用例均为在riscv上测试通过的测试用例

| 测试套/软件包名        | 测试用例名                                                  | 状态     |
| ---------------------- | ----------------------------------------------------------- | -------- |
| 389-ds-base            | oe_test_service_dirsrv-snmp                                 | success  |
|                        | oe_test_target_dirsrv                                       | success  |
| ImageMagick            | oe_test_ImageMagick_01                                      | success  |
|                        | oe_test_ImageMagick_02                                      | success  |
|                        | oe_test_ImageMagick_03                                      | success  |
|                        | oe_test_ImageMagick_04                                      | success  |
|                        | oe_test_ImageMagick_05                                      | success  |
|                        | oe_test_ImageMagick_06                                      | success  |
|                        | oe_test_ImageMagick_07                                      | success  |
|                        | oe_test_ImageMagick_08                                      | success  |
| ModemManager           | oe_test_service_ModemManager                                | success  |
| OpenEXR                | oe_test_OpenEXR_cmd                                         | success  |
|                        | oe_test_OpenEXR_exrenvmap                                   | success  |
|                        | oe_test_OpenEXR_exrenvmap_exrmakepreview                    | success  |
|                        | oe_test_OpenEXR_exrmaketiled                                | success  |
|                        | oe_test_OpenEXR_exrstdattr_01                               | success  |
|                        | oe_test_OpenEXR_exrstdattr_02                               | success  |
|                        | oe_test_OpenEXR_exrstdattr_03                               | success  |
| PackageKit             | oe_test_service_packagekit-offline-update                   | success  |
|                        | oe_test_service_packagekit                                  | success  |
| abrt                   | oe_test_service_abrt-journal-core                           | success  |
|                        | oe_test_service_abrt-oops                                   | success  |
|                        | oe_test_service_abrt-pstoreoops                             | success  |
|                        | oe_test_service_abrt-upload-watch                           | success  |
|                        | oe_test_service_abrt-vmcore                                 | success  |
|                        | oe_test_service_abrt-xorg                                   | success  |
|                        | oe_test_service_abrtd                                       | success  |
| accountsservice        | oe_test_service_accounts-daemon                             | success  |
| acpid                  | oe_test_acpid_01                                            | success  |
|                        | oe_test_acpid_02                                            | success  |
|                        | oe_test_acpid_03                                            | success  |
|                        | oe_test_service_acpid                                       | success  |
|                        | oe_test_socket_acpid                                        | success  |
| arpwatch               | oe_test_service_arpwatch                                    | success  |
| attr                   | oe_test_attr                                                | success  |
| authd                  | oe_test_socket_auth                                         | success  |
| authz                  | oe_test_service_authz                                       | success  |
| autoconf213            | oe_test_autoconf213_autoconf-2.13                           | success  |
|                        | oe_test_autoconf213_autoheader-2.13                         | success  |
|                        | oe_test_autoconf213_autoreconf-2.13_01                      | success  |
|                        | oe_test_autoconf213_autoreconf-2.13_02                      | success  |
|                        | oe_test_autoconf213_autoreconf-2.13_03                      | success  |
|                        | oe_test_autoconf213_autoreconf-2.13_04                      | success  |
|                        | oe_test_autoconf213_autoreconf-2.13_05                      | success  |
|                        | oe_test_autoconf213_autoreconf-2.13_06                      | success  |
|                        | oe_test_autoconf213_autoupdate-2.13                         | success  |
|                        | oe_test_autoconf213_ifnames-2.13                            | success  |
| avahi                  | oe_test_service_avahi-daemon                                | success  |
|                        | oe_test_service_avahi-dnsconfd                              | success  |
|                        | oe_test_socket_avahi-daemon                                 | success  |
| babeltrace             | oe_test_babeltrace                                          | success  |
| bcrypt                 | oe_test_bcrypt                                              | success  |
| bind                   | oe_test_service_named-chroot-setup                          | success  |
|                        | oe_test_service_named-chroot                                | success  |
|                        | oe_test_service_named-setup-rndc                            | success  |
|                        | oe_test_service_named                                       | success  |
| binutils               | oe_test_binutils_addr2line                                  | success  |
|                        | oe_test_binutils_ar                                         | success  |
|                        | oe_test_binutils_nm                                         | success  |
|                        | oe_test_binutils_objcopy                                    | success  |
|                        | oe_test_binutils_objdump                                    | success  |
|                        | oe_test_binutils_readelf                                    | success  |
|                        | oe_test_binutils_size                                       | success  |
|                        | oe_test_binutils_strip                                      | success  |
| bluez                  | oe_test_service_bluetooth-mesh                              | success  |
|                        | oe_test_service_bluetooth                                   | success  |
| bolt                   | oe_test_service_bolt                                        | success  |
| brltty                 | oe_test_service_brltty                                      | success  |
| byacc                  | oe_test_byacc_byacc_01                                      | success  |
|                        | oe_test_byacc_byacc_02                                      | success  |
|                        | oe_test_byacc_yacc_01                                       | success  |
|                        | oe_test_byacc_yacc_02                                       | success  |
| bzip2                  | oe_test_bzip2                                               | success  |
| cgdcbxd                | oe_test_service_cgdcbxd                                     | success  |
| clang                  | oe_test_clang_01                                            | success  |
|                        | oe_test_clang_02                                            | success  |
|                        | oe_test_clang_03                                            | success  |
| cloud-init             | oe_test_service_cloud-config                                | success  |
|                        | oe_test_service_cloud-final                                 | success  |
|                        | oe_test_service_cloud-init-local                            | success  |
|                        | oe_test_service_cloud-init                                  | success  |
|                        | oe_test_target_cloud-config                                 | success  |
|                        | oe_test_target_cloud-init                                   | success  |
| colm                   | oe_test_colm                                                | success  |
| colord                 | oe_test_service_colord                                      | success  |
| cpio                   | oe_test_cpio                                                | success  |
| cracklib               | oe_test_cracklib                                            | success  |
| cronie                 | oe_test_cronie                                              | success  |
|                        | oe_test_service_crond                                       | success  |
| cups-filters           | oe_test_service_cups-browsed                                | success  |
| cups                   | oe_test_service_cups                                        | success  |
|                        | oe_test_socket_cups-lpd                                     | success  |
|                        | oe_test_socket_cups                                         | success  |
| cyrus-sasl             | oe_test_service_saslauthd                                   | success  |
| dbus                   | oe_test_service_dbus                                        | success  |
|                        | oe_test_socket_dbus                                         | success  |
| discount               | oe_test_discount-makepage_01                                | success  |
|                        | oe_test_discount-mkd2html_01                                | success  |
|                        | oe_test_discount-theme_01                                   | success  |
|                        | oe_test_discount_markdown_01                                | success  |
|                        | oe_test_discount_markdown_02                                | success  |
| djvulibre              | oe_test_djvulibre_01                                        | success  |
|                        | oe_test_djvulibre_02                                        | success  |
|                        | oe_test_djvulibre_03                                        | success  |
|                        | oe_test_djvulibre_04                                        | success  |
|                        | oe_test_djvulibre_05                                        | success  |
| dkms                   | oe_test_service_dkms                                        | success  |
| dnsmasq                | oe_test_service_dnsmasq                                     | success  |
| docbook-utils          | oe_test_docbook-utils_jw_01                                 | success  |
|                        | oe_test_docbook-utils_jw_02                                 | success  |
|                        | oe_test_docbook-utils_sgmldiff                              | success  |
| docbook2X              | oe_test_docbook2X_db2x_docbook2man                          | success  |
|                        | oe_test_docbook2X_db2x_docbook2texi_01                      | success  |
|                        | oe_test_docbook2X_db2x_docbook2texi_02                      | success  |
|                        | oe_test_docbook2X_db2x_manxml                               | success  |
|                        | oe_test_docbook2X_db2x_texixml                              | success  |
|                        | oe_test_docbook2X_db2x_xsltproc                             | success  |
|                        | oe_test_docbook2X_sgml2xml-isoent_01                        | success  |
|                        | oe_test_docbook2X_sgml2xml-isoent_02                        | success  |
|                        | oe_test_docbook2X_sgml2xml-isoent_03                        | success  |
|                        | oe_test_docbook2X_sgml2xml-isoent_04                        | success  |
|                        | oe_test_docbook2X_utf8trans                                 | success  |
| dos2unix               | oe_test_dos2unix                                            | success  |
| dovecot                | oe_test_dovecot_basic                                       | success  |
|                        | oe_test_dovecot_doveadm_1                                   | success  |
|                        | oe_test_dovecot_doveadm_2                                   | success  |
|                        | oe_test_dovecot_doveadm_3                                   | success  |
|                        | oe_test_service_dovecot-init                                | success  |
|                        | oe_test_service_dovecot                                     | success  |
|                        | oe_test_socket_dovecot                                      | success  |
| doxygen                | oe_test_doxygen                                             | success  |
| e2fsprogs              | oe_test_service_e2scrub_all                                 | success  |
|                        | oe_test_service_e2scrub_reap                                | success  |
| elinks                 | oe_test_elinks_base_01                                      | success  |
|                        | oe_test_elinks_base_02                                      | success  |
|                        | oe_test_elinks_base_03                                      | success  |
| erlang                 | oe_test_service_epmd                                        | success  |
|                        | oe_test_socket_epmd                                         | success  |
| fakechroot             | oe_test_fakechroot_base_01                                  | success  |
|                        | oe_test_fakechroot_base_02                                  | success  |
|                        | oe_test_fakechroot_chroot                                   | success  |
|                        | oe_test_fakechroot_env_01                                   | success  |
|                        | oe_test_fakechroot_env_02                                   | success  |
| fakeroot               | oe_test_fakeroot_base                                       | success  |
|                        | oe_test_fakeroot_faked                                      | success  |
| flatpak                | oe_test_service_flatpak-system-helper                       | success  |
| fontforge              | oe_test_fontforge_fontforge                                 | success  |
|                        | oe_test_fontforge_fontimage                                 | success  |
|                        | oe_test_fontforge_fontlint                                  | success  |
| fprintd                | oe_test_service_fprintd                                     | success  |
| fwupd                  | oe_test_service_fwupd-offline-update                        | success  |
|                        | oe_test_service_fwupd                                       | success  |
| galera                 | oe_test_galera_garbd                                        | success  |
|                        | oe_test_service_garbd                                       | success  |
| geoclue2               | oe_test_service_geoclue                                     | success  |
| git                    | oe_test_socket_git                                          | success  |
| glibc                  | oe_test_service_nscd                                        | success  |
|                        | oe_test_socket_nscd                                         | success  |
| glusterfs              | oe_test_service_gluster-ta-volume                           | success  |
|                        | oe_test_service_glusterd                                    | success  |
|                        | oe_test_service_glustereventsd                              | success  |
|                        | oe_test_service_glusterfsd                                  | success  |
|                        | oe_test_service_glusterfssharedstorage                      | success  |
| gnome-shell            | oe_test_gnome-shell                                         | success  |
| gperf                  | oe_test_gperf_base_01                                       | success  |
|                        | oe_test_gperf_base_02                                       | success  |
|                        | oe_test_gperf_base_03                                       | success  |
|                        | oe_test_gperf_base_04                                       | success  |
|                        | oe_test_gperf_base_05                                       | success  |
|                        | oe_test_gperf_base_06                                       | success  |
|                        | oe_test_gperf_base_07                                       | success  |
| gpm                    | oe_test_service_gpm                                         | success  |
| gssproxy               | oe_test_service_gssproxy                                    | success  |
| haproxy                | oe_test_service_haproxy                                     | success  |
| haveged                | oe_test_service_haveged                                     | success  |
| help2man               | oe_test_help2man                                            | success  |
| hivex                  | oe_test_hivex_hivexget                                      | success  |
|                        | oe_test_hivex_hivexregedit                                  | success  |
|                        | oe_test_hivex_hivexsh_01                                    | success  |
|                        | oe_test_hivex_hivexsh_02                                    | success  |
| hsqldb                 | oe_test_service_hsqldb                                      | success  |
| htslib                 | oe_test_htslib_bgzip_01                                     | success  |
|                        | oe_test_htslib_bgzip_02                                     | success  |
|                        | oe_test_htslib_htsfile                                      | success  |
|                        | oe_test_htslib_tabix                                        | success  |
| httpd                  | oe_test_service_htcacheclean                                | success  |
|                        | oe_test_service_httpd-init                                  | success  |
|                        | oe_test_service_httpd                                       | success  |
|                        | oe_test_socket_httpd                                        | success  |
| initial-setup          | oe_test_service_initial-setup-reconfiguration               | success  |
| intltool               | oe_test_intltool_intltool-extract                           | success  |
|                        | oe_test_intltool_intltool-merge_01                          | success  |
|                        | oe_test_intltool_intltool-merge_02                          | success  |
|                        | oe_test_intltool_intltool-prepare                           | success  |
|                        | oe_test_intltool_intltool-update                            | success  |
|                        | oe_test_intltool_intltoolize                                | success  |
| libcap                 | oe_test_acl_allow_change_nochange                           | success  |
|                        | oe_test_acl_allow_change_ownership                          | success  |
|                        | oe_test_acl_bind_port                                       | success  |
|                        | oe_test_acl_ignore_dal_across                               | success  |
|                        | oe_test_acl_manage_net                                      | success  |
|                        | oe_test_acl_ordinary_users_setgid                           | success  |
|                        | oe_test_acl_send_kill_notbelong                             | success  |
|                        | oe_test_acl_verwrite_previous_rules                         | success  |
|                        | oe_test_libcap                                              | success  |
| libgpg-error           | oe_test_libgpg-error                                        | success  |
| libunistring           | oe_test_libunistring                                        | success  |
| man-db                 | oe_test_service_man-db-cache-update                         | success  |
|                        | oe_test_service_man-db                                      | success  |
|                        | oe_test_service_man-db_01                                   | success  |
| ntp                    | oe_test_service_ntp-wait                                    | success  |
|                        | oe_test_service_ntpd                                        | success  |
|                        | oe_test_service_ntpdate                                     | success  |
|                        | oe_test_service_sntp                                        | success  |
| openldap               | oe_test_service_slapd                                       | success  |
| openslp                | oe_test_service_slpd                                        | success  |
| pam                    | oe_test_service_pam_namespace                               | success  |
| polkit                 | oe_test_service_polkit                                      | success  |
| procps-ng              | oe_test_procps-ng-pmap                                      | success  |
| sqlite                 | oe_test_sqlite_alter_01                                     | success  |
|                        | oe_test_sqlite_command_01                                   | success  |
|                        | oe_test_sqlite_command_02                                   | success  |
|                        | oe_test_sqlite_command_03                                   | success  |
|                        | oe_test_sqlite_command_04                                   | success  |
|                        | oe_test_sqlite_command_05                                   | success  |
|                        | oe_test_sqlite_command_06                                   | success  |
|                        | oe_test_sqlite_command_07                                   | success  |
|                        | oe_test_sqlite_command_08                                   | success  |
|                        | oe_test_sqlite_create_06                                    | success  |
|                        | oe_test_sqlite_delete_01                                    | success  |
|                        | oe_test_sqlite_function_01                                  | success  |
|                        | oe_test_sqlite_function_02                                  | success  |
|                        | oe_test_sqlite_function_03                                  | success  |
|                        | oe_test_sqlite_function_04                                  | success  |
|                        | oe_test_sqlite_select_05                                    | success  |
|                        | oe_test_sqlite_update_01                                    | success  |
| timedatex              | oe_test_service_timedatex                                   | success  |
| util-linux             | oe_test_service_fstrim                                      | success  |
|                        | oe_test_service_uuidd                                       | success  |
|                        | oe_test_socket_uuidd                                        | success  |
| wpa_supplicant         | oe_test_service_wpa_supplicant                              | success  |
| ipwatchd               | oe_test_service_ipwatchd                                    | success  |
| isula-build            | oe_test_service_isula-build                                 | success  |
| jemalloc               | oe_test_jemalloc_01                                         | success  |
|                        | oe_test_jemalloc_02                                         | success  |
| jq                     | oe_test_jq                                                  | success  |
| kf5-kconfig-core       | oe_test_kf5-kconfig-core_01                                 | success  |
| kpatch                 | oe_test_service_kpatch                                      | success  |
| krb5                   | oe_test_service_kadmin                                      | success  |
|                        | oe_test_service_kprop                                       | success  |
|                        | oe_test_service_krb5kdc                                     | success  |
| ksh                    | oe_test_ksh                                                 | success  |
| libcanberra            | oe_test_service_canberra-system-bootup                      | success  |
|                        | oe_test_service_canberra-system-shutdown-reboot             | success  |
|                        | oe_test_service_canberra-system-shutdown                    | success  |
| libcgroup              | oe_test_service_cgconfig                                    | success  |
| libesmtp               | oe_test_libesmtp                                            | success  |
| libhangul              | oe_test_libhangul_hangul                                    | success  |
| libmemcached           | oe_test_memaslap                                            | success  |
|                        | oe_test_memcapable                                          | success  |
|                        | oe_test_memcat                                              | success  |
|                        | oe_test_memcp                                               | success  |
|                        | oe_test_memdump-memerror                                    | success  |
|                        | oe_test_memexist                                            | success  |
|                        | oe_test_memflush                                            | success  |
|                        | oe_test_memping                                             | success  |
|                        | oe_test_memrm                                               | success  |
|                        | oe_test_memslap                                             | success  |
|                        | oe_test_memstat                                             | success  |
|                        | oe_test_memtouch                                            | success  |
| libstoragemgmt         | oe_test_service_libstoragemgmt                              | success  |
| libvma                 | oe_test_service_vma                                         | success  |
| libwbxml               | oe_test_libwbxml_wbxml2xml                                  | success  |
|                        | oe_test_libwbxml_xml2wbxml                                  | success  |
| libzip                 | oe_test_libzip_zipcmp                                       | success  |
|                        | oe_test_libzip_zipmerge                                     | success  |
|                        | oe_test_libzip_ziptool                                      | success  |
| lorax                  | oe_test_socket_lorax-composer                               | success  |
|                        | oe_test_service_lorax-composer                              | success  |
| lsyncd                 | oe_test_service_lsyncd                                      | success  |
|                        | oe_test_rsync_lsyncd                                        | success  |
|                        | oe_test_direct_lsyncd                                       | success  |
|                        | oe_test_rsyncssh_lsyncd                                     | success  |
|                        | oe_test_command_lsyncd                                      | success  |
| ltrace                 | oe_test_ltrace_01                                           | success  |
|                        | oe_test_ltrace_02                                           | success  |
|                        | oe_test_ltrace_03                                           | success  |
|                        | oe_test_ltrace_04                                           | success  |
| lua-lunit              | oe_test_lua-lunit_base                                      | success  |
| lxcfs                  | oe_test_service_lxcfs                                       | success  |
| mac-robber             | oe_test_mac-robber                                          | success  |
| mariadb                | oe_test_service_mariadb                                     | success  |
|                        | oe_test_mariadb-db                                          | success  |
|                        | oe_test_mariadb-table                                       | success  |
| memcached              | oe_test_memcached_01                                        | success  |
|                        | oe_test_memcached_02                                        | success  |
|                        | oe_test_service_memcached                                   | success  |
| mksh                   | oe_test_mksh                                                | success  |
| mlocate                | oe_test_service_mlocate-updatedb                            | success  |
| mosquitto              | oe_test_service_mosquitto                                   | success  |
| mpich                  | oe_test_mpich_mpiexec_01                                    | success  |
|                        | oe_test_mpich_mpiexec_02                                    | success  |
|                        | oe_test_mpich_mpirun_01                                     | success  |
|                        | oe_test_mpich_mpirun_02                                     | success  |
| mt-st                  | oe_test_service_stinit                                      | success  |
| munge                  | oe_test_service_munge                                       | success  |
| mutt                   | oe_test_mutt                                                | success  |
| nagios                 | oe_test_service_nagios                                      | success  |
| openhpi                | oe_test_service_openhpid                                    | success  |
| openjade               | oe_test_openjade_jade_01                                    | success  |
|                        | oe_test_openjade_jade_02                                    | success  |
|                        | oe_test_openjade_jade_03                                    | success  |
|                        | oe_test_openjade_openjade_01                                | success  |
|                        | oe_test_openjade_openjade_02                                | success  |
|                        | oe_test_openjade_openjade_03                                | success  |
|                        | oe_test_openjade_openjade_04                                | success  |
| netcf                  | oe_test_service_netcf-transaction                           | success  |
| netdata                | oe_test_netdata                                             | success  |
| netperf                | oe_test_netperf_basic_command                               | success  |
|                        | oe_test_netperf_diff_connect_model                          | success  |
|                        | oe_test_netperf_remote_command                              | success  |
| nfs-utils              | oe_test_service_auth-rpcgss-module                          | success  |
|                        | oe_test_service_nfs                                         | success  |
|                        | oe_test_service_nfs-blkmap                                  | success  |
|                        | oe_test_service_nfs-idmap                                   | success  |
|                        | oe_test_service_nfs-idmapd                                  | success  |
|                        | oe_test_service_nfs-lock                                    | success  |
|                        | oe_test_service_nfs-mountd                                  | success  |
|                        | oe_test_service_nfs-secure                                  | success  |
|                        | oe_test_service_nfs-server                                  | success  |
|                        | oe_test_service_nfs-utils                                   | success  |
|                        | oe_test_service_nfsdcld                                     | success  |
|                        | oe_test_service_rpc-gssd                                    | success  |
|                        | oe_test_service_rpc-statd                                   | success  |
|                        | oe_test_service_rpc-statd-notify                            | success  |
|                        | oe_test_target_nfs-client                                   | success  |
|                        | oe_test_target_rpc_pipefs                                   | success  |
| nghttp2                | oe_test_service_nghttpx                                     | success  |
| nss-pam-ldapd          | oe_test_service_nslcd                                       | success  |
| nss_wrapper            | oe_test_nss_wrapper                                         | success  |
| objectweb-asm3         | oe_test_objectweb-asm3-processor                            | success  |
| oddjob                 | oe_test_service_oddjobd                                     | success  |
| open-isns              | oe_test_service_isnsd                                       | success  |
| opencc                 | oe_test_opencc_01                                           | success  |
| opencryptoki           | oe_test_service_pkcsslotd                                   | success  |
| opensm                 | oe_test_service_opensm                                      | success  |
| opensp                 | oe_test_opensp_onsgmls                                      | success  |
|                        | oe_test_opensp_osgmlnorm                                    | success  |
|                        | oe_test_opensp_ospam_spam                                   | success  |
|                        | oe_test_opensp_ospcat                                       | success  |
|                        | oe_test_opensp_ospent_spent                                 | success  |
|                        | oe_test_opensp_osx                                          | success  |
| optipng                | oe_test_optipng_01                                          | success  |
|                        | oe_test_optipng_02                                          | success  |
| ostree                 | oe_test_service_ostree-finalize-staged                      | success  |
| p7zip                  | oe_test_p7zip_7za_001                                       | success  |
|                        | oe_test_p7zip_7za_002                                       | success  |
|                        | oe_test_p7zip_7za_003                                       | success  |
|                        | oe_test_p7zip_7za_004                                       | success  |
|                        | oe_test_p7zip_7za_005                                       | success  |
| papi                   | oe_test_papi_avail_01                                       | success  |
|                        | oe_test_papi_avail_02                                       | success  |
|                        | oe_test_papi_command_line                                   | success  |
|                        | oe_test_papi_native_avail_01                                | success  |
|                        | oe_test_papi_native_avail_02                                | success  |
|                        | oe_test_papi_xml_event_info                                 | success  |
| paps                   | oe_test_paps                                                | success  |
| pax                    | oe_test_pax_runtest_01                                      | success  |
|                        | oe_test_pax_runtest_02                                      | success  |
|                        | oe_test_pax_runtest_03                                      | success  |
|                        | oe_test_pax_runtest_04                                      | success  |
| pcp-export-pcp2json    | oe_test_pcp2json_01                                         | success  |
|                        | oe_test_pcp2json_02                                         | success  |
|                        | oe_test_pcp2json_03                                         | success  |
|                        | oe_test_pcp2json_04                                         | success  |
|                        | oe_test_pcp2json_05                                         | success  |
| pcp-export-pcp2xml     | oe_test_pcp2xml_01                                          | success  |
|                        | oe_test_pcp2xml_02                                          | success  |
|                        | oe_test_pcp2xml_03                                          | success  |
|                        | oe_test_pcp2xml_04                                          | success  |
| pcs                    | oe_test_service_pcs_snmp_agent                              | success  |
|                        | oe_test_service_pcsd                                        | success  |
|                        | oe_test_service_pcsd-ruby                                   | success  |
| pcsc-lite              | oe_test_service_pcscd                                       | success  |
|                        | oe_test_socket_pcscd                                        | success  |
| perl-Net-Server        | oe_test_perl-Net-Server                                     | success  |
| perl-Pod-Markdown      | oe_test_perl-Pod-Markdown_pod2markdown                      | success  |
| perl-libwww-perl       | oe_test_perl-libwww-perl_GET_01                             | success  |
|                        | oe_test_perl-libwww-perl_GET_02                             | success  |
|                        | oe_test_perl-libwww-perl_HEAD_01                            | success  |
|                        | oe_test_perl-libwww-perl_HEAD_02                            | success  |
|                        | oe_test_perl-libwww-perl_POST_01                            | success  |
|                        | oe_test_perl-libwww-perl_POST_02                            | success  |
|                        | oe_test_perl-libwww-perl_lwp-dump                           | success  |
|                        | oe_test_perl-libwww-perl_lwp_request_01                     | success  |
|                        | oe_test_perl-libwww-perl_lwp_request_02                     | success  |
| php                    | oe_test_phar                                                | success  |
|                        | oe_test_phar_phar                                           | success  |
|                        | oe_test_php                                                 | success  |
|                        | oe_test_php-cgi_phpize                                      | success  |
|                        | oe_test_php-config                                          | success  |
|                        | oe_test_php-fpm                                             | success  |
|                        | oe_test_phpdbg                                              | success  |
|                        | oe_test_service_php-fpm                                     | success  |
| plymouth               | oe_test_service_plymouth-halt                               | success  |
|                        | oe_test_service_plymouth-kexec                              | success  |
|                        | oe_test_service_plymouth-poweroff                           | success  |
|                        | oe_test_service_plymouth-quit                               | success  |
|                        | oe_test_service_plymouth-quit-wait                          | success  |
|                        | oe_test_service_plymouth-read-write                         | success  |
|                        | oe_test_service_plymouth-reboot                             | success  |
|                        | oe_test_service_plymouth-start                              | success  |
|                        | oe_test_service_plymouth-switch-root                        | success  |
|                        | oe_test_service_systemd-ask-password-plymouth               | success  |
| pngcrush               | oe_test_pngcrush_01                                         | success  |
|                        | oe_test_pngcrush_02                                         | success  |
|                        | oe_test_pngcrush_03                                         | success  |
|                        | oe_test_pngcrush_04                                         | success  |
|                        | oe_test_pngcrush_05                                         | success  |
| pngquant               | oe_test_pngquant                                            | success  |
| portreserve            | oe_test_service_portreserve                                 | success  |
| postfix                | oe_test_postfix_configuration                               | success  |
|                        | oe_test_service_postfix                                     | success  |
| powertop               | oe_test_powertop                                            | success  |
|                        | oe_test_service_powertop                                    | success  |
| proftpd                | oe_test_service_proftpd                                     | success  |
|                        | oe_test_socket_proftpd                                      | success  |
| qperf                  | oe_test_qperf_01                                            | success  |
| raptor2                | oe_test_raptor2_rapper_base_01                              | success  |
|                        | oe_test_raptor2_rapper_base_02                              | success  |
|                        | oe_test_raptor2_rapper_base_03                              | success  |
|                        | oe_test_raptor2_rapper_base_04                              | success  |
| rasqal                 | oe_test_roqet_base_01                                       | success  |
|                        | oe_test_roqet_base_02                                       | success  |
|                        | oe_test_roqet_base_03                                       | success  |
|                        | oe_test_roqet_base_04                                       | success  |
| redland                | oe_test_redland_rdfproc_01                                  | success  |
|                        | oe_test_redland_rdfproc_02                                  | success  |
| resource-agents        | oe_test_service_ldirectord                                  | success  |
|                        | oe_test_target_resource-agents-deps                         | success  |
| rinetd                 | oe_test_service_rinetd                                      | success  |
| rpcbind                | oe_test_service_rpcbind                                     | success  |
|                        | oe_test_socket_rpcbind                                      | success  |
| rpmlint                | oe_test_rpmdiff                                             | success  |
|                        | oe_test_rpmlint                                             | success  |
| rrdtool                | oe_test_rrdtool_create_01                                   | success  |
|                        | oe_test_rrdtool_create_02                                   | success  |
|                        | oe_test_rrdtool_dump                                        | success  |
|                        | oe_test_rrdtool_fetch                                       | success  |
|                        | oe_test_rrdtool_flushcached                                 | success  |
|                        | oe_test_rrdtool_graph_01                                    | success  |
|                        | oe_test_rrdtool_graph_02                                    | success  |
|                        | oe_test_rrdtool_graph_03                                    | success  |
|                        | oe_test_rrdtool_graph_04                                    | success  |
|                        | oe_test_rrdtool_graph_05                                    | success  |
|                        | oe_test_rrdtool_graph_06                                    | success  |
|                        | oe_test_rrdtool_graph_07                                    | success  |
|                        | oe_test_rrdtool_graph_08                                    | success  |
|                        | oe_test_rrdtool_graph_09                                    | success  |
|                        | oe_test_rrdtool_graph_10                                    | success  |
|                        | oe_test_rrdtool_graphv_01                                   | success  |
|                        | oe_test_rrdtool_graphv_02                                   | success  |
|                        | oe_test_rrdtool_graphv_03                                   | success  |
|                        | oe_test_rrdtool_graphv_04                                   | success  |
|                        | oe_test_rrdtool_graphv_05                                   | success  |
|                        | oe_test_rrdtool_graphv_06                                   | success  |
|                        | oe_test_rrdtool_graphv_07                                   | success  |
|                        | oe_test_rrdtool_graphv_08                                   | success  |
|                        | oe_test_rrdtool_graphv_09                                   | success  |
|                        | oe_test_rrdtool_graphv_10                                   | success  |
|                        | oe_test_rrdtool_info                                        | success  |
|                        | oe_test_rrdtool_restore                                     | success  |
|                        | oe_test_rrdtool_rrdcached_01                                | success  |
|                        | oe_test_rrdtool_rrdcached_02                                | success  |
|                        | oe_test_rrdtool_rrdcreate_01                                | success  |
|                        | oe_test_rrdtool_rrdcreate_02                                | success  |
|                        | oe_test_rrdtool_update                                      | success  |
|                        | oe_test_rrdtool_xport_01                                    | success  |
|                        | oe_test_rrdtool_xport_02                                    | success  |
|                        | oe_test_service_rrdcached                                   | success  |
|                        | oe_test_socket_rrdcached                                    | success  |
| rsync                  | oe_test_service_rsyncd                                      | success  |
|                        | oe_test_socket_rsyncd                                       | success  |
| rtkit                  | oe_test_service_rtkit-daemon                                | success  |
| sane-backends          | oe_test_socket_saned                                        | success  |
| sblim-sfcb             | oe_test_service_sblim-sfcb                                  | success  |
| scsi-target-utils      | oe_test_service_tgtd                                        | success  |
| sendmail               | oe_test_service_sendmail                                    | success  |
|                        | oe_test_service_sm-client                                   | success  |
| smartmontools          | oe_test_service_smartd                                      | success  |
| smoke-module           | oe_test_module                                              | success  |
| sphinx                 | oe_test_service_searchd                                     | success  |
| spice-vdagent          | oe_test_service_spice-vdagentd                              | success  |
|                        | oe_test_socket_spice-vdagentd                               | success  |
| sqlite-jdbc            | oe_test_sqlite-jdbc_connect                                 | success  |
| squid                  | oe_test_service_squid                                       | success  |
| sssd                   | oe_test_service_sssd                                        | success  |
|                        | oe_test_service_sssd-autofs                                 | success  |
|                        | oe_test_service_sssd-ifp                                    | success  |
|                        | oe_test_service_sssd-kcm                                    | success  |
|                        | oe_test_service_sssd-nss                                    | success  |
|                        | oe_test_service_sssd-pac                                    | success  |
|                        | oe_test_service_sssd-pam                                    | success  |
|                        | oe_test_service_sssd-ssh                                    | success  |
|                        | oe_test_service_sssd-sudo                                   | success  |
|                        | oe_test_socket_sssd-autofs                                  | success  |
|                        | oe_test_socket_sssd-kcm                                     | success  |
|                        | oe_test_socket_sssd-nss                                     | success  |
|                        | oe_test_socket_sssd-pac                                     | success  |
|                        | oe_test_socket_sssd-pam                                     | success  |
|                        | oe_test_socket_sssd-pam-priv                                | success  |
|                        | oe_test_socket_sssd-ssh                                     | success  |
|                        | oe_test_socket_sssd-sudo                                    | success  |
| stunnel                | oe_test_service_stunnel                                     | success  |
| swig                   | oe_test_swig_01                                             | success  |
|                        | oe_test_swig_02                                             | success  |
|                        | oe_test_swig_03                                             | success  |
|                        | oe_test_swig_04                                             | success  |
|                        | oe_test_swig_05                                             | success  |
|                        | oe_test_swig_06                                             | success  |
|                        | oe_test_swig_07                                             | success  |
|                        | oe_test_swig_08                                             | success  |
|                        | oe_test_swig_09                                             | success  |
|                        | oe_test_swig_10                                             | success  |
|                        | oe_test_swig_11                                             | success  |
| switcheroo-control     | oe_test_service_switcheroo-control                          | success  |
| sysprof                | oe_test_service_sysprof2                                    | success  |
|                        | oe_test_service_sysprof3                                    | success  |
| sysstat                | oe_test_service_sysstat                                     | success  |
|                        | oe_test_service_sysstat-collect                             | success  |
|                        | oe_test_service_sysstat-summary                             | success  |
|                        | oe_test_sysstat_iostat                                      | success  |
| tang                   | oe_test_service_tangd-keygen                                | success  |
|                        | oe_test_service_tangd-update                                | success  |
|                        | oe_test_socket_tangd                                        | success  |
| tcllib                 | oe_test_tcllib_dtplite                                      | success  |
|                        | oe_test_tcllib_nns                                          | success  |
|                        | oe_test_tcllib_page                                         | success  |
| telnet                 | oe_test_socket_telnet                                       | success  |
| tftp                   | oe_test_service_tftp                                        | success  |
|                        | oe_test_socket_tftp                                         | success  |
| tidy                   | oe_test_tidy_character_encodings                            | success  |
|                        | oe_test_tidy_cleanup_options                                | success  |
|                        | oe_test_tidy_diagnostics_options                            | success  |
|                        | oe_test_tidy_document_display_options                       | success  |
|                        | oe_test_tidy_document_in_and_out_options                    | success  |
|                        | oe_test_tidy_encoding_options                               | success  |
|                        | oe_test_tidy_entities_options                               | success  |
|                        | oe_test_tidy_file_input-output_options                      | success  |
|                        | oe_test_tidy_file_manipulation                              | success  |
|                        | oe_test_tidy_miscellaneous                                  | success  |
|                        | oe_test_tidy_pretty_print_options                           | success  |
|                        | oe_test_tidy_processing_directives                          | success  |
|                        | oe_test_tidy_repair_options                                 | success  |
|                        | oe_test_tidy_teaching_tidy_options                          | success  |
|                        | oe_test_tidy_transformation_options                         | success  |
|                        | oe_test_tidy_xml                                            | success  |
| tigervnc               | oe_test_socket_xvnc                                         | success  |
| tog-pegasus            | oe_test_service_tog-pegasus                                 | success  |
| ttmkfdir               | oe_test_ttmkfdir_base_01                                    | success  |
|                        | oe_test_ttmkfdir_base_02                                    | success  |
| umoci                  | oe_test_umoci                                               | success  |
| upower                 | oe_test_service_upower                                      | success  |
| usbmuxd                | oe_test_service_usbmuxd                                     | success  |
| uuid                   | oe_test_uuid_1                                              | success  |
|                        | oe_test_uuid_2                                              | success  |
| valgrind               | oe_test_valgrind                                            | success  |
| varnish                | oe_test_service_varnish                                     | success  |
|                        | oe_test_service_varnishncsa                                 | success  |
| vsftpd                 | oe_test_service_vsftpd                                      | success  |
|                        | oe_test_target_vsftpd                                       | success  |
| watchdog               | oe_test_service_watchdog                                    | success  |
|                        | oe_test_service_watchdog-ping                               | success  |
|                        | oe_test_watchdog_001                                        | success  |
| webbench               | oe_test_webbench                                            | success  |
| x265                   | oe_test_x265                                                | success  |
| xapian-core            | oe_test_xapian-core_copydatabase                            | success  |
|                        | oe_test_xapian-core_quest_01                                | success  |
|                        | oe_test_xapian-core_quest_02                                | success  |
|                        | oe_test_xapian-core_quest_03                                | success  |
|                        | oe_test_xapian-core_simpleindex                             | success  |
|                        | oe_test_xapian-core_xapian-check                            | success  |
|                        | oe_test_xapian-core_xapian-compact                          | success  |
|                        | oe_test_xapian-core_xapian-config                           | success  |
|                        | oe_test_xapian-core_xapian-delve_01                         | success  |
|                        | oe_test_xapian-core_xapian-delve_02                         | success  |
|                        | oe_test_xapian-core_xapian-metadata                         | success  |
|                        | oe_test_xapian-core_xapian-pos                              | success  |
|                        | oe_test_xapian-core_xapian-progsrv                          | success  |
|                        | oe_test_xapian-core_xapian-replicate-server                 | success  |
|                        | oe_test_xapian-core_xapian-replicate_01                     | success  |
|                        | oe_test_xapian-core_xapian-replicate_02                     | success  |
|                        | oe_test_xapian-core_xapian-tcpsrv                           | success  |
| xdelta                 | oe_test_xdelta_001                                          | success  |
|                        | oe_test_xdelta_002                                          | success  |
|                        | oe_test_xdelta_003                                          | success  |
| xfsprogs               | oe_test_service_xfs_scrub_all                               | success  |
| xinetd                 | oe_test_service_xinetd                                      | success  |
| xmltoman               | oe_test_xmltoman                                            | success  |
| ypbind                 | oe_test_service_ypbind                                      | success  |
| ypserv                 | oe_test_service_yppasswdd                                   | success  |
|                        | oe_test_service_ypserv                                      | success  |
|                        | oe_test_service_ypxfrd                                      | success  |
| zerofree               | oe_test_zerofree                                            | success  |
| zvbi                   | oe_test_service_zvbid                                       | success  |
| apr                    | oe_test_apr_001                                             | success  |
|                        | oe_test_apr_002                                             | success  |
| automake               | oe_test_automake                                            | success  |
| createrepo_c           | oe_test_createrepo_c_local_repo                             | success  |
| diffutils              | oe_test_diffutils_001                                       | success  |
|                        | oe_test_diffutils_002                                       | success  |
|                        | oe_test_diffutils_003                                       | success  |
|                        | oe_test_diffutils_004                                       | success  |
| flac                   | oe_test_flac                                                | success  |
| fribidi                | oe_test_fribidi                                             | success  |
| gdb                    | oe_test_gdb_recovery_database                               | success  |
| ghostscript            | oe_test_ghostscript_001                                     | success  |
|                        | oe_test_ghostscript_002                                     | success  |
| grub2                  | oe_test_service_grub-boot-indeterminate                     | success  |
| gsl                    | oe_test_gsl_histogram_01                                    | success  |
|                        | oe_test_gsl_randlist_01                                     | success  |
|                        | oe_test_gsl_randlist_02                                     | success  |
|                        | oe_test_gsl_randlist_03                                     | success  |
|                        | oe_test_gsl_randlist_04                                     | success  |
| libldb                 | oe_test_libldb                                              | success  |
| libmicrohttpd          | oe_test_libmicrohttpd                                       | success  |
| libtar                 | oe_test_libtar                                              | success  |
| libxslt                | oe_test_libxslt                                             | success  |
| nspr                   | oe_test_nspr_001                                            | success  |
|                        | oe_test_nspr_002                                            | success  |
| nss                    | oe_test_nss                                                 | success  |
| openblas               | oe_test_openblas                                            | success  |
| openwsman              | oe_test_service_openwsmand                                  | success  |
| pixman                 | oe_test_pixman                                              | success  |
| pkgconf                | oe_test_pkgconf                                             | success  |
| poppler                | oe_test_poppler                                             | success  |
| protobuf               | oe_test_protobuf                                            | success  |
| python-blivet          | oe_test_service_blivet                                      | success  |
| slang                  | oe_test_slang_001                                           | success  |
| sudo                   | oe_test_sudo_cvtsudoers                                     | success  |
| os-basic               | oe_test_ACL_dir                                             | success  |
|                        | oe_test_IOaccess_100Mfile                                   | success  |
|                        | oe_test_IOaccess_1Gfile                                     | success  |
|                        | oe_test_IOaccess_500Mfile                                   | success  |
|                        | oe_test_ProcMgmt_at                                         | success  |
|                        | oe_test_ProcMgmt_crontab_cmd                                | success  |
|                        | oe_test_ProcMgmt_crontab_cronfile                           | success  |
|                        | oe_test_ProcMgmt_iostat                                     | success  |
|                        | oe_test_ProcMgmt_pgrep                                      | success  |
|                        | oe_test_ProcMgmt_ps                                         | success  |
|                        | oe_test_ProcMgmt_sar                                        | success  |
|                        | oe_test_ProcMgmt_start_kill                                 | success  |
|                        | oe_test_ProcMgmt_top                                        | success  |
|                        | oe_test_ProcMgmt_vmstat                                     | success  |
|                        | oe_test_USBinfo                                             | success  |
|                        | oe_test_ar                                                  | success  |
|                        | oe_test_auditc_01                                           | success  |
|                        | oe_test_autoscan                                            | success  |
|                        | oe_test_b2sum                                               | success  |
|                        | oe_test_base32                                              | success  |
|                        | oe_test_base64                                              | success  |
|                        | oe_test_basename                                            | success  |
|                        | oe_test_basic_UserMgmt_permission                           | success  |
|                        | oe_test_basic_create_group                                  | success  |
|                        | oe_test_basic_modify_group                                  | success  |
|                        | oe_test_basic_modify_user                                   | success  |
|                        | oe_test_basic_set_account_expiration_time                   | success  |
|                        | oe_test_basic_set_permissions                               | success  |
|                        | oe_test_brotli                                              | success  |
|                        | oe_test_bsdcat                                              | success  |
|                        | oe_test_bzcmp                                               | success  |
|                        | oe_test_c_stat                                              | success  |
|                        | oe_test_cairo                                               | success  |
|                        | oe_test_cal                                                 | success  |
|                        | oe_test_chgrp                                               | success  |
|                        | oe_test_chrony_Manuall                                      | success  |
|                        | oe_test_chrony_chronyc_cmd                                  | success  |
|                        | oe_test_chrony_chronyc_hardwaretime                         | success  |
|                        | oe_test_chrony_chronyc_ntpstat                              | success  |
|                        | oe_test_chrony_chronyd                                      | success  |
|                        | oe_test_chroot                                              | success  |
|                        | oe_test_cksum                                               | success  |
|                        | oe_test_cmd_id                                              | success  |
|                        | oe_test_cmd_su_user                                         | success  |
|                        | oe_test_cmd_sudo                                            | success  |
|                        | oe_test_comm                                                | success  |
|                        | oe_test_cut                                                 | success  |
|                        | oe_test_date                                                | success  |
|                        | oe_test_diff3                                               | success  |
|                        | oe_test_disk_tuned_disable                                  | success  |
|                        | oe_test_disk_tuned_install                                  | success  |
|                        | oe_test_disk_tuned_modify                                   | success  |
|                        | oe_test_disk_tuned_new                                      | success  |
|                        | oe_test_disk_tuned_set                                      | success  |
|                        | oe_test_du                                                  | success  |
|                        | oe_test_exiv2                                               | success  |
|                        | oe_test_expr                                                | success  |
|                        | oe_test_gcc_01                                              | success  |
|                        | oe_test_glibc                                               | success  |
|                        | oe_test_groff                                               | success  |
|                        | oe_test_group_access                                        | success  |
|                        | oe_test_groupdel                                            | success  |
|                        | oe_test_gsettings                                           | success  |
|                        | oe_test_history                                             | success  |
|                        | oe_test_home_directory                                      | success  |
|                        | oe_test_hwclock                                             | success  |
|                        | oe_test_json-c                                              | success  |
|                        | oe_test_kernel_cgroup                                       | success  |
|                        | oe_test_kernel_sysctl                                       | success  |
|                        | oe_test_libunistring                                        | success  |
|                        | oe_test_localectl                                           | success  |
|                        | oe_test_locate_001                                          | success  |
|                        | oe_test_look                                                | success  |
|                        | oe_test_lsusb                                               | success  |
|                        | oe_test_lua                                                 | success  |
|                        | oe_test_lz4                                                 | success  |
|                        | oe_test_man                                                 | success  |
|                        | oe_test_md5sum                                              | success  |
|                        | oe_test_net_IPVLAN                                          | success  |
|                        | oe_test_net_cmd_ifconfig                                    | success  |
|                        | oe_test_net_cmd_ping                                        | success  |
|                        | oe_test_net_cmd_telnet                                      | success  |
|                        | oe_test_net_config                                          | success  |
|                        | oe_test_net_conninfo_lsof                                   | success  |
|                        | oe_test_net_mtr                                             | success  |
|                        | oe_test_net_ncat                                            | success  |
|                        | oe_test_net_scriprts                                        | success  |
|                        | oe_test_net_setmode                                         | success  |
|                        | oe_test_nmcli_8023link                                      | success  |
|                        | oe_test_nmcli_Mgntconnect                                   | success  |
|                        | oe_test_nmcli_add_connect                                   | success  |
|                        | oe_test_nmcli_bridge                                        | success  |
|                        | oe_test_nmcli_cancel_auto                                   | success  |
|                        | oe_test_nmcli_con_reload                                    | success  |
|                        | oe_test_nmcli_config_gw                                     | success  |
|                        | oe_test_nmcli_device                                        | success  |
|                        | oe_test_nmcli_general                                       | success  |
|                        | oe_test_nmcli_route                                         | success  |
|                        | oe_test_nmcli_systemd_resolved                              | success  |
|                        | oe_test_nmcli_vlan                                          | success  |
|                        | oe_test_password_blank                                      | success  |
|                        | oe_test_password_change                                     | success  |
|                        | oe_test_paste                                               | success  |
|                        | oe_test_patch                                               | success  |
|                        | oe_test_pcre_use                                            | success  |
|                        | oe_test_performance_monitor_pcp                             | success  |
|                        | oe_test_popd_001                                            | success  |
|                        | oe_test_power_output_HTML                                   | success  |
|                        | oe_test_power_powertop_calibrate                            | success  |
|                        | oe_test_power_powertop_startup                              | success  |
|                        | oe_test_sdiff                                               | success  |
|                        | oe_test_server_fontconfig                                   | success  |
|                        | oe_test_server_git_install                                  | success  |
|                        | oe_test_server_httpd_checkfirewall                          | success  |
|                        | oe_test_server_httpd_port                                   | success  |
|                        | oe_test_server_httpd_recover                                | success  |
|                        | oe_test_server_httpd_restart                                | success  |
|                        | oe_test_server_httpd_tls                                    | success  |
|                        | oe_test_server_libtasn1                                     | success  |
|                        | oe_test_server_mariadb_backup                               | success  |
|                        | oe_test_server_mariadb_backupDB                             | success  |
|                        | oe_test_server_mariadb_backuptable                          | success  |
|                        | oe_test_server_mariadb_copy                                 | success  |
|                        | oe_test_server_mariadb_dump                                 | success  |
|                        | oe_test_server_mariadb_dumpMulDB                            | success  |
|                        | oe_test_server_mariadb_loadfile                             | success  |
|                        | oe_test_server_mariadb_onlinebackup                         | success  |
|                        | oe_test_server_mariadb_stop                                 | success  |
|                        | oe_test_server_mysql                                        | success  |
|                        | oe_test_server_openssh_key                                  | success  |
|                        | oe_test_server_openssh_restart                              | success  |
|                        | oe_test_server_openssh_secure                               | success  |
|                        | oe_test_server_postgresql                                   | success  |
|                        | oe_test_server_squid_ip                                     | success  |
|                        | oe_test_server_squid_proxy                                  | success  |
|                        | oe_test_server_vsftpd_restart                               | success  |
|                        | oe_test_sha256sum                                           | success  |
|                        | oe_test_shred                                               | success  |
|                        | oe_test_split                                               | success  |
|                        | oe_test_system_log_basic                                    | success  |
|                        | oe_test_system_log_device                                   | success  |
|                        | oe_test_system_log_process                                  | success  |
|                        | oe_test_system_log_security                                 | success  |
|                        | oe_test_system_monitor_process                              | success  |
|                        | oe_test_systool                                             | success  |
|                        | oe_test_tail                                                | success  |
|                        | oe_test_tcl                                                 | success  |
|                        | oe_test_timedatectl                                         | success  |
|                        | oe_test_ulimit                                              | success  |
|                        | oe_test_unlink                                              | success  |
|                        | oe_test_versioninfo                                         | success  |
|                        | oe_test_vim                                                 | success  |
|                        | oe_test_virt-what                                           | success  |
|                        | oe_test_whatis                                              | success  |
|                        | oe_test_whoami                                              | success  |
|                        | oe_test_zgrep                                               | success  |
|                        | oe_test_zstd                                                | success  |
| AT                     | oe_test_acl_001                                             | success  |
|                        | oe_test_acpid                                               | success  |
|                        | oe_test_aide_compare_database                               | success  |
|                        | oe_test_aide_update_database                                | success  |
|                        | oe_test_atd                                                 | success  |
|                        | oe_test_augeas_augtool                                      | success  |
|                        | oe_test_baseinfo                                            | success  |
|                        | oe_test_basic_ssh_001                                       | success  |
|                        | oe_test_bc                                                  | success  |
|                        | oe_test_bridge-utils_01                                     | success  |
|                        | oe_test_cd_002                                              | success  |
|                        | oe_test_chattr                                              | success  |
|                        | oe_test_chkconfig                                           | success  |
|                        | oe_test_chmod_001                                           | success  |
|                        | oe_test_chown_001                                           | success  |
|                        | oe_test_chroncy_001                                         | success  |
|                        | oe_test_chrt                                                | success  |
|                        | oe_test_cifsclient                                          | success  |
|                        | oe_test_cmp                                                 | success  |
|                        | oe_test_cockpit                                             | success  |
|                        | oe_test_cp_001                                              | success  |
|                        | oe_test_cpio                                                | success  |
|                        | oe_test_dateinfo_001                                        | success  |
|                        | oe_test_dd_001                                              | success  |
|                        | oe_test_df                                                  | success  |
|                        | oe_test_diffstat_001                                        | success  |
|                        | oe_test_file_001                                            | success  |
|                        | oe_test_gcc                                                 | success  |
|                        | oe_test_grep_001                                            | success  |
|                        | oe_test_group_001                                           | success  |
|                        | oe_test_group_002                                           | success  |
|                        | oe_test_haproxy                                             | success  |
|                        | oe_test_hdparm                                              | success  |
|                        | oe_test_httpd                                               | success  |
|                        | oe_test_iSula_install_deploy_001                            | success  |
|                        | oe_test_krb5                                                | success  |
|                        | oe_test_less_001                                            | success  |
|                        | oe_test_llvm                                                | success  |
|                        | oe_test_ln_001                                              | success  |
|                        | oe_test_localectl_001                                       | success  |
|                        | oe_test_logrotate_001                                       | success  |
|                        | oe_test_ls_001                                              | success  |
|                        | oe_test_lsscsi                                              | success  |
|                        | oe_test_lzo                                                 | success  |
|                        | oe_test_mkdir_001                                           | success  |
|                        | oe_test_mv_001                                              | success  |
|                        | oe_test_mv_002                                              | success  |
|                        | oe_test_ndctl                                               | success  |
|                        | oe_test_nfs                                                 | success  |
|                        | oe_test_openssl                                             | success  |
|                        | oe_test_pciutils                                            | success  |
|                        | oe_test_rm_001                                              | success  |
|                        | oe_test_rmdir_001                                           | success  |
|                        | oe_test_rsync                                               | success  |
|                        | oe_test_runc                                                | success  |
|                        | oe_test_selinux                                             | success  |
|                        | oe_test_sort                                                | success  |
|                        | oe_test_ssh                                                 | success  |
|                        | oe_test_syslog_dmesg_001                                    | success  |
|                        | oe_test_syslog_journalctl_001                               | success  |
|                        | oe_test_syslog_journalctl_002                               | success  |
|                        | oe_test_syslog_journald_001                                 | success  |
|                        | oe_test_system_level                                        | success  |
|                        | oe_test_tar_001                                             | success  |
|                        | oe_test_touch_001                                           | success  |
|                        | oe_test_umask_001                                           | success  |
|                        | oe_test_umask_002                                           | success  |
|                        | oe_test_uname                                               | success  |
|                        | oe_test_user_001                                            | success  |
|                        | oe_test_user_002                                            | success  |
|                        | oe_test_user_003                                            | success  |
|                        | oe_test_wc                                                  | success  |
|                        | oe_test_which                                               | success  |
|                        | oe_test_IPV6_traceroute6_01                                 | success  |
|                        | oe_test_IPV6_traceroute6_tracepath6                         | success  |
|                        | oe_test_IPVLAN_07                                           | success  |
|                        | oe_test_Netlink_ip_01                                       | success  |
|                        | oe_test_Numad_01                                            | success  |
|                        | oe_test_aide_basic_info                                     | success  |
|                        | oe_test_aide_config_cfgfile                                 | success  |
|                        | oe_test_aide_config_check                                   | success  |
|                        | oe_test_aide_init_database                                  | success  |
|                        | oe_test_aide_security                                       | success  |
|                        | oe_test_attr_001                                            | success  |
|                        | oe_test_audit_abnormal_kill                                 | success  |
|                        | oe_test_audit_fixed_memory_01                               | success  |
|                        | oe_test_curl_01                                             | success  |
|                        | oe_test_curl_02                                             | success  |
|                        | oe_test_curl_03                                             | success  |
|                        | oe_test_dbus                                                | success  |
|                        | oe_test_dbus-binging-tool                                   | success  |
|                        | oe_test_dbus-cleanup-sockets                                | success  |
|                        | oe_test_dbus-daemon                                         | success  |
|                        | oe_test_dbus-monitor                                        | success  |
|                        | oe_test_dbus-send                                           | success  |
|                        | oe_test_dbus-uuidgen                                        | success  |
|                        | oe_test_dhclient_01                                         | success  |
|                        | oe_test_expat                                               | success  |
|                        | oe_test_find                                                | success  |
|                        | oe_test_glibc_getaddrinfo_02                                | success  |
|                        | oe_test_gzip                                                | success  |
|                        | oe_test_hwclock                                             | success  |
|                        | oe_test_hwdata                                              | success  |
|                        | oe_test_ima_v2_manual_gen_digest_01                         | success  |
|                        | oe_test_ip6tables_02                                        | success  |
|                        | oe_test_iproute                                             | success  |
|                        | oe_test_iptables                                            | success  |
|                        | oe_test_ipv6_BRIDGE                                         | success  |
|                        | oe_test_ipv6_dnsmasq                                        | success  |
|                        | oe_test_ipv6_sysctl_01                                      | success  |
|                        | oe_test_ipv6_sysctl_02                                      | success  |
|                        | oe_test_less                                                | success  |
|                        | oe_test_let                                                 | success  |
|                        | oe_test_libcgroup_01                                        | success  |
|                        | oe_test_libcgroup_02                                        | success  |
|                        | oe_test_libcgroup_03                                        | success  |
|                        | oe_test_libcgroup_04                                        | success  |
|                        | oe_test_libuser_sm                                          | success  |
|                        | oe_test_libxml2                                             | success  |
|                        | oe_test_lldpad                                              | success  |
|                        | oe_test_losetup                                             | success  |
|                        | oe_test_lsof                                                | success  |
|                        | oe_test_lz4_01                                              | success  |
|                        | oe_test_lz4_02                                              | success  |
|                        | oe_test_maildrop_delivery_agent                             | success  |
|                        | oe_test_mktemp                                              | success  |
|                        | oe_test_module                                              | success  |
|                        | oe_test_mpstat_01                                           | success  |
|                        | oe_test_mtr_01                                              | success  |
|                        | oe_test_netstat_01                                          | success  |
|                        | oe_test_nfs_01                                              | success  |
|                        | oe_test_nfs_02                                              | success  |
|                        | oe_test_nfs_03                                              | success  |
|                        | oe_test_nmap                                                | success  |
|                        | oe_test_ntp_01                                              | success  |
|                        | oe_test_ntp_02                                              | success  |
|                        | oe_test_pcre_001                                            | success  |
|                        | oe_test_perl                                                | success  |
|                        | oe_test_procps-ng-sysctl                                    | success  |
|                        | oe_test_procps-ng-uptime                                    | success  |
|                        | oe_test_pstree                                              | success  |
|                        | oe_test_pwd_002                                             | success  |
|                        | oe_test_python_01                                           | success  |
|                        | oe_test_python_pip_install                                  | success  |
|                        | oe_test_python_subprocess_01                                | success  |
|                        | oe_test_python_subprocess_02                                | success  |
|                        | oe_test_python_subprocess_03                                | success  |
|                        | oe_test_python_urllib3_urlopen_01                           | success  |
|                        | oe_test_python_urllib3_urlopen_02                           | success  |
|                        | oe_test_python_urllib3_urlopen_03                           | success  |
|                        | oe_test_route_ipv4                                          | success  |
|                        | oe_test_rpcbind                                             | success  |
|                        | oe_test_rpm_cmd                                             | success  |
|                        | oe_test_rpmrebuild                                          | success  |
|                        | oe_test_sadf_001                                            | success  |
|                        | oe_test_sar_01                                              | success  |
|                        | oe_test_setools                                             | success  |
|                        | oe_test_shadow                                              | success  |
|                        | oe_test_source                                              | success  |
|                        | oe_test_sshd                                                | success  |
|                        | oe_test_sudo                                                | success  |
|                        | oe_test_sudo_E                                              | success  |
|                        | oe_test_sudo_U                                              | success  |
|                        | oe_test_sudo_maxseq                                         | success  |
|                        | oe_test_systemd-update-utmp                                 | success  |
|                        | oe_test_systemd_SCEN_02                                     | success  |
|                        | oe_test_systemd_SCEN_03                                     | success  |
|                        | oe_test_systemd_SCEN_04                                     | success  |
|                        | oe_test_systemd_SCEN_05                                     | success  |
|                        | oe_test_systemd_SCEN_06                                     | success  |
|                        | oe_test_systemd_SCEN_07                                     | success  |
|                        | oe_test_systemd_SCEN_08                                     | success  |
|                        | oe_test_systemd_SCEN_09                                     | success  |
|                        | oe_test_systemd_SCEN_10                                     | success  |
|                        | oe_test_systemd_SCEN_11                                     | success  |
|                        | oe_test_systemd_SCEN_12                                     | success  |
|                        | oe_test_systemd_SCEN_13                                     | success  |
|                        | oe_test_systemd_SCEN_14                                     | success  |
|                        | oe_test_systemd_SCEN_15                                     | success  |
|                        | oe_test_tcpdump                                             | success  |
|                        | oe_test_time_01                                             | success  |
|                        | oe_test_time_02                                             | success  |
|                        | oe_test_unalias_001                                         | success  |
|                        | oe_test_unset_001                                           | success  |
|                        | oe_test_user_debug_iotop_SCEN_01                            | success  |
|                        | oe_test_vmstat                                              | success  |
|                        | oe_test_wget                                                | success  |
| NetworkManager         | oe_test_service_NetworkManager-dispatcher                   | success  |
|                        | oe_test_service_NetworkManager-wait-online                  | success  |
|                        | oe_test_service_NetworkManager                              | success  |
|                        | oe_test_service_nm-cloud-setup                              | success  |
| acl                    | oe_test_acl_add_write_permissions                           | success  |
|                        | oe_test_acl_chacl                                           | success  |
|                        | oe_test_acl_change_mask                                     | success  |
|                        | oe_test_acl_check_create                                    | success  |
|                        | oe_test_acl_defaulr_rule                                    | success  |
|                        | oe_test_acl_file                                            | success  |
|                        | oe_test_acl_getfacl                                         | success  |
|                        | oe_test_acl_only_root_permission                            | success  |
|                        | oe_test_acl_setfacl                                         | success  |
| alsa-utils             | oe_test_service_alsa-state                                  | success  |
| anaconda               | oe_test_service_anaconda-direct                             | success  |
|                        | oe_test_service_anaconda-fips                               | success  |
|                        | oe_test_service_anaconda-nm-config                          | success  |
|                        | oe_test_service_anaconda-noshell                            | success  |
|                        | oe_test_service_anaconda-pre                                | success  |
|                        | oe_test_service_anaconda-sshd                               | success  |
|                        | oe_test_service_anaconda                                    | success  |
|                        | oe_test_service_instperf                                    | success  |
|                        | oe_test_target_anaconda                                     | success  |
| ansible                | oe_test_ansible_01                                          | success  |
|                        | oe_test_ansible_02                                          | success  |
|                        | oe_test_ansible_03                                          | success  |
| ant                    | oe_test_ant_001                                             | success  |
|                        | oe_test_ant_003                                             | success  |
|                        | oe_test_ant_004                                             | success  |
|                        | oe_test_ant_005                                             | success  |
| aspell                 | oe_test_aspell_02                                           | success  |
|                        | oe_test_aspell_precat_01                                    | success  |
| atune                  | oe_test_service_atune-engine                                | success  |
| audit                  | oe_test_audit_monitor_security_event                        | success  |
| clamav                 | oe_test_clamav_clamav-milter                                | success  |
|                        | oe_test_clamav_clambc                                       | success  |
|                        | oe_test_clamav_clamconf                                     | success  |
|                        | oe_test_clamav_clamdscan_service                            | success  |
|                        | oe_test_clamav_clamsubmit                                   | success  |
|                        | oe_test_clamav_freshclam                                    | success  |
|                        | oe_test_clamav_sigtool_1                                    | success  |
|                        | oe_test_clamav_sigtool_2                                    | success  |
|                        | oe_test_service_clamav-milter                               | success  |
| cmake                  | oe_test_cmake                                               | success  |
|                        | oe_test_cmake3                                              | success  |
|                        | oe_test_cpack                                               | success  |
|                        | oe_test_cpack3                                              | success  |
|                        | oe_test_ctest                                               | success  |
|                        | oe_test_ctest3                                              | success  |
| cockpit                | oe_test_service_cockpit-motd                                | success  |
| corosync-qdevice       | oe_test_service_corosync-qnetd                              | success  |
| cppcheck               | oe_test_cppcheck-htmlreport                                 | success  |
| dejagnu                | oe_test_dejagnu_runtest_03                                  | success  |
| dhcp                   | oe_test_allocate_ipv4_addresses_dhcpd                       | success  |
|                        | oe_test_allocate_ipv6_addresses_dhcpd                       | success  |
| dnf                    | oe_test_dnf_alias                                           | success  |
|                        | oe_test_dnf_assumeno_autoremove                             | success  |
|                        | oe_test_dnf_automatic                                       | success  |
|                        | oe_test_dnf_check_diffenert-packages                        | success  |
|                        | oe_test_dnf_distro-sync_dnf-3                               | success  |
|                        | oe_test_dnf_help_history_info                               | success  |
|                        | oe_test_service_dnf-automatic-download                      | success  |
|                        | oe_test_service_dnf-automatic-install                       | success  |
|                        | oe_test_service_dnf-automatic-notifyonly                    | success  |
|                        | oe_test_service_dnf-automatic                               | success  |
|                        | oe_test_service_dnf-makecache                               | success  |
| dnssec-trigger         | oe_test_service_dnssec-triggerd-keygen                      | success  |
| dracut                 | oe_test_service_dracut-cmdline                              | success  |
|                        | oe_test_service_dracut-initqueue                            | success  |
|                        | oe_test_service_dracut-mount                                | success  |
|                        | oe_test_service_dracut-pre-mount                            | success  |
|                        | oe_test_service_dracut-pre-pivot                            | success  |
|                        | oe_test_service_dracut-pre-trigger                          | success  |
|                        | oe_test_service_dracut-pre-udev                             | success  |
| easymock               | oe_test_easymock_createNiceMock                             | success  |
|                        | oe_test_easymock_frequency_abnormal                         | success  |
|                        | oe_test_easymock_junit4                                     | success  |
|                        | oe_test_easymock_junit5                                     | success  |
|                        | oe_test_easymock_mock_abnormal                              | success  |
|                        | oe_test_easymock_order_abnormal                             | success  |
|                        | oe_test_easymock_parms_abnormal                             | success  |
|                        | oe_test_easymock_parms_match                                | success  |
|                        | oe_test_easymock_set_parms                                  | success  |
|                        | oe_test_easymock_simulate_interface                         | success  |
|                        | oe_test_easymock_simulate_object                            | success  |
| fftw                   | oe_test_fftw_fftw-wisdom_01                                 | success  |
|                        | oe_test_fftw_fftw-wisdom_03                                 | success  |
|                        | oe_test_fftw_fftwf-wisdom_01                                | success  |
|                        | oe_test_fftw_fftwf-wisdom_03                                | success  |
|                        | oe_test_fftw_fftwl-wisdom_01                                | success  |
|                        | oe_test_fftw_fftwl-wisdom_03                                | success  |
| firewalld              | oe_test_firewalld_block_all_icmp                            | success  |
|                        | oe_test_firewalld_default_rules                             | success  |
|                        | oe_test_firewalld_manage_icmp                               | success  |
|                        | oe_test_firewalld_permanent_rules_in_effect                 | success  |
|                        | oe_test_firewalld_runtime_rules_in_effect                   | success  |
|                        | oe_test_firewalld_set_priority                              | success  |
| freeradius             | oe_test_freeradius_freeradius-utils_radcryptAndRadeapclient | success  |
| ganglia                | oe_test_service_gmond                                       | success  |
| gegl04                 | oe_test_gegl04_gegl                                         | success  |
| htop                   | oe_test_htop_01                                             | success  |
| initscripts            | oe_test_service_readonly-root                               | success  |
| kernel                 | oe_test_cache_rw                                            | success  |
|                        | oe_test_kernel_cmd_02                                       | success  |
|                        | oe_test_kernel_cmd_03                                       | success  |
|                        | oe_test_swappiness                                          | success  |
| kmod                   | oe_test_kmod                                                | success  |
| libarchive             | oe_test_libarchive_bsdtar                                   | success  |
| lvm2                   | oe_test_service_blk-availability                            | success  |
|                        | oe_test_service_dm-event                                    | success  |
|                        | oe_test_service_lvm2-lvmdbusd                               | success  |
|                        | oe_test_socket_dm-event                                     | success  |
|                        | oe_test_socket_lvm2-lvmpolld                                | success  |
| net-tools              | oe_test_net-tools_netstat                                   | success  |
|                        | oe_test_service_arp-ethers                                  | success  |
| openssl                | oe_test_openssl_concurrent_operations                       | success  |
|                        | oe_test_openssl_enc                                         | success  |
|                        | oe_test_openssl_encrypting_character_string                 | success  |
|                        | oe_test_openssl_generate_random_number                      | success  |
|                        | oe_test_openssl_hmac                                        | success  |
|                        | oe_test_openssl_message_digest                              | success  |
|                        | oe_test_openssl_one_way_encryption                          | success  |
|                        | oe_test_openssl_related_concurrent_operations               | success  |
|                        | oe_test_openssl_repeated_execution                          | success  |
|                        | oe_test_openssl_sm2                                         | success  |
|                        | oe_test_openssl_sm4                                         | success  |
|                        | oe_test_openssl_symmetric_encryption_decryption             | success  |
|                        | oe_test_openssl_symmetrically_encrypts_decrypts_files       | success  |
| osc                    | oe_test_osc_01                                              | success  |
|                        | oe_test_osc_02                                              | success  |
|                        | oe_test_osc_03                                              | success  |
|                        | oe_test_osc_05                                              | success  |
|                        | oe_test_osc_06                                              | success  |
|                        | oe_test_osc_07                                              | success  |
| systemd                | oe_test_service_dbus-org.freedesktop.hostname1              | success  |
|                        | oe_test_service_dbus-org.freedesktop.locale1                | success  |
|                        | oe_test_service_dbus-org.freedesktop.login1                 | success  |
|                        | oe_test_service_dbus-org.freedesktop.machine1               | success  |
|                        | oe_test_service_dbus-org.freedesktop.timedate1              | success  |
|                        | oe_test_service_debug-shell                                 | success  |
|                        | oe_test_service_emergency                                   | success  |
|                        | oe_test_service_hwclock-save                                | success  |
|                        | oe_test_service_initrd-cleanup                              | success  |
|                        | oe_test_service_initrd-parse-etc                            | success  |
|                        | oe_test_service_initrd-udevadm-cleanup-db                   | success  |
|                        | oe_test_service_kmod-static-nodes                           | success  |
|                        | oe_test_service_ldconfig                                    | success  |
|                        | oe_test_service_rc-local                                    | success  |
|                        | oe_test_service_rescue                                      | success  |
|                        | oe_test_service_systemd-ask-password-console                | success  |
|                        | oe_test_service_systemd-binfmt                              | success  |
|                        | oe_test_service_systemd-bless-boot                          | success  |
|                        | oe_test_service_systemd-boot-system-token                   | success  |
|                        | oe_test_service_systemd-exit                                | success  |
|                        | oe_test_service_systemd-firstboot                           | success  |
|                        | oe_test_service_systemd-halt                                | success  |
|                        | oe_test_service_systemd-hibernate                           | success  |
|                        | oe_test_service_systemd-hostnamed                           | success  |
|                        | oe_test_service_systemd-hwdb-update                         | success  |
|                        | oe_test_service_systemd-hybrid-sleep                        | success  |
|                        | oe_test_service_systemd-journal-catalog-update              | success  |
|                        | oe_test_service_systemd-journal-flush                       | success  |
|                        | oe_test_service_systemd-journald                            | success  |
|                        | oe_test_service_systemd-kexec                               | success  |
|                        | oe_test_service_systemd-localed                             | success  |
|                        | oe_test_service_systemd-logind                              | success  |
|                        | oe_test_service_systemd-machine-id-commit                   | success  |
|                        | oe_test_service_systemd-machined                            | success  |
|                        | oe_test_service_systemd-modules-load                        | success  |
|                        | oe_test_service_systemd-poweroff                            | success  |
|                        | oe_test_service_systemd-pstore                              | success  |
|                        | oe_test_service_systemd-random-seed                         | success  |
|                        | oe_test_service_systemd-reboot                              | success  |
|                        | oe_test_service_systemd-remount-fs                          | success  |
|                        | oe_test_service_systemd-rfkill                              | success  |
|                        | oe_test_service_systemd-suspend-then-hibernate              | success  |
|                        | oe_test_service_systemd-suspend                             | success  |
|                        | oe_test_service_systemd-sysctl                              | success  |
|                        | oe_test_service_systemd-sysusers                            | success  |
|                        | oe_test_service_systemd-time-wait-sync                      | success  |
|                        | oe_test_service_systemd-timedated                           | success  |
|                        | oe_test_service_systemd-timesyncd                           | success  |
|                        | oe_test_service_systemd-tmpfiles-clean                      | success  |
|                        | oe_test_service_systemd-tmpfiles-setup-dev                  | success  |
|                        | oe_test_service_systemd-tmpfiles-setup                      | success  |
|                        | oe_test_service_systemd-udev-settle                         | success  |
|                        | oe_test_service_systemd-udev-trigger                        | success  |
|                        | oe_test_service_systemd-update-done                         | success  |
|                        | oe_test_service_systemd-update-utmp-runlevel                | success  |
|                        | oe_test_service_systemd-update-utmp                         | success  |
|                        | oe_test_service_systemd-user-sessions                       | success  |
|                        | oe_test_service_systemd-vconsole-setup                      | success  |
|                        | oe_test_service_systemd-volatile-root                       | success  |
|                        | oe_test_socket_systemd-coredump                             | success  |
|                        | oe_test_socket_systemd-initctl                              | success  |
|                        | oe_test_socket_systemd-journald-audit                       | success  |
|                        | oe_test_socket_systemd-journald                             | success  |
|                        | oe_test_socket_systemd-udevd-control                        | success  |
|                        | oe_test_socket_systemd-udevd-kernel                         | success  |
|                        | oe_test_target_basic                                        | success  |
|                        | oe_test_target_boot-complete                                | success  |
|                        | oe_test_target_ctrl-alt-del                                 | success  |
|                        | oe_test_target_default                                      | success  |
|                        | oe_test_target_emergency                                    | success  |
|                        | oe_test_target_exit                                         | success  |
|                        | oe_test_target_final                                        | success  |
|                        | oe_test_target_first-boot-complete                          | success  |
|                        | oe_test_target_getty-pre                                    | success  |
|                        | oe_test_target_getty                                        | success  |
|                        | oe_test_target_graphical                                    | success  |
|                        | oe_test_target_halt                                         | success  |
|                        | oe_test_target_hibernate                                    | success  |
|                        | oe_test_target_hybrid-sleep                                 | success  |
|                        | oe_test_target_initrd-fs                                    | success  |
|                        | oe_test_target_initrd-root-device                           | success  |
|                        | oe_test_target_initrd-root-fs                               | success  |
|                        | oe_test_target_initrd                                       | success  |
|                        | oe_test_target_kexec                                        | success  |
|                        | oe_test_target_local-fs-pre                                 | success  |
|                        | oe_test_target_local-fs                                     | success  |
|                        | oe_test_target_machines                                     | success  |
|                        | oe_test_target_multi-user                                   | success  |
|                        | oe_test_target_network-online                               | success  |
|                        | oe_test_target_network-pre                                  | success  |
|                        | oe_test_target_network                                      | success  |
|                        | oe_test_target_nss-lookup                                   | success  |
|                        | oe_test_target_nss-user-lookup                              | success  |
|                        | oe_test_target_paths                                        | success  |
|                        | oe_test_target_poweroff                                     | success  |
|                        | oe_test_target_reboot                                       | success  |
|                        | oe_test_target_remote-fs-pre                                | success  |
|                        | oe_test_target_remote-fs                                    | success  |
|                        | oe_test_target_rescue                                       | success  |
|                        | oe_test_target_rpcbind                                      | success  |
|                        | oe_test_target_runlevel0                                    | success  |
|                        | oe_test_target_runlevel1                                    | success  |
|                        | oe_test_target_runlevel2                                    | success  |
|                        | oe_test_target_runlevel3                                    | success  |
|                        | oe_test_target_runlevel4                                    | success  |
|                        | oe_test_target_runlevel5                                    | success  |
|                        | oe_test_target_runlevel6                                    | success  |
|                        | oe_test_target_shutdown                                     | success  |
|                        | oe_test_target_sigpwr                                       | success  |
|                        | oe_test_target_sleep                                        | success  |
|                        | oe_test_target_slices                                       | success  |
|                        | oe_test_target_sockets                                      | success  |
|                        | oe_test_target_suspend-then-hibernate                       | success  |
|                        | oe_test_target_suspend                                      | success  |
|                        | oe_test_target_swap                                         | success  |
|                        | oe_test_target_sysinit                                      | success  |
|                        | oe_test_target_system-update-pre                            | success  |
|                        | oe_test_target_system-update                                | success  |
|                        | oe_test_target_time-set                                     | success  |
|                        | oe_test_target_time-sync                                    | success  |
|                        | oe_test_target_timers                                       | success  |
|                        | oe_test_target_umount                                       | success  |
| iperf3                 | oe_test_iperf3_client                                       | success  |
| ipvsadm                | oe_test_ipvs_SCEN_off_httpd_01                              | success  |
|                        | oe_test_ipvs_SCEN_on_firewalld_01                           | success  |
|                        | oe_test_ipvs_SCEN_DR_01                                     | success  |
|                        | oe_test_ipvs_SCEN_DR_02                                     | success  |
|                        | oe_test_ipvs_SCEN_DR_03                                     | success  |
|                        | oe_test_ipvs_SCEN_DR_04                                     | success  |
|                        | oe_test_ipvs_SCEN_DR_07                                     | success  |
|                        | oe_test_ipvs_SCEN_DR_08                                     | success  |
|                        | oe_test_ipvs_SCEN_TUN_01                                    | success  |
|                        | oe_test_ipvs_SCEN_TUN_02                                    | success  |
|                        | oe_test_ipvs_SCEN_TUN_03                                    | success  |
|                        | oe_test_ipvs_SCEN_TUN_04                                    | success  |
|                        | oe_test_ipvs_SCEN_TUN_07                                    | success  |
|                        | oe_test_ipvs_SCEN_TUN_08                                    | success  |
|                        | oe_test_service_ipvsadm                                     | success  |
| java-1.8.0-openjdk     | oe_test_openjdk_javap_jcmd                                  | success  |
|                        | oe_test_openjdk_javadoc_javah                               | success  |
|                        | oe_test_openjdk_jsadebugd_jstack                            | success  |
|                        | oe_test_openjdk_jjs_jmap                                    | success  |
|                        | oe_test_openjdk_native2ascii_pack200                        | success  |
|                        | oe_test_openjdk_rmic_rmid                                   | success  |
|                        | oe_test_openjdk_servertool_unpack200                        | success  |
|                        | oe_test_java                                                | success  |
| javapackages-tools     | oe_test_javapackages-local                                  | success  |
| junit5                 | oe_test_junit5_annotation_tag                               | success  |
|                        | oe_test_junit5_annotation_timeout                           | success  |
|                        | oe_test_junit5_ant                                          | success  |
|                        | oe_test_junit5_abnormal_removejar                           | success  |
|                        | oe_test_junit5_epeat                                        | success  |
|                        | oe_test_junit5_assert                                       | success  |
|                        | oe_test_junit5_junit4                                       | success  |
|                        | oe_test_junit5_maven                                        | success  |
|                        | oe_test_junit5_parametric                                   | success  |
|                        | oe_test_junit5_spring_maven                                 | success  |
| keyutils               | oe_test_keyutils-keyctl                                     | success  |
|                        | oe_test_keyutils-libs                                       | success  |
| libappstream-glib      | oe_test_libappstream-glib_appstream-builder_02              | success  |
|                        | oe_test_libappstream-glib_appstream-compose                 | success  |
|                        | oe_test_libappstream-glib_appstream-util_01                 | success  |
|                        | oe_test_libappstream-glib_appstream-builder_01              | success  |
|                        | oe_test_libappstream-glib_appstream-util_02                 | success  |
|                        | oe_test_libappstream-glib_appstream-util_04                 | success  |
|                        | oe_test_libappstream-glib_appstream-util_05                 | success  |
| libfabric              | oe_test_libfabric_fi_info_03                                | success  |
|                        | oe_test_libfabric_pingpong_01                               | success  |
|                        | oe_test_libfabric_pingpong_02                               | success  |
| libosinfo              | oe_test_osinfo-query                                        | success  |
|                        | oe_test_osinfo-install-script                               | success  |
| librabbitmq            | oe_test_librabbitmq_amqp-declare-queue                      | success  |
|                        | oe_test_librabbitmq_amqp-delete-queue                       | success  |
|                        | oe_test_librabbitmq_amqp-get                                | success  |
|                        | oe_test_librabbitmq_amqp-publish                            | success  |
| libreswan              | oe_test_libreswan_ipsec_01                                  | success  |
|                        | oe_test_libreswan_ipsec_02                                  | success  |
|                        | oe_test_libreswan_ipsec_03                                  | success  |
|                        | oe_test_libreswan_ipsec_algparse                            | success  |
|                        | oe_test_libreswan_ipsec_check                               | success  |
|                        | oe_test_libreswan_ipsec_pluto                               | success  |
|                        | oe_test_libreswan_ipsec_whack_1                             | success  |
|                        | oe_test_libreswan_ipsec_whack_2                             | success  |
|                        | oe_test_libreswan_ipsec_whack_3                             | success  |
|                        | oe_test_libreswan_ipsec_whack_4                             | success  |
| libvirt                | oe_test_service_libvirtd                                    | success  |
|                        | oe_test_service_libvirt-guests                              | success  |
|                        | oe_test_service_virtinterfaced                              | success  |
|                        | oe_test_service_virtlockd                                   | success  |
|                        | oe_test_service_virtlogd                                    | success  |
|                        | oe_test_service_virtnetworkd                                | success  |
|                        | oe_test_service_virtnodedevd                                | success  |
|                        | oe_test_service_virtnwfilterd                               | success  |
|                        | oe_test_service_virtproxyd                                  | success  |
|                        | oe_test_service_virtqemud                                   | success  |
|                        | oe_test_service_virtsecretd                                 | success  |
|                        | oe_test_service_virtstoraged                                | success  |
|                        | oe_test_socket_libvirtd-admin                               | success  |
|                        | oe_test_socket_libvirtd-ro                                  | success  |
|                        | oe_test_socket_libvirtd                                     | success  |
|                        | oe_test_socket_libvirtd-tcp                                 | success  |
|                        | oe_test_socket_libvirtd-tls                                 | success  |
|                        | oe_test_socket_virtinterfaced-admin                         | success  |
|                        | oe_test_socket_virtinterfaced                               | success  |
|                        | oe_test_socket_virtlockd-admin                              | success  |
|                        | oe_test_socket_virtlockd                                    | success  |
|                        | oe_test_socket_virtlogd-admin                               | success  |
|                        | oe_test_socket_virtlogd                                     | success  |
|                        | oe_test_socket_virtnetworkd-ro                              | success  |
|                        | oe_test_socket_virtnetworkd                                 | success  |
|                        | oe_test_socket_virtnodedevd-admin                           | success  |
|                        | oe_test_socket_virtnodedevd-ro                              | success  |
|                        | oe_test_socket_virtnodedevd                                 | success  |
|                        | oe_test_socket_virtnwfilterd-admin                          | success  |
|                        | oe_test_socket_virtnwfilterd-ro                             | success  |
|                        | oe_test_socket_virtnwfilterd                                | success  |
|                        | oe_test_socket_virtproxyd-admin                             | success  |
|                        | oe_test_socket_virtproxyd-ro                                | success  |
|                        | oe_test_socket_virtproxyd                                   | success  |
|                        | oe_test_socket_virtproxyd-tcp                               | success  |
|                        | oe_test_socket_virtproxyd-tls                               | success  |
|                        | oe_test_socket_virtqemud-admin                              | success  |
|                        | oe_test_socket_virtqemud-ro                                 | success  |
|                        | oe_test_socket_virtqemud                                    | success  |
|                        | oe_test_socket_virtsecretd-admin                            | success  |
|                        | oe_test_socket_virtsecretd-ro                               | success  |
|                        | oe_test_socket_virtsecretd                                  | success  |
|                        | oe_test_socket_virtstoraged-admin                           | success  |
|                        | oe_test_socket_virtstoraged-ro                              | success  |
|                        | oe_test_socket_virtstoraged                                 | success  |
|                        | oe_test_target_virt-guest-shutdown                          | success  |
| libwmf                 | oe_test_libwmf_wmf2eps_01                                   | success  |
|                        | oe_test_libwmf_wmf2eps_02                                   | success  |
|                        | oe_test_libwmf_wmf2eps_03                                   | success  |
|                        | oe_test_libwmf_wmf2gd_01                                    | success  |
|                        | oe_test_libwmf_wmf2gd_02                                    | success  |
|                        | oe_test_libwmf_wmf2fig_01                                   | success  |
|                        | oe_test_libwmf_wmf2fig_02                                   | success  |
|                        | oe_test_libwmf_wmf2fig_03                                   | success  |
|                        | oe_test_libwmf_wmf2svg_01                                   | success  |
|                        | oe_test_libwmf_wmf2svg_02                                   | success  |
| linuxptp               | oe_test_nsm                                                 | success  |
| lldpad                 | oe_test_socket_lldpad                                       | success  |
| lm_sensors             | oe_test_service_sensord                                     | success  |
| lxc                    | oe_test_service_lxc                                         | success  |
|                        | oe_test_lxc_unshare_update                                  | success  |
|                        | oe_test_lxc_checkconfig_console                             | success  |
|                        | oe_test_lxc_execute_freeze                                  | success  |
| mailman                | oe_test_service_mailman3                                    | success  |
|                        | oe_test_service_mailman3-digests                            | success  |
| mc                     | oe_test_mcdiff_01                                           | success  |
| mdadm                  | oe_test_service_mdcheck_continue                            | success  |
|                        | oe_test_service_mdcheck_start                               | success  |
| multipath-tools        | oe_test_socket_multipathd                                   | success  |
| nasm                   | oe_test_nasm_01                                             | success  |
|                        | oe_test_nasm_02                                             | success  |
|                        | oe_test_nasm_03                                             | success  |
|                        | oe_test_nasm_04                                             | success  |
|                        | oe_test_nasm_05                                             | success  |
|                        | oe_test_nasm_06                                             | success  |
|                        | oe_test_nasm_07                                             | success  |
|                        | oe_test_nasm_08                                             | success  |
|                        | oe_test_nasm_09                                             | success  |
|                        | oe_test_nasm_10                                             | success  |
|                        | oe_test_nasm_11                                             | success  |
|                        | oe_test_nasm_12                                             | success  |
|                        | oe_test_nasm_ndisasm_01                                     | success  |
|                        | oe_test_nasm_ndisasm_02                                     | success  |
| rsyslog                | oe_test_rsyslog_abnormal_config                             | success  |
|                        | oe_test_rsyslog_function_discard                            | success  |
|                        | oe_test_rsyslog_function_facility                           | success  |
|                        | oe_test_rsyslog_function_imfile                             | success  |
|                        | oe_test_rsyslog_function_postgreSQL                         | success  |
|                        | oe_test_rsyslog_function_priority                           | success  |
|                        | oe_test_rsyslog_function_rainerscript                       | success  |
|                        | oe_test_rsyslog_function_shell                              | success  |
|                        | oe_test_rsyslog_function_template                           | success  |
|                        | oe_test_rsyslog_function_wildcard                           | success  |
|                        | oe_test_rsyslog_parameter01                                 | success  |
|                        | oe_test_rsyslog_parameter02                                 | success  |
|                        | oe_test_rsyslog_parameter03                                 | success  |
|                        | oe_test_rsyslog_parameter04                                 | success  |
|                        | oe_test_rsyslog_reliability_operation                       | success  |
|                        | oe_test_rsyslog_reliability_restart                         | success  |
|                        | oe_test_service_rsyslog                                     | success  |
| FS_Device              | oe_test_raid_ro                                             | success  |
|                        | oe_test_raid_rw                                             | success  |
|                        | oe_test_swap_mkswap                                         | success  |
| FS_Directory           | oe_test_FSIO_dir_access                                     | success  |
|                        | oe_test_FSIO_dir_access_bin                                 | success  |
|                        | oe_test_FSIO_dir_access_lib64                               | success  |
|                        | oe_test_FSIO_dir_access_lostfound                           | success  |
|                        | oe_test_FSIO_dir_access_media                               | success  |
|                        | oe_test_FSIO_dir_access_mnt                                 | success  |
|                        | oe_test_FSIO_dir_access_opt                                 | success  |
|                        | oe_test_FSIO_dir_access_run                                 | success  |
|                        | oe_test_FSIO_dir_access_srv                                 | success  |
|                        | oe_test_FSIO_dir_access_sys                                 | success  |
|                        | oe_test_FSIO_dir_access_tmp                                 | success  |
|                        | oe_test_FSIO_dir_access_usr                                 | success  |
|                        | oe_test_FSIO_dir_bash_umask                                 | success  |
|                        | oe_test_FSIO_dir_check_basic_info                           | success  |
|                        | oe_test_FSIO_dir_chmod                                      | success  |
|                        | oe_test_FSIO_dir_chown                                      | success  |
|                        | oe_test_FSIO_dir_create                                     | success  |
|                        | oe_test_FSIO_dir_create_infs                                | success  |
|                        | oe_test_FSIO_dir_create_long_dirname                        | success  |
|                        | oe_test_FSIO_dir_mv_cp_1                                    | success  |
|                        | oe_test_FSIO_dir_mv_cp_2                                    | success  |
|                        | oe_test_FSIO_dir_rm                                         | success  |
|                        | oe_test_FSIO_dir_umask                                      | success  |
| FS_Negative            | oe_test_FSIO_boot_full_data                                 | success  |
|                        | oe_test_FSIO_cat_block_file                                 | success  |
|                        | oe_test_FSIO_cat_file_error_format                          | success  |
|                        | oe_test_FSIO_cat_stack                                      | success  |
|                        | oe_test_FSIO_check_rootfs                                   | success  |
|                        | oe_test_FSIO_create_file_format                             | success  |
|                        | oe_test_FSIO_create_file_noformat                           | success  |
|                        | oe_test_FSIO_create_hard_link_rm                            | success  |
|                        | oe_test_FSIO_e2fsck_datablock                               | success  |
|                        | oe_test_FSIO_fopen_r+_fail                                  | success  |
|                        | oe_test_FSIO_fread_larger_memsize                           | success  |
| FS_iSula               | oe_test_isula_check_overlay2fs                              | success  |
|                        | oe_test_isula_info                                          | success  |
| embedded_os_basic_test | oe_test_bashrc_umask                                        | success  |
|                        | oe_test_basic_cmd_acl                                       | success  |
|                        | oe_test_basic_cmd_cd                                        | success  |
|                        | oe_test_basic_cmd_chmod                                     | success  |
|                        | oe_test_basic_cmd_chown                                     | success  |
|                        | oe_test_basic_cmd_cp                                        | success  |
|                        | oe_test_basic_cmd_date                                      | success  |
|                        | oe_test_basic_cmd_dd                                        | success  |
|                        | oe_test_basic_cmd_df                                        | success  |
|                        | oe_test_basic_cmd_grep                                      | success  |
|                        | oe_test_basic_cmd_groupadd                                  | success  |
|                        | oe_test_basic_cmd_groupdel                                  | success  |
|                        | oe_test_basic_cmd_groupmod                                  | success  |
|                        | oe_test_basic_cmd_gzip                                      | success  |
|                        | oe_test_basic_cmd_id                                        | success  |
|                        | oe_test_basic_cmd_ln                                        | success  |
|                        | oe_test_basic_cmd_ls                                        | success  |
|                        | oe_test_basic_cmd_lsof                                      | success  |
|                        | oe_test_basic_cmd_mkdir                                     | success  |
|                        | oe_test_basic_cmd_mv                                        | success  |
|                        | oe_test_basic_cmd_pgrep                                     | success  |
|                        | oe_test_basic_cmd_ping                                      | success  |
|                        | oe_test_basic_cmd_ps                                        | success  |
|                        | oe_test_basic_cmd_pwd                                       | success  |
|                        | oe_test_basic_cmd_rm                                        | success  |
|                        | oe_test_basic_cmd_rmdir                                     | success  |
|                        | oe_test_basic_cmd_sort                                      | success  |
|                        | oe_test_basic_cmd_su                                        | success  |
|                        | oe_test_basic_cmd_sysctl                                    | success  |
|                        | oe_test_basic_cmd_tar                                       | success  |
|                        | oe_test_basic_cmd_top                                       | success  |
|                        | oe_test_basic_cmd_touch                                     | success  |
|                        | oe_test_basic_cmd_umask                                     | success  |
|                        | oe_test_basic_cmd_uname                                     | success  |
|                        | oe_test_basic_cmd_wc                                        | success  |
|                        | oe_test_basic_cmd_which                                     | success  |
|                        | oe_test_continuous_100M                                     | success  |
|                        | oe_test_system_monitor_process                              | success  |
|                        | oe_test_system_user_options_001                             | success  |
|                        | oe_test_system_user_options_002                             | success  |
|                        | oe_test_system_user_options_003                             | success  |
| nbdkit                 | oe_test_nbdkit_01                                           | success  |
|                        | oe_test_nbdkit_03                                           | success  |
| ndisc6                 | oe_test_ndisc6_addr2name                                    | success  |
|                        | oe_test_ndisc6_ndisc6                                       | success  |
|                        | oe_test_ndisc6_rdnssd                                       | success  |
|                        | oe_test_ndisc6_rltraceroute6                                | success  |
|                        | oe_test_ndisc6_tcpspray                                     | success  |
|                        | oe_test_ndisc6_tcptraceroute6                               | success  |
|                        | oe_test_ndisc6_tracert6                                     | success  |
| net-snmp               | oe_test_service_snmpd                                       | success  |
|                        | oe_test_service_snmptrapd                                   | success  |
| nftables               | oe_test_iptables_to_nftables                                | success  |
| nginx                  | oe_test_service_nginx                                       | success  |
| nmon                   | oe_test_nmon_03                                             | success  |
| ntfs-3g                | oe_test_ntfs-3g_mkfs.ntfs                                   | success  |
|                        | oe_test_ntfs-3g_mkntfs                                      | success  |
|                        | oe_test_ntfs-3g_ntfscat                                     | success  |
|                        | oe_test_ntfs-3g_ntfsclone_01                                | success  |
|                        | oe_test_ntfs-3g_ntfsclone_02                                | success  |
|                        | oe_test_ntfs-3g_ntfslabel                                   | success  |
|                        | oe_test_ntfs-3g_ntfstruncate                                | success  |
|                        | oe_test_ntfs-3g_ntfswipe_01                                 | success  |
|                        | oe_test_ntfs-3g_ntfswipe_02                                 | success  |
| obs-server             | oe_test_service_obsdeltastore                               | success  |
|                        | oe_test_service_obsdispatcher                               | success  |
|                        | oe_test_service_obsdodup                                    | success  |
|                        | oe_test_service_obsgetbinariesproxy                         | success  |
|                        | oe_test_service_obsnotifyforward                            | success  |
|                        | oe_test_service_obspublisher                                | success  |
|                        | oe_test_service_obsrepserver                                | success  |
|                        | oe_test_service_obsscheduler                                | success  |
|                        | oe_test_service_obsservice                                  | success  |
|                        | oe_test_service_obsservicedispatch                          | success  |
|                        | oe_test_service_obssigner                                   | success  |
|                        | oe_test_service_obssrcserver                                | success  |
|                        | oe_test_service_obsstoragesetup                             | success  |
|                        | oe_test_service_obswarden                                   | success  |
|                        | oe_test_service_obsworker                                   | success  |
|                        | oe_test_target_obs-api-support                              | success  |
| open-iscsi             | oe_test_service_iscsi                                       | success  |
|                        | oe_test_socket_iscsid                                       | success  |
| openscap               | oe_test_ensure_security_compliance                          | success  |
|                        | oe_test_fix_anisible                                        | success  |
|                        | oe_test_openscap_01                                         | success  |
|                        | oe_test_scanning_system                                     | success  |
| os-storage             | oe_test_storage_DevMgmt_fstrim                              | success  |
|                        | oe_test_storage_Mutipath_configure_parameter                | success  |
|                        | oe_test_storage_Mutipath_initramfs                          | success  |
|                        | oe_test_storage_btrfs_001                                   | success  |
|                        | oe_test_storage_diskpartiton_parted_create                  | success  |
|                        | oe_test_storage_diskpartiton_parted_delete                  | success  |
|                        | oe_test_storage_diskpartiton_parted_view                    | success  |
|                        | oe_test_storage_diskpartiton_view_lsblk                     | success  |
|                        | oe_test_storage_ext4_create                                 | success  |
|                        | oe_test_storage_ext4_resize                                 | success  |
|                        | oe_test_storage_fileCMD_cd                                  | success  |
|                        | oe_test_storage_fileCMD_chmod                               | success  |
|                        | oe_test_storage_fileCMD_chown                               | success  |
|                        | oe_test_storage_fileCMD_cp                                  | success  |
|                        | oe_test_storage_fileCMD_df                                  | success  |
|                        | oe_test_storage_fileCMD_file                                | success  |
|                        | oe_test_storage_fileCMD_grep                                | success  |
|                        | oe_test_storage_fileCMD_gzip                                | success  |
|                        | oe_test_storage_fileCMD_ln                                  | success  |
|                        | oe_test_storage_fileCMD_ls                                  | success  |
|                        | oe_test_storage_fileCMD_mkdir                               | success  |
|                        | oe_test_storage_fileCMD_mv                                  | success  |
|                        | oe_test_storage_fileCMD_rmdir                               | success  |
|                        | oe_test_storage_fileCMD_sort                                | success  |
|                        | oe_test_storage_fileCMD_tar                                 | success  |
|                        | oe_test_storage_fileCMD_touch                               | success  |
|                        | oe_test_storage_fileCMD_unzip                               | success  |
|                        | oe_test_storage_fileCMD_wc                                  | success  |
|                        | oe_test_storage_fileCMD_zip                                 | success  |
|                        | oe_test_storage_fileaccess_bashrc                           | success  |
|                        | oe_test_storage_lvm_VG_transfer                             | success  |
|                        | oe_test_storage_lvm_activation                              | success  |
|                        | oe_test_storage_lvm_help_info                               | success  |
|                        | oe_test_storage_lvm_print                                   | success  |
|                        | oe_test_storage_lvm_print_history                           | success  |
|                        | oe_test_storage_lvm_print_info                              | success  |
|                        | oe_test_storage_lvm_pvs                                     | success  |
|                        | oe_test_storage_lvm_rename                                  | success  |
|                        | oe_test_storage_lvm_rename_VG                               | success  |
|                        | oe_test_storage_lvm_resize_PV                               | success  |
|                        | oe_test_storage_lvm_set_lvconvert_volume                    | success  |
|                        | oe_test_storage_mount_prevent_copy                          | success  |
|                        | oe_test_storage_mount_private                               | success  |
|                        | oe_test_storage_mount_shared                                | success  |
|                        | oe_test_storage_nfs_RPC                                     | success  |
|                        | oe_test_storage_nfs_exportfs                                | success  |
|                        | oe_test_storage_nfs_modify_port                             | success  |
|                        | oe_test_storage_nfs_mount_RW                                | success  |
|                        | oe_test_storage_nfs_repeat_restart                          | success  |
|                        | oe_test_storage_nfs_rpcinfo                                 | success  |
|                        | oe_test_storage_nfs_showmount                               | success  |
|                        | oe_test_storage_nfs_start_server                            | success  |
| pacemaker              | oe_test_service_crm_mon                                     | success  |
|                        | oe_test_service_pacemaker_remote                            | success  |
| patchutils             | oe_test_patchutils_combinediff_02                           | success  |
|                        | oe_test_patchutils_filterdiff_01                            | success  |
|                        | oe_test_patchutils_filterdiff_02                            | success  |
|                        | oe_test_patchutils_filterdiff_03                            | success  |
|                        | oe_test_patchutils_flipdiff_02                              | success  |
|                        | oe_test_patchutils_grepdiff_01                              | success  |
|                        | oe_test_patchutils_grepdiff_02                              | success  |
|                        | oe_test_patchutils_grepdiff_03                              | success  |
|                        | oe_test_patchutils_grepdiff_04                              | success  |
|                        | oe_test_patchutils_interdiff_02                             | success  |
|                        | oe_test_patchutils_lsdiff_01                                | success  |
|                        | oe_test_patchutils_lsdiff_02                                | success  |
|                        | oe_test_patchutils_lsdiff_03                                | success  |
|                        | oe_test_patchutils_lsdiff_04                                | success  |
|                        | oe_test_patchutils_splitdiff                                | success  |
| pcp                    | oe_test_dbpmda                                              | success  |
|                        | oe_test_pcp                                                 | success  |
|                        | oe_test_pcp-summary_pcp-vmstat_pmcd_wait                    | success  |
|                        | oe_test_pcp_pcp-import-collectl2pcp                         | success  |
|                        | oe_test_pcp_pcp-import-iostat2pcp                           | success  |
|                        | oe_test_pcp_pcp-import-mrtg2pcp                             | success  |
|                        | oe_test_pcp_pcp-import-sar2pcp                              | success  |
|                        | oe_test_pmconfig_pmie_check                                 | success  |
|                        | oe_test_pmdate                                              | success  |
|                        | oe_test_pmdumplog_01                                        | success  |
|                        | oe_test_pmdumplog_02                                        | success  |
|                        | oe_test_pmevent_01                                          | success  |
|                        | oe_test_pmfind_pmgenmap_pmie2col_pminfo_01                  | success  |
|                        | oe_test_pminfo_02                                           | success  |
|                        | oe_test_pminfo_03                                           | success  |
|                        | oe_test_pmjson                                              | success  |
|                        | oe_test_pmlogconf_pmlogsize                                 | success  |
|                        | oe_test_pmlogger_daily_02                                   | success  |
|                        | oe_test_pmlogger_merge_pmlogger_rewrite                     | success  |
|                        | oe_test_pmloglabel                                          | success  |
|                        | oe_test_pmlogreduce_pmpause_pmpost_pmsleep                  | success  |
|                        | oe_test_pmlogsummary_01                                     | success  |
|                        | oe_test_pmlogsummary_02                                     | success  |
|                        | oe_test_pmprobe_02                                          | success  |
|                        | oe_test_pmpython_mkaf_pcp-python                            | success  |
|                        | oe_test_pmstat                                              | success  |
|                        | oe_test_pmstore_install-sh                                  | success  |
|                        | oe_test_pmval_01                                            | success  |
|                        | oe_test_service_pmcd                                        | success  |
|                        | oe_test_service_pmie                                        | success  |
|                        | oe_test_service_pmlogger                                    | success  |
|                        | oe_test_service_pmproxy                                     | success  |
| pcp-system-tools       | oe_test_dstat_01                                            | success  |
|                        | oe_test_dstat_02                                            | success  |
|                        | oe_test_pcp_dmcache                                         | success  |
|                        | oe_test_pcp_free                                            | success  |
|                        | oe_test_pmrep_01                                            | success  |
|                        | oe_test_pmrep_02                                            | success  |
|                        | oe_test_pmrep_03                                            | success  |
|                        | oe_test_pmrep_04                                            | success  |
|                        | oe_test_pmrep_05                                            | success  |
|                        | oe_test_pmrep_06                                            | success  |
| perl-Date-Manip        | oe_test_perl-Date-Manip_dm_zdump                            | success  |
|                        | oe_test_perl-Date-Manip_dm_date                             | x86 fail |
| pesign                 | oe_test_pesign_authvar                                      | success  |
|                        | oe_test_pesign_base_01                                      | success  |
|                        | oe_test_pesign_pesign-client_01                             | success  |
|                        | oe_test_pesign_pesign-client_02                             | success  |
|                        | oe_test_service_pesign                                      | success  |
| policycoreutils        | oe_test_service_selinux-autorelabel                         | success  |
|                        | oe_test_service_selinux-autorelabel-mark                    | success  |
|                        | oe_test_target_selinux-autorelabel                          | success  |
| qemu                   | oe_test_service_qemu-pr-helper                              | success  |
|                        | oe_test_socket_qemu-pr-helper                               | success  |
| qpdf                   | oe_test_qpdf_qpdf_04                                        | success  |
|                        | oe_test_qpdf_qpdf_05                                        | success  |
|                        | oe_test_qpdf_qpdf_06                                        | success  |
|                        | oe_test_qpdf_qpdf_07                                        | success  |
|                        | oe_test_qpdf_qpdf_09                                        | success  |
|                        | oe_test_qpdf_zlib-flate                                     | success  |
| qt5-qttools            | oe_test_qt5-qttools_lconvert-qt5                            | success  |
|                        | oe_test_qt5-qttools_lrelease-qt5                            | success  |
|                        | oe_test_qt5-qttools_lupdate-qt5_01                          | success  |
|                        | oe_test_qt5-qttools_lupdate-qt5_02                          | success  |
|                        | oe_test_qt5-qttools_qdoc_01                                 | success  |
|                        | oe_test_qt5-qttools_qhelpgenerator-qt5                      | success  |
|                        | oe_test_qt5-qttools_qt5-qttools-devel                       | success  |
|                        | oe_test_qt5-qttools_qtattributionsscanner-qt5               | success  |
|                        | oe_test_qt5-qttools_qtpaths                                 | success  |
| quota                  | oe_test_service_rpc-rquotad                                 | success  |
| rabbitmq-server        | oe_test_rabbitmq-plugins                                    | success  |
|                        | oe_test_rabbitmq-plugins_list                               | success  |
|                        | oe_test_rabbitmq-server                                     | success  |
|                        | oe_test_rabbitmqctl_access                                  | success  |
|                        | oe_test_rabbitmqctl_encode                                  | success  |
|                        | oe_test_rabbitmqctl_parameter                               | success  |
|                        | oe_test_rabbitmqctl_policy                                  | success  |
|                        | oe_test_rabbitmqctl_status                                  | success  |
|                        | oe_test_rabbitmqctl_user                                    | success  |
|                        | oe_test_service_rabbitmq-server                             | success  |
| rasdaemon              | oe_test_service_rasdaemon                                   | success  |
| rdma-core              | oe_test_service_srp_daemon                                  | success  |
| redis                  | oe_test_redis_01                                            | success  |
|                        | oe_test_service_redis                                       | success  |
|                        | oe_test_service_redis-sentinel                              | success  |
| redis5                 | oe_test_redis5_01                                           | success  |
|                        | oe_test_service_redis5                                      | success  |
|                        | oe_test_service_redis5-sentinel                             | success  |
| redis6                 | oe_test_redis6_01                                           | success  |
|                        | oe_test_service_redis6                                      | success  |
|                        | oe_test_service_redis6-sentinel                             | success  |
| rpmdevtools            | oe_test_rpmdevtools_rpmdev-bumpspec                         | success  |
|                        | oe_test_rpmdevtools_rpmdev-rmdevelrpms                      | success  |
|                        | oe_test_rpmdevtools_rpmdev-vercmp                           | success  |
| ruby                   | oe_test_gem                                                 | success  |
|                        | oe_test_irb_02                                              | success  |
|                        | oe_test_rake_01                                             | success  |
|                        | oe_test_rake_02                                             | success  |
|                        | oe_test_rake_03                                             | success  |
|                        | oe_test_rdoc_02                                             | success  |
|                        | oe_test_ri                                                  | success  |
| rubygem-bundler        | oe_test_rubygem-bundler_bundle_01                           | success  |
|                        | oe_test_rubygem-bundler_bundle_03                           | success  |
|                        | oe_test_rubygem-bundler_bundle_04                           | success  |
|                        | oe_test_rubygem-bundler_bundle_05                           | success  |
|                        | oe_test_rubygem-bundler_bundle_07                           | success  |
|                        | oe_test_rubygem-bundler_bundle_08                           | success  |
|                        | oe_test_rubygem-bundler_bundle_09                           | success  |
|                        | oe_test_rubygem-bundler_bundle_10                           | success  |
|                        | oe_test_rubygem-bundler_bundle_11                           | success  |
|                        | oe_test_rubygem-bundler_bundle_12                           | success  |
|                        | oe_test_rubygem-bundler_bundle_13                           | success  |
|                        | oe_test_rubygem-bundler_bundle_14                           | success  |
| samba                  | oe_test_service_ctdb                                        | success  |
| samtools               | oe_test_samtools_ace2sam                                    | success  |
|                        | oe_test_samtools_samtools_02                                | success  |
|                        | oe_test_samtools_samtools_03                                | success  |
|                        | oe_test_samtools_samtools_04                                | success  |
|                        | oe_test_samtools_samtools_05                                | success  |
|                        | oe_test_samtools_seq_cache_populate.pl                      | success  |
| sanlock                | oe_test_sanlock_base_01                                     | success  |
|                        | oe_test_sanlock_base_02                                     | success  |
|                        | oe_test_sanlock_base_03                                     | success  |
|                        | oe_test_sanlock_base_04                                     | success  |
|                        | oe_test_sanlock_sanlk-reset_01                              | success  |
|                        | oe_test_sanlock_sanlk-reset_02                              | success  |
|                        | oe_test_sanlock_sanlk_resetd                                | success  |
| security_guide         | oe_test_access_at_commands                                  | success  |
|                        | oe_test_access_cron_commands                                | success  |
|                        | oe_test_add_sticky_bit_attribute                            | success  |
|                        | oe_test_check_custom_dictionary_words                       | success  |
|                        | oe_test_check_default_dictionary_words                      | success  |
|                        | oe_test_check_passwd_encryption_algorithm                   | success  |
|                        | oe_test_delete_unowned_file                                 | success  |
|                        | oe_test_empty_linked_files                                  | success  |
|                        | oe_test_passwd_ciphertext_unique                            | success  |
|                        | oe_test_passwd_salt_value_unique                            | success  |
|                        | oe_test_password_complexity                                 | success  |
|                        | oe_test_password_validity                                   | success  |
|                        | oe_test_set_default_umask                                   | success  |
|                        | oe_test_set_exit_time                                       | success  |
|                        | oe_test_set_password_complexity                             | success  |
|                        | oe_test_set_permissions_and_owner                           | success  |
|                        | oe_test_shield_system_account                               | success  |
|                        | oe_test_ssh_access_login_in_60s                             | success  |
|                        | oe_test_ssh_character_page_timeout_limit                    | success  |
|                        | oe_test_ssh_client_reinforcement_suggestions                | success  |
|                        | oe_test_ssh_disable_root                                    | success  |
|                        | oe_test_ssh_login_failed_attempts                           | success  |
|                        | oe_test_ssh_pam_auth                                        | success  |
|                        | oe_test_ssh_passwd_dosnot_clear                             | success  |
|                        | oe_test_ssh_prohibit_root_login_system_through_ssh          | success  |
|                        | oe_test_ssh_su_permission_restrictions                      | success  |
|                        | oe_test_use_su_Initialize_path                              | success  |
| smoke-baseinfo         | oe_test_baseinfo                                            | success  |
|                        | oe_test_cockpit                                             | success  |
|                        | oe_test_selinux                                             | success  |
|                        | oe_test_ssh                                                 | success  |
|                        | oe_test_system_level                                        | success  |
|                        | oe_test_systemctl                                           | success  |
| smoke-basic-os         | oe_test_IPV6_traceroute6_01                                 | success  |
|                        | oe_test_IPV6_traceroute6_tracepath6                         | success  |
|                        | oe_test_IPVLAN_07                                           | success  |
|                        | oe_test_os-prober_02                                        | success  |
|                        | oe_test_Netlink_ip_01                                       | success  |
|                        | oe_test_Numad_01                                            | success  |
|                        | oe_test_acl_001                                             | success  |
|                        | oe_test_acpid                                               | success  |
|                        | oe_test_aide_basic_info                                     | success  |
|                        | oe_test_aide_compare_database                               | success  |
|                        | oe_test_aide_config_cfgfile                                 | success  |
|                        | oe_test_aide_config_check                                   | success  |
|                        | oe_test_aide_init_database                                  | success  |
|                        | oe_test_aide_security                                       | success  |
|                        | oe_test_aide_update_database                                | success  |
|                        | oe_test_atd                                                 | success  |
|                        | oe_test_attr_001                                            | success  |
|                        | oe_test_audit_abnormal_kill                                 | success  |
|                        | oe_test_audit_fixed_memory_01                               | success  |
|                        | oe_test_augeas_augtool                                      | success  |
|                        | oe_test_basic_ssh_001                                       | success  |
|                        | oe_test_bc                                                  | success  |
|                        | oe_test_bridge-utils_01                                     | success  |
|                        | oe_test_cd_002                                              | success  |
|                        | oe_test_chattr                                              | success  |
|                        | oe_test_chkconfig                                           | success  |
|                        | oe_test_chkconfig_01                                        | success  |
|                        | oe_test_chmod_001                                           | success  |
|                        | oe_test_chown_001                                           | success  |
|                        | oe_test_chroncy_001                                         | success  |
|                        | oe_test_chrt                                                | success  |
|                        | oe_test_cifsclient                                          | success  |
|                        | oe_test_cmp                                                 | success  |
|                        | oe_test_cp_001                                              | success  |
|                        | oe_test_cpio                                                | success  |
|                        | oe_test_curl_01                                             | success  |
|                        | oe_test_curl_02                                             | success  |
|                        | oe_test_curl_03                                             | success  |
|                        | oe_test_dateinfo_001                                        | success  |
|                        | oe_test_dbus                                                | success  |
|                        | oe_test_dbus-binging-tool                                   | success  |
|                        | oe_test_dbus-cleanup-sockets                                | success  |
|                        | oe_test_dbus-daemon                                         | success  |
|                        | oe_test_dbus-monitor                                        | success  |
|                        | oe_test_dbus-send                                           | success  |
|                        | oe_test_dbus-uuidgen                                        | success  |
|                        | oe_test_dd_001                                              | success  |
|                        | oe_test_df                                                  | success  |
|                        | oe_test_dhclient_01                                         | success  |
|                        | oe_test_diffstat_001                                        | success  |
|                        | oe_test_dracut                                              | success  |
|                        | oe_test_expat                                               | success  |
|                        | oe_test_file_001                                            | success  |
|                        | oe_test_find                                                | success  |
|                        | oe_test_gcc                                                 | success  |
|                        | oe_test_gcc_002                                             | success  |
|                        | oe_test_glibc_getaddrinfo_02                                | success  |
|                        | oe_test_log_001                                             | success  |
|                        | oe_test_grep_001                                            | success  |
|                        | oe_test_group_001                                           | success  |
|                        | oe_test_group_002                                           | success  |
|                        | oe_test_gzip                                                | success  |
|                        | oe_test_haproxy                                             | success  |
|                        | oe_test_hdparm                                              | success  |
|                        | oe_test_httpd                                               | success  |
|                        | oe_test_hwclock                                             | success  |
|                        | oe_test_hwdata                                              | success  |
|                        | oe_test_ip6tables_02                                        | success  |
|                        | oe_test_iproute                                             | success  |
|                        | oe_test_iptables                                            | success  |
|                        | oe_test_ipv6_BRIDGE                                         | success  |
|                        | oe_test_ipv6_dnsmasq                                        | success  |
|                        | oe_test_ipv6_sysctl_01                                      | success  |
|                        | oe_test_ipv6_sysctl_02                                      | success  |
|                        | oe_test_journalctl                                          | success  |
|                        | oe_test_krb5                                                | success  |
|                        | oe_test_less                                                | success  |
|                        | oe_test_less_001                                            | success  |
|                        | oe_test_let                                                 | success  |
|                        | oe_test_libcgroup_01                                        | success  |
|                        | oe_test_libcgroup_02                                        | success  |
|                        | oe_test_libcgroup_03                                        | success  |
|                        | oe_test_libuser_sm                                          | success  |
|                        | oe_test_lldpad                                              | success  |
|                        | oe_test_llvm                                                | success  |
|                        | oe_test_ln_001                                              | success  |
|                        | oe_test_localectl_001                                       | success  |
|                        | oe_test_logrotate_001                                       | success  |
|                        | oe_test_logrotate_002                                       | success  |
|                        | oe_test_logrotate_003                                       | success  |
|                        | oe_test_logrotate_004                                       | success  |
|                        | oe_test_losetup                                             | success  |
|                        | oe_test_ls_001                                              | success  |
|                        | oe_test_lsof                                                | success  |
|                        | oe_test_lsscsi                                              | success  |
|                        | oe_test_lz4_01                                              | success  |
|                        | oe_test_lz4_02                                              | success  |
|                        | oe_test_lzo                                                 | success  |
|                        | oe_test_maildrop_delivery_agent                             | success  |
|                        | oe_test_mkdir_001                                           | success  |
|                        | oe_test_mktemp                                              | success  |
|                        | oe_test_mpstat_01                                           | success  |
|                        | oe_test_mtr_01                                              | success  |
|                        | oe_test_mv_001                                              | success  |
|                        | oe_test_mv_002                                              | success  |
|                        | oe_test_ndctl                                               | success  |
|                        | oe_test_netstat_01                                          | success  |
|                        | oe_test_nfs                                                 | success  |
|                        | oe_test_nfs_01                                              | success  |
|                        | oe_test_nfs_02                                              | success  |
|                        | oe_test_nfs_03                                              | success  |
|                        | oe_test_nmap                                                | success  |
|                        | oe_test_ntp_01                                              | success  |
|                        | oe_test_ntp_02                                              | success  |
|                        | oe_test_od                                                  | success  |
|                        | oe_test_openssl                                             | success  |
|                        | oe_test_pciutils                                            | success  |
|                        | oe_test_pcre_001                                            | success  |
|                        | oe_test_perl                                                | success  |
|                        | oe_test_popt                                                | success  |
|                        | oe_test_procps-ng-sysctl                                    | success  |
|                        | oe_test_procps-ng-uptime                                    | success  |
|                        | oe_test_pstree                                              | success  |
|                        | oe_test_pwd_002                                             | success  |
|                        | oe_test_python_01                                           | success  |
|                        | oe_test_python_pip_install                                  | success  |
|                        | oe_test_python_subprocess_01                                | success  |
|                        | oe_test_python_subprocess_02                                | success  |
|                        | oe_test_python_subprocess_03                                | success  |
|                        | oe_test_python_urllib3_urlopen_01                           | success  |
|                        | oe_test_python_urllib3_urlopen_02                           | success  |
|                        | oe_test_python_urllib3_urlopen_03                           | success  |
|                        | oe_test_rm_001                                              | success  |
|                        | oe_test_rmdir_001                                           | success  |
|                        | oe_test_route_ipv4                                          | success  |
|                        | oe_test_rpcbind                                             | success  |
|                        | oe_test_rpm_cmd                                             | success  |
|                        | oe_test_rpmrebuild                                          | success  |
|                        | oe_test_rsync                                               | success  |
|                        | oe_test_sadf_001                                            | success  |
|                        | oe_test_sar_01                                              | success  |
|                        | oe_test_sed_001                                             | success  |
|                        | oe_test_shadow                                              | success  |
|                        | oe_test_sort                                                | success  |
|                        | oe_test_source                                              | success  |
|                        | oe_test_sshd                                                | success  |
|                        | oe_test_sudo                                                | success  |
|                        | oe_test_sudo_E                                              | success  |
|                        | oe_test_sudo_U                                              | success  |
|                        | oe_test_sudo_maxseq                                         | success  |
|                        | oe_test_syslog_dmesg_001                                    | success  |
|                        | oe_test_syslog_journalctl_001                               | success  |
|                        | oe_test_syslog_journalctl_002                               | success  |
|                        | oe_test_syslog_journald_001                                 | success  |
|                        | oe_test_systemd-update-utmp                                 | success  |
|                        | oe_test_systemd_SCEN_01                                     | success  |
|                        | oe_test_systemd_SCEN_02                                     | success  |
|                        | oe_test_systemd_SCEN_03                                     | success  |
|                        | oe_test_systemd_SCEN_04                                     | success  |
|                        | oe_test_systemd_SCEN_05                                     | success  |
|                        | oe_test_systemd_SCEN_06                                     | success  |
|                        | oe_test_systemd_SCEN_07                                     | success  |
|                        | oe_test_systemd_SCEN_08                                     | success  |
|                        | oe_test_systemd_SCEN_09                                     | success  |
|                        | oe_test_systemd_SCEN_10                                     | success  |
|                        | oe_test_systemd_SCEN_11                                     | success  |
|                        | oe_test_systemd_SCEN_12                                     | success  |
|                        | oe_test_systemd_SCEN_13                                     | success  |
|                        | oe_test_systemd_SCEN_14                                     | success  |
|                        | oe_test_systemd_SCEN_15                                     | success  |
|                        | oe_test_tar_001                                             | success  |
|                        | oe_test_tcpdump                                             | success  |
|                        | oe_test_time_01                                             | success  |
|                        | oe_test_time_02                                             | success  |
|                        | oe_test_touch_001                                           | success  |
|                        | oe_test_tr                                                  | success  |
|                        | oe_test_umask_001                                           | success  |
|                        | oe_test_umask_002                                           | success  |
|                        | oe_test_unalias_001                                         | success  |
|                        | oe_test_uname                                               | success  |
|                        | oe_test_unset_001                                           | success  |
|                        | oe_test_user_001                                            | success  |
|                        | oe_test_user_002                                            | success  |
|                        | oe_test_user_003                                            | success  |
|                        | oe_test_user_debug_iotop_SCEN_01                            | success  |
|                        | oe_test_vmstat                                              | success  |
|                        | oe_test_wc                                                  | success  |
|                        | oe_test_wget                                                | success  |
|                        | oe_test_which                                               | success  |
|                        | oe_test_xz                                                  | success  |
|                        | oe_test_rsyslog_10                                          | success  |
|                        | oe_test_rsyslog_01                                          | success  |
|                        | oe_test_rsyslog_02                                          | success  |
|                        | oe_test_rsyslog_04                                          | success  |
|                        | oe_test_rsyslog_05                                          | success  |
|                        | oe_test_rsyslog_06                                          | success  |
|                        | oe_test_rsyslog_07                                          | success  |
|                        | oe_test_rsyslog_08                                          | success  |
|                        | oe_test_rsyslog_09                                          | success  |
|                        | oe_test_golang                                              | success  |
|                        | oe_test_os-prober_01                                        | success  |
| smoke-iSulad           | oe_test_iSula_install_deploy_001                            | success  |
| socat                  | oe_test_socat_01                                            | success  |
|                        | oe_test_socat_02                                            | success  |
|                        | oe_test_socat_03                                            | success  |
|                        | oe_test_socat_procan                                        | success  |
| strongswan             | oe_test_service_charon-cmd_01                               | success  |
|                        | oe_test_service_charon-cmd_02                               | success  |
|                        | oe_test_service_charon-systemd                              | success  |
| systemtap              | oe_test_service_stap-exporter                               | success  |
|                        | oe_test_service_stap-server                                 | success  |
| tomcat                 | oe_test_service_tomcat                                      | success  |
|                        | oe_test_tomcat_001                                          | success  |
| unbound                | oe_test_service_unbound                                     | success  |
|                        | oe_test_service_unbound-anchor                              | success  |
| wireshark              | oe_test_capinfos                                            | success  |
|                        | oe_test_randpkt-reordercap                                  | success  |
|                        | oe_test_text2pcap                                           | success  |
|                        | oe_test_tshark_01                                           | success  |
|                        | oe_test_tshark_02                                           | success  |
|                        | oe_test_tshark_03                                           | success  |
| wsmancli               | oe_test_wsmancli_wseventmgr_03                              | success  |
|                        | oe_test_wsmancli_wseventmgr_04                              | success  |
|                        | oe_test_wsmancli_wsman_01                                   | success  |
|                        | oe_test_wsmancli_wsman_04                                   | success  |
| yelp-tools             | oe_test_yelp-check                                          | success  |
| clevis                 | oe_test_tang_encrypt                                        | success  |
|                        | oe_test_tang_nbde                                           | success  |
| fio                    | oe_test_fio_002                                             | success  |
|                        | oe_test_fio_003                                             | success  |
| amanda                 | oe_test_amanda_ambackup                                     | success  |
|                        | oe_test_amanda_amssl                                        | success  |
|                        | oe_test_service_amanda-udp                                  | success  |
|                        | oe_test_socket_amanda                                       | success  |
|                        | oe_test_socket_amanda-udp                                   | success  |
|                        | oe_test_socket_kamanda                                      | success  |
| cvs                    | oe_test_cvs_cvs_01                                          | success  |
|                        | oe_test_socket_cvs                                          | success  |
|                        | oe_test_target_cvs                                          | success  |
| openssh                | oe_test_openssh_keychecking_no                              | success  |
|                        | oe_test_openssh_keyscan                                     | success  |
|                        | oe_test_openssh_scp_r                                       | success  |
|                        | oe_test_openssh_sftp                                        | success  |
|                        | oe_test_openssh_ssh_agent                                   | success  |
|                        | oe_test_openssh_ssh_command                                 | success  |
|                        | oe_test_openssh_ssh-copy-id                                 | success  |
|                        | oe_test_openssh_ssh_user                                    | success  |
|                        | oe_test_sec_jump_login                                      | success  |
|                        | oe_test_service_sshd                                        | success  |
|                        | oe_test_socket_sshd                                         | success  |
|                        | oe_test_start_ssh                                           | success  |
|                        | oe_test_target_sshd-keygen                                  | success  |
| pbzip2                 | oe_test_pbzip2_01                                           | success  |
|                        | oe_test_pbzip2_02                                           | success  |
