# 工作报告

#### oERV相关

- 对openeuler 2309 x86 进行了测试并产出log，作为独立发版镜像的对比

- 将openeuler 2309RISCV独立发版镜像的测试结果进行了简单的分类后制成表格并提交[pr#8](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/pulls/8)

- 对openEuler2309独立发版镜像进行VF2硬件测试，测得2309在VF2上运行正常，提交测试结果[#pr6](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/pulls/6)

- 对openeuler 2309 RISCV独立发版镜像的测试结果与openeuler 2309 x86进行了对比，并对对比结果进行分析 [report](./week23/mugen_readme.md)

- 对openEuler2309独立发版镜像进行lpi4a硬件测试，测得2309在lpi4a上运行正常，提交测试结果[#pr1](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/pulls/1)

- 将当前的分析结果提交至报告[pr#9](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/pulls/9)

- 在PLCT openday中进行了报告，内容为基于[mugen的oERV 24.03 LTS自动化测试准备，实例学习mugen测试结果分析](./10-朱旭昌-基于mugen的oERV 24.03 LTS自动化测试准备，实例学习mugen测试结果分析.pdf)

- 将部分失败的测试用例提交issue

  

  | 测试套名        | 测试用例名                                          | 失败情况 | 分析                                                         | issue链接                                                  |
  | --------------- | --------------------------------------------------- | -------- | ------------------------------------------------------------ | ---------------------------------------------------------- |
  | rpcbind         | oe_test_socket_rpcbind                              | fail     | rpcbind.socket无法关闭(mugen字符匹配问题)                    | [I8FO45](https://gitee.com/openeuler/mugen/issues/I8FO45)  |
  | libvma          | oe_test_service_vma                                 | fail     | 没有libvma软件包                                             | [I8RZIX](https://gitee.com/openeuler/RISC-V/issues/I8RZIX) |
  | cockpit         | oe_test_service_cockpit                             | fail     | 没有依赖软件包kexec-tools                                    | [I8RX4W](https://gitee.com/openeuler/RISC-V/issues/I8RX4W) |
  |                 | oe_test_socket_cockpit                              | fail     | 没有依赖软件包kexec-tools                                    | [I8RX4W](https://gitee.com/openeuler/RISC-V/issues/I8RX4W) |
  |                 | oe_test_service_cockpit-wsinstance-http             | fail     | 没有依赖软件包kexec-tools                                    | [I8RX4W](https://gitee.com/openeuler/RISC-V/issues/I8RX4W) |
  | pcp             | oe_test_pmlogger_daily_01                           | x86 fail | 使用过时的egrep                                              | [I8S0FG](https://gitee.com/openeuler/mugen/issues/I8S0FG)  |
  | clevis          | oe_test_install_clevis                              | fail     | 密钥不可用                                                   | [I8S2GB](https://gitee.com/openeuler/RISC-V/issues/I8S2GB) |
  |                 | oe_test_high_nbde                                   | fail     | 软件源没有包cryptsetup-reencrypt                             | [I8S2JX](https://gitee.com/openeuler/RISC-V/issues/I8S2JX) |
  |                 | oe_test_tang_encrypt                                | x86 fail | 无法连接至目标端口                                           | [I8S31S](https://gitee.com/openeuler/mugen/issues/I8S31S)  |
  |                 | oe_test_service_clevis-luks-askpass                 | x86 fail | 测试用例编写错误？                                           | [I8S30G](https://gitee.com/openeuler/mugen/issues/I8S30G)  |
  | systemd         | oe_test_socket_systemd-journald-audit               | fail     | 重启systemd-journald-audit.socket服务失败                    | [I8S3QW](https://gitee.com/openeuler/RISC-V/issues/I8S3QW) |
  | os-basic        | oe_test_glibc                                       | x86 fail | 未预装gcc                                                    | [I8S53J](https://gitee.com/openeuler/mugen/issues/I8S53J)  |
  |                 | oe_test_c_stat                                      | x86 fail | 未预装gcc                                                    | [I8S53J](https://gitee.com/openeuler/mugen/issues/I8S53J)  |
  |                 | oe_test_pcre_use                                    | x86 fail | 未预装gcc                                                    | [I8S53J](https://gitee.com/openeuler/mugen/issues/I8S53J)  |
  |                 | oe_test_libunistring                                | x86 fail | 未预装gcc                                                    | [I8S53J](https://gitee.com/openeuler/mugen/issues/I8S53J)  |
  |                 | oe_test_cairo                                       | x86 fail | 未预装gcc                                                    | [I8S53J](https://gitee.com/openeuler/mugen/issues/I8S53J)  |
  |                 | oe_test_libidn                                      | fail     | 未安装gcc                                                    | [I8S53J](https://gitee.com/openeuler/mugen/issues/I8S53J)  |
  | amanda          | oe_test_amanda_aespipe                              | x86 fail | diff rv下载的为aespipe-v2.4g 而测试用例为aespipe-v2.4f x86未预装wget | [I8QF53](https://gitee.com/openeuler/mugen/issues/I8QF53)  |
  | openssl         | oe_test_openssl_encrypte_decrypte_emails            | x86 fail | same 密钥不为PKCS#1 格式                                     | [I8REFV](https://gitee.com/openeuler/mugen/issues/I8REFV)  |
  |                 | oe_test_openssl_empty_private_key                   | x86 fail | same 密钥不为PKCS#1 格式                                     | [I8REFV](https://gitee.com/openeuler/mugen/issues/I8REFV)  |
  |                 | oe_test_openssl_generate_key_pair                   | x86 fail | same 密钥不为PKCS#1 格式                                     | [I8REFV](https://gitee.com/openeuler/mugen/issues/I8REFV)  |
  |                 | oe_test_openssl_remove_mod_ssl                      | x86 fail | same 密钥不为PKCS#1 格式                                     | [I8REFV](https://gitee.com/openeuler/mugen/issues/I8REFV)  |
  |                 | oe_test_openssl_expired_certificate                 | x86 fail | same 密钥不为PKCS#1 格式                                     | [I8REFV](https://gitee.com/openeuler/mugen/issues/I8REFV)  |
  |                 | oe_test_openssl_file_signature_verification         | x86 fail | same 密钥不为PKCS#1 格式                                     | [I8REFV](https://gitee.com/openeuler/mugen/issues/I8REFV)  |
  |                 | oe_test_openssl_create_CA_applying_certificate      | x86 fail | same 密钥不为PKCS#1 格式                                     | [I8REFV](https://gitee.com/openeuler/mugen/issues/I8REFV)  |
  |                 | oe_test_openssl_delete_configuration_file           | x86 fail | same 密钥不为PKCS#1 格式                                     | [I8REFV](https://gitee.com/openeuler/mugen/issues/I8REFV)  |
  |                 | oe_test_openssl_speed                               | x86 fail | 测试用例编写有误                                             | [I8RJBL](https://gitee.com/openeuler/mugen/issues/I8RJBL)  |
  |                 | oe_test_openssl_repeat_restart                      | x86 fail | same 密钥不为PKCS#1 格式                                     | [I8REFV](https://gitee.com/openeuler/mugen/issues/I8REFV)  |
  |                 | oe_test_openssl_DSA_algorithm                       | x86 fail | same 密钥不为PKCS#1 格式                                     | [I8REFV](https://gitee.com/openeuler/mugen/issues/I8REFV)  |
  |                 | oe_test_openssl_empty_public_key                    | x86 fail | same 密钥不为PKCS#1 格式                                     | [I8REFV](https://gitee.com/openeuler/mugen/issues/I8REFV)  |
  |                 | oe_test_openssl_incorrect_public_private_key        | x86 fail | same 密钥不为PKCS#1 格式                                     | [I8REFV](https://gitee.com/openeuler/mugen/issues/I8REFV)  |
  |                 | oe_test_openssl_encrypt_decrypt_file_asymmetrically | x86 fail | same 密钥不为PKCS#1 格式                                     | [I8REFV](https://gitee.com/openeuler/mugen/issues/I8REFV)  |
  |                 | oe_test_openssl_Implements_https                    | x86 fail | same 密钥不为PKCS#1 格式                                     | [I8REFV](https://gitee.com/openeuler/mugen/issues/I8REFV)  |
  | bison           | oe_test_bison                                       | x86 fail | same 未安装gcc                                               | [I8QIIN](https://gitee.com/openeuler/mugen/issues/I8QIIN)  |
  | libtiff         | oe_test_libtiff                                     | x86 fail | same 没有安装gcc,安装后无<tiffio.h>                          | [I8RJW6](https://gitee.com/openeuler/mugen/issues/I8RJW6)  |
  | pixman          | oe_test_pixman                                      | x86 fail | same 没有安装gcc                                             | [I8QIRH](https://gitee.com/openeuler/mugen/issues/I8QIRH)  |
  | libmicrohttpd   | oe_test_libmicrohttpd                               | x86 fail | same 没有安装gcc                                             | [I8RJFN](https://gitee.com/openeuler/mugen/issues/I8RJFN)  |
  | libdb           | oe_test_libdb                                       | x86 fail | same没有安装gcc                                              | [I8RJ44](https://gitee.com/openeuler/mugen/issues/I8RJ44)  |
  | hwloc_2.7.1     | oe_test_hwloc_2.7.1_hwloc-ps                        | x86 fail | same 镜像源内hwloc版本不为2.7.1                              | [I8QIWX](https://gitee.com/openeuler/mugen/issues/I8QIWX)  |
  | hdparm          | oe_test_hdparm                                      | x86 fail | 没有预装hdparm                                               | [I8RLW0](https://gitee.com/openeuler/mugen/issues/I8RLW0)  |
  | rpmlint         | oe_test_rpmdiff                                     | x86 fail | 未预装wget及下载未考虑其余架构                               | [I8RO0H](https://gitee.com/openeuler/mugen/issues/I8RO0H)  |
  | smoke-baseinfo  | oe_test_cockpit                                     | fail     | 没有cockpit-285-2.oe2309.riscv64                             | [I8RX4W](https://gitee.com/openeuler/RISC-V/issues/I8RX4W) |
  | java-11-openjdk | oe_test_openjdk11_jjs_jmap                          | fail     | 预期testlog1为未定义，然而当前版本似乎jjs tool仍会将其定义   | [I8RWYH](https://gitee.com/openeuler/RISC-V/issues/I8RWYH) |
  | ops_guide       | oe_test_common_skill_rpm_commands                   | fail     | nano-7.2-2.oe2309.riscv64.rpm已安装                          | [I8RX51](https://gitee.com/openeuler/mugen/issues/I8RX51)  |
  | libguestfs      | oe_test_libguestfs_libguestfs-test-tool             | fail     | 缺失依赖包supermin5.1.18                                     | [I8RWS2](https://gitee.com/openeuler/RISC-V/issues/I8RWS2) |
  |                 | oe_test_libguestfs_guestfish_02                     | fail     | 缺失依赖包supermin5.1.18                                     | [I8RWS2](https://gitee.com/openeuler/RISC-V/issues/I8RWS2) |
  | hadoop-3.1      | oe_test_service_hadoop-namenode-3.1                 | fail     | 没有包hadoop-3.1-hdfs                                        | [I8RWUC](https://gitee.com/openeuler/RISC-V/issues/I8RWUC) |
  |                 | oe_test_service_hadoop-timelineserver-3.1           | fail     | f没有包hadoop-3.1-hdfs                                       | [I8RWUC](https://gitee.com/openeuler/RISC-V/issues/I8RWUC) |
  |                 | oe_test_service_hadoop-journalnode-3.1              | fail     | 没有包hadoop-3.1-hdfs                                        | [I8RWUC](https://gitee.com/openeuler/RISC-V/issues/I8RWUC) |
  |                 | oe_test_service_hadoop-secondarynamenode-3.1        | fail     | 没有包hadoop-3.1-hdfs                                        | [I8RWUC](https://gitee.com/openeuler/RISC-V/issues/I8RWUC) |
  |                 | oe_test_service_hadoop-datanode-3.1                 | fail     | 没有包hadoop-3.1-hdfs                                        | [I8RWUC](https://gitee.com/openeuler/RISC-V/issues/I8RWUC) |
  |                 | oe_test_service_hadoop-nodemanager-3.1              | fail     | 没有包hadoop-3.1-hdfs                                        | [I8RWUC](https://gitee.com/openeuler/RISC-V/issues/I8RWUC) |
  |                 | oe_test_service_hadoop-resourcemanager-3.1          | fail     | 没有包hadoop-3.1-hdfs                                        | [I8RWUC](https://gitee.com/openeuler/RISC-V/issues/I8RWUC) |
  |                 | oe_test_service_hadoop-proxyserver-3.1              | fail     | 没有包hadoop-3.1-hdfs                                        | [I8RWUC](https://gitee.com/openeuler/RISC-V/issues/I8RWUC) |
  | tboot_1.9.12-2  | oe_test_tboot_lcp2_crtpolelt                        | fail     | 源内无软件包tboot                                            | [I8RX54](https://gitee.com/openeuler/RISC-V/issues/I8RX54) |
  |                 | oe_test_tboot_1.9.12-2_lcp2_mlehash                 | fail     | 源内无软件包tboot                                            | [I8RX54](https://gitee.com/openeuler/RISC-V/issues/I8RX54) |
  |                 | oe_test_tboot_txt-stat                              | fail     | 源内无软件包tboot                                            | [I8RX54](https://gitee.com/openeuler/RISC-V/issues/I8RX54) |
  |                 | oe_test_tboot_1.9.12-2_lcp2_crtpol                  | fail     | 源内无软件包tboot                                            | [I8RX54](https://gitee.com/openeuler/RISC-V/issues/I8RX54) |
  |                 | oe_test_tboot_tb_polgen                             | fail     | 源内无软件包tboot                                            | [I8RX54](https://gitee.com/openeuler/RISC-V/issues/I8RX54) |
  | meson_0.63      | oe_test_meson_0.63_meson_18                         | fail     | 没有软件源valgrind                                           | [I8RX57](https://gitee.com/openeuler/RISC-V/issues/I8RX57) |
  | prometheus2     | oe_test_prometheus_querying_http_api                | fail     | 没有包prometheus2导致测试超时                                | [I8RX58](https://gitee.com/openeuler/RISC-V/issues/I8RX58) |
  |                 | oe_test_service_prometheus                          | fail     | 没有包prometheus2                                            | [I8RX58](https://gitee.com/openeuler/RISC-V/issues/I8RX58) |
  | meson_0.54      | oe_test_meson_0.54_meson_19                         | fail     | 没有包valgrind                                               | [I8RX57](https://gitee.com/openeuler/RISC-V/issues/I8RX57) |
  |                 | oe_test_meson_0.54_meson_18                         | fail     | 没有包valgrind                                               | [I8RX57](https://gitee.com/openeuler/RISC-V/issues/I8RX57) |
  | gradle          | oe_test_gradle_02                                   | fail     | 没有包gradle                                                 | [I8RX56](https://gitee.com/openeuler/RISC-V/issues/I8RX56) |
  |                 | oe_test_gradle_01                                   | fail     | 没有包gradle                                                 | [I8RX56](https://gitee.com/openeuler/RISC-V/issues/I8RX56) |
  |                 | oe_test_gradle_03                                   | fail     | 没有包gradle                                                 | [I8RX56](https://gitee.com/openeuler/RISC-V/issues/I8RX56) |
  | amanda          | oe_test_amanda_amcheck                              | fail     | /usr/bin/gettext: No such file or directory                  | [I8RX4Z](https://gitee.com/openeuler/RISC-V/issues/I8RX4Z) |
  | dbus            | oe_test_service_dbus                                | fail     | 由于dbus.socket无法关闭服务dbus.service                      | [I8RUGJ](https://gitee.com/openeuler/RISC-V/issues/I8RUGJ) |
  | systemtap       | oe_test_service_stap-exporter                       | fail     | file missing/systemd unit restart failure/systemd unit runtime  error/systemd unit enable failure | [I8RYZ7](https://gitee.com/openeuler/RISC-V/issues/I8RYZ7) |
  | smoke-basic-os  | oe_test_grub2_mkconfig                              | fail     | 未安装grub2-mkconfig                                         | [I8RULY](https://gitee.com/openeuler/RISC-V/issues/I8RULY) |
  |                 | oe_test_perf                                        | fail     | PMU硬件不支持采样/溢出中断，因此无法写入数据                 | [I8RZ51](https://gitee.com/openeuler/RISC-V/issues/I8RZ51) |
  |                 | oe_test_criu                                        | fail     | 未安装ciru gcc(源内无ciru)                                   | [I8RUUH](https://gitee.com/openeuler/RISC-V/issues/I8RUUH) |

  

  

### RUYI

- 对ruyi包管理器进行手动测试，发现未预装tar的情况下ruyi会报错并提交issue[#12](https://github.com/ruyisdk/ruyi/issues/12)
- 编写了lpi4a的openEuler2309安装文档并进行提交[#pr4](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/pulls/4)
- 对ruyi 2023 1204在ubuntu上进行测试来补全log并提交至主仓库[pr](https://gitee.com/yunxiangluo/ruyi-sdk-v0.2-test/pulls/6/files)
- 录制了lpi4a上ruyi的使用视频[video](./ruyi.mp4)







