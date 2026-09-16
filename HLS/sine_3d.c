#include <math.h>


void sine_3d(int x, double* outp)
{
	double z = x;
	int a = 0;
	for(int i = a; i < 12; i++)
	{
		//#pragma HLS unroll
		for(int j = a; j < 12; j++)
		{
			//#pragma HLS unroll
			for(int k = a; k < 12; k++)
			{
				#pragma HLS unroll
				for(int l = a; l < 12; l++)
				{
					#pragma HLS unroll
					for(int m = a; m < 12; m++)
					{
						#pragma HLS unroll
						for(int n = a; n < 12; n++)
						{
							#pragma HLS unroll
							z += sin((i+j+k+l+m+n));
						}
					}
				}
			}
		}
	}
	*outp = z;
}
