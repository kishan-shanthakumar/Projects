import math

print("1. Get capacitance value")
print("2. Get resistance value")
print("3. Get time value")
print("4. Get voltage value")
ch=int(input())

v0=float(input("Enter source voltage :"))

if(ch==1):
	r = float( input( "Enter Resistance :"))
	t = float( input( "Enter Time :"))
	v = float( input( "Voltage values :"))
	c = -t/(math.log(1-v/v0) * r)
	print("Capacitance :",c)

if(ch==2):
	c = float( input( "Enter Capacitance :"))
	t = float( input( "Enter Time :"))
	v = float( input( "Voltage values :"))
	r = -t/(math.log(1-v/v0) * c)
	print("Resistance :",r)

if(ch==3):
	r = float( input( "Enter Resistance :"))
	c = float( input( "Enter Capacitance :"))
	v = float( input( "Voltage values :"))
	t = -math.log(1-v/v0)*r*c
	print("Time :",t)

if(ch==4):
	r = float( input( "Enter Resistance :"))
	c = float( input( "Enter Capacitance :"))
	t = float( input( "Enter Time :"))
	v = v0*(1-math.exp(-t/(r*c)))
	print("Voltage :",v)
