using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for Connection
/// </summary>
public class Connection
{
    static SqlConnection cn;
    static SqlCommand cmd;
    //public static string cnstr = "Data Source=BINDIYA-PC;Initial Catalog=MovieTicketBooking;Integrated Security=True";
    public static string cnstr = "Data Source=pc99;Initial Catalog=MovieTicketBooking;Integrated Security=True";

    public static Boolean ChkFileExtension(string FilNm)
    {
     string[] arFile=FilNm.Split('.');
     if (arFile[1].ToLower() == "jpg" || arFile[1].ToLower() == "png")
         return true;
     else return false;
    }
    public static void AddUpdtDltData(string qry)
    {
        cn = new SqlConnection(cnstr);
        cn.Open();
        cmd = new SqlCommand(qry,cn);
        cmd.ExecuteNonQuery();
        cn.Close();
    }
}