import numpy as np
from os import listdir, getcwd
from os.path import isfile, join
cwd=getcwd()
cwd+='/Books/'
onlyfiles = [f for f in listdir('./Books') if isfile(join('./Books', f))]
l=len(onlyfiles)
di=dict()

def tp(filename):
	f=open(cwd+filename,'r')
	l=f.readlines()
	l=str(l)
	l=l.upper()
	l=list(l)
	s=set(l)
	d={}
	for i in s:
		d[i]=l.count(i)
	return(d)

fun=np.vectorize(tp)
l=fun(onlyfiles)
for i in l:
	for j in i:
		if j in di:
			di[j]+=i[j]
		else:
			di[j]=i[j]
fin={k: v for k, v in sorted(di.items(), key=lambda item: item[1])}
for i in fin:
	print(i,fin[i])
