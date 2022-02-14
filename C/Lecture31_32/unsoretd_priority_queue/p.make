a.out : p_client.o p_impl.o
	gcc p_client.o p_impl.o

p_client.o : p_client.c p.h
		gcc -c p_client.c

p_impl.o : p_impl.c p.h
		gcc -c p_impl.c
