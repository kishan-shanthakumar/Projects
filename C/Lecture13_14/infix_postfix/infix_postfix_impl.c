#include<stdio.h>
#include"stack.h"

int precedance(char ch)
{
    if(ch == '(')
	{
        return 0;
	}
    else if(ch == '+' || ch == '-')
	{
        return 1;
	}
    if(ch == '*' || ch == '/')
	{
        return 2;
	}
}


void infix_To_Postfix(char* infix)
{
	stack_t s;
	initialize_Stack(&s);
	char postfix[20];
	int p = 0;
    char ch = *infix;
    while(ch != '\0')
    {
        if(isalnum(ch))
		{	
            postfix[p++] = ch;
		}
        else if(ch == '(')
		{
            push(&s, ch);
		}
        else if(ch == ')')
        {
			char c;
            while((c = pop(&s)) != '(')
			{
				postfix[p++] = c;	
			}    
        }
        else
        {
            while(precedance(peep(&s)) >= precedance(ch))
			{
				postfix[p++] = pop(&s);
			}       
            push(&s, ch);
        }
        ch = *++infix;	
    }

    while(s.sp != 0)
    {
		postfix[p++] = pop(&s);
    }
	postfix[p] = '\0';
	printf("\nThe postfix expression is: %s\n",postfix);
}
