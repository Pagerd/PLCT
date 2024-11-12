# 2024.11.5 Architectural Compatible Test SIG Meeting

- bill提到TenseTorrent和至少一家其他公司正在向认证指导委员会提供测试服务，他们的测试样本包含一个随机测试的结果，对于是否需要将这些样本引入ACT仓库以便使用这些测试进行了讨论，结论是无需添加进
- Carl提到riscof似乎已经过时了，在python的新版本上许多依赖库可能会被启用，Umer回复尝试在Ubuntu 24和新版python上对缺失的函数进行更新，Carl表示将会协助进行维护

- 检查了修复isac字符串bug的PR[#544](https://github.com/riscv-non-isa/riscv-arch-test/pull/544)并合并

- 检查了修复`cross()`失效的bug的PR[#546](https://github.com/riscv-non-isa/riscv-arch-test/pull/546)并合并

- 检查了修复实用程序函数拼写错的pr[#548](https://github.com/riscv-non-isa/riscv-arch-test/pull/548)，讨论结果认为应该在此处删除s并修改对应函数名而非在其他地方添加s

- 检查了的物理内存保护 (32/64) 测试和覆盖组pr[#462](https://github.com/riscv-non-isa/riscv-arch-test/pull/462)并合并

- 检查了关于添加ruff check的pr[#538](https://github.com/riscv-non-isa/riscv-arch-test/pull/538),会议认为会导致ci变得臃肿且umer说有更好的方案，因此不批准合并

- 检查了关于添加cli env_dir参数的pr[#539](https://github.com/riscv-non-isa/riscv-arch-test/pull/539),umer认为这会影响所有isac与ctg用户，因此不批准合并

  推进了ACT 3.10.0的release,主要更新如下：        

  - 添加对 Zvk* 扩展的支持
  - 将浮点和双精度测试用例拆分成更小的测试用例
  - 将 riscv-ctg 和 riscv-isac 合并到 riscv-arch-test，并更新了 README
  - 更新加密标量指令
  - CI 更新：并在 CI 中更新了 Sail 和 Spike
  - 错误修复

