## RISCV IO Mapping Table（RIMP）批准计划

https://github.com/riscv-admin/prs/blob/main/CHARTER.md

ACPI表，用于将IOMMU信息传递给操作系统

每个CPU架构都有由各自组织维护的这样的表

- Intel - DMAR
- AMD - IVRS
- ARM - IORT

因此risc-v的规范也需要定义和维护

RIMT静态ACPI表

- 提供特定IOMMU后面的IOMMU和DMA功能设备的映射信息
- 描述PCI根复合体和IOMMU之间的关系。并将此描述与MCFG表联系起来
- 描述平台设备和IOMMU之间的关系

设计考虑因素

- 支持这两种情况：

IOMMU作为PCI设备实施时

IOMMU作为平台设备

- 支持IOMMU的有线和MSI中断
- 支持IOMMU后面的PCI和ACPI命名空间设备



| 关键日期     | 时间       |
| ------------ | ---------- |
| 计划批准     | 2024.8.14  |
| 内部审查开始 | 2024.9.2   |
| 架构请求审查 | 2024.10.1  |
| 冻结项目     | 2024.11.18 |
| 公开审查开始 | 2024.12.9  |
| 批准就绪     | 2025.1.31  |
| TSC批准      | 2025.2.28  |
| 董事会批准   | 2025.3.31  |

现状：该规范处于草案状态，正在PRS TG中进行审查。IOMMU作为PCI设备和平台设备，都是用qemu和linux完成的

相关代码链接：

- Qemu:https://github.com/vlsunil/qemu/tree/acpi_rimt_poc_v1
- Linux:https://github.com/vlsunil/qemu/tree/acpi_rimt_poc_v1

# SBI v3.0 批准计划

新增功能：

- SSE监控软件事件:从SBI实施到监督的高优先级直接陷阱
- FWFT固件功能:从监督模式请求中选择性启用/禁用功能
- DBTR调试触发器:仅访问/配置M模式调试寄存器
- MPXY消息代理:监督软件和远程实体之间任何消息传递协议的通用管道

改进：
与事件发现相关的PMU改进

| 关键日期     | 时间       |
| ------------ | ---------- |
| 计划批准     | 2024.8.14  |
| 内部审查开始 | 2024.9.2   |
| 架构请求审查 | 2024.10.1  |
| 冻结项目     | 2024.11.18 |
| 公开审查开始 | 2024.12.9  |
| 批准就绪     | 2025.1.31  |
| TSC批准      | 2025.2.28  |
| 董事会批准   | 2025.3.31  |

现状：该规范处于草案状态，正在PRS TG中进行审查。IOMMU作为PCI设备和平台设备，都是用qemu和linux完成的

相关代码链接：

- SSE:https://github.com/rivosinc/linux/commits/dev/cleger/see
- FWFT:https://github.com/rivosinc/linux/commits/dev/cleger/fwft
- DBTR:https://github.com/ventanamicro/linux/tree/dev-upstream
- MPXY：:https://github.com/ventanamicro/linux/tree/dev-upstream