# 工作报告

- 将上周测试的结果提交至主仓库 [pr](https://github.com/KotorinMinami/res_list/pull/11)

- 对rest2中在riscv上fail的以及在x86上fail的未知原因的测试套进行了一些测试原因分析[Failed](https://github.com/Pagerd/PLCT/blob/main/TestReport/Rest2/failed.md)

- 编写了现阶段的mugen测试报告及ppt [report](https://github.com/Pagerd/PLCT/blob/main/GroupReport/2303Mugen.md)

  

# 错误分析:

### groovy

缺少对应的软件包

```
 DNF_INSTALL 'groovy18 tar'
+ pkgs='groovy18 tar'
+ node=1
+ '[' -z '' ']'
+ tmpfile=
++ python3 /root/mugen/libs/locallibs/rpm_manage.py install --pkgs 'groovy18 tar' --node 1 --tempfile ''
+ tmpfile2='Last metadata expiration check: 0:08:31 ago on Mon 26 Jun 2023 01:57:00 AM CST.
Package tar-2:1.34-4.oe2303.riscv64 is already installed.
Error: 
 Problem: package groovy18-1.8.9-1.oe2303.noarch requires mvn(org.codehaus.gpars:gpars), but none of the providers can be installed
  - package gpars-1.2.1-13.oe2303.noarch requires mvn(org.codehaus.groovy:groovy-all), but none of the providers can be installed
  - conflicting requests
  - nothing provides mvn(jline:jline) needed by groovy-2.4.8-11.oe2303.noarch
(try to add '\''--skip-broken'\'' to skip uninstallable packages or '\''--nobest'\'' to use not only best candidate packages)'
+ '[' -z '' ']'
+ tmpfile='Last metadata expiration check: 0:08:31 ago on Mon 26 Jun 2023 01:57:00 AM CST.
Package tar-2:1.34-4.oe2303.riscv64 is already installed.
Error: 
 Problem: package groovy18-1.8.9-1.oe2303.noarch requires mvn(org.codehaus.gpars:gpars), but none of the providers can be installed
  - package gpars-1.2.1-13.oe2303.noarch requires mvn(org.codehaus.groovy:groovy-all), but none of the providers can be installed
  - conflicting requests
  - nothing provides mvn(jline:jline) needed by groovy-2.4.8-11.oe2303.noarch
(try to add '\''--skip-broken'\'' to skip uninstallable packages or '\''--nobest'\'' to use not only best candidate packages)'
```



### postgresql_20.03

测试套过老，与新版本不符

##### oe_test_postgresql-contrib_pg_qrchivecleanup:测试用例命令行参数过多

log内对应报错如下

```
+ su - postgres -c 'oid2name -t test "oid2name"'
+ grep Filenode
oid2name: too many command-line arguments (first is "oid2name")
Try "oid2name --help" for more information.
+ CHECK_RESULT 1
+ actual_result=1
+ expect_result=0
```

##### oe_test_postgresql-contrib_pg_waldump:无法解析起始 WAL 位置“-n”

log内对应报错如下

```
+ su - postgres -c 'pg_waldump 000000010000000000000001 -f -s  -n 3'
+ grep rmgr
pg_waldump: error: could not parse start WAL location "-n"
Try "pg_waldump --help" for more information.
+ CHECK_RESULT 1
+ actual_result=1
+ expect_result=0
```

##### oe_test_postgresql-devel_ecpg:测试版本无ecpg命令支持

log内对应报错如下

```
+ su - postgres -c 'ecpg -c test.sqc'
-bash: line 1: ecpg: command not found
+ CHECK_RESULT 127
+ actual_result=127
+ expect_result=0
```

##### oe_test_postgresql_pg_dump_02:测试版本pg_dump指令不支持-o参数

log内对应报错如下

```
+ su - postgres -c 'pg_dump -o testdb >testfile'
pg_dump: invalid option -- 'o'
```

##### oe_test_postgresql_pg_dumpall01:测试版本pg_dumpall指令不支持-o参数

log内对应报错如下

```
+ su - postgres -c 'pg_dumpall -o > /var/lib/pgsql/test.sql'
pg_dumpall: invalid option -- 'o'
```

##### oe_test_postgresql-server_pg_receivewal:测试套中的正则表达式错误

log内对应报错如下

```
++ pgrep -f 'pg_receivewal -D /var/lib/pgsql/pg_receivewal -h ${NODE1_IPV4} -U sstest -w -p 5432'
pgrep: regex error: Invalid preceding regular expression
+ kill -9
kill: usage: kill [-s sigspec | -n signum | -sigspec] pid | jobspec ... or kill -l [sigspec]
+ CHECK_RESULT 2
+ actual_result=2
+ expect_result=0
......
pg_receivewal: error: FATAL:  role "sstest" does not exist
```



### embedded_security_config_test

##### oe_test_check_file_sys_protect_002: 目录内没有对应文件

log内对应报错如下

```
+ find /etc/securetty -type f -user root -group root -perm 600
find: ‘/etc/securetty’: No such file or directory
+ CHECK_RESULT 1 0 0 'check /etc/securetty file right fail'
+ actual_result=1
+ expect_result=0
```



##### oe_testcheck_file_sys_protect_003:audit内没有log文件

log内对应报错如下

```
+ find /var/log/audit/audit.log -type f -user root -group root -perm 600
find: ‘/var/log/audit/audit.log’: No such file or directory
+ CHECK_RESULT 1 0 0 'check /var/log/audit/audit.log file right fail'
+ actual_result=1
```

##### oe_test_check_log_001:audit内没有rules文件

log内对应报错如下

```
+ grep '\-w /var/log/lastlog -p wa -k logins' /etc/audit/audit.rules
grep: /etc/audit/audit.rules: No such file or directory
+ CHECK_RESULT 2 0 0 'check /etc/audit/audit.rules set fail'
+ actual_result=2
+ expect_result=0
+ mode=0
+ error_log='check /etc/audit/audit.rules set fail'
+ exit_mode=0
```

##### oe_test_check_file_sys_protect_004: 目录内没有对应文件

log内对应报错如下

```
+ find /init -type l -user root -group root -perm 777
find: ‘/init’: No such file or directory
+ CHECK_RESULT 1 0 0 'check /init file right fail'
+ actual_result=1
```



##### oe_test_check_file_sys_protect_005:设置默认权限错误

log内对应报错如下

```
++ umask
+ umaskValue=0022
+ test 0022 == 0077
+ CHECK_RESULT 1 0 0 'check umask default value fail'
+ actual_result=1
+ expect_result=0
......
+ grep '[umaskUMASK][[:space:]]\+077'
+ grep -iE '^\s*umask\s+' /etc/profile
+ CHECK_RESULT 1 0 0 'check /etc/profile set umask value fail'
+ actual_result=1
+ expect_result=0
```



##### oe_test_check_network_firewall_002:版本更新测试套没有跟上

log内对应报错如下

```
+ check_version 1 net.ipv4.conf.all.accept_redirects
+ grep -q 22.03
+ grep VERSION_ID /etc/os-release
+ '[' 1 -eq 0 ']'
+ CHECK_RESULT 1 0 0 'check net.ipv4.conf.all.accept_redirects set fail'
+ actual_result=1
```

测试使用的版本为23.03而测试套检测的是22.03版本