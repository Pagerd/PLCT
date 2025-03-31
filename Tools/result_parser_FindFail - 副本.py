import os
import csv
from pathlib import Path

filename ='./fmadd_b15-01.S'

start = ""

if __name__ == "__main__":
    array = []
    scase = []
    row = []
    with open(filename, 'r', encoding='utf-8') as file:
        x = 0
        y = -1
        z = 0
        a = 0
        # 逐行读取并处理
        for line_number, line in enumerate(file, 1):
            # 去除行尾换行符（可选）
            cleaned_line = line.rstrip('\n')
             # 在这里处理每一行内容，例如：
            if (cleaned_line != ''):
                if(z == 0):
                    if (len(cleaned_line) > 7):
                        if(cleaned_line[7] == 'S'):
                            if(x != 0):
                                row.append(cleaned_line)
                            print(cleaned_line)
                    if (cleaned_line[0] == 'i'):
                        y=0
                        x = x+1
                    if(y > 4):
                        y = -1
                        array.append(row)
                        row = []
                        #print(x)
                        if(x == 767):
                            z = -1
                    if (y > -1):
                        row.append(cleaned_line)
                        y = y+1
                if (z == -1):
                    if (cleaned_line[0] == 'i'):
                        scase.append(cleaned_line)
                        a = a+1
                        #print(a)
                        if(a > 2302):
                            z = -2
    print(array)
    print(scase)
                        

