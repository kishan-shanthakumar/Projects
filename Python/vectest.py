import numpy as np
import time
import matplotlib.pyplot as plt
res=int(input("Enter resolution "))
fx=[]
fv=[]
t=[]
def vect(z):
	a=np.array(np.random.rand(z))
	b=np.array(np.random.rand(z))
	tic=time.time();
	c=np.dot(a,b)
	toc=time.time()
	return(1000*(toc-tic))

def fort(z):
	a=np.array(np.random.rand(z))
	b=np.array(np.random.rand(z))
	c=0
	tic=time.time();
	for i in range(len(a)):
		c += a[i]*b[i]
	toc=time.time()
	#print(c)
	#print("For loop version : "+str(1000*(toc-tic)))
	return(1000*(toc-tic))
fun1=np.vectorize(vect)
fun2=np.vectorize(fort)
t=list(range(1,res+1))
fv=fun1(t)
fx=fun2(t)
plt.plot(t,fx)
plt.plot(t,fv)
plt.show()
