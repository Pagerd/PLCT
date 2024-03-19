## 本周工作



### Eulaceura支援工作

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

### RuyiSDK

- 在Milk-V Pioneer v1.3  Fedora 38上对ruyiv0.6版本进行mugen测试
- 在LicheePi 4A openEuler 2309 上对ruyi v0.6版本进行mugen测试
- 在LicheePi 4A RevyOS 上对ruyi v0.6版本进行mugen测试

### Sail

- 编写了测试小队Sail的产出与接下来的计划[报告](./week35/Sail.md)
