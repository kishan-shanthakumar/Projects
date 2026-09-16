

#include<stdio.h>
#include"heap.h"

int main()
{
	int n;
	int array[MAX];
	printf("Enter the number of elements\n");
	scanf("%d", &n);
	read_Array(array, n);
	display_Array(array, n);
	sort(array, n);
	display_Array(array, n);
}
