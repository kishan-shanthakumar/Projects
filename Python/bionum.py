n=int(input("Enter the digits in the required autobiographical number : "))
flag=0
if n>3 and n<6:
	for i in range(((n-4)*10+2)*10**(n-2),10**n):
		s=[]
		for j in str(i):
			s.append(int(j))
		if (sum(s))==n:
			flag=1
			for k in range(n):
				if not(s[k]==s.count(k)):
					flag=0
					break
			if flag==1:
				break
if n<=3 or n==6:
	flag=0
if n>6 and n<14:
	j=[]
	for i in range(n):
		j.append(0)
	i=0
	j[0]=n-4
	j[1]=2
	j[2]=1
	j[n-4]=1	
	for k in j:
		i=i*10+k
	flag=1
if n>=14:
	flag=0
if flag==1:
	print(i)
else:
	print("Not found")
