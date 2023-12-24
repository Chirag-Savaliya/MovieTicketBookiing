using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class ShowMngmnt : System.Web.UI.Page
{
    SqlConnection cn;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataSet ds;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadShowTime();
            ChkShows();
            BindGrid("SELECT shoId,shoName,shoStrtTime,shoDt FROM tblShowMaster WHERE shoIsAct='TRUE'");
        }
        ((Menu)this.Master.FindControl("mnu")).Items[2].ChildItems[3].Selected = true;
    }
    protected void btnAddShoViw_Click(object sender, EventArgs e)
    {
        mltVieShows.ActiveViewIndex = 0;
    }
    protected void btnBckAdShoViw_Click(object sender, EventArgs e)
    {
        mltVieShows.ActiveViewIndex = 1;
    }
    protected void btnAddMv_Click(object sender, EventArgs e)
    {
        if (ddlShoTime.SelectedIndex >= 1)
        {
            AddDisableShow("INSERT INTO tblShowMaster VALUES((SELECT MAX(shoId) FROM tblShowMaster)+1,'" + txtShoName.Text + "','" + ddlShoTime.SelectedItem.ToString() + "','"+System.DateTime.Today.ToShortDateString()+"','TRUE')", true);
            //AddDisableShow("UPDATE tblShowTimeMaster SET showTimIsAct='FALSE' WHERE showTime='" + ddlShoTime.SelectedItem.ToString() + "'", false);
            BindGrid("SELECT shoId,shoName,shoStrtTime,shoDt FROM tblShowMaster WHERE shoIsAct='TRUE'");
            LoadShowTime();
            ResetControls();
            ChkShows();
        }
        else lblErrorAddShowView.Text = "Select Valid Show Time.";

    }
    void LoadShowTime()
    {
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand("SELECT showTime FROM tblShowTimeMaster WHERE showTime NOT IN(SELECT shoStrtTime FROM tblShowMaster WHERE shoIsAct='TRUE') AND showTimId>0", cn);
        ds = new DataSet();
        da = new SqlDataAdapter(cmd);
        da.Fill(ds);
        ddlShoTime.Items.Clear();
        ddlShoTime.Items.Add("-- Select Show Time --");
        if (ds.Tables[0].Rows.Count >= 1)
        {
            for (int x = 0; x < ds.Tables[0].Rows.Count; x++)
                ddlShoTime.Items.Add(ds.Tables[0].Rows[x][0].ToString());
        }
        cn.Close();
    }
    void AddDisableShow(string qry,Boolean b)
    {
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand(qry,cn);
        cmd.ExecuteNonQuery();
        cn.Close();
        if (b == true)
            Response.Write("<script>alert('Show Added Successfully.')</script>");
    }
    void ResetControls()
    {
        txtShoName.Text = "";
        lblErrorAddShowView.Text = "";
        ddlShoTime.SelectedIndex = 0;
    }
    void BindGrid(string q)
    {
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand(q,cn);
        ds = new DataSet();
        da = new SqlDataAdapter(cmd);
        da.Fill(ds);
        if (ds.Tables[0].Rows.Count >= 1)
        {
            dtGrdSho.DataSource = ds.Tables[0];
            dtGrdSho.DataBind();
            dtGrdSho.Visible = true;
        }
        else
        {
            dtGrdSho.Visible = false;
        }
        cn.Close();
    }
    protected void dtGrdSho_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //cn = new SqlConnection(Connection.cnstr);
        //cn.Open();
        //cmd = new SqlCommand("UPDATE tblShowMaster SET shoIsAct='FALSE' WHERE shoId=" + int.Parse(dtGrdSho.Rows[e.RowIndex].Cells[0].Text.ToString()) + "", cn);
        //cmd.ExecuteNonQuery();
        //cn.Close();
        Connection.AddUpdtDltData("UPDATE tblShowMaster SET shoIsAct='FALSE' WHERE shoId=" + int.Parse(dtGrdSho.Rows[e.RowIndex].Cells[0].Text.ToString()) + "");
        AddDisableShow("UPDATE tblShowTimeMaster SET showTimIsAct='TRUE' WHERE showTime='" + dtGrdSho.Rows[e.RowIndex].Cells[2].Text.ToString() + "'", false);
        Connection.AddUpdtDltData("UPDATE tblTicketRateMaster SET tcktIsAct='FALSE' WHERE shoName='"+dtGrdSho.Rows[e.RowIndex].Cells[1].Text.ToString()+"'");
        BindGrid("SELECT shoId,shoName,shoStrtTime,shoDt FROM tblShowMaster WHERE shoIsAct='TRUE'");
        LoadShowTime();
        ChkShows();
    }
    void UnableDisableControls(Boolean b)
    {
            txtShoName.Enabled =b;
            ddlShoTime.Enabled = b;
            btnAddMv.Enabled = b;
    }
    void ChkShows()
    {
        if (ddlShoTime.Items.Count >= 2)
            UnableDisableControls(true);
        else UnableDisableControls(false);
    }
    protected void ddlSlctShows_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSlctShows.SelectedIndex == 0)
        {
            BindGrid("SELECT shoId,shoName,shoStrtTime,shoDt FROM tblShowMaster WHERE shoIsAct='TRUE'");
            dtGrdSho.Columns[4].Visible = true;
        }
        if(ddlSlctShows.SelectedIndex==1)
        {
            BindGrid("SELECT shoId,shoName,shoStrtTime,shoDt FROM tblShowMaster WHERE shoId>0 AND shoIsAct='FALSE'");
            dtGrdSho.Columns[4].Visible = false;
        }
    }
}