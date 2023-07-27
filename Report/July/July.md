# 七月工作报告

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

### 合并产出

KotorinMinami/res_list:

1.添加test2测试分析结果

[KotorinMinami/res_list#16](https://github.com/KotorinMinami/res_list/pull/16)  

2.添加Fe_FileSystem测试结果

[KotorinMinami/res_list#22]((https://github.com/KotorinMinami/res_list/pull/22))  

### 文档产出

1.[Mugen2303测试文档](https://github.com/Pagerd/PLCT/blob/main/2303Mugen/2303Mugen.md)

2.[openEuler 2303 RISC-V Mugen测试结果](https://github.com/Pagerd/Mugen2303Result)
