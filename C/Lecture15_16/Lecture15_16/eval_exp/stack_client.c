#include <stdio.h>
#include "stack.h"

int main()
{
	stack_t s;
	initialize_Stack(&s);
	push(&s, 10);
	push(&s, 20);
	push(&s, 30);
	printf("%d\n", peep(&s));
	printf("%d\n", pop(&s));
	printf("%d\n", peep(&s));
	return 0;
}






