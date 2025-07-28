# 2025.7.28 Architectural Compatible Test SIG Meeting

##### ACT仓库PR积压问题：

- ACT仓库积压大量PR，审查资源不足（主要依赖Allen Baum和Umer Shahid）

- 解决方案：

  - 招募10xEngineers人员协助审查（James已与CEO Bilal沟通）
  - 安排专项代码审查会议（暂定周三，避开Allen休假时间8/10-8/27）
  - 紧急PR在Allen休假前优先处理（如PMP相关PR #683/#684）

- **CVW测试套件合并进度**

  - 需先清理现有PR才能推进CVW架构变更

    

### 测试框架技术讨论

1. **自检机制争议**
   - 由于简单RISC-V实现可能无Zicsr扩展，无法支持trap,David建议非特权测试改用`jal`跳转替代`ecall`,尔特权测试保留`ecall`
2. **特权测试参数化挑战**
   - 目前175+ UDEP参数影响测试结果（如WARL行为），因此目前需建立完整参数清单，短期优先处理二进制参数
3. **测试分发与框架**
   - David提出了替代riscof的方案：测试以ELF格式分发:开发阶段生成签名以简化测试运行流程。但存在以上争议点最终建议短期改进riscof而非重建。