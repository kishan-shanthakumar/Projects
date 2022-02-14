a.out : stack_client.o stack_impl.o
	gcc stack_client.o stack_impl.o

stack_client.o : stack_client.c stack.h
		 gcc -c stack_client.c

stack_impl.o : stack_impl.c stack.h
	       gcc -c stack_impl.c
