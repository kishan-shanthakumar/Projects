import pyopencl as cl
import numpy as np

for i in range(1,10**12):
    a_np = np.arange(1,10**8,1)

    for j in a_np:
        for k in range(1,j):
            for l in range(1,k):
                file=open('D:\Python\cubes.txt','a')
                file.write(str(j**3+k**3+l**3)+'='+str(j)+'+'+str(k)+'+'+str(l)+'\n')
                file.write(str(j**3-k**3-l**3)+'='+str(j)+'-'+str(k)+'-'+str(l)+'\n')
                file.write(str(j**3+k**3-l**3)+'='+str(j)+'+'+str(k)+'-'+str(l)+'\n')
                file.write(str(j**3-k**3+l**3)+'='+str(j)+'-'+str(k)+'+'+str(l)+'\n')
                file.close()
