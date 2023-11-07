# 十月工作报告

- 将rest2测试结果提交至主仓库[pr](https://github.com/KotorinMinami/res_list/pull/11)
- 将自己所负责的rest2中剩下的未知原因失败的13个测试用例进行了分析[Failed](https://github.com/Pagerd/PLCT/blob/main/TestReport/Rest2/failed.md)并联合之前分析的结果一同添加进主仓库[pr](https://github.com/KotorinMinami/res_list/pull/16)
- 将目前仓库中的所有测试结果进行了一些筛选以及分类
  - 从所有测试用例中筛选出属于Base OS的测试用例结果集合[BaseOS](https://github.com/Pagerd/PLCT/blob/main/Report/week/week4/baseos.csv)
  - 从[BaseOS](https://github.com/Pagerd/PLCT/blob/main/Report/week/week4/baseos.csv)中根据分类，筛选出所有的success的测试用例 [Success](https://github.com/Pagerd/PLCT/blob/main/Report/week/week4/success.csv)，x86fail的测试用例[x86fail](https://github.com/Pagerd/PLCT/blob/main/Report/week/week4/x86fail.csv)，fail的测试用例[fail](https://github.com/Pagerd/PLCT/blob/main/Report/week/week4/fail.csv)
- 根据筛选出来的测试用例集合，编写了Mugen BasOS的测试结果文档[report](https://github.com/Pagerd/PLCT/blob/main/2303Mugen/2303Mugen.md)
- 将之前测试小组进行过的详细分析以测试用例为单位进行重新编排并添加进总文档 [RISCVfail](https://github.com/Pagerd/PLCT/blob/main/2303Mugen/RISCVfail/) [x86fail](https://github.com/Pagerd/PLCT/blob/main/2303Mugen/x86Fail/)
- 将[x86fail](https://github.com/Pagerd/PLCT/blob/main/Report/week/week4/x86fail.csv)交给玮霖老师，并和玮霖老师商量了x86失败的测试用例的测试分析分配工作，并认领了[list1](https://github.com/weilinfox/PLCT-Working/tree/master/Done/Week9/lists)的分析工作
- 将[list1](https://github.com/weilinfox/PLCT-Working/tree/master/Done/Week9/lists)中的209个测试用例进行了测试原因分析，大部分都添加了详细的说明文档以及一个简单的list1分析结果报告 [FailTest1Report](./week6/FailTest1Report.md)
- 将遗漏的FS_FileSystem测试套进行测试，并将结果提交至主仓库 [Pr](https://github.com/KotorinMinami/res_list/pull/22)
- 对上周的所有测试分析结果进行了整理集合，将主仓库以及之前所有的mugen测试结果以及测试分析全部整理编写成一个包含Mugen主文档的仓库[Mugen2303Result](https://github.com/Pagerd/Mugen2303Result)
- 和玮霖老师一起将mugen测试报告进行修改并由玮霖老师添加进Mugen2303测试主仓库 [pr](https://gitee.com/yunxiangluo/oerv-2303-test/pulls/2)
- 将2303测试报告中的测试套更新至8月1日，将新增的测试用例进行测试并提交至主报告 [pr](https://gitee.com/yunxiangluo/oerv-2303-test/pulls/9)
- 和ROS 小队一起对 ROS2 进行测试，复现了 ROS 小队的测试流程和测试结果，产出了验证测试报告[测试报告](https://gitee.com/Paged/open-euler-risc-v-ros2-humble/tree/master/QEMU)
- 认领了oErv 2309测试工作中的[test3](https://github.com/Pagerd/res_list/blob/master/oe-rv2309/task/oe2309test3)和[test4](https://github.com/Pagerd/res_list/blob/master/oe-rv2309/task/oe2309test4)中的测试工作并测试,将测试结果以及分析提交至主表格[pr](https://github.com/KotorinMinami/res_list/pull/30)
- 对[test3](https://github.com/Pagerd/res_list/blob/master/oe-rv2309/task/oe2309test3)和[test4](https://github.com/Pagerd/res_list/blob/master/oe-rv2309/task/oe2309test4)中的测试失败结果进行分类总结，制成报告[ResultReport](./week8/ResultReport.md)
- 在[openEuler 2309 x86_64 alpha](http://121.36.84.172/dailybuild/openEuler-23.09/openeuler-2023-08-16-23-49-42/)镜像中完成了 [test3](https://github.com/Pagerd/res_list/blob/master/oe-rv2309/task/oe2309test3)和[test4](https://github.com/Pagerd/res_list/blob/master/oe-rv2309/task/oe2309test4)中失败的测试用例的对比测试工作，并产出[log](./week9)
- 在[openEuler 2309 x86_RC1](http://121.36.84.172/dailybuild/EBS-openEuler-23.09/rc1_openeuler-2023-08-23-20-06-19)镜像中完成了oetest3中包含的测试套的测试工作，并提交至主仓库 [pr](https://github.com/KotorinMinami/res_list/pull/37)
- 在[openEuler 2309 x86_RC1](http://121.36.84.172/dailybuild/EBS-openEuler-23.09/rc1_openeuler-2023-08-23-20-06-19)镜像中完成了oetest3中包含的测试套的测试工作，并提交至主仓库 [pr#37](https://github.com/KotorinMinami/res_list/pull/37)
- 完成[openEuler 2309 RISCV](https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/testing/20230830/v0.2/QEMU/)镜像中[test2](https://github.com/KotorinMinami/res_list/blob/master/oe-rv2309/task_v2/oe2309testv2_2)所包含的大部分测试套的测试工作，并提交至主仓库[pr#38](https://github.com/KotorinMinami/res_list/pull/38)
- 在openEuler 2309 RISCV  RC2中 对测试套集合4_2进行测试，以及在openEuler 2309 x86 RC3中进行对比测试，将测试结果进行pr提交 [pr#47](https://github.com/KotorinMinami/res_list/pull/47)
- 对OpenEuler RISCV RC3镜像进行测试，测试套范围为[test2](https://github.com/KotorinMinami/res_list/blob/master/oe-rv2309/task_v2/oe2309testv2_2)，已提交至主仓库 [pr#52](https://github.com/KotorinMinami/res_list/pull/52)
- 完成OpenEuler RISCV RC4镜像的测试，测试套范围为[test2](https://github.com/KotorinMinami/res_list/blob/master/oe-rv2309/task_v2/oe2309testv2_2)

- 负责修改RC4主报告中的表格[pr#81](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/pulls/81)[pr#79](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/pulls/79)[pr#78](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/pulls/78)[pr#76](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/pulls/76)[pr#75](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/pulls/75)
- 对OpenEuler RC5镜像进行测试，测试套范围为[test2](https://github.com/KotorinMinami/res_list/blob/master/oe-rv2309/task_v2/oe2309testv2_2)，已提交至主仓库 [pr](https://github.com/KotorinMinami/res_list/pull/52)

- 对RC4镜像修复文档中的测试用例进行了一些复测通过[log](https://github.com/Pagerd/PLCT/tree/main/Report/Oct/week14/samba)

- 对OpenEuler RC5测试结果进行了一个简单的对比 [对比结果](https://github.com/Pagerd/PLCT/tree/main/Report/Oct/week14/FailureCause.csv)

- 负责修改rc5测试报告，用于上游QA评审 [PR#13](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/pulls/13)[PR#15](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/pulls/15)

- 对rc6测试中测试出现的问题进行重测并更新在腾讯表格 [logs](https://github.com/Pagerd/PLCT/tree/main/Report/Oct/week15/logs)

- 对rc7测试出现的新增错误进行了复测及分析，并将结果提交至主仓库 [PR#99](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/pulls/99)[PR#101](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/pulls/101)

- 编写了rc7中新增11个测试套中的单独测试报告，并提交至主仓库[PR#102](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/pulls/102)

- 将rc7中新增测试套的单独测试报告合并添加至另一个仓库，并进行对应的修改[PR#18](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/pulls/18)

- 调研ruyi测试策略，和蔡老师一起编写了测试策略[RUYI包管理demo版本测试策略.md](https://github.com/Pagerd/PLCT/tree/main/Report/Oct/week16/RUYI包管理demo版本测试策略.md)

- 将RC8测试中的test3进行测试并提交 [PR](https://github.com/KotorinMinami/res_list/pull/60)

- 将RC8测试与RC7测试进行对比，筛选出新增fail测试用例 [result](https://github.com/Pagerd/PLCT/tree/main/Report/Oct/week16/result.md) 并对失败测试用例进行分析 [Result](https://github.com/Pagerd/PLCT/tree/main/Report/Oct/week16/Result.md)

- 重测部分RC8失败用例，大部分测试用例通过[logs](https://github.com/Pagerd/PLCT/tree/main/Report/Oct/week16/logs)

- 根据蔡老师的测试用例在openeuler 2309 x86 和ubuntu上对ruyisdk进行验证测试，结果相同[log](https://github.com/Pagerd/PLCT/tree/main/Report/Oct/ruyi_test)

