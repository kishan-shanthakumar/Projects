#include <stdio.h>

void seq_det(){

	int IDLE = 0;
	int S1 = 1;
	int S2 = 2;
	int S3 = 3;
	int S4 = 4;
	int S5 = 5;
	int curr_state=IDLE;
	int seq[] = {1,0,1,1,0,1,1,1,0,0,1,0,1,1,0,1,0,1,1,0,0,0};

	for (int i=0; i<(sizeof(seq)/sizeof(int)); i++){
		printf("%d %d \n", curr_state, seq[i]);
		switch(curr_state)
		{
			case 0:
			{if (seq[i])
				curr_state=S1;
			else
				curr_state=IDLE;
			break;
			}
			case 1:
			{if (seq[i])
				curr_state=IDLE;
			else
				curr_state=S2;
			break;
			}
			case 2:
			{if (seq[i])
				curr_state=S3;
			else
				curr_state=IDLE;
			break;
			}
			case 3:
			{if (seq[i])
				curr_state=S4;
			else
				curr_state=IDLE;
			break;
			}
			case 4:
			{if (seq[i])
				curr_state=IDLE;
			else
			{curr_state=S5;
				printf("Sequence 10110 detected\n");
				curr_state=IDLE;
			}
			break;
			}
		}
	}
}
