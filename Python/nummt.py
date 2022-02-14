import _thread
from math import *
import time

def findnum(ans,x):
	fp=list()
	for i in range(1,int(sqrt(ans))):
		l=list()
		if(ans%i==0):
			l.append(i),
			l.append(int(ans/i))
			fp.append(l)
	for i in fp:
		for j in range(i[0]+1):
			if (j**2-j*(i[0]-j)+(i[0]-j)**2)==i[1]:
				print("\n",x,j,i[0]-j,"\n")
				print(time.time()-ts)
				exit()

def cubenum(st,a,num,thread):
	#print(st)
	n=10**20
	for i in range(int(n*(a-1)/thread),int(n*a/thread)):
		x=(i**3)
		ans1=fabs(num-x)
		ans2=fabs(num+x)
		findnum(ans1,i)
		findnum(ans2,i)
	#print("Done",a)
number=20
numthr=8
ts=time.time()
try:
    for i in range(1,numthr+1):
       _thread.start_new_thread( cubenum, (("Thread-"+str(i)), i, number, numthr,) )
except:
   print ("Error: unable to start thread")
while(1==1):
	pass
