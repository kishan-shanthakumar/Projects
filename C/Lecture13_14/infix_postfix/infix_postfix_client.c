#include<string.h>
#include<stdio.h>
#include"stack.h"
int main()
{       
	char infix[20]; 
	printf("Enter the infix expression\n");
	gets(infix);
	infix_To_Postfix(infix);                                       
	return 0;
}
