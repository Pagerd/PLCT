# 2024.09.10 Architectural Compatible Test SIG Meeting

- Umer已经完成了新ACT仓库的准备并提交了pr，更新了Ci，删除了不便进行测试的Docker容器
- Umer提到在使用工具链的时候使用二进制文件会出一系列问题，carl perry提到正在想办法找出目前工具链repo的所有者是谁以便解决这些问题
- Umer将ACT的插件目录拆分为了32位和64位以便于分别进行单独设置，同时提到ACT相关文档较为老旧，需要进行更新
- James Shi提到在python中使用pip直接安装的riscof和ctg isac版本过低，因此考虑在官方文档中修改安装方式
- James Shi检查了工具链的部分pr请求(isac ctg)并以此为例讲述了新仓库的必要性，pr本身会议并无讨论