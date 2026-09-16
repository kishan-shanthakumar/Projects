a.out : array_client.o array_impl.o
	gcc array_client.o array_impl.o

array_client.o : array_client.c array.h
		 gcc -c array_client.c

array_impl.o : array_impl.c array.h
	       gcc -c array_impl.c	       

