from math import *
import sys
sys.setrecursionlimit(1000000000)

d = dict()

def ack(m,n):
	global d
	if m==0:
		return n+1
	elif n==0:
		if (m,n) in d:
			return d[m,n]
		else:
			d[m,n] = ack(m-1,1)
			return d[m,n]
		
	else:
		if (m,n) in d:
			return d[m,n]
		else:
			if (m,n-1) not in d:
				d[m,n-1] = ack(m,n-1)
			d[m,n] = ack(m-1,d[m,n-1])
			return d[m,n]
		

m = int(input("Enter m "))
n = int(input("Enter n "))
x = ack(m,n)
if x>10**100:
	print(log10(x))
else:
	print(x)
