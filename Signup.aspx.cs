using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class Signup : System.Web.UI.Page
{
    SqlConnection cn;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataSet ds;
    string qry = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["Usr"] != null && Session["UsrRole"] != null)
            {
                string[] usr = Session["Usr"].ToString().Split('@');
                if (Session["UsrRole"].ToString() == "A")
                {
                    chkbxAdmn.Visible = true;
                    BindUserData();
                }
                else
                {
                    chkbxAdmn.Visible = false;
                }
            }
            else
            {
                chkbxAdmn.Visible = false;
            }
        }
        (((Menu)this.Master.FindControl("mnu"))).Items[5].ChildItems[1].Selected = true;
    }
    protected void dtGrdUsrs_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        Connection.AddUpdtDltData("UPDATE tblUsrMaster SET usrIsAct='FALSE' WHERE usrId=" + int.Parse(dtGrdUsrs.Rows[e.RowIndex].Cells[1].Text.ToString()) + "");
        BindUserData();
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {

            qry = "INSERT INTO tblUsrMaster VALUES((SELECT MAX(usrId) FROM tblUsrMaster)+1,";
            qry += "'" + txtFrstName.Text + "',";
            qry += "'" + txtLstName.Text + "',";
            qry += "'" + txtMono.Text + "',";
            qry += "'" + txtAddrs.Text + "',";
            qry += "'" + txtEml.Text + "',";
            qry += "'" + txtPasswrd.Text + "',";
            if (chkbxAdmn.Checked)
            {
                qry += "'A',";
            }
            else
            {
                qry += "'U',";
            }
            qry += "'" + txtSecQstn.Text + "',";
            qry += "'" + txtQstnAnsr.Text + "',";
            qry += "'TRUE')";
            try
            {
                Connection.AddUpdtDltData(qry);
                Response.Write("<script>alert('User Added Successfully.')</script>");
                ResetControls();
                if (Session["Usr"] != null && Session["UsrRole"] != null)
                {
                    string[] usr = Session["Usr"].ToString().Split('@');
                    if (Session["UsrRole"].ToString() == "A")
                    {
                        BindUserData();
                    }
                }
            }
        catch (Exception UsrExit)
        { 
            lblError.Text = "User Having Following Email Address Already Existed."; 
        }
    }
    void BindUserData()
    {
        qry = "SELECT usrId,usrFrstName,usrLstName,usrMono,usrAddrs,usrName,usrRole FROM tblUsrMaster WHERE usrIsAct='TRUE'";
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand(qry, cn);
        da = new SqlDataAdapter(cmd);
        ds = new DataSet();
        da.Fill(ds);
        cn.Close();
        if (ds.Tables[0].Rows.Count >= 1)
        {
            dtGrdUsrs.DataSource = ds.Tables[0];
            dtGrdUsrs.DataBind();
            dtGrdUsrs.Visible = true;
        }
        else
            dtGrdUsrs.Visible = false;
    }
    protected void chbxHdr_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gr in dtGrdUsrs.Rows)
        {
            ((CheckBox)gr.FindControl("chbxClmn")).Checked = ((CheckBox)dtGrdUsrs.HeaderRow.FindControl("chbxHdr")).Checked;
        }
        if (((CheckBox)dtGrdUsrs.HeaderRow.FindControl("chbxHdr")).Checked)
            btnDltAll.Visible = true;
        else
            btnDltAll.Visible = false;
    }
    protected void chbxClmn_CheckedChanged(object sender, EventArgs e)
    {
        int x = 0;
        foreach (GridViewRow gr in dtGrdUsrs.Rows)
        {
            if (((CheckBox)gr.FindControl("chbxClmn")).Checked)
            {
                x++;
            }
        }
        if (x >= 1)
            btnDltAll.Visible = true;
        else
            btnDltAll.Visible = false;
    }
    protected void btnDltAll_Click(object sender, EventArgs e)
    {
        string rowsId = "";
        foreach (GridViewRow gr in dtGrdUsrs.Rows)
        {
            if (((CheckBox)gr.FindControl("chbxClmn")).Checked)
            {
                rowsId += gr.Cells[1].Text.ToString();
                rowsId += ",";
            }
        }
        rowsId = rowsId.Substring(0, rowsId.Length - 1);
        Connection.AddUpdtDltData("UPDATE tblUsrMaster SET usrIsAct='FALSE' WHERE usrId IN(" + rowsId + ")");
        BindUserData();
    }
    void ResetControls()
    {
        txtFrstName.Text = "";
        txtLstName.Text = "";
        txtMono.Text = "";
        txtAddrs.Text = "";
        txtEml.Text = "";
        txtSecQstn.Text = "";
        txtQstnAnsr.Text = "";
        lblError.Text = "";
        if (chkbxAdmn.Visible == true) { chkbxAdmn.Checked = false; }
    }
}