package encryption;
import java.util.*;
public class Decryption 
{
    public static void main(String args[])
    {
        Scanner sc=new Scanner(System.in);
        System.out.println("Enter the encrypted text");
        String s1=sc.nextLine();
        String s="";
        for(int i=0;i<s1.length()-1;i++)
        {
            s+=s1.charAt(i);
        }
        int key=Integer.parseInt(String.valueOf(s1.charAt(s1.length()-1)));
        String fin="";
        for(int i=key;i<s.length();i+=(key+1))
        {
            fin+=(char)((s.charAt(i))-key);
        }
        System.out.println(fin);
    }
}
