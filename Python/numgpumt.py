import time
import _thread
import numpy as np
import pyopencl as cl

ctx = cl.create_some_context()
queue = cl.CommandQueue(ctx)
mf = cl.mem_flags
prg = cl.Program(ctx, """
typedef struct{
long num1;
long num2;
}arr;

long num()
{
    return(2);
}

__kernel void add(__global const long *a_g, __global long *res1_g)
{
    int gid = get_global_id(0);
    res1_g[gid] = num() + (a_g[gid]*a_g[gid]*a_g[gid]);
}

__kernel void sub(__global const long *a_g, __global long *res2_g)
{
    int gid = get_global_id(0);
    res2_g[gid] = num() - (a_g[gid]*a_g[gid]*a_g[gid]);
}
__kernel void madd(__global const long *a_g, __global long *res1_g)
{
    int gid = get_global_id(0);
    res1_g[gid] = -1*num() + (a_g[gid]*a_g[gid]*a_g[gid]);
}

__kernel void msub(__global const long *a_g, __global long *res2_g)
{
    int gid = get_global_id(0);
    res2_g[gid] = -1*num() - (a_g[gid]*a_g[gid]*a_g[gid]);
}

__kernel void fac(__global const long *a_g, __global long *j_g, __global long *k_g)
{
    int gid = get_global_id(0);
    int i,j,c=0,z;
    float y=abs(a_g[gid]);
    float x=sqrt(y);
    arr answ[10000000000000];
    if (ans % 2==0)
    	z=1;
    else
    	z=2;
    for(i=1;i<=x;i+=z)
    {
        if(abs(a_g[gid])%i==0)
        {
            answ[c].num1=i;
            answ[c].num2=a_g[gid]/i;
            c++;
        }
    }
    int flag=0;
    for(i=0;i<c;i++)
    {
        arr temp=answ[i];
        for(j=0;j<temp.num1+1;j++)
        {
            if( ((j*j)-(j*(temp.num1-j))+((temp.num1-j)*(temp.num1-j))) == temp.num2)
            {
                j_g[gid]=j;
                k_g[gid]=temp.num1-j;
                flag=1;
                break;
            }
        }
        if(flag==1)
            break;
    }
    if(flag==0)
    {
        j_g[gid]=0;
        k_g[gid]=0;
    }
}
""").build()
zzz=1

def mainfun(zzz,thread):
    for k in range(1+zzz,10**20,thread):
        a_np = np.arange((k)*10**0,(k+1)*10**0,1)
        a_g = cl.Buffer(ctx, mf.READ_ONLY | mf.COPY_HOST_PTR, hostbuf=a_np)

        res1_g = cl.Buffer(ctx, mf.WRITE_ONLY, a_np.nbytes)
        prg.add(queue, a_np.shape, None, a_g, res1_g)
        res1_np=np.empty_like(a_np)
        cl.enqueue_copy(queue, res1_np, res1_g)

        res2_g = cl.Buffer(ctx, mf.WRITE_ONLY, a_np.nbytes)
        prg.sub(queue, a_np.shape, None, a_g, res2_g)
        res2_np=np.empty_like(a_np)
        cl.enqueue_copy(queue, res2_np, res2_g)

        res11_g = cl.Buffer(ctx, mf.WRITE_ONLY, a_np.nbytes)
        prg.madd(queue, a_np.shape, None, a_g, res11_g)
        res11_np=np.empty_like(a_np)
        cl.enqueue_copy(queue, res11_np, res11_g)

        j1_g = cl.Buffer(ctx, mf.WRITE_ONLY, a_np.nbytes)
        k1_g = cl.Buffer(ctx, mf.WRITE_ONLY, a_np.nbytes)
        j2_g = cl.Buffer(ctx, mf.WRITE_ONLY, a_np.nbytes)
        k2_g = cl.Buffer(ctx, mf.WRITE_ONLY, a_np.nbytes)
        j11_g = cl.Buffer(ctx, mf.WRITE_ONLY, a_np.nbytes)
        k11_g = cl.Buffer(ctx, mf.WRITE_ONLY, a_np.nbytes)
        
        prg.fac(queue, a_np.shape, None, res1_g, j1_g, k1_g)
        prg.fac(queue, a_np.shape, None, res2_g, j2_g, k2_g)
        prg.fac(queue, a_np.shape, None, res11_g, j11_g, k11_g)

        j1_np=np.empty_like(a_np)
        k1_np=np.empty_like(a_np)
        j2_np=np.empty_like(a_np)
        k2_np=np.empty_like(a_np)
        j11_np=np.empty_like(a_np)
        k11_np=np.empty_like(a_np)
        cl.enqueue_copy(queue, j1_np, j1_g)
        cl.enqueue_copy(queue, k1_np, k1_g)
        cl.enqueue_copy(queue, j2_np, j2_g)
        cl.enqueue_copy(queue, k2_np, k2_g)
        cl.enqueue_copy(queue, j11_np, j11_g)
        cl.enqueue_copy(queue, k11_np, k11_g)
        if(np.any(j1_np>0) or np.any(k1_np>0)):
            flag=1
            print()
            break
        if(np.any(j2_np>0) or np.any(k2_np>0)):
            flag=2
            print()
            break
        if(np.any(j11_np>0) or np.any(k11_np>0)):
            flag=11
            print()
            break
    print(a_np,end=' ')
    if(flag==1):
        print(j1_np,k1_np)
    if(flag==2):
        print(j2_np,k2_np)
    if(flag==11):
        print(j11_np,k11_np)
    print(time.time()-ts)


thread=10000
ts=time.time()
try:
    for i in range(1,thread+1):
        _thread.start_new_thread( mainfun, (i, thread,) )
except:
    print("Error : Unable to start thread")
while(True):
    pass
