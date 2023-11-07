# 八月工作报告

- 将2303测试报告中的测试套更新至8月1日，将新增的测试用例进行测试并提交至主报告 [pr](https://gitee.com/yunxiangluo/oerv-2303-test/pulls/9)
- 和ROS 小队一起对 ROS2 进行测试，复现了 ROS 小队的测试流程和测试结果，产出了验证测试报告[测试报告](https://gitee.com/Paged/open-euler-risc-v-ros2-humble/tree/master/QEMU)
- 认领了oErv 2309测试工作中的[test3](https://github.com/Pagerd/res_list/blob/master/oe-rv2309/task/oe2309test3)和[test4](https://github.com/Pagerd/res_list/blob/master/oe-rv2309/task/oe2309test4)中的测试工作并测试,将测试结果以及分析提交至主表格[pr](https://github.com/KotorinMinami/res_list/pull/30)
- 对[test3](https://github.com/Pagerd/res_list/blob/master/oe-rv2309/task/oe2309test3)和[test4](https://github.com/Pagerd/res_list/blob/master/oe-rv2309/task/oe2309test4)中的测试失败结果进行分类总结，制成报告[ResultReport](./week8/ResultReport.md)
- 在[openEuler 2309 x86_64 alpha](http://121.36.84.172/dailybuild/openEuler-23.09/openeuler-2023-08-16-23-49-42/)镜像中完成了 [test3](https://github.com/Pagerd/res_list/blob/master/oe-rv2309/task/oe2309test3)和[test4](https://github.com/Pagerd/res_list/blob/master/oe-rv2309/task/oe2309test4)中失败的测试用例的对比测试工作，并产出[log](./week9)
- 在[openEuler 2309 x86_RC1](http://121.36.84.172/dailybuild/EBS-openEuler-23.09/rc1_openeuler-2023-08-23-20-06-19)镜像中完成了oetest3中包含的测试套的测试工作，并提交至主仓库 [pr](https://github.com/KotorinMinami/res_list/pull/37)

### 合并产出

yunxiang/OERV 2303 Test

1.添加至8月1日更新的测试用例测试结果

https://gitee.com/yunxiangluo/oerv-2303-test/pulls/9

KotorinMinami/res_list:

1.添加oErv 2309 test3 test4的测试结果

https://github.com/KotorinMinami/res_list/pull/30

2.添加openEuler x86 alpha和 RC1中所负责的对应的测试结果

https://github.com/KotorinMinami/res_list/pull/37

### 文档产出

1.[2309Test3Test4测试结果报告](./week8/ResultReport.md)

2.[ROS2验证测试报告](https://gitee.com/Paged/open-euler-risc-v-ros2-humble/tree/master/QEMU)
