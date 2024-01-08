## 本周工作

- 继续分析2309独立发版镜像QEMU的失败原因

| 测试用例名            | 测试用例                                               | 状态     | 原因                                        | 行动                                                       |
| --------------------- | ------------------------------------------------------ | -------- | ------------------------------------------- | ---------------------------------------------------------- |
| freeipmi              | oe_test_service_ipmiseld                               | fail     | 服务无法启动                                | [I8U0BE](https://gitee.com/openeuler/RISC-V/issues/I8U0BE) |
| clamav                | oe_test_clamav_clamscan_3                              | fail     | 超时                                        | 增加测试时间后通过                                         |
|                       | oe_test_clamav_clamscan_2                              | fail     | 超时                                        | 增加测试时间后通过                                         |
|                       | oe_test_service_clamav-clamonacc                       | fail     | 超时                                        | 增加测试时间后通过                                         |
|                       | oe_test_clamav_clamscan_1                              | fail     | 超时                                        | 增加测试时间后通过                                         |
| socat                 | oe_test_socat_02                                       | fail     | sleep时间过短导致测试失败                   | 增加测试时间后通过                                         |
| groovy18              | oe_test_groovy18sh                                     | fail     | 疑似为效率原因导致超时                      | 加长时间后通过                                             |
| 389-ds-base_1.4.3.20  | oe_test_ds-logpipe                                     | fail     | 等待时间过短                                | 增加测试时间后通过                                         |
| security_test         | oe_test_scanning_system                                | fail     | 超时                                        | 增加测试时间后通过                                         |
| dblatex               | oe_test_dblatex_dblatex_01                             | fail     | 超时                                        | 增加测试时间后通过                                         |
| rubygem-fluentd_1.3.3 | oe_test_fluent_cat_02_2003                             | fail     | 等待时间过短                                | 增加测试时间后通过                                         |
| os-basic              | oe_test_power_powertop2tuned_optimize                  | fail     | Powertop版本不兼容                          | [I8U0JM](https://gitee.com/openeuler/RISC-V/issues/I8U0JM) |
|                       | oe_test_power_measurement_internal                     | fail     | 等待时间过短                                | 增加测试时间后通过                                         |
|                       | oe_test_ar                                             | x86 fail | 未预装ar                                    | [I8U0LF](https://gitee.com/openeuler/mugen/issues/I8U0LF)  |
|                       | oe_test_aureport                                       | x86 fail | 未预装auditd                                | [I8U0MM](https://gitee.com/openeuler/mugen/issues/I8U0MM)  |
|                       | oe_test_envsubst                                       | fail     | 未预装envsubst                              | [I8U0OK](https://gitee.com/openeuler/mugen/issues/I8U0OK)  |
|                       | oe_test_glibc                                          | x86 fail | 未预装gcc                                   | [I8S53J](https://gitee.com/openeuler/mugen/issues/I8S53J)  |
|                       | oe_test_c_stat                                         | x86 fail | 未预装gcc                                   | [I8S53J](https://gitee.com/openeuler/mugen/issues/I8S53J)  |
|                       | oe_test_pcre_use                                       | x86 fail | 未预装gcc                                   | [I8S53J](https://gitee.com/openeuler/mugen/issues/I8S53J)  |
|                       | oe_test_libunistring                                   | x86 fail | 未预装gcc                                   | [I8S53J](https://gitee.com/openeuler/mugen/issues/I8S53J)  |
|                       | oe_test_cairo                                          | x86 fail | 未预装gcc                                   | [I8S53J](https://gitee.com/openeuler/mugen/issues/I8S53J)  |
|                       | oe_test_libidn                                         | fail     | 未安装gcc                                   | [I8S53J](https://gitee.com/openeuler/mugen/issues/I8S53J)  |
| kpatch                | oe_test_service_kpatch                                 | fail     | 软件源内没有kpatch                          | [I8U0NB](https://gitee.com/openeuler/RISC-V/issues/I8U0NB) |
| amanda                | oe_test_amanda_amcheck                                 | fail     | /usr/bin/gettext: No such file or directory | [I8RX4Z](https://gitee.com/openeuler/RISC-V/issues/I8RX4Z) |
| freeradius            | oe_test_freeradius_freeradius-utils_radlastAndRadsniff | fail     | 手动重测通过                                | 手动重测通过                                               |
| clevis                | oe_test_install_clevis                                 | fail     | 密钥不可用                                  | [I8S2GB](https://gitee.com/openeuler/RISC-V/issues/I8S2GB) |
|                       | oe_test_high_nbde                                      | fail     | 软件源没有包cryptsetup-reencrypt            | [I8S2JX](https://gitee.com/openeuler/RISC-V/issues/I8S2JX) |
|                       | oe_test_tang_encrypt                                   | x86 fail | 无法连接至目标端口                          | [I8S31S](https://gitee.com/openeuler/mugen/issues/I8S31S)  |
|                       | oe_test_service_clevis-luks-askpass                    | x86 fail | 测试用例编写错误？                          | [I8S30G](https://gitee.com/openeuler/mugen/issues/I8S30G)  |