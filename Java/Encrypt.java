package encrypt;
import java.util.*;
public class Encrypt
{
    public static void main(String[] args) 
    {
        Scanner sc=new Scanner(System.in);
        System.out.println("Enter a sentence");
        String s=sc.nextLine();
        double ch=Math.random();
        for(;ch<1||ch>9;)
        {
            if(ch>9)
                ch/=10;
            if(ch<1)
                ch*=10;
        }
        int ch1=(int)ch;
        String fin="";
        for(int jj=0;jj<ch1;jj++)
        {
            fin="";
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
            fin=fin+String.valueOf(o);
            s=fin;
        }
        System.out.println(fin+String.valueOf(ch1));
    }    
}