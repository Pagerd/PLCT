# 2024.6.2 Architectural Compatible Test SIG Meeting

##### RISCOF ISA字符问题

- 目前RISCOF采用yaml文件定义ISA字符串，导致在运行时经常出现字符串不匹配错误，讨论打算使用UDB替代生成RISCOF测试配置。

##### CVW合并入ACT进展

- 目前已进入风险规避兼容阶段，随着更新增加CVW测试集变得运行时间更长，效率也更低。David Harris开始怀疑cvw相比ACT是否还有优势。