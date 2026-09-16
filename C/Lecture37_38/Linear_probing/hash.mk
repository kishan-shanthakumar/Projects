a.out : hash_client.o hash_impl.o
	gcc hash_client.o hash_impl.o

hash_client.o : hash_client.c hash.h
		gcc -c hash_client.c

hash_impl.o : hash_impl.c hash.h
		gcc -c hash_impl.c
