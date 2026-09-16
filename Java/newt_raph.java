package newtonraphsonmethod;
import java.util.*;
import java.math.*;
public class NewtonRaphsonMethod 
{
    public static void main(String[] args) 
    {
        Scanner sc=new Scanner(System.in);
        System.out.println("This works properly only for non imaginary root equations only");
        System.out.println("Enter the degree of the function");
        int n=sc.nextInt();
        double a[]=new double[n+1];
        Double x=5.0;
        System.out.println("Enter the coefficients");
        for(int i=0;i<=n;i++)
        {
            a[i]=sc.nextDouble();
        }
        double fx=0.0;
        float f1x=0;
        System.out.println("Please wait fot the result");
        for(;;)
        {
            fx=0.0;
            f1x=0;
            for(int i=0;i<=n;i++)
            {
                fx+=a[i]*Math.pow(x,n-i);
            }
            for(int i=0;i<n;i++)
            {
                f1x+=a[i]*(n-i)*Math.pow(x,(n-i)-1);
            }
            x=x+(f1x);
            if(Math.abs(f1x)<=Math.pow(10,-5))
                break;
        }
        System.out.println("One root is "+x);
    }
}