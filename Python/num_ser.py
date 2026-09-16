import math
def fib(n):
	c=2
	n1=0
	n2=1
	while(c<n):
		num=n1+n2
		n1=n2
		n2=num
		c+=1;
	return(num)

def tri(n):
	return((n*(n+1))/2)

def squ(n):
	return(n**2)

def lcn(n):
	return((n**2+n+2)/2)

def fact(n):
	return(math.factorial(n))

def msn(n):
	return((n*(n**2+1))/2)

x=int(input("Enter the index "))
x1=fib(x)
x2=tri(x)
x3=squ(x)
x4=lcn(x)
x5=fact(x)
x6=msn(x)
print(math.log10(x1))
print(math.log10(x2))
print(math.log10(x3))
print(math.log10(x4))
print(math.log10(x5))
print(math.log10(x6))
