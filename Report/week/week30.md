## 本周工作



#### RuyiSDK

- 对调研 [基于 Eclipse CDT ，了解并以任一个demo走通RISC-V GDB调试过程，输出文档和视频 #4](https://github.com/ruyisdk/pmd/issues/4)进行了初步的阶段性结果，当前Eclipse CDT并不支持RISC-V GDB调试，添加了调研[结果文档](./week30/Eclipse_CDT.md)[commit](https://github.com/ruyisdk/pmd/commit/99e261e2a7cc7741a1ff43bb5ebadeeadd5a1f92)
- 进行开发板调研工作，目前共调研了10个开发板
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

#### Aries Embedded FIVEBerry-A0A 

FIVEberry 基板是围绕 MSRZFive 系统模块构建的系统级封装,因此仅支持自有的MSRZFive系统

https://www.aries-embedded.com/evaluation-kit/cpu/rzfive-renesas-riscv-msrzfive-osm-ethernet-can-fiveberry

#### DongshanNezhaSTU RISCV64 Allwinner D1-H Board 

DongshanPi官方文档显示支持Tina-SDK

https://dongshanpi.com/DongshanNezhaSTU/11-Tina-SDK_DevelopmentGuide/

同时支持buildroot-SDK

https://dongshanpi.com/DongshanNezhaSTU/07-Buildroot-SDK_DevelopmentGuide/

#### MangoPi MQ-Pro SBC

MangoPi MQ-Pro SBC 官方文档中有对Armbian和tina-linux的工具链接

https://mangopi.org/mangopi_mqpro

#### OpenISA VEGAboard

官方文档无支持系统，在Zephyr官方wiki上可看见支持OpenISA VEGAboard

https://docs.zephyrproject.org/latest/boards/riscv/rv32m1_vega/doc/index.html

同时在freeRTOS官方文档上可以看见支持OpenISA VEGAboard

https://www.freertos.org/zh-cn-cmn-s/RTOS-RISC-V-Vegaboard_Pulp.html

#### Sipeed M1s Dock 

Sipeed M1s Dock 官方文档显示完备支持 FreeRTOS

https://wiki.sipeed.com/hardware/zh/maix/m1s/m1s_dock.html

#### Sipeed Longan Nano

官方文档无支持系统，在Zephyr官方wiki上可看见支持Sipeed Longan Nano

https://docs.zephyrproject.org/latest/boards/riscv/longan_nano/doc/index.html

#### SparkFun RED-V Things Plus

官方文档无支持系统，在Zephyr官方wiki上可看见支持SparkFun RED-V Things Plus

https://docs.zephyrproject.org/latest/boards/riscv/sparkfun_red_v_things_plus/doc/index.html

同时在RT thread官方仓库文档上可以看见支持SparkFun RED-V

https://github.com/RT-Thread/rt-thread/tree/master/bsp/sparkfun-redv

#### STAR64 Model-A

armbian社区支持STAR64 Model-A

https://forum.armbian.com/topic/28912-star64-jh7110/

同时，在一个第三方的wiki上发现STAR64有Fedora和debian的发行版，能否运行仍需测试

https://fluxcoil.net/wiki/hardwarerelated/star64_model-a_risc-v

#### Telink TLSR9518ADK80D

官方文档无支持系统，在Zephyr官方wiki上可看见支持Telink TLSR9518ADK80D

https://docs.zephyrproject.org/latest/boards/riscv/tlsr9518adk80d/doc/index.html

#### XIAO ESP32C3

官方文档无支持系统，在Zephyr官方wiki上可看见支持Telink TLSR9518ADK80D

https://docs.zephyrproject.org/latest/boards/riscv/xiao_esp32c3/doc/index.html

## 学习

- 重新开始对sail和act的学习，目前正在继续之前学习RISCV汇编相关的进度
