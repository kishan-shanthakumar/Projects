import cv2
import numpy as np
import math
print("Enter a binary number")
str=input()
l=list()
for i in range(0,len(str)):
    l.append(int(str[i]))
img=cv2.imread("image.jpg")
for i in range(0,1079):
    for j in range(0,1919):
        img[i,j]=[0,0,0]
j=0
while(j<(1919-math.ceil(1919/len(str)))):
    for i in l:
        if i==1:
            for k in range(0,math.ceil(1919/len(str))):
                for z in range(500,510):
                    img[z,j]=[0,255,0]
                j+=1
        else:
            for k in range(0,math.ceil(1919/(len(str)))):
                for z in range(580,590):
                    img[z,j]=[0,255,0]
                j+=1
cv2.imwrite("image.jpg",img)
