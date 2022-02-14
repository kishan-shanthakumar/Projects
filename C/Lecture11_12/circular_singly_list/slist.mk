a.out : slist_client.o slist_impl.o
	gcc slist_client.o slist_impl.o

slist_client.o : slist_client.c slist.h
		 gcc -c slist_client.c

slist_impl.o : slist_impl.c slist.h
	       gcc -c slist_impl.c	       

