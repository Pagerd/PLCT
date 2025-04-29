import os
import csv
from pathlib import Path
import re  # Python 正则模块，用于匹配和替换操作&#8203;:contentReference[oaicite:5]{index=5}


filename ='./fmadd.d_b1-01.S'
filename2 = "./sfmadd.d_b1-01.S"
filename3 = './test0.S'
filename4 = './test2.S'

start = ""
o = 0


def replace_f_with_x(s: str) -> str:
    """
    将字符串 s 中所有“后面必须跟 1~2 位数字且不再有第三位数字”的 f
    替换为 x，返回替换后的新字符串。
    """
    # 模式解释：
    #  f             匹配字符 'f'
    #  (?=           正前瞻，断言后面…
    #     \d{1,2}    …紧跟 1 至 2 位数字
    #     (?!\d)     …且这 1~2 位数字之后不是数字
    #  )             零宽，不消费字符
    pattern = r"f(?=\d{1,2}(?!\d))"
    return re.sub(pattern, "x", s)  # 替换所有匹配到的 f 为 x&#8203;:contentReference[oaicite:6]{index=6}


def sov():
    with open(filename, 'r', encoding='utf-8') as file:
        with open(filename2, 'w', encoding='utf-8') as file2:
            for line_number, line in enumerate(file, 1):
                cleaned_line = line.rstrip('\n')
                if (cleaned_line != ''):
                    b = replace_f_with_x(cleaned_line)
                    file2.write(b)
        file2.close()      
                        
if __name__ == "__main__":
        sov()
