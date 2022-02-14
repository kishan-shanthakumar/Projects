a.out : priority_client.o priority_impl.o
	gcc priority_client.o priority_impl.o

priority_client.o : priority_client.c priority.h
			gcc -c priority_client.c

priority_impl.o : priority_impl.c priority.h
			gcc -c priority_impl.c 
