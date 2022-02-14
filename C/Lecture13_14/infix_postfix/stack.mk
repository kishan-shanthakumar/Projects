a.out : infix_postfix_client.o infix_postfix_impl.o stack_impl.o
	gcc infix_postfix_client.o infix_postfix_impl.o stack_impl.o

infix_postfix_client.o : infix_postfix_client.c stack.h
		 gcc -c infix_postfix_client.c

stack_impl.o : stack_impl.c stack.h
	       gcc -c stack_impl.c

infix_postfix_impl.o : infix_postfix_impl.c stack.h
		gcc -c infix_postfix_impl.c
