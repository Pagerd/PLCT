import os
import csv
from pathlib import Path

folder_path ='D:/Work/ACT OTHER/acf/riscv-arch-test_1/riscv-test-suite/rv32i_m/F_Zfa/src'

if __name__ == "__main__":
    file_names = os.listdir(folder_path)
    # 遍历并打印文件名
    for name in file_names:
        print("| "+name+"  | F_Zfa       | [Github](https://github.com/riscv-non-isa/riscv-arch-test/blob/dev/riscv-test-suite/rv32i_m/D/src/) |")
