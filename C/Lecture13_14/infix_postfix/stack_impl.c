#include <stdio.h>
#include <stdlib.h>
#include "stack.h"


void initialize_Stack(stack_t* stk)
{
	stk -> sp = 0; 
}

int isFull(stack_t* stk)
{
	return stk -> sp == SIZE;
} 

void push(stack_t* stk, int data)
{
	if(isFull(stk))
	{
		printf("Full\n");
	}
	else
	{
		stk -> s[stk -> sp++] = data;
	}
}


int isEmpty(stack_t* stk)
{
	return stk -> sp == 0;
}

int pop(stack_t* stk)
{
	if(isEmpty(stk))
	{
		printf("Empty\n");
		return -1;
	}
	else
	{
		return stk -> s[--stk -> sp];
	}
}

int peep(stack_t* stk)
{
	if(isEmpty(stk))
	{
		return -1;
	}
	else
	{
		return stk -> s[stk -> sp - 1];
	}
}





