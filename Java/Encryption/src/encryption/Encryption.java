package encryption;
import java.util.*;
public class Encryption 
{
    public static void main(String[] args) 
    {
        Scanner sc=new Scanner(System.in);
        System.out.println("Enter a sentence");
        String s=sc.nextLine();
        String fin="";
        double i;
        i=Math.random();
        for(;i<1||i>9;)
        {
            if(i>9)
                i/=10;
            if(i<1)
                i*=10;
        }
        int o=(int)i;
        for(int j=0;j<s.length();j++)
        {
            for(int k=0;k<o;k++)
            {
                for(int z;;)
                {
                    z=(int) (100*Math.random());
                    if(z>=32&&z<=126)
                    {
                        fin+=(char)(int)(z);
                        break;
                    }
                }
            }
            fin+=(char)((s.charAt(j))+o);
        }
        System.out.println(fin+String.valueOf(o));
    }    
}