file = open('bit32alu.v','r')
lines = file.readlines()
ands = 0
ors = 0
nots = 0
nand = 0
nor = 0
xor = 0
xnor = 0

for i in lines:
	i = i.lower()
	if ( ('and' in i) and ('nand' not in i) ):
		ands += 1
	elif( 'nand' in i ):
		nand += 1
	elif( ('or' in i) and ('nor' not in i) and ('xnor' not in i) ):
		ors += 1
	elif( ('nor' in i) and ('xnor' not in i) ):
		nor += 1
	elif( 'xnor' in i ):
		xnor += 1
	elif( 'xor' in i ):
		xor += 1
	elif ( 'incv' in i ):
		nots += 1
	elif ( ('aoi' in i) or ('oai' in i) ):
		ands += 1
		ors += 1
		nots +=1
print(ands,ors,nots,nand,nor,xor,xnor)
print("The number of transistors is :", (ands + ors) * 6 + (nand + nor) * 4 + nots * 2 + (xor + xnor) *  8)
