import os
import csv
from pathlib import Path

filename ='./failureCause.csv'

if __name__ == "__main__":
    with open("failureCause All Fail.csv","w",encoding="UTF-8",newline="")as f:
        csv_writer = csv.writer(f)
        with open(filename,"r",encoding="UTF-8") as csvfile:
            csvreader = csv.reader(csvfile)
            csv_writer.writerow(next(csvreader))
            testname =''
            tick = 0
            for row in csvreader:
                if(row[0] != ''):
                    testname = row[0]
                    tick =1
                if(row[3] == 'RC5fail'):
                      if(tick == 1):
                          row[0] = testname
                          tick = 0
                      csv_writer.writerow(row)  
        print("end")
        f.close()