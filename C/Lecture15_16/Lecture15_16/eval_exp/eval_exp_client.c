#include<stdio.h>
#include"stack.h"

int eval_Postfix(char* postfix);

int main()
{
	char postfix[20];
	printf("Enter the postfix expression\n");
	gets(postfix);
	printf("%d\n",eval_Postfix(postfix));
	return 0;
}
