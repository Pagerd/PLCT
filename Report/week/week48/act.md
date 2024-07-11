## 5月第三周测试小队产出

- 会议上提到了关于签名在重置后不一致的问题




![1](.\img\1.png)



这个问题有三个答复

1. 如果启用了错误对齐支持，则禁用对齐支持，并且不设陷阱，但签名文件中将有四个覆盖点字同样的技术在不同的arch测试中使用，因此根据测试中TEST_CASE语句的数量，测试中可能有1对或更多的覆盖点词，您可以将这些测试假设为两个或多个测试包，这些测试将评估Sail中不同支持配置的相同条件
2. @Marc使用的方法不准确，最简单的方法是有效地使用DUT riscof_plugin flie。计算签名大小的方法是在您的DUT riscof_Pugin FIL中定义两个全局宏(BEGIN_Signdgre和end_Signal)。在RVMODEL_DADATA_BEN和RVMODEL_DATAD_END的起始位置。您可以更新您的DUT的RVMODElL_HART定义，以便在这些全局标签之间提取代码签名大小。之后，您可以在Testbench中定义一个addrss，并在该区域上复制签名区域的内容来处理它。
3. 正如James所指出的，我们的RISC-V开发人员和证书客户不接受此操作，在我看来，原因不是签名和签名分配。基于签名的验证是我们的要求(或者您可以说是约束)，因为RISC-/具有如此多的灵活性和许多不同类型的Vald配置，因此可能不可能针对所有配置编写和保存SELI测试。因此，签名，即使是好的或坏的，都不是问题所在。我们的行动并没有提供全面的功能覆盖，我们没有一个很好的方法来书写覆盖点基于复盖点，因为它们是复杂的阅读，有大量的冗余，并仍然有一些洞在它。我们将开发最好的质量覆盖点，然后行为也将被认证客户接受。

同时会议上提交了一个关于此issue的github issue



会议接下来讨论了关于ACT release的相关问题

![2](.\img\2.png)

讨论了关于update dev branch的问题