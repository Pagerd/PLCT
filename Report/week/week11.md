# 工作报告

- 在openEuler2309测试文档中添加了针对测试套的测试结果表格 [pr](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/pulls/17)
- 分析了openEuler 2303 x86和openEuler 2309 x86 RC1的测试结果，并对测试结果中均fail的测试用例进行分析
  - alpha与RC1的对比中，共有441个测试用例均fail
  - 目前已完成372个测试用例的分析 [Result](./week11/Result.csv)，其中有15个测试用例失败的原因不同，357个测试用例失败的原因相同

## 不同的失败原因分析

- oe_test_service_keepalived:服务未执行其单元配置所需的步骤,而2303并不在此报错
- oe_test_openvpn:服务项启动失败，而2303启动成功
- oe_test_openssh_port:Failed in remote CMD operation:1,而2303无此报错
- lxc:进行一项测试时报错："Received container state ""ABORTING"" instead of ""RUNNING"",而2303在此测试无此报错且测试通过
- oe_test_service_openvswitch-ipsec:进行服务项启动时报错Job for ipsec.service failed because the control process exited with error code.而2303无此报错
- oe_test_packagekit_pkcon:报错Failed to check for authentication: GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name org.freedesktop.PolicyKit1 was not provided by any .service files，而2303无此错误
- oe_test_dnf_list_mark:进行安装vim时失败，而2303正常安装
