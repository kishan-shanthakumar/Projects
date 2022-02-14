from matplotlib import pyplot as plt

li1 = list()
li2 = list()
li1.append(1)
li2.append(0)
for i in range(2,10):
	temp = i
	li1.append(i)
	c = 0
	while temp>1:
		if temp%2==0:
			temp = temp/2
		else:
			temp = temp*3 + 1
		c = c + 1
	li2.append(c)
plt.plot(li1,li2)
plt.show()
