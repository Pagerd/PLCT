##  操作步骤

```
git clone https://gitee.com/thesamename/STREAM.git
cd STREAM
sudo dnf install -y gcc gfortran
sed -i "s/CC =.*/CC = gcc/" Makefile
sed -i "s/FC =.*/FC = gfortran/" Makefile
make
./stream_c.exe
```

##  测试结果

测试通过。测试结果详见本目录下的日志文件。

