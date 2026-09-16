#include<stdio.h>
#include"exp_Tree.h"

int main()
{
	char postfix[100];
	printf("Enter the postfix expression\n");
	gets(postfix);
	node_t* root = create_Exp_Tree(postfix);
	inorder(root);
	printf("\n");
	printf("%d\n",evaluate_Exp_Tree(root));
	return 0;
}
