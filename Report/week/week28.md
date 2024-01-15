## 本周工作

#### Mugen

- 继续分析2309独立发版镜像QEMU的失败原因
- 截止目前为止将当前的测试分析结果整合进主文档 [pr#11](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/pulls/11)
- 编写了openEuler RISC-V测试策略[ppt](./week28/开源自动化测试工具Mugen和openQA在openEuler RISC-V测试中的使用-1.1.pptx)

| 测试套名      | 测试用例                            | 状态 | 原因                                                         | 结果                                             |
| ------------- | ----------------------------------- | ---- | ------------------------------------------------------------ | ------------------------------------------------ |
| clamav        | oe_test_clamav_clamscan_3           | fail | 超时                                                         | 增加测试时间后通过                               |
|               | oe_test_clamav_clamscan_2           | fail | 超时                                                         | 增加测试时间后通过                               |
|               | oe_test_service_clamav-clamonacc    | fail | 超时                                                         | 增加测试时间后通过                               |
|               | oe_test_clamav_clamscan_1           | fail | 超时                                                         | 增加测试时间后通过                               |
| pywbem_0.12.4 | oe_test_pywbem_base_mof_compiler_01 | fail | 连接失败                                                     | https://gitee.com/openeuler/RISC-V/issues/I8VSD0 |
|               | oe_test_pywbem_base_mof_compiler_02 | fail | 连接失败                                                     | https://gitee.com/openeuler/RISC-V/issues/I8VSD0 |
| wsmancli      | oe_test_wsmancli_wseventmgr_02      | fail | 网络原因无法下载对应测试文件                                 | https://gitee.com/openeuler/RISC-V/issues/I8VSDM |
|               | oe_test_wsmancli_wseventmgr_01      | fail | 网络原因无法下载对应测试文件                                 | https://gitee.com/openeuler/RISC-V/issues/I8VSDM |
|               | oe_test_wsmancli_wsman_06           | fail | 连接smash/ipmi时超时                                         | https://gitee.com/openeuler/RISC-V/issues/I8VSDM |
|               | oe_test_wsmancli_wsman_07           | fail | 连接网络时超时                                               | https://gitee.com/openeuler/RISC-V/issues/I8VSDM |
|               | oe_test_wsmancli_wsman_05           | fail | 连接网络时超时                                               | https://gitee.com/openeuler/RISC-V/issues/I8VSDM |
|               | oe_test_wsmancli_wsman_02           | fail | 缺少对应docker                                               | https://gitee.com/openeuler/RISC-V/issues/I8VSDM |
| hbase         | oe_test_service_hbase-regionserver  | fail | 没有包hbase，hadoop-3.1-hdfs，hadoop-3.1-mapreduce，hadoop-3.1-yarn | https://gitee.com/openeuler/RISC-V/issues/I8VS5N |
|               | oe_test_service_hbase-rest          | fail | 没有包hbase，hadoop-3.1-hdfs，hadoop-3.1-mapreduce，hadoop-3.1-yarn | https://gitee.com/openeuler/RISC-V/issues/I8VS5N |
|               | oe_test_service_hbase-thrift        | fail | 没有包hbase，hadoop-3.1-hdfs，hadoop-3.1-mapreduce，hadoop-3.1-yarn | https://gitee.com/openeuler/RISC-V/issues/I8VS5N |

#### RuyiSDK

- 接收ruyisdk调研请求 [基于 Eclipse CDT ，了解并以任一个demo走通RISC-V GDB调试过程，输出文档和视频 #4](https://github.com/ruyisdk/pmd/issues/4)

  ​        当前结果： Eclipse Embedded CDT 官方支持 RISCV QEMU GDB调试和openOCD GDB调试，因此理论上是支持RISC-V GDB调试，目前由于对Eclipse调试环境及RISC-V GDB调试的不熟悉因此尚未完整走通一遍，后续将继续进行调研和学习

