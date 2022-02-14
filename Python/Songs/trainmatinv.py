import numpy as np
import pandas as pd

sd=pd.read_excel('Song_Dataset.xlsx')
sd.drop(['Name','Artist'],axis=1,inplace=True)
sdr=pd.Series(sd['Rating (10)'])
sd.drop(['Rating (10)'],axis=1,inplace=True)
sd=np.array(sd)
sdr=np.array(sdr)

a=np.linalg.pinv(sd)
theta=np.matmul(a,sdr)
print("Enter the song parameters")
par=list()
for i in range(11):
	x=int(input())
	par.append(x)
while not(par=='q'):
	par=list(par)
	print("Estimation =",np.matmul(theta,par))
	print('Enter q to exit')
	par=input("Enter the song parameters")
	for i in range(11):
		x=int(input())
		par.append(x)
