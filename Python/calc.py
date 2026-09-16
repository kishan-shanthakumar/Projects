ch=int(input("Enter choice "))

if(ch):
	inp = float(input("Enter "))

	print( ((7.38+7.04+7.13+inp)*24+(7.36+8.18)*22+60+160)/(24*4+44+6+16) )
else:
	inp = float(input("Enter "))
	
	print( ((7.38+7.04+7.13+inp)*24+(7.36+8.18)*22+60)/(24*4+44+6) )
