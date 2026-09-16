#include<stdio.h>
#include"stack.h"

int parantheses_Matching(char* input);

int main()
{
	char input[20];
	printf("Enter the input\n");
	gets(input);
	if(parantheses_Matching(input))
	{
		printf("Valid\n");
	}
	else
	{
		printf("Invalid\n");
	}
	return 0;
}
