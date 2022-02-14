int has_even_parity(unsigned int x){
    unsigned int count = 0, i, b = 1;

    for(i = 0; i < 32; i++){
        if( x & (b << i) ){count++;}
    }

    if( (count % 2) ){return 0;}

    return 1;
}

void bit32alu(unsigned int a, unsigned int b, unsigned int c, unsigned int *acc, unsigned int *mulh, unsigned int *flag)
{
	switch(c)
	{
		case 0: *acc = 0;
				break;
		case 1: *acc = 4294967295;
				break;
		case 2: *acc = a & b;
				break;
		case 3: *acc = a | b;
				break;
		case 4: *acc = !a;
				break;
		case 5: *acc = a + 1;
				break;
		case 6: *acc = a << 1;
				break;
		case 7: *acc = a - 1;
				break;
		case 8: *acc = a >> 1;
				break;
		case 9: *acc = a + b;
				break;
		case 10: *acc = a - b;
				break;
		case 11: *acc = a;
				break;
		case 12: *acc = ( a << 1 ) + a[31];
				break;
		case 13: *acc = a[0]*4294967296 + ( a >> 1 );
				break;
		case 14: *acc = (a * b) % 4294967296;
				*mulh = (a * b) / 4294967296;
				break;
		case 15: *acc = ( a > b )? 2 : ( a < b )? 4 : 1;
				break;
	}
	*flag = (a + 1)/4294967296 + (a * 2147483648) * 2 + ((a<1)?1:0) * 4 + (a % 2) * 8 + ((a + b)/4294967296) * 16 + ((a<b)?1:0) * 32 + ((*acc==0)?1:0) * 64 + has_even_parity(*acc) * 128;
}
