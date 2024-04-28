##  操作步骤

1.安装 `fio`：`apt install -y fio`

2.创建 `fio.sh` 测试脚本，执行：

```
cat << 'EOF' > fio.sh
#!/bin/bash
numjobs=10
iodepth=10
mkdir test
for rw in read write randread randwrite randrw;do
for bs in 4 16 32 64 128 256 512 1024;do
if [ $rw == "randrw" ];then
fio -filename=test/fio -direct=1 -iodepth ${iodepth} -thread -rw=$rw -rwmixread=70 -ioengine=libaio -bs=${bs}k -size=1G -numjobs=${numjobs} -runtime=30 -group_reporting -name=job1
else
fio -filename=test/fio -direct=1 -iodepth ${iodepth} -thread -rw=$rw -ioengine=libaio -bs=${bs}k -size=1G -numjobs=${numjobs} -runtime=30 -group_reportin -name=job1
fi
sleep 30
done
done
EOF
```

3.运行 `fio.sh`：`bash fio.sh`



##  测试结果

测试通过，测试结果详见本目录下的日志文件。

