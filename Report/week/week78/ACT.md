# 2024.3.11 Architectural Compatible Test SIG Meeting

##### 新的ACT测试组件

Walley 团队所做的新测试套件：

- 基于 SystemVerilog 的覆盖点，带有 asm 测试，可高度重用。
- 拥有功能覆盖点，用于完整指令和功能级验证。
- 与实际 DV 流程保持一致。
- 更自信和详尽的验证。

集成进ACT的挑战：

- 将基于 SV 的覆盖点与 YAML/Assembly 流程混合。
- 框架演变：需要更新/替换 CTG 和 ISA 覆盖范围。

转向用 Walley 测试取代现有的 ACT(进度流程)：

- Walley 测试将转换为 riscv-arch-tests 模板 - 正在进行中
- 变更公告 - 本次会议后
- 投票 - 下一次 SIG 会议
- 将 walley 测试合并到 riscv-arch-tests 中 - 在 CSC F2F 之前