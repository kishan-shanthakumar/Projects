a.out : double_hash_client.o double_hash_impl.o
	gcc double_hash_client.o double_hash_impl.o

double_hash_client.o : double_hash_client.c double_hash.h
			gcc -c double_hash_client.c

double_hash_impl.o : double_hash_impl.c double_hash.h
		     gcc -c double_hash_impl.c
