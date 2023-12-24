using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class TcktMngmnt : System.Web.UI.Page
{
    SqlConnection cn;
    SqlCommand cmd;
    SqlDataAdapter da;
    SqlDataReader dr;
    DataSet ds;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
                SetMvNamPoster(lblMvNmSetTcktRtView, imgMvBnrSetTcktRtView);
            if(lblMvNmSetTcktRtView.Text.Length>0)
                BindGrid("SELECT shoName,tcktDt,tcktRtPltinum,tcktRtGoldn,tcktRtSlver FROM tblTicketRateMaster WHERE mvId=" + lblMvNmSetTcktRtView.ToolTip.ToString() + " AND tcktIsAct='TRUE'");
        }
        ((Menu)this.Master.FindControl("mnu")).Items[2].ChildItems[4].Selected = true;
    }
    protected void btnSetTcktRtView_Click(object sender, EventArgs e)
    {
        mltVieTcktRt.ActiveViewIndex = 0;
        SetMvNamPoster(lblMvNmSetTcktRtView, imgMvBnrSetTcktRtView);
        if (lblMvNmSetTcktRtView.Text.Length > 0)
        {
            LoadShow(ddlShoSetTcktRtView);
        }
        dtSetTcktRtView.Text = System.DateTime.Now.ToShortDateString();
        SetCalendar(clndrSetTcktRtView,false);
        ResetControls(viewSetTcktRt);
    }
    protected void btnEdtTcktRtViw_Click(object sender, EventArgs e)
    {
        mltVieTcktRt.ActiveViewIndex = 1;
        SetMvNamPoster(lblMvNmEdtTcktRtView, mvBnrEdtTcktRtView);
        if (lblMvNmEdtTcktRtView.Text.Length > 0)
        {
            LoadShow(ddlShowEdtTcktRtView);
        }
        ResetControls(viewEdtTcktRt);
    }
    protected void btnCnclSetTcktRtView_Click(object sender, EventArgs e)
    {
        ResetControls(viewSetTcktRt);
    }
    protected void btnCnclEdtTcktRtView_Click(object sender, EventArgs e)
    {
        ResetControls(viewEdtTcktRt);
    }
    protected void btnBckEdtTcktRtViw_Click(object sender, EventArgs e)
    {
        mltVieTcktRt.ActiveViewIndex = 2;
    }
    protected void btnBckSetTcktRtViw_Click(object sender, EventArgs e)
    {
        mltVieTcktRt.ActiveViewIndex = 2;
    }
    void SetMvNamPoster(Label mvNm,Image mvPoster)
    {
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand("SELECT mvId,mvName,mvBnr FROM tblMovieMaster WHERE mvId=(SELECT MAX(mvId) FROM tblMovieMaster WHERE mvIsAct='TRUE')", cn);
        dr = cmd.ExecuteReader();
        if (dr.Read())
        {
         mvNm.Text = dr[1].ToString();
         byte[] Poster = (byte[])dr[2];
         string b64Img = Convert.ToBase64String(Poster, 0, Poster.Length);
         mvPoster.ImageUrl = "data:image/jpg;base64," + b64Img;
         mvNm.ToolTip = dr[0].ToString();
        }
        cn.Close();
    }
    void LoadShow(DropDownList d)
    {
        d.Items.Clear();
        d.Items.Add("-- Select Show --");
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        if (d == ddlShoSetTcktRtView)
        {
            cmd = new SqlCommand("SELECT shoName FROM tblShowMaster WHERE shoName NOT IN(SELECT shoName FROM tblTicketRateMaster WHERE mvId=" + lblMvNmSetTcktRtView.ToolTip.ToString() + " AND tcktIsAct='TRUE') AND shoIsAct='TRUE'", cn);
        }
        else
        {
            cmd = new SqlCommand("SELECT shoName FROM tblTicketRateMaster WHERE mvId=" + lblMvNmSetTcktRtView.ToolTip.ToString() + " AND tcktIsAct='TRUE'", cn);
        }
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            d.Items.Add(dr[0].ToString());
        }
        cn.Close();
    }
    protected void btnSetRt_Click(object sender, EventArgs e)
    {
        String[] arrSetTcktRtDt = dtSetTcktRtView.Text.ToString().Split('/');
        DateTime dt = new DateTime(int.Parse(arrSetTcktRtDt[2]),int.Parse(arrSetTcktRtDt[0]),int.Parse(arrSetTcktRtDt[1]));
        if(ddlShoSetTcktRtView.SelectedIndex==0)
        {
            lblErrorSetTcktRtView.Text = "Select Valid Show Name.";
        }
        else if (System.DateTime.Today.CompareTo(dt)==1)
        {
            lblErrorSetTcktRtView.Text = "Select Valid Date.Date Must Be Greater Than Or Equal To Date Of Today.";
        }
        else
        {
            Connection.AddUpdtDltData("INSERT INTO tblTicketRateMaster VALUES((SELECT MAX(tcktRtId) FROM tblTicketRateMaster)+1,"+lblMvNmSetTcktRtView.ToolTip.ToString()+",'"+ddlShoSetTcktRtView.SelectedItem.ToString()+"','"+dtSetTcktRtView.Text+"','"+txtPltnmRtSetTcktRtView.Text+"','"+txtGldnRtSetTcktRtView.Text+"','"+txtSlvrRtSetTcktRtView.Text+"','TRUE')");
            Response.Write("<script>alert('Tickets Rates Set Successfully.')</script>");
            LoadShow(ddlShoSetTcktRtView);
            ResetControls(viewSetTcktRt);
            BindGrid("SELECT shoName,tcktDt,tcktRtPltinum,tcktRtGoldn,tcktRtSlver FROM tblTicketRateMaster WHERE mvId=" + lblMvNmSetTcktRtView.ToolTip.ToString() + " AND tcktIsAct='TRUE'");
        }
    }
    protected void btnClndrSetTcktRtView_Click(object sender, EventArgs e)
    {
        SetCalendar(clndrSetTcktRtView,true);
    }
    void SetCalendar(Calendar c,Boolean b)
    {
        if (b == true)
        {
            if (c.Visible == true) c.Visible = false;
            else c.Visible = true;
        }
        else c.Visible = false;
    }
    void ResetControls(View v)
    {
        if (v == viewSetTcktRt)
        {
            lblErrorSetTcktRtView.Text = "";
            txtPltnmRtSetTcktRtView.Text = "";
            txtGldnRtSetTcktRtView.Text = "";
            txtSlvrRtSetTcktRtView.Text ="";
            dtSetTcktRtView.Text = System.DateTime.Now.ToShortDateString();
            ddlShoSetTcktRtView.SelectedIndex = 0;
            SetCalendar(clndrSetTcktRtView, false);
        }
        else
        {
            lblErrorEdtTcktRtView.Text = "";
            txtPltnmRtEdtTcktRtView.Text = "";
            txtGldnRtEdtTcktRtView.Text = "";
            txtSlvrRtEdtcktRtView.Text = "";
            ddlShowEdtTcktRtView.SelectedIndex = 0;
        }
    }
    protected void clndrSetTcktRtView_SelectionChanged(object sender, EventArgs e)
    {
        dtSetTcktRtView.Text = clndrSetTcktRtView.SelectedDate.ToShortDateString();
        SetCalendar(clndrSetTcktRtView, false);
    }
    void BindGrid(string q)
    {
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand(q,cn);
        da = new SqlDataAdapter(cmd);
        ds = new DataSet();
        da.Fill(ds);
        cn.Close();
        if (ds.Tables[0].Rows.Count >= 1)
        {
            dtGrdTcktInfo.DataSource = ds.Tables[0];
            dtGrdTcktInfo.DataBind();
            dtGrdTcktInfo.Visible = true;
        }
        else dtGrdTcktInfo.Visible = false;
    }
    protected void btnUpdtRt_Click(object sender, EventArgs e)
    {
        if (ddlShowEdtTcktRtView.SelectedIndex == 0)
        {
            lblErrorEdtTcktRtView.Text = "Select Valid Show Name.";
        }
        else
        {
            Connection.AddUpdtDltData("UPDATE tblTicketRateMaster SET tcktRtPltinum=" + txtPltnmRtEdtTcktRtView.Text + ",tcktRtGoldn=" + txtGldnRtEdtTcktRtView.Text + ",tcktRtSlver=" + txtSlvrRtEdtcktRtView.Text + " WHERE mvId=" + lblMvNmEdtTcktRtView.ToolTip.ToString() + " AND shoName='"+ddlShowEdtTcktRtView.SelectedItem.ToString()+"'");
            Response.Write("<script>alert('Tickets Rates Updated Successfully.')</script>");
            ResetControls(viewEdtTcktRt);
            BindGrid("SELECT shoName,tcktDt,tcktRtPltinum,tcktRtGoldn,tcktRtSlver FROM tblTicketRateMaster WHERE mvId=" + lblMvNmSetTcktRtView.ToolTip.ToString() + " AND tcktIsAct='TRUE'");
        }
    }
    void BindTcktRts()
    {
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand("select tcktRtPltinum,tcktRtGoldn,tcktRtSlver from tblTicketRateMaster where mvId="+lblMvNmEdtTcktRtView.ToolTip.ToString()+" and shoName='"+ddlShowEdtTcktRtView.SelectedItem.ToString()+"' and tcktIsAct='true'", cn);
        da = new SqlDataAdapter(cmd);
        ds = new DataSet();
        da.Fill(ds);
        cn.Close();
        if (ds.Tables[0].Rows.Count > 0)
        {
            txtPltnmRtEdtTcktRtView.Text = ds.Tables[0].Rows[0][0].ToString();
            txtGldnRtEdtTcktRtView.Text = ds.Tables[0].Rows[0][1].ToString();
            txtSlvrRtEdtcktRtView.Text = ds.Tables[0].Rows[0][2].ToString();
        }
    }
    protected void ddlShowEdtTcktRtView_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlShowEdtTcktRtView.SelectedIndex > 0)
            BindTcktRts();
        else
        {
            txtPltnmRtEdtTcktRtView.Text = "";
            txtGldnRtEdtTcktRtView.Text = "";
            txtSlvrRtEdtcktRtView.Text = "";
        }
    }
}