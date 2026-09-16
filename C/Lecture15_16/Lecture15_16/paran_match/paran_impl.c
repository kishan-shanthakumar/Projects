#include"stack.h"

int parantheses_Matching(char* input)
{
	stack_t s;
	initialize_Stack(&s);

	char ch = *input;
	char x;
	while(ch != '\0')
	{
		if(ch == '(' || ch == '[' || ch == '{')
		{
			push(&s, ch);
		}	
		else if(ch == ')')
		{
			if(isEmpty(&s))
			{
				return 0;		
			}
			else
			{
				x = pop(&s);
				if(x != '(')
				{
					return 0;
				}
			}	
		}
		else if(ch == ']')
		{
			if(isEmpty(&s))
			{
				return 0;		
			}
			else
			{
				x = pop(&s);
				if(x != '[')
				{
					return 0;
				}
			}
			
		}
		else if(ch == '}')
		{
			if(isEmpty(&s))
			{
				return 0;		
			}
			else
			{
				x = pop(&s);
				if(x != '{')
				{
					return 0;
				}
			}
			
		}
		ch = *++input;
	}
	if(isEmpty(&s))
	{
		return 1;		
	}
	else
	{
		return 0;
	}
}
