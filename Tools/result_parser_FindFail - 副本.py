import os
import csv
from pathlib import Path

filename ='./fsub_b11-01.S'
filename2 = ""
filename3 = './test0.S'
filename4 = './test2.S'

start = ""
o = 0




def sov():
    x1 = 0 + (1534*o)
    y1 = 0 + (4606*o)
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
                    if (cleaned_line[0] == 'i'):
                        if(x >= x1):
                            y=0
                        x = x+1
                    if (len(cleaned_line) > 7):
                        if(cleaned_line[7] == 'S'):
                            if(x >= x1):
                                row.append(cleaned_line)
                                print(cleaned_line)
                    if(y > 4):
                        y = -1
                        row.append(cleaned_line)
                        array.append(row)
                        row = []
                        #print(x)
                        if(x >= (x1+726)):
                            z = -1
                    if (y > -1):
                        row.append(cleaned_line)
                        y = y+1
                if (z == -1):
                    if (cleaned_line[0] == 'N'):
                        if(a >= y1):
                            scase.append(cleaned_line)
                        a = a+1
                        #print(a)
                        if(a > (y1+2303)):
                            z = -2
    #print(array[1][1])
    print(scase)
    with open(filename2, 'w', encoding='utf-8') as file2:
        with open(filename4, 'r', encoding='utf-8') as file3:
            lines = file3.readlines()
            for gj in lines:
                s = ""
                s = gj
                file2.write(s)
        for ii in array:
            for bb in ii:
                file2.write(bb)
                file2.write("\n")
            file2.write("\n")
        file2.write("#endif\n")
        file2.write("RVTEST_CODE_END\n")
        file2.write("RVMODEL_HALT\n")
        file2.write("RVTEST_DATA_BEGIN\n")
        file2.write(".align 4\n")
        file2.write("rvtest_data:\n")
        file2.write(".word 0xbabecafe\n")
        file2.write(".word 0xabecafeb\n")
        file2.write(".word 0xbecafeba\n")
        file2.write(".word 0xecafebab\n")
        file2.write("test_dataset_0:\n")
        for yo in scase:
            file2.write(yo)
            file2.write("\n")
        with open(filename3, 'r', encoding='utf-8') as file3:
            lines = file3.readlines()
            for gj in lines:
                s = ""
                s = gj
                file2.write(s)
        
    file2.close()
        
                        
if __name__ == "__main__":
    for i in range(10):
        o = i
        print(o)
        if(o >9):
            if(o >= 100):
                filename2 = "./fsub_b11-"+str(i+1)+".S"
            else:
                filename2 = "./fsub_b11-0"+str(i+1)+".S"
        else:
            filename2 = "./fsub_b11-00"+str(i+1)+".S"
        sov()
