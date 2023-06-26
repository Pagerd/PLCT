### 修订记录

| 日期      | 修订版本 | 修改描述             | 作者   |
| --------- | -------- | -------------------- | ------ |
| 2023-6-24 | 0.0.1    | Demo                 | Pagerd |
| 2023-6-26 | 0.0.2    | 测试结果添加对应链接 | Pagerd |

# 目录

- 摘要
- 工作内容
  - 测试配置
  - 测试套遴选
  - 分级测试策略
  - 运行测试
  - 分析测试用例失败原因
- BaseOS测试结果
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

| 测试类     | 描述                                 | 当前状态           |
| ---------- | ------------------------------------ | ------------------ |
| BaseOS     | 软件包分级BaseOS中所覆盖的软件包     | 基本完成测试       |
| everything | 软件包分级everything中所覆盖的软件包 | 尚未开始测试套遴选 |
| EPOL       | 软件包分级EPOL中所覆盖的软件包       | 尚未开始测试套遴选 |

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

# BaseOS测试结果

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

| 测试套/软件包名    | 测试用例名                                                   | 原因                                                         | 日志文件                                                     | 状态 |
| ------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ---- |
| os-basic           | oe_test_accessdb                                             | preinstall absent                                            | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_accessdb/2023-04-28-03:37:05.log) | fail |
|                    | oe_test_aureport                                             | timeout                                                      | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_aureport/2023-04-28-10:26:13.log) | fail |
|                    | oe_test_awk                                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_awk/2023-04-28-03:34:31.log) | fail |
|                    | oe_test_c++                                                  | file missing                                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_c++/2023-04-28-03:32:15.log) | fail |
|                    | oe_test_chsh                                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_chsh/2023-04-28-10:56:22.log) | fail |
|                    | oe_test_count_gperftools_function                            | file missing                                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_count_gperftools_function/2023-04-28-10:58:54.log) | fail |
|                    | oe_test_disk_graphics_card                                   | file missing                                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_disk_graphics_card/2023-04-28-10:05:30.log) | fail |
|                    | oe_test_disk_io_sched                                        | preinstall absent                                            | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_disk_io_sched/2023-04-28-10:24:32.log) | fail |
|                    | oe_test_disk_schedule_specific                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_disk_schedule_specific/2023-04-28-08:31:35.log) | fail |
|                    | oe_test_disk_schedule_udev                                   | preinstall absent                                            | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_disk_schedule_udev/2023-04-28-08:32:02.log) | fail |
|                    | oe_test_ethtool                                              | file missing                                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_ethtool/2023-04-28-08:42:35.log) | fail |
|                    | oe_test_expect                                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_expect/2023-04-28-10:21:46.log) | fail |
|                    | oe_test_fuse                                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_fuse/2023-04-28-03:35:43.log) | fail |
|                    | oe_test_gmp                                                  | file missing                                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_gmp/2023-04-28-10:18:16.log) | fail |
|                    | oe_test_hostnamectl                                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_hostnamectl/2023-04-28-09:16:05.log) | fail |
|                    | oe_test_kernel_kdump                                         | preinstall absent                                            | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_kernel_kdump/2023-04-28-09:16:35.log) | fail |
|                    | oe_test_kernel_module_operation                              | kernel module absent                                         | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_kernel_module_operation/2023-04-28-09:51:53.log) | fail |
|                    | oe_test_lastb                                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_lastb/2023-04-28-10:25:56.log) | fail |
|                    | oe_test_libffi                                               | file missing                                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_libffi/2023-04-28-10:19:24.log) | fail |
|                    | oe_test_net_VRF                                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_net_VRF/2023-04-28-09:56:52.log) | fail |
|                    | oe_test_net_cmd_scp                                          | timeout                                                      | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_net_cmd_scp/2023-04-28-09:58:51.log) | fail |
|                    | oe_test_nmcli_set_bond                                       | preinstall absent                                            | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_nmcli_set_bond/2023-04-28-10:04:10.log) | fail |
|                    | oe_test_nmcli_set_team                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_nmcli_set_team/2023-04-28-10:06:10.log) | fail |
|                    | oe_test_power_measurement_internal                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_power_measurement_internal/2023-04-28-08:03:14.log) | fail |
|                    | oe_test_system_log_dmesg                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_system_log_dmesg/2023-04-28-04:12:53.log) | fail |
|                    | oe_test_system_log_view                                      | preinstall absent                                            | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_system_log_view/2023-04-28-04:11:47.log) | fail |
|                    | oe_test_system_monitor_share_total                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_system_monitor_share_total/2023-04-28-10:05:14.log) | fail |
|                    | oe_test_who                                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_who/2023-04-28-03:28:28.log) | fail |
|                    | oe_test_xmlsec                                               | file missing                                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_xmlsec/2023-04-28-10:22:18.log) | fail |
|                    | oe_test_xzcmp                                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_xzcmp/2023-04-28-11:10:16.log) | fail |
|                    | oe_test_zlib                                                 | file missing                                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_zlib/2023-04-28-10:10:25.log) | fail |
| NetworkManager     | oe_test_libnetfilter_conntrack                               | 镜像没有预装测试所需的 kernel-headers                        | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/NetworkManager/oe_test_libnetfilter_conntrack/2023-05-25-16_27_41.log) | fail |
| OpenIPMI           | oe_test_service_ipmi                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/OpenIPMI/oe_test_service_ipmi/2023-05-25-21_21_10.log) | fail |
| acl                | oe_test_acl_default_kernel_setting                           | 未打开 CONFIG_XFS_POSIX_ACL=y                                | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/acl/oe_test_acl_default_kernel_setting/2023-05-25-16_29_46.log) | fail |
| arptables          | oe_test_service_arptables                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/arptables/oe_test_service_arptables/2023-05-25-21_46_57.log) | fail |
| cachefilesd        | oe_test_service_cachefilesd                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cachefilesd/oe_test_service_cachefilesd/2023-05-25-13:58:05.log) | fail |
| ceph               | oe_test_target_ceph-fuse                                     | pkg not found/file missing                                   | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ceph/oe_test_target_ceph-fuse/2023-05-25-14:09:22.log) | fail |
|                    | oe_test_target_ceph-mds                                      | pkg not found/file missing                                   | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ceph/oe_test_target_ceph-mds/2023-05-25-14:11:16.log) | fail |
|                    | oe_test_target_ceph-mgr                                      | pkg not found/file missing                                   | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ceph/oe_test_target_ceph-mgr/2023-05-25-14:13:09.log) | fail |
|                    | oe_test_target_ceph-mon                                      | pkg not found/file missing                                   | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ceph/oe_test_target_ceph-mon/2023-05-25-14:15:26.log) | fail |
|                    | oe_test_target_ceph-osd                                      | pkg not found/file missing                                   | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ceph/oe_test_target_ceph-osd/2023-05-25-14:17:24.log) | fail |
|                    | oe_test_target_ceph-radosgw                                  | pkg not found/file missing                                   | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ceph/oe_test_target_ceph-radosgw/2023-05-25-14:19:20.log) | fail |
|                    | oe_test_target_ceph-rbd-mirror                               | pkg not found/file missing                                   | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ceph/oe_test_target_ceph-rbd-mirror/2023-05-25-14:21:20.log) | fail |
| chrony             | oe_test_service_chronyd                                      | preinstall absent/systemd unit restart failure/systemd unit runtime error | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/chrony/oe_test_service_chronyd/2023-05-25-14:08:06.log) | fail |
| cryptsetup         | oe_test_encrypt_data                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cryptsetup/oe_test_encrypt_data/2023-05-31-17:02:28.log) | fail |
|                    | oe_test_luks_encrypted                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cryptsetup/oe_test_luks_encrypted/2023-05-31-17:04:33.log) | fail |
|                    | oe_test_use_luks                                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cryptsetup/oe_test_use_luks/2023-05-31-17:07:04.log) | fail |
| dhcp               | oe_test_service_dhcrelay                                     | preinstall absent/systemd unit restart failure/systemd unit runtime error | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dhcp/oe_test_service_dhcrelay/2023-05-25-21:40:24.log) | fail |
| dnf                | oe_test_dnf_all-repos                                        | oerv 和 x86 的软件源结构不同                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dnf/oe_test_dnf_all-repos/2023-05-25-16_43_17.log) | fail |
|                    | oe_test_dnf_enhancement_exclude                              | oerv 和 x86 的软件源结构不同                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dnf/oe_test_dnf_enhancement_exclude/2023-05-25-17_11_41.log) | fail |
|                    | oe_test_dnf_makecache_clean                                  | oerv 和 x86 的软件源结构不同                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dnf/oe_test_dnf_makecache_clean/2023-05-25-16_56_12.log) | fail |
|                    | oe_test_dnf_nobest_nodocs_nogpgcheck                         | oerv 和 x86 的软件源结构不同                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dnf/oe_test_dnf_nobest_nodocs_nogpgcheck/2023-05-25-17_16_55.log) | fail |
|                    | oe_test_dnf_priority                                         | oerv 和 x86 的软件源结构不同                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dnf/oe_test_dnf_priority/2023-05-25-17_18_28.log) | fail |
|                    | oe_test_dnf_provides_randomwait                              | oerv 和 x86 的软件源结构不同                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dnf/oe_test_dnf_provides_randomwait/2023-05-25-17_19_15.log) | fail |
|                    | oe_test_dnf_repeat-install                                   | oerv 和 x86 的软件源结构不同                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dnf/oe_test_dnf_repeat-install/2023-05-25-17_23_20.log) | fail |
| dracut             | oe_test_service_dracut-shutdown                              | preinstall absent/systemd unit restart failure/systemd unit runtime error | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dracut/oe_test_service_dracut-shutdown/2023-05-26-00:26:32.log) | fail |
| fcoe-utils         | oe_test_service_fcoe                                         | Job for fcoe.service failed because the control process exited with error code. | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/fcoe-utils/oe_test_service_fcoe/2023-05-26-14:16:43.log) | fail |
| freeradius         | oe_test_freeradius_freeradius-utils_rad_counter              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeradius/oe_test_freeradius_freeradius-utils_rad_counter/2023-05-26-17:57:11.log) | fail |
|                    | oe_test_freeradius_freeradius-utils_radclient                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeradius/oe_test_freeradius_freeradius-utils_radclient/2023-05-26-17:33:18.log) | fail |
|                    | oe_test_freeradius_freeradius-utils_radclient2               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeradius/oe_test_freeradius_freeradius-utils_radclient2/2023-05-26-17:47:10.log) | fail |
|                    | oe_test_freeradius_freeradius-utils_radeapclient             | timeout                                                      | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeradius/oe_test_freeradius_freeradius-utils_radeapclient/2023-05-26-18:08:32.log) | fail |
|                    | oe_test_freeradius_freeradius-utils_radwho                   | file missing                                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeradius/oe_test_freeradius_freeradius-utils_radwho/2023-05-26-18:57:24.log) | fail |
|                    | oe_test_freeradius_freeradius-utils_radzap                   | file missing                                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeradius/oe_test_freeradius_freeradius-utils_radzap/2023-05-26-18:58:31.log) | fail |
|                    | oe_test_freeradius_freeradius-utils_rlm_ippool_toolAndSmbencrypt | file missing                                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeradius/oe_test_freeradius_freeradius-utils_rlm_ippool_toolAndSmbencrypt/2023-05-26-19:00:20.log) | fail |
|                    | oe_test_freeradius_freeradius_raddebugAndCheckrad            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeradius/oe_test_freeradius_freeradius_raddebugAndCheckrad/2023-05-26-17:00:58.log) | fail |
|                    | oe_test_freeradius_freeradius_radiusd                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeradius/oe_test_freeradius_freeradius_radiusd/2023-05-26-17:19:22.log) | fail |
|                    | oe_test_freeradius_freeradius_radiusdAndRadmin               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeradius/oe_test_freeradius_freeradius_radiusdAndRadmin/2023-05-26-17:25:19.log) | fail |
|                    | oe_test_service_radiusd                                      | file missing/systemd unit restart failure/systemd unit runtime error/systemd unit enable failure | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeradius/oe_test_service_radiusd/2023-05-26-19:01:19.log) | fail |
| gdm                | oe_test_service_gdm                                          | 下载超时                                                     | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/gdm/oe_test_service_gdm/2023-05-26-20:01:27.log) | fail |
| glib2              | oe_test_glib2                                                | 镜像没有预装测试所需的 kernel-headers                        | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/glib2/oe_test_glib2/2023-05-25-16_48_06.log) | fail |
| graphviz           | oe_test_service_zvbid                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/graphviz/oe_test_service_zvbid/2023-05-26-22:11:36.log) | fail |
| initscripts        | oe_test_service_import-state                                 | preinstall absent/systemd unit restart failure/systemd unit runtime error | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/initscripts/oe_test_service_import-state/2023-05-27-01:00:01.log) | fail |
|                    | oe_test_service_loadmodules                                  | preinstall absent/systemd unit restart failure/systemd unit runtime error | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/initscripts/oe_test_service_loadmodules/2023-05-27-01:01:03.log) | fail |
| kernel             | oe_test_hqlogic                                              | 内核模块缺失 qla2xxx                                         | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kernel/oe_test_hqlogic/2023-05-25-17_09_19.log) | fail |
|                    | oe_test_ipip                                                 | 内核模块缺失 ipip                                            | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kernel/oe_test_ipip/2023-05-25-17_07_08.log) | fail |
|                    | oe_test_kernel_cmd_01                                        | 测试使用 hostnamectl grep Virtualization 判断是否为虚拟机，而 qemu-system-riscv64 不适用这个方法 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kernel/oe_test_kernel_cmd_01/2023-05-25-17_00_23.log) | fail |
|                    | oe_test_lpfc                                                 | 内核模块缺失 lpfc                                            | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kernel/oe_test_lpfc/2023-05-25-17_11_35.log) | fail |
|                    | oe_test_qxl                                                  | 内核模块缺失 qxl                                             | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kernel/oe_test_qxl/2023-05-25-17_10_14.log) | fail |
|                    | oe_test_service_cpupower                                     | 测试使用 hostnamectl grep Virtualization 判断是否为虚拟机，而 qemu-system-riscv64 不适用这个方法 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kernel/oe_test_service_cpupower/2023-05-25-17_06_08.log) | fail |
|                    | oe_test_snd_aloop                                            | 内核模块缺失 snd-aloop                                       | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kernel/oe_test_snd_aloop/2023-05-25-17_08_23.log) | fail |
|                    | oe_test_softdog                                              | 内核模块缺失 softdog                                         | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kernel/oe_test_softdog/2023-05-25-17_12_40.log) | fail |
|                    | oe_test_vport-geneve                                         | 内核模块缺失 vport-geneve                                    | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kernel/oe_test_vport-geneve/2023-05-25-17_10_48.log) | fail |
|                    | oe_test_wangxun                                              | 内核模块缺失 ngbe.ko txgbe.ko                                | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kernel/oe_test_wangxun/2023-05-25-17_13_55.log) | fail |
|                    | oe_test_xfs                                                  | 内核模块缺失 xfs                                             | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kernel/oe_test_xfs/2023-05-25-17_13_30.log) | fail |
| kmod               | oe_test_rmmod                                                | 内核模块缺失 dm_log dm_mirror dm_region_hash                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kmod/oe_test_rmmod/2023-05-25-17_05_55.log) | fail |
|                    | oe_test_weak-modules                                         | 镜像没有预装测试所需的 dracut （引入后 Unable to decompress /boot/initramfs-6.1.8-3.oe2303.riscv64.img: Unknown format） | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kmod/oe_test_weak-modules/2023-05-25-17_06_19.log) | fail |
| libarchive         | oe_test_libarchive_bsdcpio                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libarchive/oe_test_libarchive_bsdcpio/2023-06-02-09_35_39.log) | fail |
| lvm2               | oe_test_service_lvmlockd                                     | oerv 缺失软件包 lvm2-locked                                  | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_service_lvmlockd/2023-05-25-17_30_48.log) | fail |
|                    | oe_test_service_lvmlocks                                     | oerv 缺失软件包 lvm2-locked                                  | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_service_lvmlocks/2023-05-25-17_32_35.log) | fail |
| systemd            | oe_test_socket_syslog                                        | 镜像没有预装测试所需的 rsyslog                               | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_socket_syslog/2023-05-25-21_41_08.log) | fail |
| ipset              | oe_test_service_ipset_02                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ipset/oe_test_service_ipset_02/2023-06-02-03:14:42.log) | fail |
|                    | oe_test_ipset_01                                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ipset/oe_test_ipset_01/2023-06-02-03:15:50.log) | fail |
| javapackages-tools | oe_test_binary_files_operation                               | file missing                                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/javapackages-tools/oe_test_binary_files_operation/2023-06-02-05:38:07.log) | fail |
|                    | oe_test_build-jar-repository                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/javapackages-tools/oe_test_build-jar-repository/2023-06-02-05:43:17.log) | fail |
| libreswan          | oe_test_libreswan_ipsec_addconn                              | timeout                                                      | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libreswan/oe_test_libreswan_ipsec_addconn/2023-06-02-10:05:50.log) | fail |
|                    | oe_test_libreswan_ipsec_auto_1                               | timeout                                                      | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libreswan/oe_test_libreswan_ipsec_auto_1/2023-06-02-10:08:43.log) | fail |
| libvirt            | oe_test_socket_virtinterfaced-ro                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libvirt/oe_test_socket_virtinterfaced-ro/2023-06-02-11:12:50.log) | fail |
|                    | oe_test_socket_virtnetworkd-admin                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libvirt/oe_test_socket_virtnetworkd-admin/2023-06-02-11:26:17.log) | fail |
| lksctp-tools       | oe_test_lksctp-tools_checksctp                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lksctp-tools/oe_test_lksctp-tools_checksctp/2023-06-02-12:54:34.log) | fail |
|                    | oe_test_lksctp-tools_sctp_darn_02                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lksctp-tools/oe_test_lksctp-tools_sctp_darn_02/2023-06-02-13:25:57.log) | fail |
|                    | oe_test_lksctp-tools_sctp_status                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lksctp-tools/oe_test_lksctp-tools_sctp_status/2023-06-02-13:26:57.log) | fail |
|                    | oe_test_lksctp-tools_sctp_test                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lksctp-tools/oe_test_lksctp-tools_sctp_test/2023-06-02-13:28:11.log) | fail |
|                    | oe_test_lksctp-tools_sctp_darn_01                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lksctp-tools/oe_test_lksctp-tools_sctp_darn_01/2023-06-02-12:55:49.log) | fail |
| lldpad             | oe_test_service_lldpad                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lldpad/oe_test_service_lldpad/2023-06-02-13:30:03.log) | fail |
| multipath-tools    | oe_test_multipath-tools_kpartx                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/multipath-tools/oe_test_multipath-tools_kpartx/2023-06-02-16:34:41.log) | fail |
|                    | oe_test_multipath-tools_mpathconf                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/multipath-tools/oe_test_multipath-tools_mpathconf/2023-06-02-16:36:24.log) | fail |
|                    | oe_test_multipath-tools_mpathpersist                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/multipath-tools/oe_test_multipath-tools_mpathpersist/2023-06-02-16:37:37.log) | fail |
|                    | oe_test_multipath-tools_multipath_01                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/multipath-tools/oe_test_multipath-tools_multipath_01/2023-06-02-16:39:12.log) | fail |
|                    | oe_test_multipath-tools_multipath_02                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/multipath-tools/oe_test_multipath-tools_multipath_02/2023-06-02-16:41:06.log) | fail |
|                    | oe_test_service_multipathd                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/multipath-tools/oe_test_service_multipathd/2023-06-02-16:42:47.log) | fail |
| FS_Directory       | oe_test_FSIO_dir_access_etc                                  | /etc文件夹内容与x86不符合                                    | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Directory/oe_test_FSIO_dir_access_etc/2023-04-28-21:47:20.log) | fail |
|                    | oe_test_FSIO_dir_access_proc                                 | /proc/cpuinfo中正常显示cpu信息但无'CPU'关键字                | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Directory/oe_test_FSIO_dir_access_proc/2023-04-28-21:49:26.log) | fail |
|                    | oe_test_FSIO_dir_access_var                                  | /var文件夹内容与x86不符合                                    | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Directory/oe_test_FSIO_dir_access_var/2023-04-28-21:52:08.log) | fail |
| numad              | oe_test_service_numad                                        | systemd启动失败，原因未知                                    | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/numad/oe_test_service_numad/2023-04-26-12:11:17.log) | fail |
| open-iscsi         | oe_test_service_iscsid                                       | systemd unit restart failure/systemd unit runtime error/systemd unit enable failure | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/open-iscsi/oe_test_service_iscsid/2023-04-26-12:21:15.log) | fail |
| openvswitch        | oe_test_service_openvswitch                                  | file missing systemd unit restart failure systemd unit runtime error | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openvswitch/oe_test_service_openvswitch/2023-04-26-14:26:52.log) | fail |
|                    | oe_test_service_ovs-vswitchd                                 | file missing systemd unit restart failure systemd unit runtime error | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openvswitch/oe_test_service_ovs-vswitchd/2023-04-26-14:34:14.log) | fail |
|                    | oe_test_service_ovsdb-server                                 | file missing systemd unit restart failure systemd unit runtime error | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openvswitch/oe_test_service_ovsdb-server/2023-04-26-14:30:45.log) | fail |
| os-storage         | oe_test_storage_Mutipath_configure_blacklist                 | kernel module absent                                         | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_Mutipath_configure_blacklist/2023-04-28-07:19:57.log) | fail |
|                    | oe_test_storage_Mutipath_configure_defaults                  | kernel module absent                                         | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_Mutipath_configure_defaults/2023-04-28-07:16:45.log) | fail |
|                    | oe_test_storage_Mutipath_configure_device                    | kernel module absent                                         | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_Mutipath_configure_device/2023-04-28-06:54:06.log) | fail |
|                    | oe_test_storage_Mutipath_configure_section                   | kernel module absent                                         | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_Mutipath_configure_section/2023-04-28-07:09:02.log) | fail |
|                    | oe_test_storage_Mutipath_mpathconf                           | kernel module absent                                         | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_Mutipath_mpathconf/2023-04-28-06:33:46.log) | fail |
|                    | oe_test_storage_Mutipath_various_fields                      | kernel module absent                                         | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_Mutipath_various_fields/2023-04-28-07:03:35.log) | fail |
|                    | oe_test_storage_Mutipath_view_info                           | kernel module absent                                         | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_Mutipath_view_info/2023-04-28-06:55:09.log) | fail |
|                    | oe_test_storage_ext3_mount_write                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_ext3_mount_write/2023-04-28-07:18:51.log) | fail |
|                    | oe_test_storage_ext4_mount                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_ext4_mount/2023-04-28-06:55:41.log) | fail |
|                    | oe_test_storage_fileCMD_mkfs                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_fileCMD_mkfs/2023-04-28-06:44:53.log) | fail |
|                    | oe_test_storage_fileCMD_pwd                                  | 文件系统中并没有选择测试的目录，使用mkdir事先建立对应目录可过，建议加入pre_test中 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_fileCMD_pwd/2023-04-28-06:36:59.log) | fail |
|                    | oe_test_storage_lvm_set_regionsize                           | kernel module absent                                         | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_set_regionsize/2023-04-28-11:35:23.log) | fail |
|                    | oe_test_storage_smb_cmd_smbcontrol                           | 运行软件时需要加载libmessages-util-samba4.so，在LD_LIBRARY_PATH环境变量相同时，x86环境下运行可自动找到对应文件，但riscv下无法找到，只有将对应lib的文件路径赋值到环境变量时才可正常运行 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_cmd_smbcontrol/2023-04-28-09:42:50.log) | fail |
|                    | oe_test_storage_smb_cmd_smbpasswd                            | 运行软件时需要加载libmessages-util-samba4.so，在LD_LIBRARY_PATH环境变量相同时，x86环境下运行可自动找到对应文件，但riscv下无法找到，只有将对应lib的文件路径赋值到环境变量时才可正常运行 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_cmd_smbpasswd/2023-04-28-09:45:03.log) | fail |
|                    | oe_test_storage_smb_cmd_smbstatus                            | 运行软件时需要加载libmessages-util-samba4.so，在LD_LIBRARY_PATH环境变量相同时，x86环境下运行可自动找到对应文件，但riscv下无法找到，只有将对应lib的文件路径赋值到环境变量时才可正常运行 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_cmd_smbstatus/2023-04-28-09:54:50.log) | fail |
|                    | oe_test_storage_smb_cmd_testparm                             | 运行软件时需要加载libserver-role-samba4.so，在LD_LIBRARY_PATH环境变量相同时，x86环境下运行可自动找到对应文件，但riscv下无法找到，只有将对应lib的文件路径赋值到环境变量时才可正常运行 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_cmd_testparm/2023-04-28-10:26:24.log) | fail |
|                    | oe_test_storage_smb_guest_share                              | 同上缺失lib文件，不过上面两个lib文件都需加载                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_guest_share/2023-04-28-10:29:54.log) | fail |
|                    | oe_test_storage_xfs_restore                                  | xfsdemp error                                                | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_xfs_restore/2023-04-28-11:05:53.log) | fail |
| pcp                | oe_test_service_pmmgr                                        | file missing systemd unit restart failure systemd unit runtime error | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pcp/oe_test_service_pmmgr/2023-04-28-02:52:21.log) | fail |
|                    | oe_test_service_pmwebd                                       | file missing systemd unit restart failure systemd unit runtime error | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pcp/oe_test_service_pmwebd/2023-04-28-02:57:15.log) | fail |
| pigz               | oe_test_pigz                                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pigz/oe_test_pigz/2023-04-26-19:20:20.log) | fail |
| psacct             | oe_test_psacct                                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/psacct/oe_test_psacct/2023-04-26-20:13:03.log) | fail |
|                    | oe_test_service_psacct                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/psacct/oe_test_service_psacct/2023-04-26-20:15:06.log) | fail |
| quota              | oe_test_service_quota_nld                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/quota/oe_test_service_quota_nld/2023-04-26-21:17:36.log) | fail |
| rasdaemon          | oe_test_service_ras-mc-ctl                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rasdaemon/oe_test_service_ras-mc-ctl/2023-04-26-22:25:28.log) | fail |
| rdma-core          | oe_test_socket_ibacm                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rdma-core/oe_test_socket_ibacm/2023-04-26-22:38:45.log) | fail |
| realmd             | oe_test_service_realmd                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/realmd/oe_test_service_realmd/2023-04-26-22:42:34.log) | fail |
| rpmdevtools        | oe_test_rpmdevtools_rpmdev-wipetree                          | Broken testcase/preinstall absent/timeout                    | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rpmdevtools/oe_test_rpmdevtools_rpmdev-wipetree/2023-05-19-19:27:17.log) | fail |
| samba              | oe_test_service_nmb                                          | systemd unit restart failure/systemd unit runtime error/systemd unit enable failure | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/samba/oe_test_service_nmb/2023-04-27-02:03:38.log) | fail |
|                    | oe_test_service_smb                                          | systemd unit restart failure/systemd unit runtime error/systemd unit enable failure | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/samba/oe_test_service_smb/2023-04-27-02:10:01.log) | fail |
|                    | oe_test_service_winbind                                      | systemd unit restart failure/systemd unit runtime error/systemd unit enable failure | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/samba/oe_test_service_winbind/2023-04-27-02:12:55.log) | fail |
| sanlock            | oe_test_sanlock_wdmd                                         | Module softdog not found                                     | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/sanlock/oe_test_sanlock_wdmd/2023-04-27-02:26:40.log) | fail |
| security-tool      | oe_test_security_tool                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/security-tool/oe_test_security_tool/2023-04-27-02:40:49.log) | fail |
|                    | oe_test_service_openEuler-security                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/security-tool/oe_test_service_openEuler-security/2023-04-27-02:42:59.log) | fail |
| smoke-basic-os     | oe_test_CPUinfo_001                                          | file missing/timeout                                         | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_CPUinfo_001/2023-05-26-00:21:53.log) | fail |
|                    | oe_test_bbr_02                                               | preinstall absent                                            | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_bbr_02/2023-04-29-09:54:28.log) | fail |
|                    | oe_test_bbr_04                                               | kernel module absent                                         | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_bbr_04/2023-04-29-09:54:45.log) | fail |
|                    | oe_test_bonding_SCEN_05                                      | preinstall absent kernel module absent                       | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_bonding_SCEN_05/2023-04-29-09:55:05.log) | fail |
|                    | oe_test_criu                                                 | file missing                                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_criu/2023-04-29-05:34:06.log) | fail |
|                    | oe_test_gcc_001                                              | file missing                                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_gcc_001/2023-05-26-00:01:54.log) | fail |
|                    | oe_test_ip_rule_01                                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_ip_rule_01/2023-04-29-07:32:00.log) | fail |
|                    | oe_test_ip_rule_02                                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_ip_rule_02/2023-04-29-07:32:16.log) | fail |
|                    | oe_test_iscsi                                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_iscsi/2023-04-29-05:46:14.log) | fail |
|                    | oe_test_iscsid                                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_iscsid/2023-04-29-07:40:15.log) | fail |
|                    | oe_test_libcgroup_04                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_libcgroup_04/2023-04-29-07:49:01.log) | fail |
|                    | oe_test_ncurses                                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_ncurses/2023-04-29-07:53:42.log) | fail |
|                    | oe_test_numactl                                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_numactl/2023-04-29-05:58:41.log) | fail |
|                    | oe_test_perf                                                 | timeout                                                      | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_perf/2023-04-29-06:01:18.log) | fail |
|                    | oe_test_pwd_001                                              | preinstall absent                                            | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_pwd_001/2023-04-29-06:02:28.log) | fail |
|                    | oe_test_rollback                                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_rollback/2023-04-29-06:26:56.log) | fail |
|                    | oe_test_rule_ipv6                                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_rule_ipv6/2023-04-29-08:40:20.log) | fail |
|                    | oe_test_service                                              | preinstall absent                                            | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_service/2023-04-29-08:40:36.log) | fail |
|                    | oe_test_skopeo                                               | choosing image instance: no image found in manifest list for architecture riscv64 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_skopeo/2023-04-29-06:04:38.log) | fail |
|                    | oe_test_syslog_logrotate_001                                 | preinstall absent                                            | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_syslog_logrotate_001/2023-05-26-00:15:50.log) | fail |
|                    | oe_test_user_debug_iotop_03                                  | file missing                                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_user_debug_iotop_03/2023-04-29-10:09:55.log) | fail |
|                    | oe_test_yumgroup_001                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_yumgroup_001/2023-04-29-06:23:17.log) | fail |
|                    | oe_test_MEMinfo_001                                          | file missing                                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_MEMinfo_001/2023-05-26-00:16:17.log) | fail |
|                    | oe_test_perf_top_01                                          | file missing                                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_perf_top_01/2023-05-26-00:17:11.log) | fail |
| strongswan         | oe_test_service_strongswan_02                                | pre_test时podman出现堆栈错误导致后续软件运行错误             | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/strongswan/oe_test_service_strongswan_02/2023-04-27-03:34:49.log) | fail |
|                    | oe_test_service_swanctl_01                                   | pre_test时podman出现堆栈错误导致后续软件运行错误             | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/strongswan/oe_test_service_swanctl_01/2023-04-27-03:52:50.log) | fail |
|                    | oe_test_service_swanctl_02                                   | pre_test时podman出现堆栈错误导致后续软件运行错误             | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/strongswan/oe_test_service_swanctl_02/2023-04-27-04:00:56.log) | fail |
| udisks2            | oe_test_service_udisks2                                      | Failed to load module: /usr/lib64/gio/modules/libgvfsdbus.so | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/udisks2/oe_test_service_udisks2/2023-04-27-04:42:18.log) | fail |
| vdo                | oe_test_service_vdo                                          | nothing provides kmod-kvdo                                   | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/vdo/oe_test_service_vdo/2023-04-27-04:56:41.log) | fail |
| amanda             | oe_test_amanda_amcheck                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/amanda/oe_test_amanda_amcheck/2023-06-16-03:44:44.log) | fail |
| openssh            | oe_test_openssh_cipher                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssh/oe_test_openssh_cipher/2023-06-16-04:10:21.log) | fail |
|                    | oe_test_openssh_locked                                       | preinstall absent/timeout                                    | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssh/oe_test_openssh_locked/2023-06-16-04:11:55.log) | fail |
|                    | oe_test_openssh_no_password                                  | preinstall absent/timeout                                    | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssh/oe_test_openssh_no_password/2023-06-16-04:12:57.log) | fail |
|                    | oe_test_openssh_scp                                          | preinstall absent/timeout                                    | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssh/oe_test_openssh_scp/2023-06-16-04:17:42.log) | fail |
|                    | oe_test_openssh_scp_P                                        | preinstall absent/timeout                                    | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssh/oe_test_openssh_scp_P/2023-06-16-04:15:05.log) | fail |
|                    | oe_test_openssh_scp_q                                        | preinstall absent/timeout                                    | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssh/oe_test_openssh_scp_q/2023-06-16-04:16:05.log) | fail |
| python-rtslib      | oe_test_service_target                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/python-rtslib/oe_test_service_target/2023-06-16-04:21:37.log) | fail |





## x86 fail

此表内的测试套和测试用例均为在x86上和riscv上均失败的测试用例

| 测试套/软件包名                    | 测试用例名                                              | 原因                                                         | 日志文件                                                     | 状态     |
| ---------------------------------- | ------------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | -------- |
| os-basic                           | oe_test_auditctl                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_auditctl/2023-04-28-03:36:43.log) | x86 fail |
|                                    | oe_test_catman                                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_catman/2023-04-28-03:30:09.log) | x86 fail |
|                                    | oe_test_dmraid                                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_dmraid/2023-04-28-03:31:39.log) | x86 fail |
|                                    | oe_test_nmcli_config_connect                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_nmcli_config_connect/2023-04-28-08:12:59.log) | x86 fail |
|                                    | oe_test_nmcli_macsec                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_nmcli_macsec/2023-04-28-08:10:38.log) | x86 fail |
|                                    | oe_test_power_powertop2tuned_optimize                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_power_powertop2tuned_optimize/2023-04-28-07:59:24.log) | x86 fail |
|                                    | oe_test_power_powertop_powerup                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_power_powertop_powerup/2023-04-28-07:56:45.log) | x86 fail |
|                                    | oe_test_reboot                                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_reboot/2023-04-28-05:55:16.log) | x86 fail |
|                                    | oe_test_server_mariadb_compatibilty                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_server_mariadb_compatibilty/2023-04-28-04:54:41.log) | x86 fail |
|                                    | oe_test_server_openssh_verifykey                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_server_openssh_verifykey/2023-04-28-04:29:21.log) | x86 fail |
|                                    | oe_test_server_squid_blacklist                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_server_squid_blacklist/2023-04-28-04:25:29.log) | x86 fail |
|                                    | oe_test_server_vsftpd_NKdelay                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_server_vsftpd_NKdelay/2023-04-28-04:18:57.log) | x86 fail |
|                                    | oe_test_server_vsftpd_transfer                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_server_vsftpd_transfer/2023-04-28-04:13:38.log) | x86 fail |
|                                    | oe_test_sos                                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_sos/2023-04-28-05:25:07.log) | x86 fail |
|                                    | oe_test_system_log_recorded                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_system_log_recorded/2023-04-28-04:12:23.log) | x86 fail |
|                                    | oe_test_system_monitor_login                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_system_monitor_login/2023-04-28-04:11:08.log) | x86 fail |
|                                    | oe_test_system_monitor_reboot                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_system_monitor_reboot/2023-04-28-03:40:46.log) | x86 fail |
|                                    | oe_test_uname                                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_uname/2023-04-28-03:40:18.log) | x86 fail |
|                                    | oe_test_whereis                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-basic/oe_test_whereis/2023-04-28-03:29:34.log) | x86 fail |
| AT                                 | oe_test_cat_001                                         | 当前版本的openEuler（6.1.19-7.0.0.17.oe2303.x86_64和6.1.8-3.oe2303.riscv64）root用户的User ID Info是Super User而不是root，所以/etc/passwd中root的信息为`root:x:0:0:Super User:/root:/bin/bash`而不是`root:x:0:0:root:/root:/bin/bash`，导致grep失败 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/AT/oe_test_cat_001/2023-04-29-02:35:30.log) | x86 fail |
|                                    | oe_test_dmesg_messages_log                              | oerv没有/var/log/messages,具体原因请看[here](https://github.com/l0tk3/PLCT/blob/main//WrokReport/week4/x86fail.md) | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/AT/oe_test_dmesg_messages_log/2023-04-29-00:23:38.log) | x86 fail |
|                                    | oe_test_docker_custom_image                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/AT/oe_test_docker_custom_image/2023-04-29-01:40:14.log) | x86 fail |
|                                    | oe_test_firewalld                                       | 没有ip6table_nat.ko模块,具体原因请看[here](https://github.com/l0tk3/PLCT/blob/main//WrokReport/week4/x86fail.md) | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/AT/oe_test_firewalld/2023-04-29-00:31:01.log) | x86 fail |
|                                    | oe_test_network_001                                     | 配置文件中没有填NIC（网卡名称），并且oerv中默认没有安装ethtool | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/AT/oe_test_network_001/2023-04-29-03:27:37.log) | x86 fail |
|                                    | oe_test_partition                                       | 没有swap分区和home分区                                       | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/AT/oe_test_partition/2023-04-29-00:31:25.log) | x86 fail |
| acl                                | oe_test_access_providepam                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/acl/oe_test_access_providepam/2023-05-25-16_28_24.log) | x86 fail |
| alsa-utils                         | oe_test_service_alsa-restore                            | 测试之前没有安装pciutils,具体原因请看[here](https://github.com/l0tk3/PLCT/blob/main/WrokReport/week4/x86fail.md) | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/alsa-utils/oe_test_service_alsa-restore/2023-05-25-21_35_07.log) | x86 fail |
| anaconda                           | oe_test_service_zram                                    | 没有启用zram                                                 | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/anaconda/oe_test_service_zram/2023-05-25-21_41_44.log) | x86 fail |
| ansible                            | oe_test_ansible_04                                      | 没有预装unzip,命令有变化，具体原因请看[here](https://github.com/l0tk3/PLCT/blob/main/WrokReport/week4/x86fail.md) | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ansible/oe_test_ansible_04/2023-05-25-21_58_33.log) | x86 fail |
| aspell                             | oe_test_aspell_01                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/aspell/oe_test_aspell_01/2023-05-25-21_52_26.log) | x86 fail |
| atune                              | oe_test_service_atuned                                  | 具体原因请看[here](https://github.com/l0tk3/PLCT/blob/main/WrokReport/week4/x86fail.md) | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/atune/oe_test_service_atuned/2023-05-25-21_58_33.log) | x86 fail |
|                                    | oe_test_service_atuned_01                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/atune/oe_test_service_atuned_01/2023-05-25-22_14_49.log) | x86 fail |
|                                    | oe_test_service_atuned_02                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/atune/oe_test_service_atuned_02/2023-05-25-22_22_52.log) | x86 fail |
|                                    | oe_test_service_atuned_03                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/atune/oe_test_service_atuned_03/2023-05-25-22_28_50.log) | x86 fail |
|                                    | oe_test_service_atuned_04                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/atune/oe_test_service_atuned_04/2023-05-25-22_35_35.log) | x86 fail |
|                                    | oe_test_service_atuned_05                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/atune/oe_test_service_atuned_05/2023-05-25-22_42_47.log) | x86 fail |
|                                    | oe_test_service_atuned_06                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/atune/oe_test_service_atuned_06/2023-05-25-22_47_57.log) | x86 fail |
|                                    | oe_test_service_atuned_07                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/atune/oe_test_service_atuned_07/2023-05-25-22_53_09.log) | x86 fail |
|                                    | oe_test_service_atuned_08                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/atune/oe_test_service_atuned_08/2023-05-25-22_58_21.log) | x86 fail |
|                                    | oe_test_service_atuned_09                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/atune/oe_test_service_atuned_09/2023-05-25-23_03_22.log) | x86 fail |
|                                    | oe_test_audit_ausearch                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_ausearch/2023-05-25-22_58_32.log) | x86 fail |
|                                    | oe_test_audit_available_disk_space                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_available_disk_space/2023-05-25-22_51_28.log) | x86 fail |
|                                    | oe_test_audit_count_number_of_event                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_count_number_of_event/2023-05-25-22_37_18.log) | x86 fail |
|                                    | oe_test_audit_count_time                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_count_time/2023-05-25-22_37_08.log) | x86 fail |
|                                    | oe_test_audit_event_log                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_event_log/2023-05-25-22_57_47.log) | x86 fail |
|                                    | oe_test_audit_fetch_file_in_order                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_fetch_file_in_order/2023-05-25-22_36_21.log) | x86 fail |
|                                    | oe_test_audit_max_log_file_ignore                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_max_log_file_ignore/2023-05-25-22_40_37.log) | x86 fail |
|                                    | oe_test_audit_max_log_file_keep_logs                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_max_log_file_keep_logs/2023-05-25-22_50_35.log) | x86 fail |
|                                    | oe_test_audit_max_log_file_rotate                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_max_log_file_rotate/2023-05-25-22_39_42.log) | x86 fail |
|                                    | oe_test_audit_max_log_file_suspend                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_max_log_file_suspend/2023-05-25-22_49_20.log) | x86 fail |
|                                    | oe_test_audit_max_log_file_syslog                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_max_log_file_syslog/2023-05-25-22_48_03.log) | x86 fail |
|                                    | oe_test_audit_monitor_dictionary_access                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_monitor_dictionary_access/2023-05-25-22_33_01.log) | x86 fail |
|                                    | oe_test_audit_monitor_do_command                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_monitor_do_command/2023-05-25-22_33_36.log) | x86 fail |
|                                    | oe_test_audit_monitor_file_access                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_monitor_file_access/2023-05-25-22_02_54.log) | x86 fail |
|                                    | oe_test_audit_monitor_network_visit                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_monitor_network_visit/2023-05-25-22_34_21.log) | x86 fail |
|                                    | oe_test_audit_monitor_system_use                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_monitor_system_use/2023-05-25-22_33_17.log) | x86 fail |
|                                    | oe_test_audit_other                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_other/2023-05-25-22_58_00.log) | x86 fail |
|                                    | oe_test_audit_rule_conflict_strategy                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_rule_conflict_strategy/2023-05-25-22_35_47.log) | x86 fail |
|                                    | oe_test_audit_rule_contact_strategy                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_rule_contact_strategy/2023-05-25-22_35_13.log) | x86 fail |
|                                    | oe_test_audit_rule_fetch_from_rule                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_rule_fetch_from_rule/2023-05-25-22_36_08.log) | x86 fail |
|                                    | oe_test_audit_show_event_list                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_show_event_list/2023-05-25-22_37_30.log) | x86 fail |
|                                    | oe_test_audit_track_designated_access                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_track_designated_access/2023-05-25-22_34_36.log) | x86 fail |
|                                    | oe_test_audit_use_d_audit                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_use_d_audit/2023-05-25-22_34_47.log) | x86 fail |
|                                    | oe_test_audit_use_w_audit                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_use_w_audit/2023-05-25-22_35_01.log) | x86 fail |
|                                    | oe_test_audit_user_build_connection                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_audit_user_build_connection/2023-05-25-22_37_42.log) | x86 fail |
|                                    | oe_test_aulastlog                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_aulastlog/2023-05-25-22_58_53.log) | x86 fail |
|                                    | oe_test_inject_time_fault                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_inject_time_fault/2023-05-25-22_55_53.log) | x86 fail |
|                                    | oe_test_service_auditd                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_service_auditd/2023-05-25-22_57_10.log) | x86 fail |
|                                    | oe_test_start_audit                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/audit/oe_test_start_audit/2023-05-25-22_58_18.log) | x86 fail |
| auter                              | oe_test_auter                                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/auter/oe_test_auter/2023-05-25-13:06:46.log) | x86 fail |
| autofs                             | oe_test_autofs                                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/autofs/oe_test_autofs/2023-05-25-13:14:54.log) | x86 fail |
|                                    | oe_test_service_autofs                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/autofs/oe_test_service_autofs/2023-05-25-13:20:51.log) | x86 fail |
| ceph                               | oe_test_service_rbdmap                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ceph/oe_test_service_rbdmap/2023-05-25-14:06:22.log) | x86 fail |
|                                    | oe_test_target_ceph                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ceph/oe_test_target_ceph/2023-05-25-14:23:13.log) | x86 fail |
| chrony                             | oe_test_service_chrony-wait                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/chrony/oe_test_service_chrony-wait/2023-05-25-14:09:34.log) | x86 fail |
| clamav                             | oe_test_clamav_clamdtop                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/clamav/oe_test_clamav_clamdtop/2023-05-25-15:39:00.log) | x86 fail |
|                                    | oe_test_clamav_clamonacc                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/clamav/oe_test_clamav_clamonacc/2023-05-25-15:55:11.log) | x86 fail |
|                                    | oe_test_clamav_clamscan_1                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/clamav/oe_test_clamav_clamscan_1/2023-05-25-16:11:23.log) | x86 fail |
|                                    | oe_test_clamav_clamscan_2                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/clamav/oe_test_clamav_clamscan_2/2023-05-25-16:41:45.log) | x86 fail |
|                                    | oe_test_clamav_clamscan_3                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/clamav/oe_test_clamav_clamscan_3/2023-05-25-16:51:09.log) | x86 fail |
|                                    | oe_test_service_clamav-clamonacc                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/clamav/oe_test_service_clamav-clamonacc/2023-05-25-14:15:38.log) | x86 fail |
| cmake                              | oe_test_ccmake                                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cmake/oe_test_ccmake/2023-05-25-15:21:43.log) | x86 fail |
|                                    | oe_test_ccmake3                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cmake/oe_test_ccmake3/2023-05-25-15:25:48.log) | x86 fail |
| cobbler                            | oe_test_cobbler_distro                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cobbler/oe_test_cobbler_distro/2023-05-25-16:03:06.log) | x86 fail |
|                                    | oe_test_cobbler_file                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cobbler/oe_test_cobbler_file/2023-05-25-17:09:17.log) | x86 fail |
|                                    | oe_test_cobbler_image                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cobbler/oe_test_cobbler_image/2023-05-25-16:41:56.log) | x86 fail |
|                                    | oe_test_cobbler_mgmtclass                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cobbler/oe_test_cobbler_mgmtclass/2023-05-25-16:51:20.log) | x86 fail |
|                                    | oe_test_cobbler_other                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cobbler/oe_test_cobbler_other/2023-05-25-17:18:28.log) | x86 fail |
|                                    | oe_test_cobbler_package                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cobbler/oe_test_cobbler_package/2023-05-25-17:00:31.log) | x86 fail |
|                                    | oe_test_cobbler_profile                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cobbler/oe_test_cobbler_profile/2023-05-25-16:13:21.log) | x86 fail |
|                                    | oe_test_cobbler_repo                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cobbler/oe_test_cobbler_repo/2023-05-25-16:32:56.log) | x86 fail |
|                                    | oe_test_cobbler_system                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cobbler/oe_test_cobbler_system/2023-05-25-16:22:47.log) | x86 fail |
| cockpit                            | oe_test_service_cockpit                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cockpit/oe_test_service_cockpit/2023-05-25-17:34:10.log) | x86 fail |
|                                    | oe_test_socket_cockpit                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cockpit/oe_test_socket_cockpit/2023-05-25-17:36:31.log) | x86 fail |
| conntrack-tools                    | oe_test_service_conntrackd                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/conntrack-tools/oe_test_service_conntrackd/2023-05-25-17:55:29.log) | x86 fail |
| corosync-qdevice                   | oe_test_service_corosync-qdevice                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/corosync-qdevice/oe_test_service_corosync-qdevice/2023-05-25-18:10:59.log) | x86 fail |
| corosync                           | oe_test_service_corosync-notifyd                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/corosync/oe_test_service_corosync-notifyd/2023-05-25-18:17:25.log) | x86 fail |
|                                    | oe_test_service_corosync                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/corosync/oe_test_service_corosync/2023-05-25-18:05:04.log) | x86 fail |
|                                    | oe_test_service_spausedd                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/corosync/oe_test_service_spausedd/2023-05-25-18:03:16.log) | x86 fail |
| cppcheck                           | oe_test_cppcheck                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cppcheck/oe_test_cppcheck/2023-05-25-18:32:32.log) | x86 fail |
| crontabs                           | oe_test_crontabs                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/crontabs/oe_test_crontabs/2023-05-25-16_38_51.log) | x86 fail |
| dblatex                            | oe_test_dblatex_dblatex_01                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dblatex/oe_test_dblatex_dblatex_01/2023-05-25-19:22:26.log) | x86 fail |
|                                    | oe_test_dblatex_dblatex_02                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dblatex/oe_test_dblatex_dblatex_02/2023-05-25-19:52:44.log) | x86 fail |
|                                    | oe_test_dblatex_dblatex_03                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dblatex/oe_test_dblatex_dblatex_03/2023-05-25-20:07:49.log) | x86 fail |
|                                    | oe_test_dblatex_dblatex_04                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dblatex/oe_test_dblatex_dblatex_04/2023-05-25-20:14:51.log) | x86 fail |
|                                    | oe_test_dblatex_dblatex_05                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dblatex/oe_test_dblatex_dblatex_05/2023-05-25-20:21:56.log) | x86 fail |
|                                    | oe_test_dblatex_dblatex_06                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dblatex/oe_test_dblatex_dblatex_06/2023-05-25-20:52:14.log) | x86 fail |
| dbxtool                            | oe_test_service_dbxtool                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dbxtool/oe_test_service_dbxtool/2023-05-25-21:05:52.log) | x86 fail |
| dejagnu                            | oe_test_dejagnu_runtest_01                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dejagnu/oe_test_dejagnu_runtest_01/2023-05-25-21:13:30.log) | x86 fail |
| derby                              | oe_test_service_derby                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/derby/oe_test_service_derby/2023-05-25-21:30:29.log) | x86 fail |
| dhcp                               | oe_test_service_dhcpd                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dhcp/oe_test_service_dhcpd/2023-05-25-21:39:19.log) | x86 fail |
|                                    | oe_test_service_dhcpd6                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dhcp/oe_test_service_dhcpd6/2023-05-25-21:38:13.log) | x86 fail |
| digest-list-tools                  | oe_test_service_setup-ima-digest-lists                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/digest-list-tools/oe_test_service_setup-ima-digest-lists/2023-05-25-21:49:13.log) | x86 fail |
| dmidecode                          | oe_test_dmidecode                                       | 测试套没有安装dmidecode这一步骤                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dmidecode/oe_test_dmidecode/2023-05-25-22:30:42.log) | x86 fail |
| dnf                                | oe_test_dnf_enabled_enablerepo                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dnf/oe_test_dnf_enabled_enablerepo/2023-05-25-17_06_44.log) | x86 fail |
|                                    | oe_test_dnf_list_mark                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dnf/oe_test_dnf_list_mark/2023-05-25-17_14_32.log) | x86 fail |
|                                    | oe_test_dnf_reinstall_repoinfo                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dnf/oe_test_dnf_reinstall_repoinfo/2023-05-25-17_20_55.log) | x86 fail |
|                                    | oe_test_dnf_repeat-upgrade-downgrade                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/dnf/oe_test_dnf_repeat-upgrade-downgrade/2023-05-25-17_35_52.log) | x86 fail |
| docker-engine                      | oe_test_service_docker                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/docker-engine/oe_test_service_docker/2023-05-25-23:31:48.log) | x86 fail |
| dracut                             | oe_test_easymock_spring                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/easymock/oe_test_easymock_spring/2023-05-26-01:04:28.log) | x86 fail |
| ebtables                           | oe_test_service_ebtables                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ebtables/oe_test_service_ebtables/2023-05-26-02:18:40.log) | x86 fail |
| etcd                               | oe_test_etcd_03                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/etcd/oe_test_etcd_03/2023-05-26-14:05:56.log) | x86 fail |
|                                    | oe_test_etcd_05                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/etcd/oe_test_etcd_05/2023-05-26-15:06:29.log) | x86 fail |
| fastdfs                            | oe_test_fastdfs_01                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/fastdfs/oe_test_fastdfs_01/2023-05-26-13:47:56.log) | x86 fail |
|                                    | oe_test_fastdfs_02                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/fastdfs/oe_test_fastdfs_02/2023-05-26-13:52:31.log) | x86 fail |
|                                    | oe_test_fastdfs_03                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/fastdfs/oe_test_fastdfs_03/2023-05-26-13:56:05.log) | x86 fail |
|                                    | oe_test_fastdfs_04                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/fastdfs/oe_test_fastdfs_04/2023-05-26-14:00:05.log) | x86 fail |
| fcgi                               | oe_test_fcgi                                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/fcgi/oe_test_fcgi/2023-05-26-14:06:31.log) | x86 fail |
| fftw                               | oe_test_fftw_fftw-wisdom-to-conf                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/fftw/oe_test_fftw_fftw-wisdom-to-conf/2023-05-26-14:22:42.log) | x86 fail |
|                                    | oe_test_fftw_fftw-wisdom_02                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/fftw/oe_test_fftw_fftw-wisdom_02/2023-05-26-14:26:27.log) | x86 fail |
|                                    | oe_test_fftw_fftwf-wisdom_02                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/fftw/oe_test_fftw_fftwf-wisdom_02/2023-05-26-14:31:51.log) | x86 fail |
|                                    | oe_test_fftw_fftwl-wisdom_02                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/fftw/oe_test_fftw_fftwl-wisdom_02/2023-05-26-14:37:36.log) | x86 fail |
| firebird                           | oe_test_service_firebird-superserver                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firebird/oe_test_service_firebird-superserver/2023-05-26-15:11:09.log) | x86 fail |
| firewalld                          | oe_test_firewalld_add_newservice                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_add_newservice/2023-05-26-15:17:27.log) | x86 fail |
|                                    | oe_test_firewalld_add_port                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_add_port/2023-05-26-15:21:23.log) | x86 fail |
|                                    | oe_test_firewalld_add_service                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_add_service/2023-05-26-15:26:04.log) | x86 fail |
|                                    | oe_test_firewalld_add_sourceip                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_add_sourceip/2023-05-26-15:28:36.log) | x86 fail |
|                                    | oe_test_firewalld_add_sourceport                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_add_sourceport/2023-05-26-15:29:01.log) | x86 fail |
|                                    | oe_test_firewalld_addport_udp                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_addport_udp/2023-05-26-15:23:54.log) | x86 fail |
|                                    | oe_test_firewalld_allow_zones                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_allow_zones/2023-05-26-15:29:28.log) | x86 fail |
|                                    | oe_test_firewalld_block_icmp                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_block_icmp/2023-05-26-15:32:25.log) | x86 fail |
|                                    | oe_test_firewalld_change_interface                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_change_interface/2023-05-26-15:32:54.log) | x86 fail |
|                                    | oe_test_firewalld_change_xml                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_change_xml/2023-05-26-15:35:18.log) | x86 fail |
|                                    | oe_test_firewalld_directrule_acceptdport                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_directrule_acceptdport/2023-05-26-15:37:44.log) | x86 fail |
|                                    | oe_test_firewalld_dnat                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_dnat/2023-05-26-15:40:07.log) | x86 fail |
|                                    | oe_test_firewalld_dropzone_service                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_dropzone_service/2023-05-26-15:43:02.log) | x86 fail |
|                                    | oe_test_firewalld_forward_nat                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_forward_nat/2023-05-26-15:45:27.log) | x86 fail |
|                                    | oe_test_firewalld_getzone                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_getzone/2023-05-26-15:46:10.log) | x86 fail |
|                                    | oe_test_firewalld_ip_camouflage                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_ip_camouflage/2023-05-26-15:46:36.log) | x86 fail |
|                                    | oe_test_firewalld_list                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_list/2023-05-26-15:47:04.log) | x86 fail |
|                                    | oe_test_firewalld_lockdown                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_lockdown/2023-05-26-15:47:31.log) | x86 fail |
|                                    | oe_test_firewalld_log_denied                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_log_denied/2023-05-26-15:47:57.log) | x86 fail |
|                                    | oe_test_firewalld_new_zone                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_new_zone/2023-05-26-15:50:38.log) | x86 fail |
|                                    | oe_test_firewalld_panic_on                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_panic_on/2023-05-26-15:51:05.log) | x86 fail |
|                                    | oe_test_firewalld_port_map                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_port_map/2023-05-26-15:51:48.log) | x86 fail |
|                                    | oe_test_firewalld_protocol_tcp                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_protocol_tcp/2023-05-26-15:54:01.log) | x86 fail |
|                                    | oe_test_firewalld_richrule_acceptsource                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_richrule_acceptsource/2023-05-26-15:56:16.log) | x86 fail |
|                                    | oe_test_firewalld_richrule_allowippak                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_richrule_allowippak/2023-05-26-15:58:40.log) | x86 fail |
|                                    | oe_test_firewalld_richrule_blacklist                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_richrule_blacklist/2023-05-26-16:01:06.log) | x86 fail |
|                                    | oe_test_firewalld_richrule_dropicmppack                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_richrule_dropicmppack/2023-05-26-16:01:47.log) | x86 fail |
|                                    | oe_test_firewalld_richrule_dropipv4pak                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_richrule_dropipv4pak/2023-05-26-16:02:18.log) | x86 fail |
|                                    | oe_test_firewalld_richrule_forwardport                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_richrule_forwardport/2023-05-26-16:04:47.log) | x86 fail |
|                                    | oe_test_firewalld_runtime_permanent                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_runtime_permanent/2023-05-26-16:07:05.log) | x86 fail |
|                                    | oe_test_firewalld_set_defaultzone                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_set_defaultzone/2023-05-26-16:07:32.log) | x86 fail |
|                                    | oe_test_firewalld_set_ipset                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_set_ipset/2023-05-26-16:09:56.log) | x86 fail |
|                                    | oe_test_firewalld_set_target                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_set_target/2023-05-26-16:12:51.log) | x86 fail |
|                                    | oe_test_firewalld_start_check                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_start_check/2023-05-26-16:13:20.log) | x86 fail |
|                                    | oe_test_firewalld_start_status                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_start_status/2023-05-26-16:13:43.log) | x86 fail |
|                                    | oe_test_firewalld_start_stop                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_start_stop/2023-05-26-16:14:11.log) | x86 fail |
|                                    | oe_test_firewalld_whitelist_command                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_whitelist_command/2023-05-26-16:15:12.log) | x86 fail |
|                                    | oe_test_firewalld_whitelist_contexts                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_whitelist_contexts/2023-05-26-16:15:47.log) | x86 fail |
|                                    | oe_test_firewalld_whitelist_uids                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_whitelist_uids/2023-05-26-16:16:12.log) | x86 fail |
|                                    | oe_test_firewalld_whitelist_user                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_whitelist_user/2023-05-26-16:16:41.log) | x86 fail |
|                                    | oe_test_firewalld_zone_add_service                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_zone_add_service/2023-05-26-16:17:12.log) | x86 fail |
|                                    | oe_test_firewalld_zone_migration                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_firewalld_zone_migration/2023-05-26-16:23:08.log) | x86 fail |
|                                    | oe_test_service_firewalld                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/firewalld/oe_test_service_firewalld/2023-05-26-16:17:37.log) | x86 fail |
| freeipmi                           | oe_test_service_bmc-watchdog                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeipmi/oe_test_service_bmc-watchdog/2023-05-26-16:49:31.log) | x86 fail |
|                                    | oe_test_service_ipmidetectd                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeipmi/oe_test_service_ipmidetectd/2023-05-26-16:52:34.log) | x86 fail |
|                                    | oe_test_service_ipmiseld                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeipmi/oe_test_service_ipmiseld/2023-05-26-16:55:23.log) | x86 fail |
| freeradius                         | oe_test_freeradius_freeradius-utils_radlast             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeradius/oe_test_freeradius_freeradius-utils_radlast/2023-05-26-18:11:53.log) | x86 fail |
|                                    | oe_test_freeradius_freeradius-utils_radlastAndRadsniff  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeradius/oe_test_freeradius_freeradius-utils_radlastAndRadsniff/2023-05-26-18:16:55.log) | x86 fail |
|                                    | oe_test_freeradius_freeradius-utils_radsniff            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeradius/oe_test_freeradius_freeradius-utils_radsniff/2023-05-26-18:22:35.log) | x86 fail |
|                                    | oe_test_freeradius_freeradius-utils_radsniff2           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeradius/oe_test_freeradius_freeradius-utils_radsniff2/2023-05-26-18:52:49.log) | x86 fail |
|                                    | oe_test_freeradius_freeradius-utils_radsqlrelay         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeradius/oe_test_freeradius_freeradius-utils_radsqlrelay/2023-05-26-18:53:42.log) | x86 fail |
|                                    | oe_test_freeradius_freeradius-utils_radtestAndRadwho    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/freeradius/oe_test_freeradius_freeradius-utils_radtestAndRadwho/2023-05-26-18:54:43.log) | x86 fail |
| gradle                             | oe_test_gradle_01                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/gradle/oe_test_gradle_01/2023-05-26-22:02:35.log) | x86 fail |
|                                    | oe_test_gradle_02                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/gradle/oe_test_gradle_02/2023-05-26-22:04:17.log) | x86 fail |
|                                    | oe_test_gradle_03                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/gradle/oe_test_gradle_03/2023-05-26-22:05:48.log) | x86 fail |
|                                    | oe_test_gradle_04                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/gradle/oe_test_gradle_04/2023-05-26-22:07:19.log) | x86 fail |
| groovy                             | oe_test_groovy_01                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/groovy/oe_test_groovy_01/2023-05-26-22:14:30.log) | x86 fail |
|                                    | oe_test_groovy_02                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/groovy/oe_test_groovy_02/2023-05-26-22:16:16.log) | x86 fail |
| hostname                           | oe_test_service_nis-domainname                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/hostname/oe_test_service_nis-domainname/2023-05-25-16_57_06.log) | x86 fail |
| iSulad                             | oe_test_service_isulad                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/iSulad/oe_test_service_isulad/2023-05-26-23:31:47.log) | x86 fail |
| iftop                              | oe_test_iftop_config                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/iftop/oe_test_iftop_config/2023-05-27-00:14:03.log) | x86 fail |
|                                    | oe_test_iftop_gui                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/iftop/oe_test_iftop_gui/2023-05-27-00:08:51.log) | x86 fail |
|                                    | oe_test_iftop_text_mode                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/iftop/oe_test_iftop_text_mode/2023-05-26-23:38:34.log) | x86 fail |
| initscripts                        | oe_test_service_netconsole                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/initscripts/oe_test_service_netconsole/2023-05-27-01:03:12.log) | x86 fail |
|                                    | oe_test_service_network                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/initscripts/oe_test_service_network/2023-05-27-01:02:07.log) | x86 fail |
| iputils                            | oe_test_service_ninfod                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/iputils/oe_test_service_ninfod/2023-05-25-16_57_27.log) | x86 fail |
|                                    | oe_test_service_rdisc                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/iputils/oe_test_service_rdisc/2023-05-25-16_59_05.log) | x86 fail |
| kernel                             | oe_test_check_huge_task                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kernel/oe_test_check_huge_task/2023-05-25-17_11_57.log) | x86 fail |
|                                    | oe_test_cifs                                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kernel/oe_test_cifs/2023-05-25-17_13_05.log) | x86 fail |
|                                    | oe_test_cpu_rand                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kernel/oe_test_cpu_rand/2023-05-25-17_09_52.log) | x86 fail |
|                                    | oe_test_hinic                                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kernel/oe_test_hinic/2023-05-25-17_08_46.log) | x86 fail |
|                                    | oe_test_io_sched                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kernel/oe_test_io_sched/2023-05-25-17_07_36.log) | x86 fail |
|                                    | oe_test_swap_compress                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kernel/oe_test_swap_compress/2023-05-25-17_11_12.log) | x86 fail |
| kmod                               | oe_test_depmod                                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kmod/oe_test_depmod/2023-05-25-17_02_28.log) | x86 fail |
|                                    | oe_test_insmod-lsmod                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kmod/oe_test_insmod-lsmod/2023-05-25-17_03_47.log) | x86 fail |
|                                    | oe_test_modinfo                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kmod/oe_test_modinfo/2023-05-25-17_04_39.log) | x86 fail |
|                                    | oe_test_modprobe                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kmod/oe_test_modprobe/2023-05-25-17_05_03.log) | x86 fail |
| lvm2                               | oe_test_lvm2_pvchange_001                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_lvm2_pvchange_001/2023-05-25-17_50_26.log) | x86 fail |
|                                    | oe_test_lvm2_pvcreate_001                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_lvm2_pvcreate_001/2023-05-25-17_41_15.log) | x86 fail |
|                                    | oe_test_lvm2_pvcreate_002                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_lvm2_pvcreate_002/2023-05-25-17_38_17.log) | x86 fail |
|                                    | oe_test_lvm2_pvdisplay_001                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_lvm2_pvdisplay_001/2023-05-25-17_47_58.log) | x86 fail |
|                                    | oe_test_lvm2_pvdisplay_002                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_lvm2_pvdisplay_002/2023-05-25-17_44_50.log) | x86 fail |
|                                    | oe_test_lvm2_pvmove_001                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_lvm2_pvmove_001/2023-05-25-17_42_15.log) | x86 fail |
|                                    | oe_test_lvm2_pvmove_002                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_lvm2_pvmove_002/2023-05-25-17_49_01.log) | x86 fail |
|                                    | oe_test_lvm2_pvremove_001                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_lvm2_pvremove_001/2023-05-25-17_35_39.log) | x86 fail |
|                                    | oe_test_lvm2_pvresize_001                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_lvm2_pvresize_001/2023-05-25-17_40_21.log) | x86 fail |
|                                    | oe_test_lvm2_vgchange_001                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_lvm2_vgchange_001/2023-05-25-17_51_19.log) | x86 fail |
|                                    | oe_test_lvm2_vgchange_002                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_lvm2_vgchange_002/2023-05-25-17_57_25.log) | x86 fail |
|                                    | oe_test_lvm2_vgcreate_001                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_lvm2_vgcreate_001/2023-05-25-17_43_21.log) | x86 fail |
|                                    | oe_test_lvm2_vgdisplay_001                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_lvm2_vgdisplay_001/2023-05-25-17_45_56.log) | x86 fail |
|                                    | oe_test_lvm2_vgexport_001                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_lvm2_vgexport_001/2023-05-25-17_56_06.log) | x86 fail |
|                                    | oe_test_lvm2_vgextend_001                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_lvm2_vgextend_001/2023-05-25-17_54_11.log) | x86 fail |
|                                    | oe_test_lvm2_vgextend_002                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_lvm2_vgextend_002/2023-05-25-17_52_49.log) | x86 fail |
|                                    | oe_test_lvm2_vgrename_001                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_lvm2_vgrename_001/2023-05-25-17_46_56.log) | x86 fail |
|                                    | oe_test_service_lvm2-lvmpolld                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_service_lvm2-lvmpolld/2023-05-25-17_29_04.log) | x86 fail |
|                                    | oe_test_service_lvm2-monitor                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lvm2/oe_test_service_lvm2-monitor/2023-05-25-17_29_55.log) | x86 fail |
| net-tools                          | oe_test_net-tools_ipmaddr                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/net-tools/oe_test_net-tools_ipmaddr/2023-05-25-17_31_35.log) | x86 fail |
|                                    | oe_test_net-tools_route                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/net-tools/oe_test_net-tools_route/2023-05-25-17_30_48.log) | x86 fail |
| openssl                            | oe_test_openssl_DSA_algorithm                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_DSA_algorithm/2023-05-25-18_06_26.log) | x86 fail |
|                                    | oe_test_openssl_Diffie_Hellman                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_Diffie_Hellman/2023-05-25-18_05_42.log) | x86 fail |
|                                    | oe_test_openssl_Implements_https                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_Implements_https/2023-05-25-18_13_15.log) | x86 fail |
|                                    | oe_test_openssl_RSA_algorithm                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_RSA_algorithm/2023-05-25-18_30_50.log) | x86 fail |
|                                    | oe_test_openssl_create_CA_applying_certificate          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_create_CA_applying_certificate/2023-05-25-18_01_37.log) | x86 fail |
|                                    | oe_test_openssl_delete_configuration_file               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_delete_configuration_file/2023-05-25-18_03_32.log) | x86 fail |
|                                    | oe_test_openssl_empty_private_key                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_empty_private_key/2023-05-25-18_06_55.log) | x86 fail |
|                                    | oe_test_openssl_empty_public_key                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_empty_public_key/2023-05-25-18_07_23.log) | x86 fail |
|                                    | oe_test_openssl_encrypt_decrypt_file_asymmetrically     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_encrypt_decrypt_file_asymmetrically/2023-05-25-18_07_52.log) | x86 fail |
|                                    | oe_test_openssl_encrypte_decrypte_emails                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_encrypte_decrypte_emails/2023-05-25-18_08_18.log) | x86 fail |
|                                    | oe_test_openssl_expired_certificate                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_expired_certificate/2023-05-25-18_09_01.log) | x86 fail |
|                                    | oe_test_openssl_file_signature_verification             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_file_signature_verification/2023-05-25-18_11_19.log) | x86 fail |
|                                    | oe_test_openssl_generate_key_pair                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_generate_key_pair/2023-05-25-18_12_02.log) | x86 fail |
|                                    | oe_test_openssl_generate_password                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_generate_password/2023-05-25-18_12_30.log) | x86 fail |
|                                    | oe_test_openssl_incorrect_public_private_key            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_incorrect_public_private_key/2023-05-25-18_15_37.log) | x86 fail |
|                                    | oe_test_openssl_rc4_encryption_file                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_rc4_encryption_file/2023-05-25-18_32_45.log) | x86 fail |
|                                    | oe_test_openssl_reliability                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_reliability/2023-05-25-18_17_52.log) | x86 fail |
|                                    | oe_test_openssl_remove_mod_ssl                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_remove_mod_ssl/2023-05-25-18_20_08.log) | x86 fail |
|                                    | oe_test_openssl_repeat_restart                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_repeat_restart/2023-05-25-18_24_17.log) | x86 fail |
|                                    | oe_test_openssl_speed                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssl/oe_test_openssl_speed/2023-05-25-18_34_13.log) | x86 fail |
| osc                                | oe_test_osc_04                                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/osc/oe_test_osc_04/2023-05-25-18_07_22.log) | x86 fail |
|                                    | oe_test_osc_build                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/osc/oe_test_osc_build/2023-05-25-18_19_19.log) | x86 fail |
| systemd                            | oe_test_service_console-getty                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_console-getty/2023-05-25-20_53_53.log) | x86 fail |
|                                    | oe_test_service_dbus-org.freedesktop.import1            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_dbus-org.freedesktop.import1/2023-05-25-20_55_26.log) | x86 fail |
|                                    | oe_test_service_dbus-org.freedesktop.portable1          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_dbus-org.freedesktop.portable1/2023-05-25-21_00_01.log) | x86 fail |
|                                    | oe_test_service_initrd-switch-root                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_initrd-switch-root/2023-05-25-21_03_47.log) | x86 fail |
|                                    | oe_test_service_quotaon                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_quotaon/2023-05-25-21_05_38.log) | x86 fail |
|                                    | oe_test_service_systemd-ask-password-wall               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_systemd-ask-password-wall/2023-05-25-21_09_30.log) | x86 fail |
|                                    | oe_test_service_systemd-fsck-root                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_systemd-fsck-root/2023-05-25-21_11_31.log) | x86 fail |
|                                    | oe_test_service_systemd-importd                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_systemd-importd/2023-05-25-21_14_07.log) | x86 fail |
|                                    | oe_test_service_systemd-initctl                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_systemd-initctl/2023-05-25-21_15_07.log) | x86 fail |
|                                    | oe_test_service_systemd-journal-gatewayd                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_systemd-journal-gatewayd/2023-05-25-21_17_42.log) | x86 fail |
|                                    | oe_test_service_systemd-journal-remote                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_systemd-journal-remote/2023-05-25-21_19_03.log) | x86 fail |
|                                    | oe_test_service_systemd-journal-upload                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_systemd-journal-upload/2023-05-25-21_20_33.log) | x86 fail |
|                                    | oe_test_service_systemd-network-generator               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_systemd-network-generator/2023-05-25-21_26_35.log) | x86 fail |
|                                    | oe_test_service_systemd-networkd-wait-online            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_systemd-networkd-wait-online/2023-05-25-21_25_47.log) | x86 fail |
|                                    | oe_test_service_systemd-networkd                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_systemd-networkd/2023-05-25-21_25_00.log) | x86 fail |
|                                    | oe_test_service_systemd-portabled                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_systemd-portabled/2023-05-25-21_27_05.log) | x86 fail |
|                                    | oe_test_service_systemd-quotacheck                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_systemd-quotacheck/2023-05-25-21_28_24.log) | x86 fail |
|                                    | oe_test_service_systemd-resolved                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_systemd-resolved/2023-05-25-21_30_35.log) | x86 fail |
|                                    | oe_test_service_systemd-sysext                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_systemd-sysext/2023-05-25-22_20_13.log) | x86 fail |
|                                    | oe_test_service_systemd-udevd                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_systemd-udevd/2023-05-25-21_36_49.log) | x86 fail |
|                                    | oe_test_service_systemd-userdbd                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_service_systemd-userdbd/2023-05-25-22_21_02.log) | x86 fail |
|                                    | oe_test_socket_systemd-journal-gatewayd                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_socket_systemd-journal-gatewayd/2023-05-25-21_45_19.log) | x86 fail |
|                                    | oe_test_socket_systemd-journal-remote                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_socket_systemd-journal-remote/2023-05-25-21_46_40.log) | x86 fail |
|                                    | oe_test_socket_systemd-journald-dev-log                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_socket_systemd-journald-dev-log/2023-05-25-21_43_55.log) | x86 fail |
|                                    | oe_test_socket_systemd-networkd                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_socket_systemd-networkd/2023-05-25-21_48_03.log) | x86 fail |
|                                    | oe_test_socket_systemd-rfkill                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_socket_systemd-rfkill/2023-05-25-21_48_49.log) | x86 fail |
|                                    | oe_test_socket_systemd-userdbd                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_socket_systemd-userdbd/2023-05-25-22_21_49.log) | x86 fail |
|                                    | oe_test_target_cryptsetup-pre                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_target_cryptsetup-pre/2023-05-25-21_52_09.log) | x86 fail |
|                                    | oe_test_target_cryptsetup                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_target_cryptsetup/2023-05-25-21_52_29.log) | x86 fail |
|                                    | oe_test_target_initrd-switch-root                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_target_initrd-switch-root/2023-05-25-22_00_18.log) | x86 fail |
|                                    | oe_test_target_remote-cryptsetup                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_target_remote-cryptsetup/2023-05-25-22_06_49.log) | x86 fail |
|                                    | oe_test_target_remote-veritysetup                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_target_remote-veritysetup/2023-05-25-22_22_51.log) | x86 fail |
|                                    | oe_test_target_usb-gadget                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_target_usb-gadget/2023-05-25-22_23_39.log) | x86 fail |
|                                    | oe_test_target_veritysetup-pre                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_target_veritysetup-pre/2023-05-25-22_25_11.log) | x86 fail |
|                                    | oe_test_target_veritysetup                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemd/oe_test_target_veritysetup/2023-05-25-22_24_25.log) | x86 fail |
| iperf3                             | oe_test_iperf3_command_client                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/iperf3/oe_test_iperf3_command_client/2023-06-02-03:08:49.log) | x86 fail |
|                                    | oe_test_iperf3_command_clientAndShared                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/iperf3/oe_test_iperf3_command_clientAndShared/2023-06-02-03:09:59.log) | x86 fail |
|                                    | oe_test_iperf3_command_serverAndBase                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/iperf3/oe_test_iperf3_command_serverAndBase/2023-06-02-03:11:06.log) | x86 fail |
| ipmitool                           | oe_test_service_bmc-snmp-proxy                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ipmitool/oe_test_service_bmc-snmp-proxy/2023-06-02-14:37:37.log) | x86 fail |
|                                    | oe_test_service_exchange-bmc-os-info                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ipmitool/oe_test_service_exchange-bmc-os-info/2023-06-02-14:39:23.log) | x86 fail |
|                                    | oe_test_service_ipmievd                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ipmitool/oe_test_service_ipmievd/2023-06-02-14:40:55.log) | x86 fail |
| iprutils                           | oe_test_service_iprdump                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/iprutils/oe_test_service_iprdump/2023-06-02-17:40:32.log) | x86 fail |
|                                    | oe_test_service_iprinit                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/iprutils/oe_test_service_iprinit/2023-06-02-17:41:13.log) | x86 fail |
|                                    | oe_test_service_iprupdate                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/iprutils/oe_test_service_iprupdate/2023-06-02-17:41:53.log) | x86 fail |
|                                    | oe_test_target_iprutils                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/iprutils/oe_test_target_iprutils/2023-06-02-17:42:33.log) | x86 fail |
| ipset                              | oe_test_service_ipset                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ipset/oe_test_service_ipset/2023-06-02-03:13:50.log) | x86 fail |
| iptables                           | oe_test_service_ip6tables                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/iptables/oe_test_service_ip6tables/2023-06-02-03:16:55.log) | x86 fail |
|                                    | oe_test_service_iptables                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/iptables/oe_test_service_iptables/2023-06-02-03:17:48.log) | x86 fail |
|                                    | oe_test_iptables-restore                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/iptables/oe_test_iptables-restore/2023-06-02-03:18:40.log) | x86 fail |
|                                    | oe_test_ip6tables-save                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/iptables/oe_test_ip6tables-save/2023-06-02-03:19:53.log) | x86 fail |
|                                    | oe_test_ip6tables-restore_01                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/iptables/oe_test_ip6tables-restore_01/2023-06-02-03:20:57.log) | x86 fail |
| ipvsadm                            | oe_test_ipvs_ADD_01                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ipvsadm/oe_test_ipvs_ADD_01/2023-06-02-03:26:55.log) | x86 fail |
|                                    | oe_test_ipvs_DEL_01                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ipvsadm/oe_test_ipvs_DEL_01/2023-06-02-03:28:00.log) | x86 fail |
|                                    | oe_test_ipvs_MOD_01                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ipvsadm/oe_test_ipvs_MOD_01/2023-06-02-03:29:07.log) | x86 fail |
|                                    | oe_test_ipvs_SAVE_01                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ipvsadm/oe_test_ipvs_SAVE_01/2023-06-02-03:30:17.log) | x86 fail |
|                                    | oe_test_ipvs_SCEN_DR_05                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ipvsadm/oe_test_ipvs_SCEN_DR_05/2023-06-02-03:44:17.log) | x86 fail |
|                                    | oe_test_ipvs_SCEN_DR_06                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ipvsadm/oe_test_ipvs_SCEN_DR_06/2023-06-02-03:46:11.log) | x86 fail |
|                                    | oe_test_ipvs_SCEN_TUN_05                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ipvsadm/oe_test_ipvs_SCEN_TUN_05/2023-06-02-03:59:53.log) | x86 fail |
|                                    | oe_test_ipvs_SCEN_TUN_06                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ipvsadm/oe_test_ipvs_SCEN_TUN_06/2023-06-02-04:01:50.log) | x86 fail |
|                                    | oe_test_ipvs_WRONG_COMMAND_01                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ipvsadm/oe_test_ipvs_WRONG_COMMAND_01/2023-06-02-04:07:56.log) | x86 fail |
| irqbalance                         | oe_test_service_irqbalance                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/irqbalance/oe_test_service_irqbalance/2023-06-02-04:13:30.log) | x86 fail |
| java-1.8.0-openjdk                 | oe_test_openjdk_appletviewer_clhsdb                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/java-1.8.0-openjdk/oe_test_openjdk_appletviewer_clhsdb/2023-06-02-04:17:16.log) | x86 fail |
|                                    | oe_test_openjdk_java_javac                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/java-1.8.0-openjdk/oe_test_openjdk_java_javac/2023-06-02-04:31:45.log) | x86 fail |
| javapackages-tools                 | oe_test_build-classpath                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/javapackages-tools/oe_test_build-classpath/2023-06-02-05:41:10.log) | x86 fail |
|                                    | oe_test_find-shade-jar                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/javapackages-tools/oe_test_find-shade-jar/2023-06-02-05:45:34.log) | x86 fail |
|                                    | oe_test_gradle-local                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/javapackages-tools/oe_test_gradle-local/2023-06-02-05:48:18.log) | x86 fail |
| jetty                              | oe_test_jetty_start                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/jetty/oe_test_jetty_start/2023-06-02-05:54:09.log) | x86 fail |
|                                    | oe_test_service_jetty                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/jetty/oe_test_service_jetty/2023-06-02-05:54:54.log) | x86 fail |
| junit5                             | oe_test_junit5_gradle                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/junit5/oe_test_junit5_gradle/2023-06-02-06:18:02.log) | x86 fail |
|                                    | oe_test_junit5_kotlin_maven                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/junit5/oe_test_junit5_kotlin_maven/2023-06-02-06:31:06.log) | x86 fail |
|                                    | oe_test_junit5_noimport                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/junit5/oe_test_junit5_noimport/2023-06-02-06:43:48.log) | x86 fail |
| jython                             | oe_test_jython_01                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/jython/oe_test_jython_01/2023-06-02-07:04:04.log) | x86 fail |
|                                    | oe_test_jython_02                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/jython/oe_test_jython_02/2023-06-02-07:05:04.log) | x86 fail |
|                                    | oe_test_jython_03                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/jython/oe_test_jython_03/2023-06-02-07:05:51.log) | x86 fail |
| keepalived                         | oe_test_service_keepalived                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/keepalived/oe_test_service_keepalived/2023-06-02-07:07:06.log) | x86 fail |
| kexec-tools                        | oe_test_service_kdump                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kexec-tools/oe_test_service_kdump/2023-06-02-07:09:39.log) | x86 fail |
| keyutils                           | oe_test_keyutils-api                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/keyutils/oe_test_keyutils-api/2023-06-02-07:11:00.log) | x86 fail |
| kubernetes                         | oe_test_service_kube-controller-manager                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/kubernetes/oe_test_service_kube-controller-manager/2023-06-02-07:29:33.log) | x86 fail |
| libappstream-glib                  | oe_test_libappstream-glib_appstream-util_03             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libappstream-glib/oe_test_libappstream-glib_appstream-util_03/2023-06-02-08:47:36.log) | x86 fail |
| libfabric                          | oe_test_libfabric_fi_info_01                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libfabric/oe_test_libfabric_fi_info_01/2023-06-02-09:00:29.log) | x86 fail |
|                                    | oe_test_libfabric_fi_info_02                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libfabric/oe_test_libfabric_fi_info_02/2023-06-02-09:01:59.log) | x86 fail |
| libosinfo                          | oe_test_osinfo-detect                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libosinfo/oe_test_osinfo-detect/2023-06-02-09:28:08.log) | x86 fail |
|                                    | oe_test_osinfo-db-import                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libosinfo/oe_test_osinfo-db-import/2023-06-02-09:33:10.log) | x86 fail |
| libreswan                          | oe_test_libreswan_ipsec_auto_2                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libreswan/oe_test_libreswan_ipsec_auto_2/2023-06-02-10:10:17.log) | x86 fail |
|                                    | oe_test_libreswan_ipsec_setup                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libreswan/oe_test_libreswan_ipsec_setup/2023-06-02-10:14:54.log) | x86 fail |
|                                    | oe_test_libreswan_ipsec_showhostkey_nss                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libreswan/oe_test_libreswan_ipsec_showhostkey_nss/2023-06-02-10:16:22.log) | x86 fail |
|                                    | oe_test_libreswan_ipsec_systemctl                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libreswan/oe_test_libreswan_ipsec_systemctl/2023-06-02-10:17:58.log) | x86 fail |
|                                    | oe_test_service_ipsec                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libreswan/oe_test_service_ipsec/2023-06-02-10:24:43.log) | x86 fail |
|                                    | oe_test_host_to_host_vpn                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libreswan/oe_test_host_to_host_vpn/2023-06-02-10:26:45.log) | x86 fail |
|                                    | oe_test_site_to_site_vpn                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libreswan/oe_test_site_to_site_vpn/2023-06-02-10:29:06.log) | x86 fail |
| libwmf                             | oe_test_libwmf_libwmf-fontmap                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libwmf/oe_test_libwmf_libwmf-fontmap/2023-06-02-12:22:55.log) | x86 fail |
|                                    | oe_test_libwmf_wmf2x_02                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/libwmf/oe_test_libwmf_wmf2x_02/2023-06-02-12:36:11.log) | x86 fail |
| linuxptp                           | oe_test_service_phc2sys                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/linuxptp/oe_test_service_phc2sys/2023-06-02-12:41:04.log) | x86 fail |
|                                    | oe_test_service_ptp4l                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/linuxptp/oe_test_service_ptp4l/2023-06-02-12:42:47.log) | x86 fail |
|                                    | oe_test_pmc                                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/linuxptp/oe_test_pmc/2023-06-02-12:45:17.log) | x86 fail |
|                                    | oe_test_ptp4l_01                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/linuxptp/oe_test_ptp4l_01/2023-06-02-12:46:29.log) | x86 fail |
|                                    | oe_test_ptp4l_02                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/linuxptp/oe_test_ptp4l_02/2023-06-02-12:50:27.log) | x86 fail |
|                                    | oe_test_timemaster                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/linuxptp/oe_test_timemaster/2023-06-02-12:52:19.log) | x86 fail |
| lm_sensors                         | oe_test_service_fancontrol                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lm_sensors/oe_test_service_fancontrol/2023-06-02-13:33:54.log) | x86 fail |
|                                    | oe_test_service_lm_sensors                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lm_sensors/oe_test_service_lm_sensors/2023-06-02-13:35:05.log) | x86 fail |
| lxc                                | oe_test_service_lxc-net                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lxc/oe_test_service_lxc-net/2023-06-02-14:43:02.log) | x86 fail |
|                                    | oe_test_lxc_create_attach                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lxc/oe_test_lxc_create_attach/2023-06-02-14:46:56.log) | x86 fail |
|                                    | oe_test_lxc_ls_monitor                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lxc/oe_test_lxc_ls_monitor/2023-06-02-14:48:51.log) | x86 fail |
|                                    | oe_test_lxc_unfreeze_destroy                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lxc/oe_test_lxc_unfreeze_destroy/2023-06-02-14:50:48.log) | x86 fail |
|                                    | oe_test_lxc_autostart_cgroup                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lxc/oe_test_lxc_autostart_cgroup/2023-06-02-14:52:46.log) | x86 fail |
|                                    | oe_test_lxc_device_copy                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lxc/oe_test_lxc_device_copy/2023-06-02-14:54:43.log) | x86 fail |
|                                    | oe_test_lxc_snapshot_start                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lxc/oe_test_lxc_snapshot_start/2023-06-02-14:56:40.log) | x86 fail |
|                                    | oe_test_lxc_stop_top                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lxc/oe_test_lxc_stop_top/2023-06-02-15:04:15.log) | x86 fail |
|                                    | oe_test_lxc_info                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/lxc/oe_test_lxc_info/2023-06-02-15:06:17.log) | x86 fail |
| mailman                            | oe_test_service_mailman                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mailman/oe_test_service_mailman/2023-06-02-15:14:45.log) | x86 fail |
| mc                                 | oe_test_mc_base_01                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mc/oe_test_mc_base_01/2023-06-02-15:35:47.log) | x86 fail |
|                                    | oe_test_mcedit_base_01                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mc/oe_test_mcedit_base_01/2023-06-02-15:37:42.log) | x86 fail |
|                                    | oe_test_mcview_base_01                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mc/oe_test_mcview_base_01/2023-06-02-15:38:06.log) | x86 fail |
| mcstrans                           | oe_test_service_mcstransd                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mcstrans/oe_test_service_mcstransd/2023-06-02-15:39:00.log) | x86 fail |
|                                    | oe_test_service_mcstrans                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mcstrans/oe_test_service_mcstrans/2023-06-02-15:40:30.log) | x86 fail |
| mdadm                              | oe_test_service_mdmonitor                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mdadm/oe_test_service_mdmonitor/2023-06-02-15:42:29.log) | x86 fail |
| mikmod                             | oe_test_mikmod_mikmod_02                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mikmod/oe_test_mikmod_mikmod_02/2023-06-02-16:00:58.log) | x86 fail |
|                                    | oe_test_mikmod_mikmod_01                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mikmod/oe_test_mikmod_mikmod_01/2023-06-02-16:02:12.log) | x86 fail |
|                                    | oe_test_mikmod_mikmod_03                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mikmod/oe_test_mikmod_mikmod_03/2023-06-02-16:03:07.log) | x86 fail |
|                                    | oe_test_mikmod_mikmod_04                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mikmod/oe_test_mikmod_mikmod_04/2023-06-02-16:04:15.log) | x86 fail |
|                                    | oe_test_mikmod_mikmod_05                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mikmod/oe_test_mikmod_mikmod_05/2023-06-02-16:05:23.log) | x86 fail |
|                                    | oe_test_mikmod_mikmod_06                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mikmod/oe_test_mikmod_mikmod_06/2023-06-02-16:06:28.log) | x86 fail |
|                                    | oe_test_mikmod_mikmod_07                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mikmod/oe_test_mikmod_mikmod_07/2023-06-02-16:07:37.log) | x86 fail |
| mpg123                             | oe_test_mpg123                                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mpg123/oe_test_mpg123/2023-06-02-16:14:41.log) | x86 fail |
| mrtg                               | oe_test_service_mrtg                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mrtg/oe_test_service_mrtg/2023-06-02-16:20:57.log) | x86 fail |
| mtx                                | oe_test_mtx_loaderinfo                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mtx/oe_test_mtx_loaderinfo/2023-06-02-16:25:20.log) | x86 fail |
|                                    | oe_test_mtx_tapeinfo                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mtx/oe_test_mtx_tapeinfo/2023-06-02-16:26:44.log) | x86 fail |
|                                    | oe_test_mtx_mtx                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mtx/oe_test_mtx_mtx/2023-06-02-16:27:59.log) | x86 fail |
|                                    | oe_test_mtx_scsieject                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mtx/oe_test_mtx_scsieject/2023-06-02-16:29:25.log) | x86 fail |
|                                    | oe_test_mtx_scsitape                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mtx/oe_test_mtx_scsitape/2023-06-02-16:30:43.log) | x86 fail |
| mysql                              | oe_test_service_mysql                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/mysql/oe_test_service_mysql/2023-06-02-16:56:14.log) | x86 fail |
| nasm                               | oe_test_nasm_13                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/nasm/oe_test_nasm_13/2023-06-02-17:12:41.log) | x86 fail |
| rsyslog                            | oe_test_rsyslog_abnormal_template                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rsyslog/oe_test_rsyslog_abnormal_template/2023-05-22-22:30:13.log) | x86 fail |
|                                    | oe_test_rsyslog_function_attribute                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rsyslog/oe_test_rsyslog_function_attribute/2023-05-22-22:27:34.log) | x86 fail |
|                                    | oe_test_rsyslog_function_httpd                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rsyslog/oe_test_rsyslog_function_httpd/2023-05-22-22:43:28.log) | x86 fail |
|                                    | oe_test_rsyslog_function_relp                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rsyslog/oe_test_rsyslog_function_relp/2023-05-22-22:28:36.log) | x86 fail |
|                                    | oe_test_rsyslog_function_tcp                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rsyslog/oe_test_rsyslog_function_tcp/2023-05-22-22:35:31.log) | x86 fail |
|                                    | oe_test_rsyslog_function_tcp_firewall                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rsyslog/oe_test_rsyslog_function_tcp_firewall/2023-05-22-22:46:20.log) | x86 fail |
|                                    | oe_test_rsyslog_function_udp                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rsyslog/oe_test_rsyslog_function_udp/2023-05-22-22:41:40.log) | x86 fail |
|                                    | oe_test_rsyslog_reliability_lenght                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rsyslog/oe_test_rsyslog_reliability_lenght/2023-05-22-22:38:41.log) | x86 fail |
|                                    | oe_test_rsyslog_reliability_network                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rsyslog/oe_test_rsyslog_reliability_network/2023-05-22-22:47:22.log) | x86 fail |
|                                    | oe_test_rsyslog_reliability_tcp                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rsyslog/oe_test_rsyslog_reliability_tcp/2023-05-22-22:36:59.log) | x86 fail |
| FS_Device                          | oe_test_dm_create                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Device/oe_test_dm_create/2023-04-28-12:23:34.log) | x86 fail |
|                                    | oe_test_dm_info                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Device/oe_test_dm_info/2023-04-28-12:53:45.log) | x86 fail |
|                                    | oe_test_raid_auto_mount                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Device/oe_test_raid_auto_mount/2023-04-28-12:54:08.log) | x86 fail |
|                                    | oe_test_raid_compress                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Device/oe_test_raid_compress/2023-04-28-13:24:17.log) | x86 fail |
|                                    | oe_test_raid_react                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Device/oe_test_raid_react/2023-04-28-13:40:43.log) | x86 fail |
|                                    | oe_test_raid_rm_ko                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Device/oe_test_raid_rm_ko/2023-04-28-13:44:46.log) | x86 fail |
|                                    | oe_test_snapshot_dump                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Device/oe_test_snapshot_dump/2023-04-28-13:50:11.log) | x86 fail |
|                                    | oe_test_snapshot_lvconvert                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Device/oe_test_snapshot_lvconvert/2023-04-28-13:51:37.log) | x86 fail |
|                                    | oe_test_snapshot_rw                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Device/oe_test_snapshot_rw/2023-04-28-13:52:33.log) | x86 fail |
|                                    | oe_test_swap_auto_mount                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Device/oe_test_swap_auto_mount/2023-04-28-13:53:22.log) | x86 fail |
|                                    | oe_test_swap_close                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Device/oe_test_swap_close/2023-04-28-14:23:32.log) | x86 fail |
|                                    | oe_test_swap_close_temp                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Device/oe_test_swap_close_temp/2023-04-28-14:53:42.log) | x86 fail |
| FS_Directory                       | oe_test_FSIO_dir_access_boot                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Directory/oe_test_FSIO_dir_access_boot/2023-04-28-21:46:32.log) | x86 fail |
|                                    | oe_test_FSIO_dir_access_dev                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Directory/oe_test_FSIO_dir_access_dev/2023-04-28-21:46:55.log) | x86 fail |
|                                    | oe_test_FSIO_dir_access_root                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Directory/oe_test_FSIO_dir_access_root/2023-04-28-21:49:46.log) | x86 fail |
|                                    | oe_test_FSIO_dir_access_sbin                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Directory/oe_test_FSIO_dir_access_sbin/2023-04-28-21:50:26.log) | x86 fail |
|                                    | oe_test_FSIO_dir_create_lack_inode                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Directory/oe_test_FSIO_dir_create_lack_inode/2023-04-28-21:55:36.log) | x86 fail |
|                                    | oe_test_FSIO_dir_modify_name                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Directory/oe_test_FSIO_dir_modify_name/2023-04-28-21:56:38.log) | x86 fail |
|                                    | oe_test_FSIO_dir_umask_exit                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Directory/oe_test_FSIO_dir_umask_exit/2023-04-28-21:59:30.log) | x86 fail |
| FS_Negative                        | oe_test_FSIO_create_same_name_dir_file                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Negative/oe_test_FSIO_create_same_name_dir_file/2023-05-04-02:59:54.log) | x86 fail |
|                                    | oe_test_FSIO_destory_block                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Negative/oe_test_FSIO_destory_block/2023-05-04-03:01:24.log) | x86 fail |
|                                    | oe_test_FSIO_etc_full_data                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Negative/oe_test_FSIO_etc_full_data/2023-05-04-03:03:10.log) | x86 fail |
| FS_Raw                             | oe_test_raw_create                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Raw/oe_test_raw_create/2023-04-28-23:06:32.log) | x86 fail |
|                                    | oe_test_raw_disk                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Raw/oe_test_raw_disk/2023-04-28-23:06:55.log) | x86 fail |
|                                    | oe_test_raw_lvm                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Raw/oe_test_raw_lvm/2023-04-28-23:07:23.log) | x86 fail |
|                                    | oe_test_raw_mknod                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Raw/oe_test_raw_mknod/2023-04-28-23:07:52.log) | x86 fail |
|                                    | oe_test_raw_reboot                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Raw/oe_test_raw_reboot/2023-04-28-23:08:13.log) | x86 fail |
|                                    | oe_test_raw_reraw                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Raw/oe_test_raw_reraw/2023-04-28-23:38:22.log) | x86 fail |
|                                    | oe_test_raw_service                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_Raw/oe_test_raw_service/2023-04-28-23:38:44.log) | x86 fail |
| FS_iSula                           | oe_test_isula_compress                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_iSula/oe_test_isula_compress/2023-04-29-03:04:12.log) | x86 fail |
|                                    | oe_test_isula_cp                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_iSula/oe_test_isula_cp/2023-04-29-03:18:48.log) | x86 fail |
|                                    | oe_test_isula_mergedir                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_iSula/oe_test_isula_mergedir/2023-04-29-03:48:22.log) | x86 fail |
|                                    | oe_test_isula_mount                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_iSula/oe_test_isula_mount/2023-04-29-04:05:14.log) | x86 fail |
|                                    | oe_test_isula_mount_system_isula                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_iSula/oe_test_isula_mount_system_isula/2023-04-29-04:24:20.log) | x86 fail |
|                                    | oe_test_isula_write_in_isula                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/FS_iSula/oe_test_isula_write_in_isula/2023-04-29-04:42:15.log) | x86 fail |
| embedded_application_develop_tests | oe_test_cpp_hello_world_test                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/embedded_application_develop_tests/oe_test_cpp_hello_world_test/2023-04-27-11:11:07.log) | x86 fail |
|                                    | oe_test_hello_world_test                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/embedded_application_develop_tests/oe_test_hello_world_test/2023-04-27-11:10:12.log) | x86 fail |
|                                    | oe_test_kernel_hello_world_test                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/embedded_application_develop_tests/oe_test_kernel_hello_world_test/2023-04-27-11:10:39.log) | x86 fail |
| embedded_os_basic_test             | oe_test_basic_cmd_cat                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/embedded_os_basic_test/oe_test_basic_cmd_cat/2023-04-27-11:51:37.log) | x86 fail |
|                                    | oe_test_basic_cmd_shopt                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/embedded_os_basic_test/oe_test_basic_cmd_shopt/2023-04-27-12:18:27.log) | x86 fail |
|                                    | oe_test_os_release                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/embedded_os_basic_test/oe_test_os_release/2023-04-27-12:14:03.log) | x86 fail |
|                                    | oe_test_system_service_sshd                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/embedded_os_basic_test/oe_test_system_service_sshd/2023-04-27-12:15:03.log) | x86 fail |
| embedded_tiny_image_test           | oe_test_check_aarch_tiny_image_001                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/embedded_tiny_image_test/oe_test_check_aarch_tiny_image_001/2023-04-29-00:21:40.log) | x86 fail |
|                                    | oe_test_nbdkit_02                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/nbdkit/oe_test_nbdkit_02/2023-04-26-11:02:45.log) | x86 fail |
| ndisc6                             | oe_test_ndisc6_name2addr                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ndisc6/oe_test_ndisc6_name2addr/2023-04-26-11:07:48.log) | x86 fail |
|                                    | oe_test_ndisc6_rdisc6                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ndisc6/oe_test_ndisc6_rdisc6/2023-04-26-11:12:20.log) | x86 fail |
| net-snmp                           | oe_test_net-snmp_01                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/net-snmp/oe_test_net-snmp_01/2023-04-26-11:06:20.log) | x86 fail |
|                                    | oe_test_net-snmp_02                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/net-snmp/oe_test_net-snmp_02/2023-04-26-11:08:12.log) | x86 fail |
| netlabel_tools                     | oe_test_netlabel_tools_netlabelctl_03                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/netlabel_tools/oe_test_netlabel_tools_netlabelctl_03/2023-04-26-11:18:45.log) | x86 fail |
| nftables                           | oe_test_nftables_anonymous_map                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/nftables/oe_test_nftables_anonymous_map/2023-04-26-11:36:32.log) | x86 fail |
|                                    | oe_test_nftables_backup_rules                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/nftables/oe_test_nftables_backup_rules/2023-04-26-11:40:43.log) | x86 fail |
|                                    | oe_test_nftables_chains                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/nftables/oe_test_nftables_chains/2023-04-26-11:38:57.log) | x86 fail |
|                                    | oe_test_nftables_create_counters                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/nftables/oe_test_nftables_create_counters/2023-04-26-11:34:22.log) | x86 fail |
|                                    | oe_test_nftables_listen_package                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/nftables/oe_test_nftables_listen_package/2023-04-26-11:37:08.log) | x86 fail |
|                                    | oe_test_nftables_name_sets                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/nftables/oe_test_nftables_name_sets/2023-04-26-11:37:59.log) | x86 fail |
|                                    | oe_test_nftables_replace_counters                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/nftables/oe_test_nftables_replace_counters/2023-04-26-11:41:08.log) | x86 fail |
|                                    | oe_test_nftables_variable_map                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/nftables/oe_test_nftables_variable_map/2023-04-26-11:38:30.log) | x86 fail |
|                                    | oe_test_service_nftables                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/nftables/oe_test_service_nftables/2023-04-26-11:41:29.log) | x86 fail |
| nginx                              | oe_test_nginx_concurrent                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/nginx/oe_test_nginx_concurrent/2023-04-26-11:47:44.log) | x86 fail |
| nmon                               | oe_test_nmon_01                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/nmon/oe_test_nmon_01/2023-04-26-11:49:06.log) | x86 fail |
|                                    | oe_test_nmon_02                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/nmon/oe_test_nmon_02/2023-04-26-11:54:13.log) | x86 fail |
|                                    | oe_test_nmon_04                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/nmon/oe_test_nmon_04/2023-04-26-12:00:32.log) | x86 fail |
| nodejs                             | oe_test_nodejs_04                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/nodejs/oe_test_nodejs_04/2023-04-26-11:59:19.log) | x86 fail |
| novnc                              | oe_test_novnc                                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/novnc/oe_test_novnc/2023-04-26-12:03:46.log) | x86 fail |
| ntfs-3g                            | oe_test_ntfs-3g_lowntfs-3g_01                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ntfs-3g/oe_test_ntfs-3g_lowntfs-3g_01/2023-04-28-00:25:45.log) | x86 fail |
|                                    | oe_test_ntfs-3g_lowntfs-3g_02                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ntfs-3g/oe_test_ntfs-3g_lowntfs-3g_02/2023-04-28-00:27:42.log) | x86 fail |
|                                    | oe_test_ntfs-3g_lowntfs-3g_03                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ntfs-3g/oe_test_ntfs-3g_lowntfs-3g_03/2023-04-28-00:29:49.log) | x86 fail |
|                                    | oe_test_ntfs-3g_ntfs-3g_01                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ntfs-3g/oe_test_ntfs-3g_ntfs-3g_01/2023-04-28-00:19:19.log) | x86 fail |
|                                    | oe_test_ntfs-3g_ntfs-3g_02                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ntfs-3g/oe_test_ntfs-3g_ntfs-3g_02/2023-04-28-00:21:15.log) | x86 fail |
|                                    | oe_test_ntfs-3g_ntfs-3g_03                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ntfs-3g/oe_test_ntfs-3g_ntfs-3g_03/2023-04-28-00:23:22.log) | x86 fail |
|                                    | oe_test_ntfs-3g_ntfscluster                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ntfs-3g/oe_test_ntfs-3g_ntfscluster/2023-04-28-00:10:20.log) | x86 fail |
|                                    | oe_test_ntfs-3g_ntfscp                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ntfs-3g/oe_test_ntfs-3g_ntfscp/2023-04-27-23:51:25.log) | x86 fail |
|                                    | oe_test_ntfs-3g_ntfsfallocate                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ntfs-3g/oe_test_ntfs-3g_ntfsfallocate/2023-04-28-00:32:36.log) | x86 fail |
|                                    | oe_test_ntfs-3g_ntfsinfo                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ntfs-3g/oe_test_ntfs-3g_ntfsinfo/2023-04-28-00:01:43.log) | x86 fail |
|                                    | oe_test_ntfs-3g_ntfsls                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ntfs-3g/oe_test_ntfs-3g_ntfsls/2023-04-28-00:03:08.log) | x86 fail |
|                                    | oe_test_ntfs-3g_ntfsmove                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ntfs-3g/oe_test_ntfs-3g_ntfsmove/2023-04-28-00:11:42.log) | x86 fail |
|                                    | oe_test_ntfs-3g_ntfsresize                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ntfs-3g/oe_test_ntfs-3g_ntfsresize/2023-04-28-00:08:54.log) | x86 fail |
|                                    | oe_test_ntfs-3g_ntfssecaudit                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ntfs-3g/oe_test_ntfs-3g_ntfssecaudit/2023-04-28-00:13:20.log) | x86 fail |
|                                    | oe_test_ntfs-3g_ntfsundelete_01                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ntfs-3g/oe_test_ntfs-3g_ntfsundelete_01/2023-04-28-00:16:16.log) | x86 fail |
|                                    | oe_test_ntfs-3g_ntfsundelete_02                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ntfs-3g/oe_test_ntfs-3g_ntfsundelete_02/2023-04-28-00:17:51.log) | x86 fail |
| obs-server                         | oe_test_obs-server                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/obs-server/oe_test_obs-server/2023-04-26-12:15:03.log) | x86 fail |
|                                    | oe_test_service_obs-clockwork                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/obs-server/oe_test_service_obs-clockwork/2023-04-26-14:00:59.log) | x86 fail |
|                                    | oe_test_service_obs-delayedjob-queue-consistency_check  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/obs-server/oe_test_service_obs-delayedjob-queue-consistency_check/2023-04-26-14:30:02.log) | x86 fail |
|                                    | oe_test_service_obs-delayedjob-queue-default            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/obs-server/oe_test_service_obs-delayedjob-queue-default/2023-04-26-17:05:06.log) | x86 fail |
|                                    | oe_test_service_obs-delayedjob-queue-issuetracking      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/obs-server/oe_test_service_obs-delayedjob-queue-issuetracking/2023-04-26-14:46:26.log) | x86 fail |
|                                    | oe_test_service_obs-delayedjob-queue-mailers            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/obs-server/oe_test_service_obs-delayedjob-queue-mailers/2023-04-26-15:00:00.log) | x86 fail |
|                                    | oe_test_service_obs-delayedjob-queue-project_log_rotate |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/obs-server/oe_test_service_obs-delayedjob-queue-project_log_rotate/2023-04-26-15:15:13.log) | x86 fail |
|                                    | oe_test_service_obs-delayedjob-queue-releasetracking    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/obs-server/oe_test_service_obs-delayedjob-queue-releasetracking/2023-04-26-15:29:37.log) | x86 fail |
|                                    | oe_test_service_obs-delayedjob-queue-staging            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/obs-server/oe_test_service_obs-delayedjob-queue-staging/2023-04-26-15:43:15.log) | x86 fail |
|                                    | oe_test_service_obs-sphinx                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/obs-server/oe_test_service_obs-sphinx/2023-04-26-14:17:28.log) | x86 fail |
| open-iscsi                         | oe_test_open-iscsi_iscsiadm                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/open-iscsi/oe_test_open-iscsi_iscsiadm/2023-04-26-12:17:21.log) | x86 fail |
|                                    | oe_test_open-iscsi_iscsistart_iscsiuio                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/open-iscsi/oe_test_open-iscsi_iscsistart_iscsiuio/2023-04-26-12:19:19.log) | x86 fail |
|                                    | oe_test_service_iscsiuio                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/open-iscsi/oe_test_service_iscsiuio/2023-04-26-12:54:29.log) | x86 fail |
|                                    | oe_test_socket_iscsiuio                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/open-iscsi/oe_test_socket_iscsiuio/2023-04-26-13:46:41.log) | x86 fail |
| openmpi                            | oe_test_openmpi_cluster                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openmpi/oe_test_openmpi_cluster/2023-04-26-12:46:24.log) | x86 fail |
|                                    | oe_test_openmpi_single_01                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openmpi/oe_test_openmpi_single_01/2023-04-26-12:56:15.log) | x86 fail |
|                                    | oe_test_openmpi_single_02                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openmpi/oe_test_openmpi_single_02/2023-04-26-12:59:49.log) | x86 fail |
| openscap                           | oe_test_assess_safety_compliance                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openscap/oe_test_assess_safety_compliance/2023-04-26-13:43:58.log) | x86 fail |
|                                    | oe_test_scanning_remote_system                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openscap/oe_test_scanning_remote_system/2023-04-26-13:42:41.log) | x86 fail |
| openvpn                            | oe_test_openvpn                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openvpn/oe_test_openvpn/2023-04-26-14:10:41.log) | x86 fail |
| openvswitch                        | oe_test_service_openvswitch-ipsec                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openvswitch/oe_test_service_openvswitch-ipsec/2023-04-26-14:41:14.log) | x86 fail |
|                                    | oe_test_service_ovn-controller                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openvswitch/oe_test_service_ovn-controller/2023-04-26-14:37:41.log) | x86 fail |
|                                    | oe_test_service_ovn-controller-vtep                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openvswitch/oe_test_service_ovn-controller-vtep/2023-04-26-14:39:51.log) | x86 fail |
|                                    | oe_test_service_ovn-northd                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openvswitch/oe_test_service_ovn-northd/2023-04-26-14:38:39.log) | x86 fail |
| os-storage                         | oe_test_storage_DevMgmt_block_drop                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_DevMgmt_block_drop/2023-04-28-06:38:14.log) | x86 fail |
|                                    | oe_test_storage_DevMgmt_disk_operation                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_DevMgmt_disk_operation/2023-04-28-06:52:01.log) | x86 fail |
|                                    | oe_test_storage_DevMgmt_lsblk                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_DevMgmt_lsblk/2023-04-28-06:44:14.log) | x86 fail |
|                                    | oe_test_storage_DevMgmt_swap                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_DevMgmt_swap/2023-04-28-07:07:30.log) | x86 fail |
|                                    | oe_test_storage_Mutipath_dmsetup                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_Mutipath_dmsetup/2023-04-28-06:34:27.log) | x86 fail |
|                                    | oe_test_storage_diskpartiton_create_raid0               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_diskpartiton_create_raid0/2023-04-28-06:39:29.log) | x86 fail |
|                                    | oe_test_storage_diskpartiton_create_raid1               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_diskpartiton_create_raid1/2023-04-28-07:06:07.log) | x86 fail |
|                                    | oe_test_storage_diskpartiton_create_raid5               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_diskpartiton_create_raid5/2023-04-28-07:13:20.log) | x86 fail |
|                                    | oe_test_storage_diskpartiton_fdisk                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_diskpartiton_fdisk/2023-04-28-06:49:19.log) | x86 fail |
|                                    | oe_test_storage_diskpartiton_fdisk_delete               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_diskpartiton_fdisk_delete/2023-04-28-07:17:18.log) | x86 fail |
|                                    | oe_test_storage_diskpartiton_fdisk_settype              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_diskpartiton_fdisk_settype/2023-04-28-06:47:43.log) | x86 fail |
|                                    | oe_test_storage_diskpartiton_parted_resize              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_diskpartiton_parted_resize/2023-04-28-07:03:01.log) | x86 fail |
|                                    | oe_test_storage_diskpartiton_view_fdisk                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_diskpartiton_view_fdisk/2023-04-28-06:41:44.log) | x86 fail |
|                                    | oe_test_storage_ext3_create                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_ext3_create/2023-04-28-06:57:00.log) | x86 fail |
|                                    | oe_test_storage_ext3_mount                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_ext3_mount/2023-04-28-06:54:38.log) | x86 fail |
|                                    | oe_test_storage_ext3_resize                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_ext3_resize/2023-04-28-07:16:18.log) | x86 fail |
|                                    | oe_test_storage_ext4_mount_write                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_ext4_mount_write/2023-04-28-06:49:47.log) | x86 fail |
|                                    | oe_test_storage_fileCMD_cat                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_fileCMD_cat/2023-04-28-06:42:00.log) | x86 fail |
|                                    | oe_test_storage_fileCMD_dd                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_fileCMD_dd/2023-04-28-07:14:26.log) | x86 fail |
|                                    | oe_test_storage_longname_list                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_longname_list/2023-04-28-06:59:21.log) | x86 fail |
|                                    | oe_test_storage_longname_modify                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_longname_modify/2023-04-28-06:59:55.log) | x86 fail |
|                                    | oe_test_storage_lvm_activation_missing                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_activation_missing/2023-04-28-07:12:48.log) | x86 fail |
|                                    | oe_test_storage_lvm_add_VG                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_add_VG/2023-04-28-06:34:42.log) | x86 fail |
|                                    | oe_test_storage_lvm_change_number                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_change_number/2023-04-28-06:36:22.log) | x86 fail |
|                                    | oe_test_storage_lvm_cling                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_cling/2023-04-28-06:58:37.log) | x86 fail |
|                                    | oe_test_storage_lvm_create_cache                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_create_cache/2023-04-28-06:43:40.log) | x86 fail |
|                                    | oe_test_storage_lvm_create_raid                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_create_raid/2023-04-28-06:53:32.log) | x86 fail |
|                                    | oe_test_storage_lvm_create_snapshot                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_create_snapshot/2023-04-28-06:45:26.log) | x86 fail |
|                                    | oe_test_storage_lvm_create_thinSnapshot                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_create_thinSnapshot/2023-04-28-07:17:50.log) | x86 fail |
|                                    | oe_test_storage_lvm_expand_stripeLV                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_expand_stripeLV/2023-04-28-06:35:16.log) | x86 fail |
|                                    | oe_test_storage_lvm_lvdisplay_lvscan                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_lvdisplay_lvscan/2023-04-28-07:09:56.log) | x86 fail |
|                                    | oe_test_storage_lvm_merge_VG                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_merge_VG/2023-04-28-06:51:31.log) | x86 fail |
|                                    | oe_test_storage_lvm_query_lvmsnap                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_query_lvmsnap/2023-04-28-06:42:15.log) | x86 fail |
|                                    | oe_test_storage_lvm_raid_synchronization                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_raid_synchronization/2023-04-28-06:38:47.log) | x86 fail |
|                                    | oe_test_storage_lvm_replace_badraid                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_replace_badraid/2023-04-28-07:15:42.log) | x86 fail |
|                                    | oe_test_storage_lvm_replace_raid                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_replace_raid/2023-04-28-07:04:24.log) | x86 fail |
|                                    | oe_test_storage_lvm_separate_raid                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_separate_raid/2023-04-28-07:02:11.log) | x86 fail |
|                                    | oe_test_storage_lvm_set_label                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_set_label/2023-04-28-11:39:17.log) | x86 fail |
|                                    | oe_test_storage_lvm_set_limit                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_set_limit/2023-04-28-11:38:48.log) | x86 fail |
|                                    | oe_test_storage_lvm_set_lvconvert_raid                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_set_lvconvert_raid/2023-04-28-11:39:45.log) | x86 fail |
|                                    | oe_test_storage_lvm_set_lvconvert_raid1                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_set_lvconvert_raid1/2023-04-28-11:38:18.log) | x86 fail |
|                                    | oe_test_storage_lvm_snapshot_merge                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_snapshot_merge/2023-04-28-11:35:51.log) | x86 fail |
|                                    | oe_test_storage_lvm_snapshot_tag                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_snapshot_tag/2023-04-28-11:37:15.log) | x86 fail |
|                                    | oe_test_storage_lvm_specify_size                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_specify_size/2023-04-28-11:37:52.log) | x86 fail |
|                                    | oe_test_storage_lvm_split_VG                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_lvm_split_VG/2023-04-28-11:40:13.log) | x86 fail |
|                                    | oe_test_storage_mount_UUID                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_mount_UUID/2023-04-28-07:00:45.log) | x86 fail |
|                                    | oe_test_storage_mount_block_device                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_mount_block_device/2023-04-28-06:35:50.log) | x86 fail |
|                                    | oe_test_storage_mount_copy                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_mount_copy/2023-04-28-07:20:33.log) | x86 fail |
|                                    | oe_test_storage_mount_findmnt                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_mount_findmnt/2023-04-28-06:56:10.log) | x86 fail |
|                                    | oe_test_storage_mount_mobile_point                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_mount_mobile_point/2023-04-28-06:50:19.log) | x86 fail |
|                                    | oe_test_storage_mount_repeat                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_mount_repeat/2023-04-28-06:46:27.log) | x86 fail |
|                                    | oe_test_storage_mount_umount                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_mount_umount/2023-04-28-06:48:49.log) | x86 fail |
|                                    | oe_test_storage_nfs_configure_nfsv4                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_nfs_configure_nfsv4/2023-04-28-07:49:09.log) | x86 fail |
|                                    | oe_test_storage_nfs_mount_readonly                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_nfs_mount_readonly/2023-04-28-08:16:31.log) | x86 fail |
|                                    | oe_test_storage_nfs_mount_root                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_nfs_mount_root/2023-04-28-08:03:26.log) | x86 fail |
|                                    | oe_test_storage_nfs_network_latency                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_nfs_network_latency/2023-04-28-09:16:20.log) | x86 fail |
|                                    | oe_test_storage_nfs_repeat_mount                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_nfs_repeat_mount/2023-04-28-08:30:26.log) | x86 fail |
|                                    | oe_test_storage_nfs_repeat_restartServer                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_nfs_repeat_restartServer/2023-04-28-07:40:32.log) | x86 fail |
|                                    | oe_test_storage_nfs_restrict_hostname                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_nfs_restrict_hostname/2023-04-28-09:27:43.log) | x86 fail |
|                                    | oe_test_storage_nfs_restrict_ip                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_nfs_restrict_ip/2023-04-28-10:05:55.log) | x86 fail |
|                                    | oe_test_storage_nfs_share_mount                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_nfs_share_mount/2023-04-28-09:08:38.log) | x86 fail |
|                                    | oe_test_storage_nfs_v3_v4                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_nfs_v3_v4/2023-04-28-09:46:39.log) | x86 fail |
|                                    | oe_test_storage_nfs_write_full                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_nfs_write_full/2023-04-28-09:33:29.log) | x86 fail |
|                                    | oe_test_storage_repair_e2fsck                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_repair_e2fsck/2023-04-28-09:44:24.log) | x86 fail |
|                                    | oe_test_storage_repair_xfs                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_repair_xfs/2023-04-28-09:56:23.log) | x86 fail |
|                                    | oe_test_storage_smb_3.0                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_3.0/2023-04-28-09:57:04.log) | x86 fail |
|                                    | oe_test_storage_smb_POSIX_ACL                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_POSIX_ACL/2023-04-28-10:31:23.log) | x86 fail |
|                                    | oe_test_storage_smb_abnormal_poweroff                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_abnormal_poweroff/2023-04-28-10:52:00.log) | x86 fail |
|                                    | oe_test_storage_smb_automatically_mount                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_automatically_mount/2023-04-28-11:10:43.log) | x86 fail |
|                                    | oe_test_storage_smb_cmd_rpcclient                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_cmd_rpcclient/2023-04-28-10:12:13.log) | x86 fail |
|                                    | oe_test_storage_smb_cmd_smbclient                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_cmd_smbclient/2023-04-28-11:31:50.log) | x86 fail |
|                                    | oe_test_storage_smb_credential_files                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_credential_files/2023-04-28-10:58:43.log) | x86 fail |
|                                    | oe_test_storage_smb_host_share                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_host_share/2023-04-28-10:35:19.log) | x86 fail |
|                                    | oe_test_storage_smb_mount                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_mount/2023-04-28-10:15:10.log) | x86 fail |
|                                    | oe_test_storage_smb_mount_umount                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_mount_umount/2023-04-28-11:16:54.log) | x86 fail |
|                                    | oe_test_storage_smb_multi-user_mount                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_multi-user_mount/2023-04-28-10:23:23.log) | x86 fail |
|                                    | oe_test_storage_smb_network_latency                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_network_latency/2023-04-28-11:07:06.log) | x86 fail |
|                                    | oe_test_storage_smb_repeat_restart                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_repeat_restart/2023-04-28-10:40:44.log) | x86 fail |
|                                    | oe_test_storage_smb_share_dir                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_share_dir/2023-04-28-11:23:36.log) | x86 fail |
|                                    | oe_test_storage_smb_write_full                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_smb_write_full/2023-04-28-11:26:23.log) | x86 fail |
|                                    | oe_test_storage_vfat_mount_write                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_vfat_mount_write/2023-04-28-10:27:53.log) | x86 fail |
|                                    | oe_test_storage_xfs_Increase_size                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_xfs_Increase_size/2023-04-28-10:28:36.log) | x86 fail |
|                                    | oe_test_storage_xfs_backup                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_xfs_backup/2023-04-28-11:34:16.log) | x86 fail |
|                                    | oe_test_storage_xfs_create                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/os-storage/oe_test_storage_xfs_create/2023-04-28-11:23:07.log) | x86 fail |
| patchutils                         | oe_test_patchutils_combinediff_01                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/patchutils/oe_test_patchutils_combinediff_01/2023-04-26-15:35:52.log) | x86 fail |
|                                    | oe_test_patchutils_flipdiff_01                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/patchutils/oe_test_patchutils_flipdiff_01/2023-04-26-15:41:29.log) | x86 fail |
|                                    | oe_test_patchutils_interdiff_01                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/patchutils/oe_test_patchutils_interdiff_01/2023-04-26-15:47:52.log) | x86 fail |
| pcp                                | oe_test_pcp_atop_01                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pcp/oe_test_pcp_atop_01/2023-04-28-02:00:11.log) | x86 fail |
|                                    | oe_test_pcp_atop_02                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pcp/oe_test_pcp_atop_02/2023-04-28-02:10:23.log) | x86 fail |
|                                    | oe_test_pcp_pcp-import-ganglia2pcp                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pcp/oe_test_pcp_pcp-import-ganglia2pcp/2023-04-28-02:24:21.log) | x86 fail |
|                                    | oe_test_pmevent_02                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pcp/oe_test_pmevent_02/2023-04-28-00:14:24.log) | x86 fail |
|                                    | oe_test_pmhostname_pmlock_pmlogger_check                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pcp/oe_test_pmhostname_pmlock_pmlogger_check/2023-04-28-01:25:42.log) | x86 fail |
|                                    | oe_test_pmlogcheck_pmlogmv                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pcp/oe_test_pmlogcheck_pmlogmv/2023-04-28-00:31:32.log) | x86 fail |
|                                    | oe_test_pmlogger_daily_01                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pcp/oe_test_pmlogger_daily_01/2023-04-28-01:31:57.log) | x86 fail |
|                                    | oe_test_pmlogger_daily_report                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pcp/oe_test_pmlogger_daily_report/2023-04-28-01:48:40.log) | x86 fail |
|                                    | oe_test_pmprobe_01                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pcp/oe_test_pmprobe_01/2023-04-28-00:49:41.log) | x86 fail |
|                                    | oe_test_pmval_02                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pcp/oe_test_pmval_02/2023-04-28-01:11:29.log) | x86 fail |
| pcp-system-tools                   | oe_test_pcp-iostat                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pcp-system-tools/oe_test_pcp-iostat/2023-04-26-19:22:18.log) | x86 fail |
|                                    | oe_test_pcp-mpstat_pcp-numastat                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pcp-system-tools/oe_test_pcp-mpstat_pcp-numastat/2023-04-26-19:31:04.log) | x86 fail |
|                                    | oe_test_pcp-pidstat_01                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pcp-system-tools/oe_test_pcp-pidstat_01/2023-04-26-19:04:07.log) | x86 fail |
|                                    | oe_test_pcp-pidstat_02_pcp-ipcs                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pcp-system-tools/oe_test_pcp-pidstat_02_pcp-ipcs/2023-04-26-19:13:51.log) | x86 fail |
|                                    | oe_test_pcp_collectl                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pcp-system-tools/oe_test_pcp_collectl/2023-04-26-18:15:51.log) | x86 fail |
| perl-Date-Manip                    | oe_test_perl-Date-Manip_dm_date                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/perl-Date-Manip/oe_test_perl-Date-Manip_dm_date/2023-04-26-18:40:13.log) | x86 fail |
| pesign                             | oe_test_pesign_base_02                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pesign/oe_test_pesign_base_02/2023-04-26-19:09:06.log) | x86 fail |
|                                    | oe_test_pesign_efikeygen                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pesign/oe_test_pesign_efikeygen/2023-04-26-19:03:23.log) | x86 fail |
|                                    | oe_test_pesign_efisiglist                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pesign/oe_test_pesign_efisiglist/2023-04-26-19:05:12.log) | x86 fail |
|                                    | oe_test_pesign_pesigcheck                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pesign/oe_test_pesign_pesigcheck/2023-04-26-19:16:58.log) | x86 fail |
| podman                             | oe_test_podman_01                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_01/2023-04-26-19:36:13.log) | x86 fail |
|                                    | oe_test_podman_02                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_02/2023-04-26-19:42:43.log) | x86 fail |
|                                    | oe_test_podman_03                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_03/2023-04-26-19:48:49.log) | x86 fail |
|                                    | oe_test_podman_04                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_04/2023-04-26-19:55:15.log) | x86 fail |
|                                    | oe_test_podman_05                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_05/2023-04-26-20:01:56.log) | x86 fail |
|                                    | oe_test_podman_06                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_06/2023-04-26-20:08:36.log) | x86 fail |
|                                    | oe_test_podman_07                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_07/2023-04-26-20:15:19.log) | x86 fail |
|                                    | oe_test_podman_08                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_08/2023-04-26-20:21:35.log) | x86 fail |
|                                    | oe_test_podman_09                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_09/2023-04-26-20:27:38.log) | x86 fail |
|                                    | oe_test_podman_10                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_10/2023-04-26-20:57:49.log) | x86 fail |
|                                    | oe_test_podman_11                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_11/2023-04-26-20:58:54.log) | x86 fail |
|                                    | oe_test_podman_12                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_12/2023-04-26-20:59:56.log) | x86 fail |
|                                    | oe_test_podman_13                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_13/2023-04-26-21:00:56.log) | x86 fail |
|                                    | oe_test_podman_14                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_14/2023-04-26-21:02:09.log) | x86 fail |
|                                    | oe_test_podman_15                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_15/2023-04-26-21:03:26.log) | x86 fail |
|                                    | oe_test_podman_16                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_16/2023-04-26-21:04:32.log) | x86 fail |
|                                    | oe_test_podman_17                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_17/2023-04-26-21:05:46.log) | x86 fail |
|                                    | oe_test_podman_18                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_18/2023-04-26-21:06:47.log) | x86 fail |
|                                    | oe_test_podman_19                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_19/2023-04-26-21:07:45.log) | x86 fail |
|                                    | oe_test_podman_20                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_20/2023-04-26-21:08:51.log) | x86 fail |
|                                    | oe_test_podman_21                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_21/2023-04-26-21:09:35.log) | x86 fail |
|                                    | oe_test_podman_22                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_22/2023-04-26-21:10:35.log) | x86 fail |
|                                    | oe_test_podman_23                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_23/2023-04-26-21:11:37.log) | x86 fail |
|                                    | oe_test_podman_24                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_24/2023-04-26-21:12:43.log) | x86 fail |
|                                    | oe_test_podman_26                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_26/2023-04-26-21:14:47.log) | x86 fail |
|                                    | oe_test_podman_27                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_27/2023-04-26-21:15:47.log) | x86 fail |
|                                    | oe_test_podman_DK_01                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_01/2023-04-26-21:17:28.log) | x86 fail |
|                                    | oe_test_podman_DK_02                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_02/2023-04-26-21:18:23.log) | x86 fail |
|                                    | oe_test_podman_DK_03                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_03/2023-04-26-21:19:35.log) | x86 fail |
|                                    | oe_test_podman_DK_04                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_04/2023-04-26-21:20:33.log) | x86 fail |
|                                    | oe_test_podman_DK_05                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_05/2023-04-26-21:21:32.log) | x86 fail |
|                                    | oe_test_podman_DK_06                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_06/2023-04-26-21:22:31.log) | x86 fail |
|                                    | oe_test_podman_DK_07                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_07/2023-04-26-21:23:36.log) | x86 fail |
|                                    | oe_test_podman_DK_08                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_08/2023-04-26-21:24:57.log) | x86 fail |
|                                    | oe_test_podman_DK_09                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_09/2023-04-26-21:26:11.log) | x86 fail |
|                                    | oe_test_podman_DK_10                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_10/2023-04-26-21:56:25.log) | x86 fail |
|                                    | oe_test_podman_DK_11                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_11/2023-04-26-21:57:58.log) | x86 fail |
|                                    | oe_test_podman_DK_12                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_12/2023-04-26-21:59:23.log) | x86 fail |
|                                    | oe_test_podman_DK_13                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_13/2023-04-26-22:00:56.log) | x86 fail |
|                                    | oe_test_podman_DK_14                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_14/2023-04-26-22:02:23.log) | x86 fail |
|                                    | oe_test_podman_DK_15                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_15/2023-04-26-22:04:00.log) | x86 fail |
|                                    | oe_test_podman_DK_16                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_16/2023-04-26-22:05:16.log) | x86 fail |
|                                    | oe_test_podman_DK_17                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_17/2023-04-26-22:06:40.log) | x86 fail |
|                                    | oe_test_podman_DK_18                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_18/2023-04-26-22:07:48.log) | x86 fail |
|                                    | oe_test_podman_DK_19                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_19/2023-04-26-22:08:56.log) | x86 fail |
|                                    | oe_test_podman_DK_20                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_20/2023-04-26-22:10:12.log) | x86 fail |
|                                    | oe_test_podman_DK_21                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_21/2023-04-26-22:11:09.log) | x86 fail |
|                                    | oe_test_podman_DK_22                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_22/2023-04-26-22:12:33.log) | x86 fail |
|                                    | oe_test_podman_DK_23                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_23/2023-04-26-22:14:01.log) | x86 fail |
|                                    | oe_test_podman_DK_24                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_24/2023-04-26-22:15:23.log) | x86 fail |
|                                    | oe_test_podman_DK_26                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_26/2023-04-26-22:17:45.log) | x86 fail |
|                                    | oe_test_podman_DK_27                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_podman_DK_27/2023-04-26-22:18:54.log) | x86 fail |
|                                    | oe_test_service_podman                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_service_podman/2023-04-26-19:35:45.log) | x86 fail |
|                                    | oe_test_socket_podman                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman/oe_test_socket_podman/2023-04-26-19:36:03.log) | x86 fail |
| policycoreutils                    | oe_test_service_restorecond                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/policycoreutils/oe_test_service_restorecond/2023-04-26-19:45:43.log) | x86 fail |
| pps-tools                          | oe_test_pps-tools                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pps-tools/oe_test_pps-tools/2023-04-26-19:54:50.log) | x86 fail |
| procinfo                           | oe_test_procinfo_01                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/procinfo/oe_test_procinfo_01/2023-04-26-19:55:55.log) | x86 fail |
|                                    | oe_test_procinfo_02                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/procinfo/oe_test_procinfo_02/2023-04-26-19:58:04.log) | x86 fail |
| qemu                               | oe_test_service_qemu-guest-agent                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/qemu/oe_test_service_qemu-guest-agent/2023-04-26-20:18:50.log) | x86 fail |
| qpdf                               | oe_test_qpdf_qpdf_01                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/qpdf/oe_test_qpdf_qpdf_01/2023-04-26-20:46:43.log) | x86 fail |
|                                    | oe_test_qpdf_qpdf_02                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/qpdf/oe_test_qpdf_qpdf_02/2023-04-26-20:48:04.log) | x86 fail |
|                                    | oe_test_qpdf_qpdf_03                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/qpdf/oe_test_qpdf_qpdf_03/2023-04-26-20:49:19.log) | x86 fail |
|                                    | oe_test_qpdf_qpdf_08                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/qpdf/oe_test_qpdf_qpdf_08/2023-04-26-20:55:08.log) | x86 fail |
|                                    | oe_test_qpdf_qpdf_10                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/qpdf/oe_test_qpdf_qpdf_10/2023-04-26-20:57:22.log) | x86 fail |
| rabbitmq-server                    | oe_test_rabbitmqctl_app                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rabbitmq-server/oe_test_rabbitmqctl_app/2023-04-26-21:31:54.log) | x86 fail |
|                                    | oe_test_rabbitmqctl_cluster                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rabbitmq-server/oe_test_rabbitmqctl_cluster/2023-04-26-21:40:47.log) | x86 fail |
| radvd                              | oe_test_service_radvd                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/radvd/oe_test_service_radvd/2023-04-26-22:17:29.log) | x86 fail |
| rdate                              | oe_test_rdate                                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rdate/oe_test_rdate/2023-04-26-22:29:51.log) | x86 fail |
| redis                              | oe_test_redis_02                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/redis/oe_test_redis_02/2023-04-26-23:03:54.log) | x86 fail |
| redis5                             | oe_test_redis5_02                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/redis5/oe_test_redis5_02/2023-04-26-23:17:54.log) | x86 fail |
| redis6                             | oe_test_redis6_02                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/redis6/oe_test_redis6_02/2023-04-26-23:12:41.log) | x86 fail |
| rng-tools                          | oe_test_service_rngd                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rng-tools/oe_test_service_rngd/2023-04-26-23:25:33.log) | x86 fail |
| rootsh                             | oe_test_rootsh01                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rootsh/oe_test_rootsh01/2023-04-26-23:28:08.log) | x86 fail |
|                                    | oe_test_rootsh02                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rootsh/oe_test_rootsh02/2023-04-26-23:30:17.log) | x86 fail |
| rootsh                             | oe_test_rpmdevtools_rpmargs                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rpmdevtools/oe_test_rpmdevtools_rpmargs/2023-04-26-23:33:32.log) | x86 fail |
| ruby                               | oe_test_erb                                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ruby/oe_test_erb/2023-04-27-00:41:50.log) | x86 fail |
|                                    | oe_test_irb_01                                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ruby/oe_test_irb_01/2023-04-27-00:45:49.log) | x86 fail |
|                                    | oe_test_irb_03                                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ruby/oe_test_irb_03/2023-04-27-00:49:53.log) | x86 fail |
|                                    | oe_test_rdoc_01                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ruby/oe_test_rdoc_01/2023-04-27-00:58:53.log) | x86 fail |
|                                    | oe_test_ruby                                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/ruby/oe_test_ruby/2023-04-27-01:07:05.log) | x86 fail |
| rubygem-bundler                    | oe_test_rubygem-bundler_bundle_02                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rubygem-bundler/oe_test_rubygem-bundler_bundle_02/2023-04-27-01:13:40.log) | x86 fail |
|                                    | oe_test_rubygem-bundler_bundle_06                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rubygem-bundler/oe_test_rubygem-bundler_bundle_06/2023-04-27-01:49:05.log) | x86 fail |
| samba                              | oe_test_service_samba                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/samba/oe_test_service_samba/2023-04-27-02:06:32.log) | x86 fail |
| samtools                           | oe_test_samtools_samtools_01                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/samtools/oe_test_samtools_samtools_01/2023-04-27-02:14:19.log) | x86 fail |
| sbd                                | oe_test_service_sbd                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/sbd/oe_test_service_sbd/2023-04-27-02:20:56.log) | x86 fail |
|                                    | oe_test_service_sbd_remote                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/sbd/oe_test_service_sbd_remote/2023-04-27-02:22:57.log) | x86 fail |
| scala                              | oe_test_scala                                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/scala/oe_test_scala/2023-04-27-02:31:21.log) | x86 fail |
|                                    | oe_test_scala_fsc_01                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/scala/oe_test_scala_fsc_01/2023-04-27-02:32:50.log) | x86 fail |
|                                    | oe_test_scala_fsc_02                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/scala/oe_test_scala_fsc_02/2023-04-27-02:34:26.log) | x86 fail |
|                                    | oe_test_scala_fsc_03                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/scala/oe_test_scala_fsc_03/2023-04-27-02:36:05.log) | x86 fail |
|                                    | oe_test_scala_fsc_04                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/scala/oe_test_scala_fsc_04/2023-04-27-02:37:43.log) | x86 fail |
|                                    | oe_test_scala_scalac_01                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/scala/oe_test_scala_scalac_01/2023-04-27-02:39:06.log) | x86 fail |
|                                    | oe_test_scala_scalac_02                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/scala/oe_test_scala_scalac_02/2023-04-27-02:40:12.log) | x86 fail |
|                                    | oe_test_scala_scalac_03                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/scala/oe_test_scala_scalac_03/2023-04-27-02:41:32.log) | x86 fail |
|                                    | oe_test_scala_scaladoc_01                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/scala/oe_test_scala_scaladoc_01/2023-04-27-02:42:56.log) | x86 fail |
|                                    | oe_test_scala_scaladoc_02                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/scala/oe_test_scala_scaladoc_02/2023-04-27-02:44:00.log) | x86 fail |
|                                    | oe_test_scala_scaladoc_03                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/scala/oe_test_scala_scaladoc_03/2023-04-27-02:45:28.log) | x86 fail |
|                                    | oe_test_scala_scaladoc_04                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/scala/oe_test_scala_scaladoc_04/2023-04-27-02:46:55.log) | x86 fail |
|                                    | oe_test_scala_scaladoc_05                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/scala/oe_test_scala_scaladoc_05/2023-04-27-02:48:15.log) | x86 fail |
|                                    | oe_test_scala_scaladoc_06                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/scala/oe_test_scala_scaladoc_06/2023-04-27-02:49:38.log) | x86 fail |
|                                    | oe_test_scala_scalap                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/scala/oe_test_scala_scalap/2023-04-27-02:50:55.log) | x86 fail |
| security_guide                     | oe_test_access_sudo_commands                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/security_guide/oe_test_access_sudo_commands/2023-04-28-21:50:16.log) | x86 fail |
|                                    | oe_test_delete_global_writable_property                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/security_guide/oe_test_delete_global_writable_property/2023-04-28-22:15:12.log) | x86 fail |
|                                    | oe_test_lock_after_login_fail                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/security_guide/oe_test_lock_after_login_fail/2023-04-28-22:10:06.log) | x86 fail |
|                                    | oe_test_ssh_RSA_auth                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/security_guide/oe_test_ssh_RSA_auth/2023-04-28-22:20:38.log) | x86 fail |
|                                    | oe_test_ssh_allow_public_key                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/security_guide/oe_test_ssh_allow_public_key/2023-04-28-22:17:49.log) | x86 fail |
|                                    | oe_test_ssh_server_reinforcement_suggestions            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/security_guide/oe_test_ssh_server_reinforcement_suggestions/2023-04-28-22:40:59.log) | x86 fail |
|                                    | oe_test_ssh_sftp_across_updir                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/security_guide/oe_test_ssh_sftp_across_updir/2023-04-28-21:46:56.log) | x86 fail |
|                                    | oe_test_ssh_system_reinforcement                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/security_guide/oe_test_ssh_system_reinforcement/2023-04-28-22:26:33.log) | x86 fail |
|                                    | oe_test_umask_default                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/security_guide/oe_test_umask_default/2023-04-28-22:38:01.log) | x86 fail |
| smoke-baseinfo                     | oe_test_dmesg_messages_log                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-baseinfo/oe_test_dmesg_messages_log/2023-04-29-02:37:20.log) | x86 fail |
|                                    | oe_test_firewalld                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-baseinfo/oe_test_firewalld/2023-04-29-02:43:22.log) | x86 fail |
|                                    | oe_test_partition                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-baseinfo/oe_test_partition/2023-04-29-02:43:43.log) | x86 fail |
| smoke-basic-os                     | oe_test_IPV6_traceroute6_02                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_IPV6_traceroute6_02/2023-04-29-07:36:29.log) | x86 fail |
|                                    | oe_test_arping                                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_arping/2023-04-29-07:08:27.log) | x86 fail |
|                                    | oe_test_audit_fixed_memory_02                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_audit_fixed_memory_02/2023-04-29-09:53:36.log) | x86 fail |
|                                    | oe_test_cat_001                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_cat_001/2023-04-29-05:02:20.log) | x86 fail |
|                                    | oe_test_ebtables                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_ebtables/2023-04-29-07:22:35.log) | x86 fail |
|                                    | oe_test_ethtool_01                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_ethtool_01/2023-04-29-07:22:52.log) | x86 fail |
|                                    | oe_test_firewalld_server                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_firewalld_server/2023-04-29-07:23:41.log) | x86 fail |
|                                    | oe_test_gettext                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_gettext/2023-04-29-08:08:21.log) | x86 fail |
|                                    | oe_test_glibc_getaddrinfo_01                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_glibc_getaddrinfo_01/2023-04-29-07:23:59.log) | x86 fail |
|                                    | oe_test_grub2_mkconfig                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_grub2_mkconfig/2023-04-29-07:26:46.log) | x86 fail |
|                                    | oe_test_ifconfig_ipv6_01                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_ifconfig_ipv6_01/2023-04-29-07:28:00.log) | x86 fail |
|                                    | oe_test_ima_v2_manual_gen_digest_01                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_ima_v2_manual_gen_digest_01/2023-04-29-09:55:31.log) | x86 fail |
|                                    | oe_test_ip6tables_01                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_ip6tables_01/2023-04-29-07:28:40.log) | x86 fail |
|                                    | oe_test_ip_ipv6_01                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_ip_ipv6_01/2023-04-29-07:29:11.log) | x86 fail |
|                                    | oe_test_ip_ipv6_02                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_ip_ipv6_02/2023-04-29-07:29:41.log) | x86 fail |
|                                    | oe_test_ip_ipv6_03                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_ip_ipv6_03/2023-04-29-07:30:21.log) | x86 fail |
|                                    | oe_test_ip_ipv6_04                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_ip_ipv6_04/2023-04-29-07:30:39.log) | x86 fail |
|                                    | oe_test_iproute_ipv6_01                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_iproute_ipv6_01/2023-04-29-07:31:20.log) | x86 fail |
|                                    | oe_test_iptables-save                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_iptables-save/2023-04-29-07:32:40.log) | x86 fail |
|                                    | oe_test_ipv6_VLAN_01                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_ipv6_VLAN_01/2023-04-29-07:38:24.log) | x86 fail |
|                                    | oe_test_ipv6_VLAN_02                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_ipv6_VLAN_02/2023-04-29-07:38:41.log) | x86 fail |
|                                    | oe_test_libxml2_001                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_libxml2_001/2023-04-29-10:15:03.log) | x86 fail |
|                                    | oe_test_libxml2_002                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_libxml2_002/2023-04-29-10:16:22.log) | x86 fail |
|                                    | oe_test_mtr                                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_mtr/2023-04-29-09:12:00.log) | x86 fail |
|                                    | oe_test_network_001                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_network_001/2023-04-29-05:56:26.log) | x86 fail |
|                                    | oe_test_normal_tcpdump_02                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_normal_tcpdump_02/2023-04-29-10:01:02.log) | x86 fail |
|                                    | oe_test_normal_tcpdump_03                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_normal_tcpdump_03/2023-04-29-08:01:26.log) | x86 fail |
|                                    | oe_test_normal_tcpdump_04                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_normal_tcpdump_04/2023-04-29-10:01:52.log) | x86 fail |
|                                    | oe_test_route_ipv6                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_route_ipv6/2023-04-29-08:12:16.log) | x86 fail |
|                                    | oe_test_setools                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_setools/2023-04-29-08:40:50.log) | x86 fail |
|                                    | oe_test_sevice_001                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_sevice_001/2023-04-29-06:04:10.log) | x86 fail |
|                                    | oe_test_stat                                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_stat/2023-04-29-08:42:30.log) | x86 fail |
|                                    | oe_test_systemd_journald                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_systemd_journald/2023-04-29-08:49:27.log) | x86 fail |
|                                    | oe_test_tftp_ipv6                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-basic-os/oe_test_tftp_ipv6/2023-04-29-08:57:38.log) | x86 fail |
| smoke-iSulad                       | oe_test_iSula_exec_cmd_001                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/smoke-iSulad/oe_test_iSula_exec_cmd_001/2023-04-29-00:07:44.log) | x86 fail |
| socat                              | oe_test_socat_filan                                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/socat/oe_test_socat_filan/2023-04-27-02:56:03.log) | x86 fail |
| sos                                | oe_test_sosreport_02                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/sos/oe_test_sosreport_02/2023-04-27-03:24:24.log) | x86 fail |
|                                    | oe_test_sosreport_04                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/sos/oe_test_sosreport_04/2023-04-27-03:40:36.log) | x86 fail |
| strongswan                         | oe_test_service_strongswan                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/strongswan/oe_test_service_strongswan/2023-04-27-03:21:58.log) | x86 fail |
|                                    | oe_test_service_strongswan-swanctl                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/strongswan/oe_test_service_strongswan-swanctl/2023-04-27-03:24:32.log) | x86 fail |
|                                    | oe_test_service_strongswan_01                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/strongswan/oe_test_service_strongswan_01/2023-04-27-03:26:48.log) | x86 fail |
|                                    | oe_test_service_strongswan_03                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/strongswan/oe_test_service_strongswan_03/2023-04-27-03:42:53.log) | x86 fail |
| systemtap                          | oe_test_service_systemtap                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/systemtap/oe_test_service_systemtap/2023-04-27-04:10:30.log) | x86 fail |
| tomcat                             | oe_test_service_tomcat-jsvc                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/tomcat/oe_test_service_tomcat-jsvc/2023-04-27-04:33:13.log) | x86 fail |
| tuned                              | oe_test_service_tuned                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/tuned/oe_test_service_tuned/2023-04-27-04:39:45.log) | x86 fail |
| unbound                            | oe_test_service_unbound-keygen                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/unbound/oe_test_service_unbound-keygen/2023-04-27-04:46:59.log) | x86 fail |
| wireshark                          | oe_test_captype                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/wireshark/oe_test_captype/2023-04-28-01:51:23.log) | x86 fail |
|                                    | oe_test_dumpcap_01                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/wireshark/oe_test_dumpcap_01/2023-04-28-02:21:36.log) | x86 fail |
|                                    | oe_test_dumpcap_02                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/wireshark/oe_test_dumpcap_02/2023-04-28-02:51:50.log) | x86 fail |
|                                    | oe_test_editcap_01                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/wireshark/oe_test_editcap_01/2023-04-28-03:22:00.log) | x86 fail |
|                                    | oe_test_editcap_02                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/wireshark/oe_test_editcap_02/2023-04-28-03:52:08.log) | x86 fail |
| wsmancli                           | oe_test_wsmancli_wseventmgr_02                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/wsmancli/oe_test_wsmancli_wseventmgr_02/2023-04-27-05:12:01.log) | x86 fail |
|                                    | oe_test_wsmancli_wsman_03                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/wsmancli/oe_test_wsmancli_wsman_03/2023-04-27-05:23:51.log) | x86 fail |
| yelp-tools                         | oe_test_yelp-build                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/yelp-tools/oe_test_yelp-build/2023-04-27-06:19:02.log) | x86 fail |
|                                    | oe_test_yelp-new                                        |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/yelp-tools/oe_test_yelp-new/2023-04-27-06:25:27.log) | x86 fail |
| clevis                             | oe_test_high_nbde                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/clevis/oe_test_high_nbde/2023-06-08-11:59:31.log) | x86 fail |
|                                    | oe_test_install_clevis                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/clevis/oe_test_install_clevis/2023-06-08-11:52:49.log) | x86 fail |
|                                    | oe_test_service_clevis-luks-askpass                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/clevis/oe_test_service_clevis-luks-askpass/2023-06-08-11:39:28.log) | x86 fail |
| fio                                | oe_test_fio_001                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/fio/oe_test_fio_001/2023-05-31-17:54:21.log) | x86 fail |
|                                    | oe_test_fio_004                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/fio/oe_test_fio_004/2023-05-31-18:52:51.log) | x86 fail |
| chrpath                            | oe_test_chrpath                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/chrpath/oe_test_chrpath/2023-06-16-03:44:58.log) | x86 fail |
| cvs                                | oe_test_cvs_cvs_02                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cvs/oe_test_cvs_cvs_02/2023-06-16-03:51:26.log) | x86 fail |
|                                    | oe_test_cvs_cvs_03                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cvs/oe_test_cvs_cvs_03/2023-06-16-03:52:44.log) | x86 fail |
|                                    | oe_test_cvs_cvs_04                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cvs/oe_test_cvs_cvs_04/2023-06-16-03:54:05.log) | x86 fail |
|                                    | oe_test_cvs_cvs_05                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cvs/oe_test_cvs_cvs_05/2023-06-16-03:55:25.log) | x86 fail |
|                                    | oe_test_cvs_cvs_06                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/cvs/oe_test_cvs_cvs_06/2023-06-16-03:56:44.log) | x86 fail |
| hdparm                             | oe_test_hdparm                                          |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/hdparm/oe_test_hdparm/2023-06-16-04:00:43.log) | x86 fail |
| openssh                            | oe_test_openssh_port                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssh/oe_test_openssh_port/2023-06-16-04:14:38.log) | x86 fail |
|                                    | oe_test_sec_ssh                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/openssh/oe_test_sec_ssh/2023-06-16-04:25:06.log) | x86 fail |
| pbzip2                             | oe_test_pbzip2_03                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/pbzip2/oe_test_pbzip2_03/2023-06-16-04:13:38.log) | x86 fail |
| yajl                               | oe_test_yajl                                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/yajl/oe_test_yajl/2023-06-16-04:24:52.log) | x86 fail |
| podman_3.4.4.2                     | oe_test_podman_3.4.4.2_10                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman_3.4.4.2/oe_test_podman_3.4.4.2_10/2023-06-22-06:23:16.log) | x86 fail |
|                                    | oe_test_podman_3.4.4.2_08                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman_3.4.4.2/oe_test_podman_3.4.4.2_08/2023-06-22-06:28:33.log) | x86 fail |
|                                    | oe_test_service_podman                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman_3.4.4.2/oe_test_service_podman/2023-06-22-06:33:44.log) | x86 fail |
|                                    | oe_test_socket_podman                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman_3.4.4.2/oe_test_socket_podman/2023-06-22-07:15:45.log) | x86 fail |
|                                    | oe_test_podman_3.4.4.2_19                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman_3.4.4.2/oe_test_podman_3.4.4.2_19/2023-06-22-07:16:45.log) | x86 fail |
|                                    | oe_test_podman_3.4.4.2_18                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman_3.4.4.2/oe_test_podman_3.4.4.2_18/2023-06-22-07:24:00.log) | x86 fail |
|                                    | oe_test_podman_3.4.4.2_24                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman_3.4.4.2/oe_test_podman_3.4.4.2_24/2023-06-22-07:30:46.log) | x86 fail |
|                                    | oe_test_podman_DK_3.4.4.2_08                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman_3.4.4.2/oe_test_podman_DK_3.4.4.2_08/2023-06-22-07:33:59.log) | x86 fail |
|                                    | oe_test_podman_DK_3.4.4.2_07                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman_3.4.4.2/oe_test_podman_DK_3.4.4.2_07/2023-06-22-07:35:37.log) | x86 fail |
|                                    | oe_test_podman_DK_3.4.4.2_10                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman_3.4.4.2/oe_test_podman_DK_3.4.4.2_10/2023-06-22-08:07:28.log) | x86 fail |
|                                    | oe_test_podman_DK_3.4.4.2_22                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman_3.4.4.2/oe_test_podman_DK_3.4.4.2_22/2023-06-22-08:10:52.log) | x86 fail |
|                                    | oe_test_podman_DK_3.4.4.2_18                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/podman_3.4.4.2/oe_test_podman_DK_3.4.4.2_18/2023-06-22-08:11:52.log) | x86 fail |
| hwloc_1.11.9                       | oe_test_hwloc_1.11.9_hwloc-assembler                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/hwloc_1.11.9/oe_test_hwloc_1.11.9_hwloc-assembler/2023-06-22-06:34:36.log) | x86 fail |
|                                    | oe_test_hwloc_1.11.9_hwloc-distances_01                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/hwloc_1.11.9/oe_test_hwloc_1.11.9_hwloc-distances_01/2023-06-22-06:35:45.log) | x86 fail |
|                                    | oe_test_hwloc_1.11.9_hwloc-distances_02                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/hwloc_1.11.9/oe_test_hwloc_1.11.9_hwloc-distances_02/2023-06-22-06:36:58.log) | x86 fail |
| rubygem-fluentd_1.3.3              | oe_test_fluentd_01_2003                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rubygem-fluentd_1.3.3/oe_test_fluentd_01_2003/2023-06-22-06:12:15.log) | x86 fail |
|                                    | oe_test_fluentd_02                                      |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rubygem-fluentd_1.3.3/oe_test_fluentd_02/2023-06-22-06:36:55.log) | x86 fail |
|                                    | oe_test_fluentd_03_2003                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rubygem-fluentd_1.3.3/oe_test_fluentd_03_2003/2023-06-22-06:40:21.log) | x86 fail |
|                                    | oe_test_fluent_debug                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rubygem-fluentd_1.3.3/oe_test_fluent_debug/2023-06-22-07:06:21.log) | x86 fail |
|                                    | oe_test_fluent_gem_01_2003                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rubygem-fluentd_1.3.3/oe_test_fluent_gem_01_2003/2023-06-22-07:08:39.log) | x86 fail |
|                                    | oe_test_fluent_gem_02_2003                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rubygem-fluentd_1.3.3/oe_test_fluent_gem_02_2003/2023-06-22-07:12:26.log) | x86 fail |
|                                    | oe_test_fluent_gem_03_2003                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rubygem-fluentd_1.3.3/oe_test_fluent_gem_03_2003/2023-06-22-07:17:39.log) | x86 fail |
| junit4                             | oe_test_junit4_performances                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/junit4/oe_test_junit4_performances/2023-06-22-07:13:55.log) | x86 fail |
| conmon                             | oe_test_conmon_01                                       |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/conmon/oe_test_conmon_01/2023-06-22-07:57:57.log) | x86 fail |
| tpm-tools_20.03                    | oe_test_tpm-tools_01                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/tpm-tools_20.03/oe_test_tpm-tools_01/2023-06-22-08:19:16.log) | x86 fail |
|                                    | oe_test_tpm-tools_02                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/tpm-tools_20.03/oe_test_tpm-tools_02/2023-06-22-08:22:41.log) | x86 fail |
|                                    | oe_test_tpm-tools_03                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/tpm-tools_20.03/oe_test_tpm-tools_03/2023-06-22-08:52:52.log) | x86 fail |
|                                    | oe_test_tpm-tools_04                                    |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/tpm-tools_20.03/oe_test_tpm-tools_04/2023-06-22-09:23:02.log) | x86 fail |
| rubygem-ZenTest                    | oe_test_zentest_autotest                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rubygem-ZenTest/oe_test_zentest_autotest/2023-06-22-08:28:48.log) | x86 fail |
|                                    | oe_test_zentest_multiruby_setup                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rubygem-ZenTest/oe_test_zentest_multiruby_setup/2023-06-22-08:30:26.log) | x86 fail |
|                                    | oe_test_zentest_zentest                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/rubygem-ZenTest/oe_test_zentest_zentest/2023-06-22-08:31:40.log) | x86 fail |
| keepalived-cli                     | oe_test_keepalived_cli                                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/keepalived-cli/oe_test_keepalived_cli/2023-06-22-08:34:57.log) | x86 fail |
| python_rsa_3.4.2                   | oe_test_python3-rsa_3.4.2                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/python_rsa_3.4.2/oe_test_python3-rsa_3.4.2/2023-06-22-09:06:49.log) | x86 fail |
| bacula                             | oe_test_service_bacula-dir                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_service_bacula-dir/2023-06-22-09:09:22.log) | x86 fail |
|                                    | oe_test_bacula_bconsole_01                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_bconsole_01/2023-06-22-09:15:26.log) | x86 fail |
|                                    | oe_test_bacula_bconsole_02                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_bconsole_02/2023-06-22-09:16:25.log) | x86 fail |
|                                    | oe_test_bacula_bcopy_01                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_bcopy_01/2023-06-22-09:17:06.log) | x86 fail |
|                                    | oe_test_bacula_bsdjson_01                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_bsdjson_01/2023-06-22-09:23:19.log) | x86 fail |
|                                    | oe_test_bacula_bfdjson_01                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_bfdjson_01/2023-06-22-09:24:10.log) | x86 fail |
|                                    | oe_test_bacula_bscan_01                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_bscan_01/2023-06-22-09:25:02.log) | x86 fail |
|                                    | oe_test_bacula_bscan_02                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_bscan_02/2023-06-22-09:25:48.log) | x86 fail |
|                                    | oe_test_bacula_bregex_01                                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_bregex_01/2023-06-22-09:26:36.log) | x86 fail |
|                                    | oe_test_bacula_bextract_01                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_bextract_01/2023-06-22-09:27:22.log) | x86 fail |
|                                    | oe_test_bacula_bextract_02                              |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_bextract_02/2023-06-22-09:28:12.log) | x86 fail |
|                                    | oe_test_bacula_bwild_01                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_bwild_01/2023-06-22-09:28:55.log) | x86 fail |
|                                    | oe_test_bacula_dbcheck_01                               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_dbcheck_01/2023-06-22-09:29:40.log) | x86 fail |
|                                    | oe_test_bacula_bls_01                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_bls_01/2023-06-22-09:30:28.log) | x86 fail |
|                                    | oe_test_bacula_bls_02                                   |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_bls_02/2023-06-22-09:31:18.log) | x86 fail |
|                                    | oe_test_bacula_btape_01                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_btape_01/2023-06-22-09:32:03.log) | x86 fail |
|                                    | oe_test_bacula_btape_02                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_btape_02/2023-06-22-09:32:58.log) | x86 fail |
|                                    | oe_test_bacula_btape_03                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_btape_03/2023-06-22-09:33:52.log) | x86 fail |
|                                    | oe_test_bacula_btape_04                                 |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_btape_04/2023-06-22-09:34:47.log) | x86 fail |
|                                    | oe_test_bacula_bacula_fd_01                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_bacula_fd_01/2023-06-22-09:35:46.log) | x86 fail |
|                                    | oe_test_bacula_bacula_sd_01                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_bacula_sd_01/2023-06-22-09:37:06.log) | x86 fail |
|                                    | oe_test_bacula_bacula_sd_02                             |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_bacula_sd_02/2023-06-22-09:38:19.log) | x86 fail |
|                                    | oe_test_bacula_bacula_dir_01                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_bacula_dir_01/2023-06-22-09:39:05.log) | x86 fail |
|                                    | oe_test_bacula_bacula_dir_02                            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/bacula/oe_test_bacula_bacula_dir_02/2023-06-22-09:40:21.log) | x86 fail |
| hadoop-3.1                         | oe_test_service_hadoop-journalnode-3.1                  |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/hadoop-3.1/oe_test_service_hadoop-journalnode-3.1/2023-06-22-09:25:44.log) | x86 fail |
|                                    | oe_test_service_hadoop-namenode-3.1                     |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/hadoop-3.1/oe_test_service_hadoop-namenode-3.1/2023-06-22-09:27:07.log) | x86 fail |
|                                    | oe_test_service_hadoop-secondarynamenode-3.1            |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/hadoop-3.1/oe_test_service_hadoop-secondarynamenode-3.1/2023-06-22-09:32:40.log) | x86 fail |
|                                    | oe_test_service_hadoop-timelineserver-3.1               |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/hadoop-3.1/oe_test_service_hadoop-timelineserver-3.1/2023-06-22-09:34:03.log) | x86 fail |
|                                    | oe_test_service_hadoop-historyserver-3.1                |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/hadoop-3.1/oe_test_service_hadoop-historyserver-3.1/2023-06-22-09:35:26.log) | x86 fail |
| nodejs-tiny-lr-fork                | oe_test_tiny_lr                                         |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/nodejs-tiny-lr-fork/oe_test_tiny_lr/2023-06-22-09:49:01.log) | x86 fail |
| uwsgi                              | oe_test_uwsgi                                           |                                                              | [log](https://gitee.com/kotoriminamidesu/openeuler-riscv-2303-test/blob/master/23.09/mugen/logs_failed/uwsgi/oe_test_uwsgi/2023-06-22-09:52:43.log) | x86 fail |




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
|                        | oe_test_service_dbus-org.freedesktop.log)in1                 | success  |
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