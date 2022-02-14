print("Enter first number")
num1,n1=input().split('.')
print("Enter second number")
num2,n2=input().split('.')
number1=''
number2=''
if(len(n2)>len(n1)):
    while(len(n2)>len(n1)):
        n1+='0'
    number1=num1+n1
    number2=num2+n2
elif(len(n1)>len(n2)):
    while(len(n1)>len(n2)):
        n2+='0'
    number1=num1+n1
    number2=num2+n2
else:
    number1=num1+n1
    number2=num2+n2
dec=len(n1)
ans=str(int(number1)+int(number2))
ans=list(ans)
print('\n\nSum = ',end='')
ans.insert(-dec,'.')
for i in ans:
    print(i,end='')
while(True):
    pass
