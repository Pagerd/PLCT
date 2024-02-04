## 

### OpenEuler-RISCV

- 对Mugen仓库失败测试用例结果进行了分析，将分析结果提交了issue

| 测试用例                              | 原因                                        | 行动                                                       |
| ------------------------------------- | ------------------------------------------- | ---------------------------------------------------------- |
| oe_test_service_ipmiseld              | 服务无法启动                                | [I8U0BE](https://gitee.com/openeuler/RISC-V/issues/I8U0BE) |
| oe_test_power_powertop2tuned_optimize | Powertop版本不兼容                          | [I8U0JM](https://gitee.com/openeuler/RISC-V/issues/I8U0JM) |
| oe_test_ar                            | 未预装ar                                    | [I8U0LF](https://gitee.com/openeuler/mugen/issues/I8U0LF)  |
| oe_test_aureport                      | 未预装auditd                                | [I8U0MM](https://gitee.com/openeuler/mugen/issues/I8U0MM)  |
| oe_test_envsubst                      | 未预装envsubst                              | [I8U0OK](https://gitee.com/openeuler/mugen/issues/I8U0OK)  |
| oe_test_glibc                         | 未预装gcc                                   | [I8S53J](https://gitee.com/openeuler/mugen/issues/I8S53J)  |
| oe_test_c_stat                        | 未预装gcc                                   | [I8S53J](https://gitee.com/openeuler/mugen/issues/I8S53J)  |
| oe_test_pcre_use                      | 未预装gcc                                   | [I8S53J](https://gitee.com/openeuler/mugen/issues/I8S53J)  |
| oe_test_libunistring                  | 未预装gcc                                   | [I8S53J](https://gitee.com/openeuler/mugen/issues/I8S53J)  |
| oe_test_cairo                         | 未预装gcc                                   | [I8S53J](https://gitee.com/openeuler/mugen/issues/I8S53J)  |
| oe_test_libidn                        | 未安装gcc                                   | [I8S53J](https://gitee.com/openeuler/mugen/issues/I8S53J)  |
| oe_test_service_kpatch                | 软件源内没有kpatch                          | [I8U0NB](https://gitee.com/openeuler/RISC-V/issues/I8U0NB) |
| oe_test_amanda_amcheck                | /usr/bin/gettext: No such file or directory | [I8RX4Z](https://gitee.com/openeuler/RISC-V/issues/I8RX4Z) |
| oe_test_install_clevis                | 密钥不可用                                  | [I8S2GB](https://gitee.com/openeuler/RISC-V/issues/I8S2GB) |
| oe_test_high_nbde                     | 软件源没有包cryptsetup-reencrypt            | [I8S2JX](https://gitee.com/openeuler/RISC-V/issues/I8S2JX) |
| oe_test_tang_encrypt                  | 无法连接至目标端口                          | [I8S31S](https://gitee.com/openeuler/mugen/issues/I8S31S)  |
| oe_test_service_clevis-luks-askpass   | 测试用例编写错误？                          | [I8S30G](https://gitee.com/openeuler/mugen/issues/I8S30G)  |
| oe_test_pywbem_base_mof_compiler_01 | 连接失败                                                     | [I8VSD0](https://gitee.com/openeuler/RISC-V/issues/I8VSD0) |
| oe_test_pywbem_base_mof_compiler_02 | 连接失败                                                     | [I8VSD0](https://gitee.com/openeuler/RISC-V/issues/I8VSD0) |
| oe_test_wsmancli_wseventmgr_02      | 网络原因无法下载对应测试文件                                 | [I8VSDM](https://gitee.com/openeuler/RISC-V/issues/I8VSDM) |
| oe_test_wsmancli_wseventmgr_01      | 网络原因无法下载对应测试文件                                 | [I8VSDM](https://gitee.com/openeuler/RISC-V/issues/I8VSDM) |
| oe_test_wsmancli_wsman_06           | 连接smash/ipmi时超时                                         | [I8VSDM](https://gitee.com/openeuler/RISC-V/issues/I8VSDM) |
| oe_test_wsmancli_wsman_07           | 连接网络时超时                                               | [I8VSDM](https://gitee.com/openeuler/RISC-V/issues/I8VSDM) |
| oe_test_wsmancli_wsman_05           | 连接网络时超时                                               | [I8VSDM](https://gitee.com/openeuler/RISC-V/issues/I8VSDM) |
| oe_test_wsmancli_wsman_02           | 缺少对应docker                                               | [I8VSDM](https://gitee.com/openeuler/RISC-V/issues/I8VSDM) |
| oe_test_service_hbase-regionserver  | 没有包hbase，hadoop-3.1-hdfs，hadoop-3.1-mapreduce，hadoop-3.1-yarn | [I8VS5N](https://gitee.com/openeuler/RISC-V/issues/I8VS5N) |
| oe_test_service_hbase-rest          | 没有包hbase，hadoop-3.1-hdfs，hadoop-3.1-mapreduce，hadoop-3.1-yarn | [I8VS5N](https://gitee.com/openeuler/RISC-V/issues/I8VS5N) |
| oe_test_service_hbase-thrift        | 没有包hbase，hadoop-3.1-hdfs，hadoop-3.1-mapreduce，hadoop-3.1-yarn | [I8VS5N](https://gitee.com/openeuler/RISC-V/issues/I8VS5N) |

- 向mugen仓库提交了修复部分测试用例错误的pr [#pr2261](https://gitee.com/openeuler/mugen/pulls/2261)
- 截止目前为止将当前的测试分析结果整合进独立发版测试主文档 [pr#11](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/pulls/11)
- 将剩余的仅RV失败的测试用例提交至riscv issue [#I8XL9B](https://gitee.com/openeuler/RISC-V/issues/I8XL9B)

- 进行了《Mugen RISC-V测试策略》的编写 [ppt](./week28/开源自动化测试工具Mugen和openQA在openEuler RISC-V测试中的使用.pptx)

### RuyiSDK

#### 测试

-  Lpi4A     revyos系统ruyi mugen自动测试 [Gitee](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240116/RevyOS-LPi4A.md)
- Pioneer Box SG2042   fedora系统ruyi mugen自动测试 [Gitee](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240116/fedora-SG2042-Pioneer.md)
- Milk-V duo  ruyi镜像烧录工具测试 [Gitee](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240116/MilkV-Duo-%E9%95%9C%E5%83%8F%E5%88%B7%E5%86%99%E6%B5%8B%E8%AF%95.md)

#### Issue

- 发现ruyi镜像烧录工具在下载镜像时出现的网络错误 [#issue46](https://github.com/ruyisdk/ruyi/issues/46)

#### 调研

- 接受了调研 [基于 Eclipse CDT ，了解并以任一个demo走通RISC-V GDB调试过程，输出文档和视频 #4](https://github.com/ruyisdk/pmd/issues/4)并有了初步的阶段性结果，当前Eclipse CDT并不支持RISC-V GDB调试，添加了调研[结果文档](./week30/Eclipse_CDT.md)[commit](https://github.com/ruyisdk/pmd/commit/99e261e2a7cc7741a1ff43bb5ebadeeadd5a1f92)
- RuyiSDK开发板操作系统支持情况调研，共调研了10个开发板
  - [Aries Embedded FIVEBerry-A0A](./week30/investigation/AriesEmbeddedFIVEBerry-A0A.md)
  - [DongshanNezhaSTU RISCV64 Allwinner D1-H Board](./week30/investigation/DongshanNezhaSTURISCV64AllwinnerD1-HBoard.md)
  - [MangoPi MQ-Pro SBC](./week30/investigation/MangoPiMQ-ProSBC.md)
  - [OpenISAVEGAboard](./week30/investigation/OpenISAVEGAboard.md)
  - [Sipeed M1s Dock](./week30/investigation/SipeedM1sDock.md)
  - [SipeedLonganNano](./week30/investigation/SipeedLonganNano.md)
  - [SparkFunRED-VThingsPlus](./week30/investigation/SparkFunRED-VThingsPlus.md)
  - [STAR64 Model-A](./week30/investigation/STAR64Model-A.md)
  - [TelinkTLSR9518ADK80D](./week30/investigation/TelinkTLSR9518ADK80D.md)
  - [XIAOESP32C3](./week30/investigation/XIAOESP32C3.md)

##### Aries Embedded FIVEBerry-A0A 

- FIVEberry 基板是围绕 MSRZFive 系统模块构建的系统级封装,因此仅支持自有的MSRZFive系统 [Link](https://www.aries-embedded.com/evaluation-kit/cpu/rzfive-renesas-riscv-msrzfive-osm-ethernet-can-fiveberry)


##### DongshanNezhaSTU RISCV64 Allwinner D1-H Board 

- DongshanPi官方文档显示支持Tina-SDK [Link](https://dongshanpi.com/DongshanNezhaSTU/11-Tina-SDK_DevelopmentGuide/)

- 同时支持buildroot-SDK [Link](https://dongshanpi.com/DongshanNezhaSTU/07-Buildroot-SDK_DevelopmentGuide/)


##### MangoPi MQ-Pro SBC

- MangoPi MQ-Pro SBC 官方文档中有对Armbian和tina-linux的工具链接 [Link](https://mangopi.org/mangopi_mqpro)


##### OpenISA VEGAboard

- 官方文档无支持系统，在Zephyr官方wiki上可看见支持OpenISA VEGAboard [Link](https://docs.zephyrproject.org/latest/boards/riscv/rv32m1_vega/doc/index.html)

- 同时在freeRTOS官方文档上可以看见支持OpenISA VEGAboard  [Link](https://www.freertos.org/zh-cn-cmn-s/RTOS-RISC-V-Vegaboard_Pulp.html)


##### Sipeed M1s Dock 

- Sipeed M1s Dock 官方文档显示完备支持 FreeRTOS [Link](https://wiki.sipeed.com/hardware/zh/maix/m1s/m1s_dock.html)


##### Sipeed Longan Nano

- 官方文档无支持系统，在Zephyr官方wiki上可看见支持Sipeed Longan Nano [Link](https://docs.zephyrproject.org/latest/boards/riscv/longan_nano/doc/index.html)


##### SparkFun RED-V Things Plus

- 官方文档无支持系统，在Zephyr官方wiki上可看见支持SparkFun RED-V Things Plus  [Link](https://docs.zephyrproject.org/latest/boards/riscv/sparkfun_red_v_things_plus/doc/index.html)

- 同时在RT thread官方仓库文档上可以看见支持SparkFun RED-V [Link](https://github.com/RT-Thread/rt-thread/tree/master/bsp/sparkfun-redv)


##### STAR64 Model-A

- armbian社区支持STAR64 Model-A [Link](https://forum.armbian.com/topic/28912-star64-jh7110/)

- 同时，在一个第三方的wiki上发现STAR64有Fedora和debian的发行版，能否运行仍需测试 [Link](https://fluxcoil.net/wiki/hardwarerelated/star64_model-a_risc-v)


##### Telink TLSR9518ADK80D

- 官方文档无支持系统，在Zephyr官方wiki上可看见支持Telink TLSR9518ADK80D [Link](https://docs.zephyrproject.org/latest/boards/riscv/tlsr9518adk80d/doc/index.html)


##### XIAO ESP32C3

- 官方文档无支持系统，在Zephyr官方wiki上可看见支持Telink TLSR9518ADK80D [Link](https://docs.zephyrproject.org/latest/boards/riscv/xiao_esp32c3/doc/index.html)
