a.out : exp_Tree_client.o exp_Tree_server.o
	gcc exp_Tree_client.o exp_Tree_server.o

exp_Tree_client.o : exp_Tree_client.c exp_Tree.h
			gcc -c exp_Tree_client.c

exp_Tree_server.o : exp_Tree_server.c exp_Tree.h
			gcc -c exp_Tree_server.c
