#include<stdio.h>
#include"array.h"
void insert(array_list* l, int data)
{
	if(l -> rear == VAL - 1)
	{
		printf("Insertion not possible\n");	
	}
	else
	{
		++l -> rear;
		l -> a[l -> rear] = data;
	}
}


void display(array_list* l)
{
	for(int i = 0; i <= l -> rear; ++i)
	{
		printf("%d\n", l -> a[i]);
	}
}


