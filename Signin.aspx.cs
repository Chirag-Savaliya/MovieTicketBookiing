using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Signin : System.Web.UI.Page
{
    SqlConnection cn;
    SqlCommand cmd;
    SqlDataAdapter da;
    SqlDataReader dr;
    DataSet ds;
    protected void Page_Load(object sender, EventArgs e)
    {
        (((Menu)this.Master.FindControl("mnu"))).Items[5].ChildItems[0].Selected = true;
    }
    protected void frgtPass_Click(object sender, EventArgs e)
    {
        mltViewLogin.ActiveViewIndex = 1;
    }
    protected void btnCnclFrgtPassView_Click(object sender, EventArgs e)
    {
        mltViewLogin.ActiveViewIndex = 0;
    }
    protected void btnNxt_Click(object sender, EventArgs e)
    {
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand("SELECT usrName,usrSecQstn FROM tblUsrMaster WHERE usrName='"+txtUserFrgtPassView.Text+"'", cn);
        dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            if (dr[0].ToString() == txtUserFrgtPassView.Text.ToString())
            {
                ((Label)this.Master.FindControl("lblUser")).ToolTip = txtUserFrgtPassView.Text.ToString();
                 mltViewLogin.ActiveViewIndex = 2;
            }
            else
            {
                lblErrorFrgtPassView.Text = "User Could Not Be Found.";
                ((Label)this.Master.FindControl("lblUser")).ToolTip = "";
            }
        }
        else
        {
            lblErrorFrgtPassView.Text = "User Could Not Be Found.";
            ((Label)this.Master.FindControl("lblUser")).ToolTip = "";
        }
        cn.Close();
    }
    protected void btnCnclRecPassView_Click(object sender, EventArgs e)
    {
        mltViewLogin.ActiveViewIndex = 0;
    }
    protected void viewFrgtPass_Activate(object sender, EventArgs e)
    {
        lblErrorFrgtPassView.Text = "";
        txtUserFrgtPassView.Text = "";
    }
    protected void viewPassRec_Activate(object sender, EventArgs e)
    {
        lblErrorPassRecView.Text = "";
        txtUsrSecQstnPassRec.Text = "";
        txtQstnAnsrPassRec.Text = "";
        SetSecQuestion();
    }
    void SetSecQuestion()
    {
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand("SELECT usrSecQstn FROM tblUsrMaster WHERE usrName='" + ((Label)this.Master.FindControl("lblUser")).ToolTip.ToString() + "'", cn);
        da = new SqlDataAdapter(cmd);
        ds = new DataSet();
        da.Fill(ds);
        cn.Close();
        if (ds.Tables[0].Rows.Count >= 1)
        {
            txtUsrSecQstnPassRec.Text = ds.Tables[0].Rows[0][0].ToString();
        }
    }
    protected void btnNextFnl_Click(object sender, EventArgs e)
    {
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand("SELECT usrSecQstnAnsr FROM tblUsrMaster WHERE usrName='" + ((Label)this.Master.FindControl("lblUser")).ToolTip.ToString() + "'", cn);
        dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            if (dr[0].ToString() == txtQstnAnsrPassRec.Text.ToString())
            {
                Response.Write("<script>alert('Your Password Is : " + dr[0].ToString() + "')</script>");
                mltViewLogin.ActiveViewIndex = 0;
            }
            else
                lblErrorPassRecView.Text = "Question Answer Does Not Match.";
        }
        cn.Close();
    }
    protected void viewLogin_Activate(object sender, EventArgs e)
    {
        lblError.Text = "";
        txtUsrnm.Text = "";
        txtPass.Text = "";
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand("SELECT usrName,usrPasswrd,usrRole FROM tblUsrMaster WHERE usrName='" +txtUsrnm.Text+ "'", cn);
        dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            if (dr[0].ToString() == txtUsrnm.Text.ToString() && dr[1].ToString()==txtPass.Text.ToString())
            {
                Session["Usr"] = dr[0].ToString();
                Session["UsrRole"] = dr[2].ToString();
                Response.Redirect("Home.aspx");
            }
            else
                lblError.Text = "User Name Or Password Does Not Match.";
        }
        else
            lblError.Text = "User Name Or Password Does Not Match.";
        cn.Close();
    }
}