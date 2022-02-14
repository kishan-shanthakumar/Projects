#include"queue.h"
#include<stdio.h>

void initialize_Queue(Q* queue)
{
	queue -> front = MAX - 1;
	queue -> rear = MAX - 1;
}

int isFull(Q* queue)
{
	if((queue -> rear + 1) % MAX  == queue -> front)
	{
		return 1;
	}
	else 
	{
		return 0;
	}
}
void enqueue(Q* queue, int data)
{
	if(isFull(queue))
	{
		printf("Queue is full, cannot enqueue\n");
	}
	else
	{
		queue -> rear = (queue -> rear + 1) % MAX;
		queue -> q[queue -> rear] = data;
	}
	
}

int isEmpty(Q* queue)
{
	if(queue -> front == queue -> rear)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}


void dequeue(Q* queue)
{
	if(isEmpty(queue))
	{
		printf("Empty\n");
	}
	else
	{
		queue -> front = (queue -> front + 1) % MAX;
		printf("%d\n", queue -> q[queue -> front]);
		
	}


}
void display(Q* queue)
{
	if(isEmpty(queue))
	{
		printf("Empty queue, cannot display\n");
	}
	else
	{
		int i = queue -> front;
		while(i != queue -> rear)
		{
			i = (i + 1) % MAX;
			printf("%d\n", queue -> q[i]);
		}
		/*for(int i = queue -> front; i <= queue -> rear; ++i)
		{
			printf("%d\t", queue -> q[i]);
		}*/
		printf("\n");
	}
}


int front(Q* queue)
{
	if(isEmpty(queue))
	{
		return -1;
	}
	else
	{
		return queue -> q[(queue -> front + 1) % MAX];
	}
}
