


void initialize_Tree(tree_t* t)
{
	t -> root = NULL;
}

node_t* create_Node(int key)
{
	node_t* new = (node_t*)malloc(sizeof(node_t));
	new -> data = key;
	new -> left = NULL;
	new -> right = NULL;

	return new;
}

void insert(tree_t* t, int key)
{
	node_t* new = create_Node(key);
	if(t -> root == NULL)
	{
		t -> root = new;
	}
	else if(key < t -> root -> data)
	{
		insert(t -> root -> left, key);
	}
	else if(key > t -> root -> data)
	{
		insert(t -> root -> right, key);
	}
}


