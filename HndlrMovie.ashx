<%@ WebHandler Language="C#" Class="HndlrMovie" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class HndlrMovie : IHttpHandler
{
    SqlConnection cn;
    SqlCommand cmd;
    SqlDataReader dr;
    public void ProcessRequest (HttpContext context)
    {
        string imgId = context.Request.QueryString["mvPostr"];
        int id = int.Parse(imgId);
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand("SELECT mvBnr FROM tblMovieMaster WHERE mvId=" + id + "", cn);
        dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            if (dr != null)
            {
                context.Response.BinaryWrite((byte[])dr[0]);
                context.Response.End();
            }
        }
        cn.Close();
        cn.Dispose();
        cmd.Dispose();
    }
    
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}