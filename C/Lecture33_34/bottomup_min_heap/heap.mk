a.out : heap_client.o heap_impl.o
	gcc heap_client.o heap_impl.o


heap_client.o : heap_client.c heap.h
		gcc -c heap_client.c

heap_impl.o : heap_impl.c heap.h
		gcc -c heap_impl.c
