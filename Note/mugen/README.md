# Mugen学习笔记

mugen为openEuler社区进行测试时使用的框架

## Mugen测试的开发

在进行mugen测试的开发时，要明确以下两个概念

- testsuite 测试套，主要包括一到多个测试用例，用于对应某个专门的测试程序
- testcase 测试用例，用于进行特定的测试任务而编写的一组测试方法

#### 测试套testsuite编写方法

每个测试套都在mugen主目录下的suite2cases里，每个测试套均为一个json文件,文件名为测试套名

```
{
      "path":""$OET_PATH/testcases/cli-test/testname," // 测试用例的目录 
               //$OET_PATH为mugen根目录
      "cases": [  //包含的测试用例
        {
            "name": "oe_test_01"                //测试用例的文件名
        },
        {
            "name": "oe_test_02"                //测试用例的文件名
        },
        {
            "name": "oe_test_03"                //测试用例的文件名
        }
    ]
}
```

#### 测试用例testcase编写方法

测试用例一般都保存在testcase文件夹下，不同的测试用例放在不同的子文件夹中

- clt-test
- doc-test
- embedded-test
- feature-test 特性测试
- security-test 安全测试
- smoke-test 冒烟测试
- system-test 系统功能测试
  - os basic
  - os storage
- testsuite示例

一个测试模板如下所示

```
source ${OET_PATH}/libs/locallibs/common_lib.sh

# 需要预加载的数据、参数配置
function config_params() {
    LOG_INFO "Start to config params of the case."

    LOG_INFO "No params need to config."

    LOG_INFO "End to config params of the case."
}

# 测试对象、测试需要的工具等安装准备
function pre_test() {
    LOG_INFO "Start to prepare the test environment."

    LOG_INFO "No pkgs need to install."

    LOG_INFO "End to prepare the test environment."
}

# 测试点的执行
function run_test() {
    LOG_INFO "Start to run test."

    # 测试命令：ls
    ls -CZl -all
    CHECK_RESULT 0

    # 测试/目录下是否存在proc|usr|roor|var|sys|etc|boot|dev目录
    CHECK_RESULT "$(ls / | grep -cE 'proc|usr|roor|var|sys|etc|boot|dev')" 7

    LOG_INFO "End to run test."
}

# 后置处理，恢复测试环境
function post_test() {
    LOG_INFO "Start to restore the test environment."

    LOG_INFO "Nothing to do."

    LOG_INFO "End to restore the test environment."
}

main "$@"
```

在测试用例开头的source命令是用来导入mugen库

随后根据需要编写文件中的四个函数

最后的 `main "$@"` 则是用来开始命令

#### 常用函数

mugen提供了一些公共的函数用于调用

##### 日志打印

- `LOG_INFO`    用于在测试过程中往日志输出信息
- `LOG_WARN ` 用于在测试过程中往日志输出警告信息
- `LOG_DEBUG` 用于在测试过程中往日志输出调试信息
- `LOG_ERROR ` 用于在测试过程中往日志输出错误信息

##### 结果检查

```
CHECK_RESULT $1 $2 $3 $4 $5
```

- $1:测试点的返回结果
- $2:对于该测试点的预期结果
- $3:对比预期与实际结果模式及 0:返回结果相等 1:返回结果不等
- $4:在发现问题后将$4输出到日志
- $5:设置返回模式 0：发现问题后继续执行 1：发现问题后中断并退出

##### 安装与卸载rpm包

```
DNF_INSTALL "vim bc"  //安装vim bc rpm包
DNF_REMOVE "jq"       //卸载jq rpm包
```

注：`DNF_REMOVE`会自动记录`DNF_INSTALL`安装的软件，因此在使用`DNF_REMOVE`时可以忽略rpm包名

## 使用mugen进行本地测试

#### 下载mugen

使用Git克隆mugen的repo

```
#git clone https://gitee.com/src-oerv/mugen
```

####  安装必要依赖

进入mugen根目录

```
cd mugen
```

安装依赖

```
sudo bash dep_install.sh
```

#### 配置mugen节点

```
bash mugen.sh -c --ip $ip --password $passwd --user $user --port $port
```

- ip:测试机的ip地址，由于使用本机作为被测虚拟机，因此可将ip设置为127.0.0.1
- passwd:测试机的密码，可填为openEuler12#$
- user:测试机的用户，默认为root
- port:测试机的SSH端口，默认为22

#### 进行测试

当配置完成后，便可在mugen主目录进行测试

执行所有用例 `bash mugen.sh -a`

执行指定测试套 `bash mugen.sh -f testsuite`

执行单条用例 `bash mugen.sh -f testsuite -r testcase`

## 调用QEMU进行虚拟机测试

mugen提供了一个可以通过调用QEMU来进行虚拟机测试的脚本`qemu_test.py`

要调用QEMU进行虚拟机测试，需要在物理机上使用脚本

#### 物理机配置

物理机不一定需要openEuler，常见的linux发行版均可

首先需要在物理机上使用Git克隆mugen的repo

```
git clone https://gitee.com/src-oerv/mugen
```

使用`qemu_test.py`需要python以及python库`paramiko`,因此需要物理机上拥有python环境以及python库`paramiko`,该python库可以使用pip命令进行安装也可以使用操作系统的包管理器安装

注意：在0331 23.03oE中，需要对`qemu_test.py`进行修改

- 编辑`qemu_test.py`，将第150行的append参数删除，并在上一行末添加引号

若不对此进行修改，在开启脚本后将只输出线程消息

#### 虚拟机配置

进行QEMU测试需要一个准备好的虚拟机镜像来进行测试

从软件源上下载以下文件

- 待测试的系统镜像(`.qcow2.zst`文件)
- 引导加载程序(`fw_payload_oe_uboot_*.bin`文件)
- 启动脚本(`start_*.sh`文件)

在下载完成后，需要使用zstd命令将系统镜像解压为`.qcow2.zst`文件，将以上所有文件保存在一个工作目录中

打开命令行，使用`bash start_*.sh`启动虚拟机，默认用户名为`root`,密码是`openEuler12#$`，登录完成后，需要克隆一份mugen在虚拟机内，使用Git克隆mugen的repo到虚拟机的一个目录(默认为/root/mugen,可自行更改)

```
#git clone https://gitee.com/src-oerv/mugen
```

随后参考本地安装的方法安装mugen的依赖和配置

安装完成后，可以根据具体需求再次对虚拟机进行一些修改

至此虚拟机配置已经完成，可以使用`poweroff`关闭虚拟机

#### 启动配置编写

退出虚拟机后进入物理机mugen目录，理论上已经可以启动`qemu_test.py`进行测试，但是为了方便以后继续测试，可以编写一个配置文件方便进行配置的更改

在mugen主目录下创建一个JSON文件，进行如下编写

```
{
    "workingDir":"../testdrive",           // 工作目录，为虚拟机镜像加载程序等路径
    "bios":"fw_payload_oe_uboot_2304.bin", // 引导加载程序的文件名
    "drive":"mugen_ready.qcow2",           // 准备好的虚拟机镜像的文件名
    "user":"root",                         // 虚拟机的用户名
    "password":"openEuler12#$",            // 虚拟机的密码
    "threads":4,                           // 测试线程数
    "cores":4,                             // 为虚拟机分配的核心数
    "memory":4,                            // 为虚拟机分配的内存容量，单位为 GB
    "mugenNative":1,                       // 是否使用虚拟机上的测试套
    "detailed":1,                          // 是否在屏幕上打印详细日志
    "addDisk":1,                           // 添加的磁盘数量
    "mugenDir":"/root/mugen",              // 在虚拟机中 mugen 所在的目录
    "listFile":"lists/list_test",          // 需要测试的测试套列表文件
    "generate":1                           // 是否将测试套保存到物理机上
}
```

在编写完成后，可以进入mugen里的list目录，将想要测试的测试套填在配置文件对应的文件里

##### 开始测试

在编写完配置文件后，便可以使用命令调用脚本进行测试

```
$python3 qemu_test.py -F xxx.json //xxx为配置文件
```

在运行后，脚本会不断的输出各线程的信息

```
Thread x is alive
```

此时可以通过查看进程以及cpu的占用情况来判断是否在运行

也可以前往工作目录，查看imgx.qcow2的文件大小来判断是否在运行

在脚本进行测试时，会概率抛出SSH相关的连接错误，属于正常运行

测试完成后，可以发现在工作目录下生成了几个文件夹，可以查看有关的信息：

- exec_log ：测试套在运行时产生的日志
- logs: 测试用例在运行时产生的日志
- logs_failed:所有失败的测试用例在运行时产生的日志
- suite2cases_out:所有被测试完成的测试套

## TO DO

- 检查并分析测试用例失败的原因
