x=int(input("Enter the dimension of the square matrix : "))
print("Enter the values of the matrix")
l=list()
for i in range(x):
	lr=list()
	print("Row "+str(i+1))
	for j in range(x):
		k=int(input())
		lr.append(k)
	l.append(lr)
print("Your matrix is ")
for i in l:
	print(i)
ev=list()
ev.append(1)
for i in range(x-1):
	ev.append(0)
c=0
while(c<1000):
	evtemp=list()
	for i in range(x):
		s=0
		for j in range(x):
			s+=l[i][j]*ev[j]
		evtemp.append(s)
	ev=evtemp
	h=min(ev)
	for y in range(len(ev)):
		ev[y]/=h
	c+=1
print("\nEigen vector is :")
print(ev)
