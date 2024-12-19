# 2024.12.17 Architectural Compatible Test SIG Meeting

RISC-V架构功能验证

David Harris展示了一个新的架构测试[cvw-arch-verif](https://github.com/openhwgroup/cvw-arch-verif)，由哈维穆德学院、数十名工程师、哈比卜大学和 UET共同进行开发。

David认为的riscv-arch-test缺点：

- 原始开发人员不活跃，很难更改
- 非标准 YAML 覆盖范围难以解释/审查
- 不完整的 Zfa 测试需要数月才能纠正
- 特权测试需要数年才能开发
- 发现许多错误
并非所有相关状态（例如 fflags）都记录在签名中
Zfa 缺少指令并且覆盖点不足

他认为的cvw-arch-verif 的优缺点
+ 锁步测试避免了签名记录中的错误，避免了对签名代码的需求
+ 开发速度快，学生可以轻松添加更多测试
+ 具有随机输入的定向测试比 risv-arch-test 约束随机测试更易于阅读和排除故障
+ 比 riscv-arch-test 更全面的覆盖点
+ 拥有特权测试尝试与riscv-arch-test共享虚拟内存和 PMP 

最后David希望cvw-arch-verif 能成为 RISC-V 认证测试的基础架构测试
