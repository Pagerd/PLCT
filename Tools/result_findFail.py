import os
import csv
from pathlib import Path

filename ='./failureCause_new.csv'
fileFname ='./failureCause_old.csv'
if __name__ == "__main__":
    with open(filename,"r",encoding="UTF-8") as csvfile:
        csvreader = csv.reader(csvfile)
        with open(fileFname,"r",encoding="UTF-8") as csvfile1:
            csvreader1 = csv.reader(csvfile1)
            csv_head=list(next(csvreader1))
            with open("failureCause_newold.csv","w",encoding="UTF-8",newline="")as f:
                csv_writer = csv.writer(f)
                next(csvreader)
                csv_writer.writerow(csv_head)
                lister = list(csvreader)
                lister1 = list(csvreader1)
                lister2 = []
                lister3 = []
                isFind = False
                bls =1
                name = ''
                for row in range(0,len(lister)):
                    isFind = False
                    if(lister[row][0] != ""):
                        name = lister[row][0]
                        bls = 0
                    for row1 in range(0,len(lister1)):
                        
                        if(lister1[row1][1] == lister[row][1]):
                            isFind = True

                            print("find:"+lister1[row1][1])
                            if(lister1[row1][2] != lister[row][2]):
                                if(lister[row][2] == 'fail'):
                                    if(bls == 0):
                                        lister[row][0] = name
                                        bls =1
                                    lister2.append(lister[row])
                    if(isFind != True and lister[row][2] == 'fail'):
                        lister[row][2] ="new" + lister[row][2] 
                        lister3.append(lister[row])
                for row in range(0,len(lister2)):
                    csv_writer.writerow(lister2[row])             
                print("end")
                f.close()
            with open("failureCause_newfailold.csv","w",encoding="UTF-8",newline="")as g:
                csv_writer = csv.writer(g)
                csv_writer.writerow(csv_head)
                for row in range(0,len(lister3)):
                    csv_writer.writerow(lister3[row])  
                print("end")
                g.close()
                
