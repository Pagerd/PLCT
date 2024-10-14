# 2024.10.7 Architectural Compatible Test SIG Meeting

- Umer根据某位csc的要求更新了一张当前ACT 差距分析的表,部分在表上的细节将在会后进行仔细查看
- carl perry简述了关于gcc目前的调研情况，他认为最新的gcc并不适合在act这种需要稳定的测试环境中使用,他提议创建一个文件来检测使用哪个版本的gcc并设置正确的标签，会议最终决定继续使用gcc 10版本
- James Shi对之前ACT新仓库的pr进行了讨论，讨论结果认为发布ACT新仓库后需要为此通知其他工具仓库上的pr/issue发起者将pr/issue转移到act仓库上