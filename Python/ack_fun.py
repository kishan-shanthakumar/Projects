from math import *
import sys
sys.setrecursionlimit(1000000)

def ack(m,n):
	if m==0:
		return n+1
	elif n==0:
		return ack(m-1,1)
	else:
		return ack(m-1,ack(m,n-1))

m = int(input("Enter m "))
n = int(input("Enter n "))
x = ack(m,n)
if x>10**100:
	print(log10(x))
else:
	print(x)
