# 9月工作报告

### 测试相关

- 在[openEuler 2309 x86_RC1](http://121.36.84.172/dailybuild/EBS-openEuler-23.09/rc1_openeuler-2023-08-23-20-06-19)镜像中完成了oetest3中包含的测试套的测试工作，并提交至主仓库 [pr#37](https://github.com/KotorinMinami/res_list/pull/37)
- 完成[openEuler 2309 RISCV](https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/testing/20230830/v0.2/QEMU/)镜像中[test2](https://github.com/KotorinMinami/res_list/blob/master/oe-rv2309/task_v2/oe2309testv2_2)所包含的大部分测试套的测试工作，并提交至主仓库[pr#38](https://github.com/KotorinMinami/res_list/pull/38)
- 在openEuler 2309 RISCV  RC2中 对测试套集合4_2进行测试，以及在openEuler 2309 x86 RC3中进行对比测试，将测试结果进行pr提交 [pr#47](https://github.com/KotorinMinami/res_list/pull/47)
- 对OpenEuler RISCV RC3镜像进行测试，测试套范围为[test2](https://github.com/KotorinMinami/res_list/blob/master/oe-rv2309/task_v2/oe2309testv2_2)，已提交至主仓库 [pr#52](https://github.com/KotorinMinami/res_list/pull/52)
- 完成OpenEuler RISCV RC4镜像的测试，测试套范围为[test2](https://github.com/KotorinMinami/res_list/blob/master/oe-rv2309/task_v2/oe2309testv2_2)

### 分析相关

- 分析了openEuler 2303 x86和openEuler 2309 x86 RC1的测试结果，并对测试结果中均fail的测试用例进行分析
  - alpha与RC1的对比中，共有441个测试用例均fail
  - 更新了 [测试结果](./week11/Result.csv)，其中有15个测试用例失败的原因不同，357个测试用例失败的原因相同
- 分析了一下OpenEuler RISCV RC2测试的测试结果 [文档](./week12/test.md)
- 对OpenEuler RISCV RC3测试结果与RC1进行了一个简单的对比并提交至RC3主表格 [对比结果](./week13/new.md) [pr#7](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/pulls/7)
- 对2309 RC1表格中遗漏的需要进行操作的测试用例进行了重测并验证
- 对RC3中剩下的测试用例进行了分析并提交[pr#62](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/pulls/62)

### 文档相关

- 根据2309 RC1表格中后续修复的工作，修改了RC1 Mugen主报告中的测试用例表格[pr#1](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/pulls/1) [pr#3](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/pulls/3)
- 参加了20日的QA SIG会议，展示了目前的Mugen测试结果，并根据要求修改了主报告中的表格[pr#5](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/pulls/5)
- 在openEuler RISCV 2309测试文档中添加了针对测试套的测试结果表格 [pr#17](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/pulls/17)

### 脚本相关

- 修改了测试结果脚本[res_list.py](https://github.com/KotorinMinami/res_list/blob/master/res_list.py),现在能显示未进行x86对比测试的用例[pr](https://github.com/KotorinMinami/res_list/pull/51)