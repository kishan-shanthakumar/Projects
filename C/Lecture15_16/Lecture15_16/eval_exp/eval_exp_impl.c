#include<stdio.h>
#include<stdlib.h>
#include"stack.h"

int eval_Postfix(char* postfix)
{
	stack_t s;
	initialize_Stack(&s);
	char ch = *postfix;
	while(ch != '\0')
	{
		if(ch >= '0' && ch <= '9')
		{
			push(&s, ch - '0');
		}
		else if(ch == '+' || ch == '-' || ch == '*' || ch == '/')
		{
			int a = pop(&s);	
			int b = pop(&s);	
			switch(ch)
			{
				case '+': push(&s, a + b);
						  break;
				case '-': push(&s, b - a);
						  break;
				case '*': push(&s, a * b);
						  break;
				case '/': push(&s, b / a);
						  break;
				default: exit(0);
			}
		}
		ch = *++postfix;
	}
	//int a = pop(&s);
	return pop(&s);
}
