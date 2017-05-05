/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package studentacadmicdetails;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Himanshu Makkar
 */
public class dbaccess {

    
    public  static boolean updatequery(String query,Object ob[])
    {
        try{
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection conn=DriverManager.getConnection("jdbc:sqlserver://localhost;database=project","sa","abc");
        
            CallableStatement pst=conn.prepareCall(query);
            for(int i=0;i<ob.length;i++)
            {
                pst.setObject(i+1, ob[i]);
            }
            int r=pst.executeUpdate();
            if(r>=0)
            {
        return true;
            }    }
    
    catch(Exception ex)
    {
        System.out.println(ex);
    }
        return false;
}
    public static ResultSet selectquery(String query,Object ob[])
            {
                ResultSet rs=null;
        try
        {
             Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection conn=DriverManager.getConnection("jdbc:sqlserver://localhost;database=project","sa","abc");
//            CallableStatement pst = conn.prepareCall(query);
            
            PreparedStatement pst=conn.prepareStatement(query);
            int index=1;
            for(Object a:ob)
            {
                pst.setObject(index, a);
                index++;
            }
            rs=pst.executeQuery();
          
            
            
              return rs;   
        }
        catch(Exception ex)
        {
            System.out.println(ex);
        }
    return rs     ;
    }
    
}