a.out : tree_client.o tree_impl.o
	gcc tree_client.o tree_impl.o

tree_client.o: tree_client.c tree.h
		gcc -c tree_client.c 

tree_impl.o: tree_impl.c tree.h
		gcc -c tree_impl.c
