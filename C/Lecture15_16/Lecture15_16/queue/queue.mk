a.out : queue_client.o queue_impl.o
	gcc queue_client.o queue_impl.o

queue_client.o : queue_client.c queue.h
		 gcc -c queue_client.c

queue_impl.o : queue_impl.c queue.h
	       gcc -c queue_impl.c
