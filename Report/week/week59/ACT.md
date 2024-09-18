# 2024.09.10 Architectural Compatible Test SIG Meeting

会议主要内容：

1. 优化ACT测试官方仓库后续
2. ACT CI的问题
3. ACT PR检查



## 优化ACT测试官方仓库后续

Umer已经在CI中建立了工具链以及搭建了预先构建好的版本,但是设置路径时遇到了一些问题，以及相关toolchain的一些bug,下次的会议中将会进行演示

## ACT CI的问题

carl perry提交了一个关于act riscof spike所使用的GCC版本及后续工具链支持的问题，carl perry希望推进toolchain版本规范化，Allen回答说目前无法给出确切的答复但是新版本的GCC由于flag变动不支持当前测试工具

Allen提到了尝试在新拓展中进行测试然而由于工具链不支持导致失败





## ACT PR检查

pr [380](https://github.com/riscv-non-isa/riscv-arch-test/pull/380)

经检查该测试虽然简单但是符合测试需求，且由于拓展已批准因此将pr修改为`Require SAIL Support` `ratified`