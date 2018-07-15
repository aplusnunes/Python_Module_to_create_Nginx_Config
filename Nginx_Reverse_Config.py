t = open('Sample_Config.txt', 'r')
tempstr = t.read()
t.close()

import csv
with open('Input_Dict.csv') as Inputs:
    Dict = dict(filter(None, csv.reader(Inputs)))

print(Dict)

for key,val in Dict.items():
    tempstr = tempstr.replace(key,val)

fout = open('output.txt', 'w')
fout.write(tempstr)
fout.close()
print (tempstr)
