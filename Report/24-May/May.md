## 三月工作

### Eulaceura支援工作

- 在Eulaceura上对300多个测试套[Eulaceura23H2_2](https://github.com/Pagerd/PLCT/tree/main/Report/week/week34/Eulaceura23H2_2)进行测试，将测试结果添加至仓库 [eula-result](https://gitee.com/Paged/eula-result)
-  将测试结果与2309 oERV测试结果进行对比，筛选出仅在Eulaceura上失败的103个测试用例[Fail.csv](https://github.com/Pagerd/PLCT/tree/main/Report/week/week34/Fail.csv)
- 对失败测试用例进行部分分析，并将目前分析的结果制成简易表格[RESULT.md](https://gitee.com/Paged/eula-result/blob/master/README.md)

- 将自己负责的eulaceura部分测试用例进行分析，制作了测试报告并提交[#pr](https://gitee.com/yunxiangluo/eulaceura-test/pulls/3)
- 将可能为系统问题的测试用例提交至[仓库issue](https://gitee.com/eulaceura/Tracker/issues)处

| 测试用例名                       | 原因                                                         | ISSUE                                                       |
| -------------------------------- | ------------------------------------------------------------ | ----------------------------------------------------------- |
| oe_test_java                     | (core dumped)                                                | [I98OE8](https://gitee.com/eulaceura/Tracker/issues/I98OE8) |
| oe_test_groovy18c_01             | java(core dumped)有问题                                      | [I98OE8](https://gitee.com/eulaceura/Tracker/issues/I98OE8) |
| oe_test_ri                       | kernel_require.rb报错                                        | [I98OEZ](https://gitee.com/eulaceura/Tracker/issues/I98OEZ) |
| oe_test_irb_02                   | /usr/bin/irb:9:in `require': cannot load such file -- rubygems (LoadError) | [I98OEZ](https://gitee.com/eulaceura/Tracker/issues/I98OEZ) |
| oe_test_service_ras-mc-ctl       | 启动ras-mc-ctl.service时失败                                 | [I98OF2](https://gitee.com/eulaceura/Tracker/issues/I98OF2) |
| oe_test_pmix                     | Open MPI 包装器编译器无法找到指定的编译器gcc 路径。          | [I98OF5](https://gitee.com/eulaceura/Tracker/issues/I98OF5) |
| oe_test_service_ipvsadm          | kernel疑似没有ipvs                                           | [I98OF7](https://gitee.com/eulaceura/Tracker/issues/I98OF7) |
| oe_test_ant_005                  | Java returned: 1                                             | [I98OE8](https://gitee.com/eulaceura/Tracker/issues/I98OE8) |
| oe_test_ant_004                  | Java returned: 1                                             | [I98OE8](https://gitee.com/eulaceura/Tracker/issues/I98OE8) |
| oe_test_console-setup_ckbcomp_02 | 测试失败,原因未知                                            | [I98OF8](https://gitee.com/eulaceura/Tracker/issues/I98OF8) |
| oe_test_console-setup_ckbcomp_01 | 测试失败,原因未知                                            | [I98OF8](https://gitee.com/eulaceura/Tracker/issues/I98OF8) |
| oe_test_python3-xgboost          | 未能成功安装openblas                                         | [I98OF9](https://gitee.com/eulaceura/Tracker/issues/I98OF9) |
| oe_test_nodejs-jsonpointer       | Segmentation fault      (core dumped)                        | [I98OFA](https://gitee.com/eulaceura/Tracker/issues/I98OFA) |
| oe_test_postfix_configuration    | postfix.service无法启动                                      | [I98OFB](https://gitee.com/eulaceura/Tracker/issues/I98OFB) |
| oe_test_service_postfix          | postfix.service无法启动                                      | [I98OFB](https://gitee.com/eulaceura/Tracker/issues/I98OFB) |
| oe_test_service_ntpdate          | ntpdate.service无法启动                                      | [I98OFC](https://gitee.com/eulaceura/Tracker/issues/I98OFC) |

###  RuyiSDK

##### V0.6.0

- 在Milk-V Pioneer v1.3  Fedora 38上对ruyiv0.6版本进行mugen测试，编写[测试报告](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240312/fedora-SG2042-Pioneer.md)
- 在LicheePi 4A openEuler 2309 上对ruyi v0.6版本进行mugen测试,编写[测试报告](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240312/oERV2309-LPi4A.md)
- 在LicheePi 4A RevyOS 上对ruyi v0.6版本进行mugen测试编写[测试报告](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240312/RevyOS-LPi4A.md)
- 发现了RUYI0.6.0在fedora上的一个问题，提交issue[#89](https://github.com/ruyisdk/ruyi/issues/89)

##### V0.7.0

- 在Milk-V Pioneer v1.3  Fedora 38上对ruyiv0.7版本进行mugen测试，编写[测试报告](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240327/fedora-SG2042-Pioneer.md)
- 在LicheePi 4A RevyOS 上对ruyi v0.7版本进行mugen测试编写[测试报告](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240327/RevyOS-LPi4A.md)

### Sail

- 编写了测试小队Sail的产出与接下来的计划[报告](https://github.com/Pagerd/PLCT/tree/main/Report/week/week35/Sail.md)
- 对sail-riscv[仓库](https://github.com/riscv/sail-riscv/issues?page=1&q=is%3Aissue+is%3Aopen)进行了issue调研,编写了issue文档

| Issue地址                                      | issue简述                               | 链接                                                         |
| ---------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ |
| https://github.com/riscv/sail-riscv/issues/296 | **pmpcfg允许非法值R=0, W=1**            | [MD](https://github.com/Pagerd/PLCT/tree/main/Report/week/week36/296.md) |
| https://github.com/riscv/sail-riscv/issues/356 | **C.SRAI 和 C.SRLI 缺少 RV32 解码限制** | [MD](https://github.com/Pagerd/PLCT/tree/main/Report/week/week36/356.md) |
| https://github.com/riscv/sail-riscv/issues/402 | **Sail中有大量的冗余代码**              | [MD](https://github.com/Pagerd/PLCT/tree/main/Report/week/week36/402.md) |
| https://github.com/riscv/sail-riscv/issues/423 | **Sail中有大量的冗余代码**              | [MD](https://github.com/Pagerd/PLCT/tree/main/Report/week/week36/423.md) |
| https://github.com/riscv/sail-riscv/issues/429 | **Sail中有大量的冗余代码**              | [MD](https://github.com/Pagerd/PLCT/tree/main/Report/week/week36/429.md) |
| https://github.com/riscv/sail-riscv/issues/430 | **AMO 异常的拼写错误**                  | [MD](https://github.com/Pagerd/PLCT/tree/main/Report/week/week36/430.md) |

- 对issue进行汇总，编写了[SAIL-Issue调研文档](https://github.com/Pagerd/PLCT/tree/main/Report/week/week36/Sail-RISCV-Issue.md)
- 编写了[ppt](https://github.com/Pagerd/PLCT/blob/main/Report/week/week36/%E6%9C%B1%E6%97%AD%E6%98%8C-Sail-RISCV%20issue%E8%B0%83%E7%A0%94.pptx)，并在周三在技术分享上分享了Sail-RISCV issue调研
- 调研了RISCOF的测试用例自动生成工具:RISCV-CTG，编写了[调研文档](https://github.com/Pagerd/PLCT/blob/main/Report/week/week37/CTG.md)
- 编写了[ppt](https://github.com/Pagerd/PLCT/blob/main/Report/week/week37/CTG-ppt.pptx)，并在周三在技术分享上分享了Sail-RISCV issue调研
