using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Users : System.Web.UI.Page
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
            qry = "SELECT usrId,usrFrstName,usrLstName,usrMono,usrAddrs,usrName,usrRole FROM tblUsrMaster WHERE usrIsAct='TRUE'";
            BindUserData();
        }
        ((Menu)this.Master.FindControl("mnu")).Items[2].ChildItems[2].Selected = true;
    }
    protected void dtGrdUsrs_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        Connection.AddUpdtDltData("UPDATE tblUsrMaster SET usrIsAct='FALSE' WHERE usrId=" + int.Parse(dtGrdUsrs.Rows[e.RowIndex].Cells[1].Text.ToString()) + "");
        if (rdbtnAdmn.Checked)
        {
            qry = "SELECT usrId,usrFrstName,usrLstName,usrMono,usrAddrs,usrName,usrRole FROM tblUsrMaster WHERE usrIsAct='TRUE' AND usrRole='A'";
            BindUserData();
        }
        else if (rdbtnUsr.Checked)
        {
            qry = "SELECT usrId,usrFrstName,usrLstName,usrMono,usrAddrs,usrName,usrRole FROM tblUsrMaster WHERE usrIsAct='TRUE' AND usrRole='U'";
            BindUserData();
        }
        else
        {
            qry = "SELECT usrId,usrFrstName,usrLstName,usrMono,usrAddrs,usrName,usrRole FROM tblUsrMaster WHERE usrIsAct='TRUE'";
            BindUserData();
        }
        BindUserData();
    }
    void BindUserData()
    {
        
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
        if (rdbtnAdmn.Checked)
        {
            qry = "SELECT usrId,usrFrstName,usrLstName,usrMono,usrAddrs,usrName,usrRole FROM tblUsrMaster WHERE usrIsAct='TRUE' AND usrRole='A'";
            BindUserData();
        }
        else if (rdbtnUsr.Checked)
        {
            qry = "SELECT usrId,usrFrstName,usrLstName,usrMono,usrAddrs,usrName,usrRole FROM tblUsrMaster WHERE usrIsAct='TRUE' AND usrRole='U'";
            BindUserData();
        }
        else
        {
            qry = "SELECT usrId,usrFrstName,usrLstName,usrMono,usrAddrs,usrName,usrRole FROM tblUsrMaster WHERE usrIsAct='TRUE'";
            BindUserData();
        }
        BindUserData();
    }
    protected void chbxHdr_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gr in dtGrdUsrs.Rows)
        {
            ((CheckBox)gr.FindControl("chbxClmn")).Checked = ((CheckBox)dtGrdUsrs.HeaderRow.FindControl("chbxHdr")).Checked;
        }
        if (((CheckBox)dtGrdUsrs.HeaderRow.FindControl("chbxHdr")).Checked)
        {
            btnDltAll.Visible = true;
            if (rdbtnAdmn.Checked || rdbtnUsr.Checked)
            {
                btnRole.Visible = true;
            }
        }
        else
        {
            btnDltAll.Visible = false;
            btnRole.Visible = false;
        }
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
        {
            btnDltAll.Visible = true;
            if (rdbtnAdmn.Checked || rdbtnUsr.Checked)
            {
                btnRole.Visible = true;
            }
        }
        else
        {
            btnDltAll.Visible = false;
            btnRole.Visible = false;
        }
    }
    protected void rdbtnAdmn_CheckedChanged(object sender, EventArgs e)
    {
        btnDltAll.Visible = false;
        btnRole.Visible = false;
        if (rdbtnAdmn.Checked)
        {
            btnRole.Text = "CHANGE ROLE TO CLIENT";
            qry = "SELECT usrId,usrFrstName,usrLstName,usrMono,usrAddrs,usrName,usrRole FROM tblUsrMaster WHERE usrIsAct='TRUE' AND usrRole='A'";
            BindUserData();
        }
        else if (rdbtnUsr.Checked)
        {
            btnRole.Text = "CHANGE ROLE TO ADMIN";
            qry = "SELECT usrId,usrFrstName,usrLstName,usrMono,usrAddrs,usrName,usrRole FROM tblUsrMaster WHERE usrIsAct='TRUE' AND usrRole='U'";
            BindUserData();
        }
        else
        {
            qry = "SELECT usrId,usrFrstName,usrLstName,usrMono,usrAddrs,usrName,usrRole FROM tblUsrMaster WHERE usrIsAct='TRUE'";
            BindUserData();
        }
    }
    protected void btnRole_Click(object sender, EventArgs e)
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
        if (rdbtnAdmn.Checked)
        {
            Connection.AddUpdtDltData("UPDATE tblUsrMaster SET usrRole='U' WHERE usrId IN("+rowsId+")");
            qry = "SELECT usrId,usrFrstName,usrLstName,usrMono,usrAddrs,usrName,usrRole FROM tblUsrMaster WHERE usrIsAct='TRUE' AND usrRole='A'";
        }
        else if (rdbtnUsr.Checked)
        {
            Connection.AddUpdtDltData("UPDATE tblUsrMaster SET usrRole='A' WHERE usrId IN(" + rowsId + ")");
            qry = "SELECT usrId,usrFrstName,usrLstName,usrMono,usrAddrs,usrName,usrRole FROM tblUsrMaster WHERE usrIsAct='TRUE' AND usrRole='U'";
        }
        Response.Write("<script>alert('Role Changed Successfully')</script>");
        BindUserData();
    }
}