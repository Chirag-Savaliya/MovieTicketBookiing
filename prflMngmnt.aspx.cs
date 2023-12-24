using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class prflMngmnt : System.Web.UI.Page
{
    SqlConnection cn;
    SqlCommand cmd;
    SqlDataAdapter da;
    SqlDataReader dr;
    string qry = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //BindUserProfile();
        }
        (((Menu)this.Master.FindControl("mnu"))).Items[5].ChildItems[3].Selected = true;
    }
    protected void btnPrfl_Click(object sender, EventArgs e)
    {
        if (btnPrfl.Text == "EDIT PROFILE")
        {
            BindUserProfile();
            pnlPrfl.Visible = true;
            btnPrfl.Text = "UPDATE PROFILE";
        }
        else
        {
            UpdateProfile();
            pnlPrfl.Visible = false;
            btnPrfl.Text = "EDIT PROFILE";
        }
    }
    void BindUserProfile()
    {
        if (((Label)this.Master.FindControl("lblUser")).Text.Length >= 1)
        {
            if (Session["Usr"] != null)
            {
                qry = "SELECT usrFrstName,usrLstName,usrMono,usrAddrs,usrPasswrd,usrSecQstn,usrSecQstnAnsr FROM tblUsrMaster WHERE usrName='" + Session["Usr"].ToString() + "' ";
                qry += "AND usrIsAct='TRUE'";
                cn = new SqlConnection(Connection.cnstr);
                cn.Open();
                cmd = new SqlCommand(qry, cn);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtFrstnm.Text = dr[0].ToString();
                    txtLstnm.Text = dr[1].ToString();
                    txtMono.Text = dr[2].ToString();
                    txtAddrs.Text = dr[3].ToString();
                    txtPass.Text = dr[4].ToString();
                    txtCnfrmPass.Text = dr[4].ToString();
                    txtSecQstn.Text = dr[5].ToString();
                    txtQstnAnsr.Text = dr[6].ToString();
                }
                cn.Close();
            }
            else
            {
                lblError.Text = "You Must Need To Login First Or Signup If You Dont Have An Account.";
            }
        }
    }
    void UpdateProfile()
    {
        qry = "UPDATE tblUsrMaster SET ";
        qry += "usrFrstName='"+txtFrstnm.Text+"',";
        qry += "usrLstName='" + txtLstnm.Text + "',";
        qry += "usrMono='" + txtMono.Text + "',";
        qry += "usrAddrs='" + txtAddrs.Text + "',";
        qry += "usrPasswrd='" + txtPass.Text + "',";
        qry += "usrSecQstn='" + txtSecQstn.Text + "',";
        qry += "usrSecQstnAnsr='" + txtQstnAnsr.Text + "' WHERE usrName='" + Session["Usr"].ToString() + "' AND usrIsAct='TRUE'";
        Connection.AddUpdtDltData(qry);
        Response.Write("<script>alert('Your Profile Updated Successfully.')</script>");
    }
    protected void btnCncl_Click(object sender, EventArgs e)
    {
        pnlPrfl.Visible = false;
        btnPrfl.Text = "EDIT PROFILE";
    }
}