import _thread
from math import *
import numpy as np

def findnum(ans,x):
	fp=list()
	if ans%2==0:
		j=1
	else:
		j=2
	for i in range(1,int(sqrt(ans)),j):
		l=list()
		if(ans%i==0):
			l.append(i),
			l.append(int(ans/i))
			fp.append(l)
	for i in fp:
		for j in range(i[0]+1):
			if (j**2-j*(i[0]-j)+(i[0]-j)**2)==i[1]:
				print("\n",x,j,i[0]-j,"\n")
				return

def cubenum(a):
	n=10**19
	num=2
	for i in range(int((a-1)),int(a)):
		x=(i**3)
		ans1=fabs(num-x)
		ans2=fabs(num+x)
		findnum(ans1,i)
		findnum(ans2,i)

#func=np.vectorize(cubenum)
for i in range(10**12):
    #a=np.arange(i*8,(i+1)*8,1)
    #func(a)
    cubenum(i)
    #print("Done")
