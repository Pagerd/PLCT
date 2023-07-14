# 工作报告

- 将rest2剩余的失败原因进行了分析

- 将rest2中的失败原因分析提交至主仓库 [pr](https://github.com/KotorinMinami/res_list/pull/11)

- 将目前主仓库中的结果进行了一些筛选

  - 所有baseos的测试用例 [BaseOS](https://github.com/Pagerd/PLCT/blob/main/Report/week/week4/baseos.csv)
  - baseos中的success测试用例 [Success](https://github.com/Pagerd/PLCT/blob/main/Report/week/week4/success.csv)
  - baseos中的fail测试用例[fail](https://github.com/Pagerd/PLCT/blob/main/Report/week/week4/fail.csv)
  - baseos中的x86fail测试用例[x86fail](https://github.com/Pagerd/PLCT/blob/main/Report/week/week4/x86fail.csv)

- 整理并编写出mugen baseos的测试结果文档[report](https://github.com/Pagerd/PLCT/blob/main/2303Mugen/2303Mugen.md)

- 将之前的详细分析以测试用例为单位进行编排并添加进总文档 [RISCVfail](https://github.com/Pagerd/PLCT/blob/main/2303Mugen/RISCVfail/) [x86fail](https://github.com/Pagerd/PLCT/blob/main/2303Mugen/x86Fail/)

  

# 错误分析:

### embedded_os_basic_extra_test

##### oe_test_acl_verwrite_previous_rules:缺少文件'/usr/bin/less.less'

对应报错log如下:

```
+ setcap cap_dac_override=eip /usr/bin/less.less
Failed to set capabilities on file '/usr/bin/less.less': No such file or directory
+ CHECK_RESULT 1 0 0 'Failed to set cap'
+ actual_result=1
+ expect_result=0
```



##### oe_test_acl_send_kill_notbelong:缺少文件'/bin/kill.procps'

对应报错log如下:

```
+ setcap cap_kill=eip /bin/kill.procps
Failed to set capabilities on file '/bin/kill.procps': No such file or directory
+ CHECK_RESULT 1
+ actual_result=1
```



#####   oe_test_acl_allow_change_nochange:缺少文件'/bin/chattr.e2fsprogs'

对应报错log如下:

```
+ setcap cap_linux_immutable=eip /bin/chattr.e2fsprogs
Failed to set capabilities on file '/bin/chattr.e2fsprogs': No such file or directory
```

##### oe_test_acl_ignore_dal_across:缺少文件'/usr/bin/less.less'

对应报错log如下:

```
+ grep cap_dac_override.eip
/usr/bin/less.less (No such file or directory)
```

##### oe_test_acl_manage_net:文件系统设置不正确

对应log如下：

```
+ su - example -c '/sbin/ifconfig lo:1 192.168.1.1 netmask 255.255.255.0'
SIOCSIFADDR: Operation not permitted
SIOCSIFFLAGS: Operation not permitted
SIOCSIFNETMASK: Operation not permitted
```

##### oe_test_acl_allow_change_ownership:操作无法执行

对应log如下：

```
+ su - example -c 'chown example:example /tmp/test'
chown: changing ownership of '/tmp/test': Operation not permitted
```

##### oe_test_acl_ordinary_users_setgid:缺少文件'/bin/chattr.e2fsprogs'

```
+ setcap cap_linux_immutable=eip /bin/chattr.e2fsprogs
Failed to set capabilities on file '/bin/chattr.e2fsprogs': No such file or directory
```

