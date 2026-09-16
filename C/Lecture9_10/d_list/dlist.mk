a.out : dlist_client.o dlist_impl.o
	gcc dlist_client.o dlist_impl.o

dlist_client.o : dlist_client.c dlist.h
		 gcc -c dlist_client.c

dlist_impl.o : dlist_impl.c dlist.h
	       gcc -c dlist_impl.c	       

