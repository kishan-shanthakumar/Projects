package encrypt;
import java.util.*;
public class Decrypt
{
    public static void main(String args[])
    {
        Scanner sc=new Scanner(System.in);
        System.out.println("Enter the encrypted text");
        String s1=sc.nextLine();
        int ch1=Integer.parseInt(String.valueOf(s1.charAt(s1.length()-1)));
        String s="";
        String fin="";
        for(int jj=0;jj<ch1;jj++)
        {
            s="";
            for(int i=0;i<s1.length()-1;i++)
            {
                s+=s1.charAt(i);
            }
            int key=Integer.parseInt(String.valueOf(s1.charAt(s1.length()-1)));
            fin="";
            for(int i=key;i<s.length();i+=(key+1))
            {
                fin+=(char)((s.charAt(i))-key);
            }
            s1=fin;
        }
        System.out.println(fin);
    }
}
