#include"queue.h"
#include<stdio.h>

void initialize_Queue(Q* queue)
{
	queue -> front = 0;
	queue -> rear = -1;
}

int isFull(Q* queue)
{
	if(queue -> rear == MAX - 1)
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
		queue -> q[++queue -> rear] = data;
	}
	
}

int isEmpty(Q* queue)
{
	if(queue -> front > queue -> rear)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}


int dequeue(Q* queue)
{
	if(isEmpty(queue))
	{
		return -1;
	}
	else
	{
		return queue -> q[queue -> front++];
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
		for(int i = queue -> front; i <= queue -> rear; ++i)
		{
			printf("%d\t", queue -> q[i]);
		}
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
		return queue -> q[queue -> front];
	}
}
