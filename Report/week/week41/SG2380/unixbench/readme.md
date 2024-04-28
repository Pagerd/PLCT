## 前置条件：

Windows11、算能官网已登录、已进入SG2380通用云开发空间WEB终端

## 操作步骤:

git clone https://github.com/kdlucas/byte-unixbench
cd byte-unixbench/UnixBench
make -j$(nproc)
./Run -c $(nproc)
## 测试结果：

测试通过，测试结果详见本目录下的日志文件

