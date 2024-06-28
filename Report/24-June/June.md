# 六月工作

### Sail

- 调研了RISCV D拓展的定义并在sail中如何实现 [文档](https://github.com/Pagerd/PLCT/tree/main/Note/sail/D-TYPE.md)

- 参加了6月3日的ACT会议，并编写了[会议纪要](https://github.com/Pagerd/PLCT/blob/main/Report/week/week46/ACT.md)
- 查看了Sail Issue [#169](https://github.com/riscv/sail-riscv/issues/169),尝试了解fcsr处于无效编码时sail的哪一步导致了崩溃 [Issue_169](https://github.com/Pagerd/PLCT/blob/main/Report/week/week46/Issue_169.md)
- 在Sail Issue [#169](https://github.com/riscv/sail-riscv/issues/169)中提交了一个[commit](https://github.com/riscv/sail-riscv/issues/169#issuecomment-2160190360)，协助进行issue的关闭


- 在Sail-RISCV仓库中 `pmpcfg 允许非法值 R=0, W=1`问题下进行了讨论，并协助跟进解决关闭此issue [#296](https://github.com/riscv/sail-riscv/issues/296#issuecomment-2175539444)


### ROS2测试

- 在openEuler 2403 LTS x86上对ROS2进行了测试，产出[测试报告](.\week47\ROS-humble-oerv24.03-x86)
- 在openEuler 2403 LTS arm上对ROS2进行了测试，产出[测试报告](.\week47\ROS-humble-oerv24.03-arm)

- 在lpi4a openEuler 2403 LTS上对ROS2进行了测试，产出[测试报告](.\week47\ROS-humble-oerv24.03-lpi4a)
- 在openEuler 2403 LTS x86上对ROS2进行了测试，产出[测试报告](.\week47\ROS-humble-oerv24.03-x86)
- 在Lpi4A上进行了xfce测试，结果失败，并提交了相关issue [IA9077](https://gitee.com/openeuler/RISC-V/issues/IA9077?from=project-issue)
- 将测试安装文档提交至ROS社区文档 [PR#8](https://gitee.com/openeuler/ros/pulls/8 )
- 在x86上进行了xfce和ukui的桌面安装及测试，结果成功，并添加pr至社区文档[#Pr9](https://gitee.com/openeuler/ros/pulls/9)