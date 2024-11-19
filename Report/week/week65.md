## 本周工作

### Sail

- 更新了用于提交ACT测试的代码[#Zfh](https://github.com/Pagerd/riscv-arch-test/tree/zfh),尚未通过coverage测试，正在尝试重新搭建环境

- 调研问题[#issues559](https://github.com/riscv-non-isa/riscv-arch-test/issues/559),已发现问题出自z-inxflag没有更新导致使用非32位进行测试的原因，已重新生成ACT测试代码，尚未通过coverage测试，原因同上.
