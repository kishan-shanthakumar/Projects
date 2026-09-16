a.out : bst_array_client.o bst_array_impl.o
	gcc bst_array_client.o bst_array_impl.o

bst_array_client.o : bst_array_client.c bst_array.h
			gcc -c bst_array_client.c

bst_array_impl.o : bst_array_impl.c bst_array.h
			gcc -c bst_array_impl.c
