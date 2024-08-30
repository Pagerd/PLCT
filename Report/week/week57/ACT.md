# 2024.08.26 Architectural Compatible Test SIG Meeting

会议主要内容：

1. 优化ACT测试官方仓库 - [ Umer]
2. ACT Repo 发布会议 - [ 所有 ACT 维护者]



## 优化ACT测试官方仓库

Umer提出了一个新的仓库格式，即将riscof相关测试工具全部关联进ACT测试官方仓库，这样当后续添加新指令支持时可以通过一个pr将修改过的riscv-ctg riscv-isac等工具的改动全部汇总，同时仓库中将包含ctg测试需要的cgf格式文件，并且修改了文档，将所有测试工具的文档进行了汇总

## 新的RISCV开发容器

edoInx在会议上展示了他所创建的新的用于sail-riscv和riscof开发使用的开发容器https://github.com/edolnx/buildah-riscv_dev