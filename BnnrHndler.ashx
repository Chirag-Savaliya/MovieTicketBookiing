<%@ WebHandler Language="C#" Class="BnnrHndler" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
public class BnnrHndler : IHttpHandler
{
    SqlConnection cn;
    SqlCommand cmd;
    SqlDataReader dr;
    public void ProcessRequest (HttpContext context)
    {
        string imgId = context.Request.QueryString["imgBnr"];
        int id = int.Parse(imgId);
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand("SELECT bnrImg FROM tblBnrsMngmnt WHERE bnrId=" + id + " AND bnrIsAct='TRUE'", cn);
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
        get {
            return false;
        }
    }
}