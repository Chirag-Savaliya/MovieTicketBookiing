using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

public partial class TcktBooking : System.Web.UI.Page
{
    SqlConnection cn;
    SqlCommand cmd;
    SqlDataAdapter da;
    SqlDataReader dr;
    DataSet ds;
    ReportDocument Rpt = new ReportDocument();
    protected void Page_Load(object sender, EventArgs e)
    {
        ((Menu)this.Master.FindControl("mnu")).Items[1].Selected = true;
        if (!Page.IsPostBack)
        {
            SetMvNamPoster(lblMvNmTcktBook, imgMvBnrTcktBook);
            if (lblMvNmTcktBook.Text.Length > 1)
            {
                //SetMvNamPoster(lblMvNmTcktBook, imgMvBnrTcktBook);
                txtdtTcktBook.Text = System.DateTime.Today.ToShortDateString();
                LoadShow(ddlShowTcktBook);
               BindGrid();
            }
            txtdtTcktBook.Text = System.DateTime.Now.ToShortDateString();
        }
    }
    void SetMvNamPoster(Label mvNm, Image mvPoster)
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
    protected void btnClndrTcktBook_Click(object sender, EventArgs e)
    {
        SetCalendar(clndrTcktBook, true);
    }
    void SetCalendar(Calendar c, Boolean b)
    {
        if (b == true)
        {
            if (c.Visible == true) c.Visible = false;
            else c.Visible = true;
        }
        else c.Visible = false;
    }
    protected void clndrTcktBook_SelectionChanged(object sender, EventArgs e)
    {
        string Sd = clndrTcktBook.SelectedDate.ToShortDateString();
        ResetControls();
        txtdtTcktBook.Text = Sd;
        lblShowTime.Text = "";
        LoadShow(ddlShowTcktBook);
        SetCalendar(clndrTcktBook, false);
    }
    void LoadShow(DropDownList d)
    {
        lblErrorTcktBook.Text = "";
        d.Items.Clear();
        d.Items.Add("-- Select Show --");
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand("SELECT shoName,shoStrtTime FROM tblShowMaster WHERE shoName IN(SELECT shoName FROM tblTicketRateMaster WHERE mvId=" + lblMvNmTcktBook.ToolTip.ToString() + " AND tcktIsAct='TRUE') AND shoIsAct='TRUE'", cn);
        ds = new DataSet();
        da = new SqlDataAdapter(cmd);
        da.Fill(ds);
        cn.Close();
        if (ds.Tables[0].Rows.Count >= 1)
        {
            string[] arrShTim;
            string[] arrCrTim;
            int ShTimStHr, ShTimStMnts, ShTimEdndHr, ShTimEndMnts, CrHr, CrMnt;
            string ShTimStrtFrmnt, ShTimEndFrmt, CrFrmt;
            String[] arrSetTcktBkDt = txtdtTcktBook.Text.ToString().Split('/');
            DateTime dt = new DateTime(int.Parse(arrSetTcktBkDt[2]), int.Parse(arrSetTcktBkDt[0]), int.Parse(arrSetTcktBkDt[1]));
            for (int x = 0; x < ds.Tables[0].Rows.Count; x++)
            {
                arrShTim = ds.Tables[0].Rows[x][1].ToString().Split('-');
                arrCrTim = System.DateTime.Now.ToShortTimeString().Split(':');
                CrHr = int.Parse(arrCrTim[0]);
                CrMnt = int.Parse(arrCrTim[1].Substring(0, 2));
                ShTimStHr = int.Parse(arrShTim[0].Substring(0, 2));
                ShTimStMnts = int.Parse(arrShTim[0].Substring(3, 2));
                ShTimEdndHr = int.Parse(arrShTim[1].Substring(0, 2));
                ShTimEndMnts = int.Parse(arrShTim[1].Substring(3, 2));
                ShTimStrtFrmnt = arrShTim[0].Substring(6, 2);
                ShTimEndFrmt = arrShTim[1].Substring(6, 2);

                if (System.DateTime.Now.ToShortTimeString().Contains("AM"))
                {
                    CrFrmt = "AM";
                }
                else
                {
                    CrFrmt = "PM";
                }

                if (System.DateTime.Today.CompareTo(dt) == -1)
                {
                    d.Items.Add(ds.Tables[0].Rows[x][0].ToString());
                }
                else if (System.DateTime.Today.CompareTo(dt) == 0)
                {
                    if (ChkShowTime(CrHr, ShTimStHr, CrMnt, ShTimStMnts, CrFrmt, ShTimStrtFrmnt))
                        d.Items.Add(ds.Tables[0].Rows[x][0].ToString());
                }
                else lblErrorTcktBook.Text = "Select Valid Date.Date Must Be Greater Than Or Equal To Current Date.";
            }
        }
    }
    protected void ddlShowTcktBook_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlShowTcktBook.SelectedIndex > 0)
        {
            DisplayShowTime();
            pnlTcktBook.Visible = true;
            BindAvlblSeats();
            BindTcktsRts();
        }
        else
        {
            lblShowTime.Text = "";
            txtTcktQunPltnm.Text = "0";
            txtTcktQunGoldn.Text = "0";
            txtTcktQunSlvr.Text = "0";
            pnlTcktBook.Visible = false;
            pnlTcktBookInfo.Visible = false;
        }
    }
   
    void BindAvlblSeats()
    {
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand("select 10-sum(tcktPltinm),15-sum(tcktGoldn),25-sum(tcktSlvr) from tblTicketBookingMaster where mvId=" + lblMvNmTcktBook.ToolTip.ToString() + " and showName='" + ddlShowTcktBook.SelectedItem.ToString() + "' and tcktUseDt='" + txtdtTcktBook.Text + "'", cn);
        dr = cmd.ExecuteReader();
        if (dr != null)
        {
            if (dr.Read())
            {
                if (dr[0].ToString().Length >= 1)
                    txtPltnmAvlblSts.Text = dr[0].ToString();
                else txtPltnmAvlblSts.Text = "10";

                if (dr[1].ToString().Length >= 1)
                    txtGldnAvlblSts.Text = dr[1].ToString();
                else txtGldnAvlblSts.Text = "15";

                if (dr[2].ToString().Length > 1)
                    txtSlvrAvlblSts.Text = dr[2].ToString();
                else txtSlvrAvlblSts.Text = "25";
            }
        }
        cn.Close();
    }
    void BindTcktsRts()
    {
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand("select tcktRtPltinum,tcktRtGoldn,tcktRtSlver from tblTicketRateMaster where tcktRtId=(select max(tcktRtId) from tblTicketRateMaster where mvId=" + lblMvNmTcktBook.ToolTip.ToString() + " and shoName='" + ddlShowTcktBook.SelectedItem.ToString() + "' and tcktIsAct='TRUE')", cn);
        dr = cmd.ExecuteReader();
        if (dr != null)
        {
            if (dr.Read())
            {
                txtPltnmRt.Text = dr[0].ToString();
                txtGoldnRt.Text = dr[1].ToString();
                txtSlvrRt.Text = dr[2].ToString();
            }
        }
        cn.Close();
    }
    void DisplayShowTime()
    {
            cn = new SqlConnection(Connection.cnstr);
            cn.Open();
            cmd = new SqlCommand("SELECT shoStrtTime FROM tblShowMaster WHERE shoName='" + ddlShowTcktBook.SelectedItem.ToString() + "' AND shoIsAct='TRUE'", cn);
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                lblShowTime.Text = "Show-Time." + dr[0].ToString();
            }
            else lblShowTime.Text = "";
            cn.Close();
    }
    protected void btnNxt_Click(object sender, EventArgs e)
    {
        String[] arrSetTcktBkDt = txtdtTcktBook.Text.ToString().Split('/');
        DateTime dt = new DateTime(int.Parse(arrSetTcktBkDt[2]), int.Parse(arrSetTcktBkDt[0]), int.Parse(arrSetTcktBkDt[1]));
        if (System.DateTime.Today.CompareTo(dt) == 1)
            lblErrorTcktBook.Text = "Select Valid Date.Date Must Be Greater Than Or Equal To Current Date.";
        else
        {
            lblErrorTcktBook.Text = "";
            pnlTcktBookInfo.Visible = true;
            CalcAmount();
            EnblDsblControls(false);
        }
    }
    void CalcAmount()
    {
        if (txtTcktQunPltnm.Text.Length < 1)
            txtTcktQunPltnm.Text = "0";
        if (txtTcktQunGoldn.Text.Length < 1)
            txtTcktQunGoldn.Text = "0";
        if (txtTcktQunSlvr.Text.Length < 1)
        {
            txtTcktQunSlvr.Text = "0";
        }

        lblTcktBookInfoP.Text = txtPltnmRt.Text.ToString() + " X " + txtTcktQunPltnm.Text.ToString() + " = " + int.Parse(txtPltnmRt.Text.ToString()) * int.Parse(txtTcktQunPltnm.Text.ToString());
        lblTcktBookInfoG.Text = txtGoldnRt.Text.ToString() + " X " + txtTcktQunGoldn.Text.ToString() + " = " + int.Parse(txtGoldnRt.Text.ToString()) * int.Parse(txtTcktQunGoldn.Text.ToString());
        lblTcktBookInfoS.Text = txtSlvrRt.Text.ToString() + " X " + txtTcktQunSlvr.Text.ToString() + " = " + int.Parse(txtSlvrRt.Text.ToString()) * int.Parse(txtTcktQunSlvr.Text.ToString());
        lblTtlAmntTcktBook.Text = int.Parse(((int.Parse(txtPltnmRt.Text.ToString()) * int.Parse(txtTcktQunPltnm.Text.ToString())) + (int.Parse(txtGoldnRt.Text.ToString()) * int.Parse(txtTcktQunGoldn.Text.ToString())) + (int.Parse(txtSlvrRt.Text.ToString()) * int.Parse(txtTcktQunSlvr.Text.ToString()))).ToString()).ToString();
    }
    void EnblDsblControls(Boolean b)
    {
        pnlTcktBook.Enabled = b;
        ddlShowTcktBook.Enabled = b;
        btnClndrTcktBook.Enabled = b;
    }
    protected void btnCnclTcktBook_Click(object sender, EventArgs e)
    {
        EnblDsblControls(true);
        ResetControls();
    }
    void ResetControls()
    {
        txtdtTcktBook.Text = System.DateTime.Today.ToShortDateString();
        ddlShowTcktBook.SelectedIndex = 0;
        lblShowTime.Text = "";
        txtTcktQunGoldn.Text = "0";
        txtTcktQunPltnm.Text = "0";
        txtTcktQunSlvr.Text = "0";
        pnlTcktBook.Visible = false;
        pnlTcktBookInfo.Visible = false;
    }
    protected void btnBook_Click(object sender, EventArgs e)
    {
        string[] shTim=lblShowTime.Text.ToString().Split('.');
        string[] arrPlAmnt = lblTcktBookInfoP.Text.ToString().Split('=');
        string[] arrGlAmnt = lblTcktBookInfoG.Text.ToString().Split('=');
        string[] arrSlAmnt = lblTcktBookInfoS.Text.ToString().Split('=');
        string StNoPl, StNoGl, StNoSl;
        StNoPl = "";
        StNoGl = "";
        StNoSl = "";
        if (int.Parse(txtTcktQunPltnm.Text.ToString()) > 0)
        {
            for (int x = (10 - (int.Parse(txtPltnmAvlblSts.Text.ToString()))) + 1; x < ((10 - (int.Parse(txtPltnmAvlblSts.Text.ToString()))) + 1) + int.Parse(txtTcktQunPltnm.Text.ToString()); x++)
                StNoPl += x.ToString() + " ";
        }

        if (int.Parse(txtTcktQunGoldn.Text.ToString()) > 0)
        {
            for (int x = (15 - (int.Parse(txtGldnAvlblSts.Text.ToString()))) + 1; x < ((15 - (int.Parse(txtGldnAvlblSts.Text.ToString()))) + 1) + int.Parse(txtTcktQunGoldn.Text.ToString()); x++)
                StNoGl += x.ToString() + " ";
        }

        if (int.Parse(txtTcktQunSlvr.Text.ToString()) > 0)
        {
            for (int x = (25 - (int.Parse(txtSlvrAvlblSts.Text.ToString()))) + 1; x < ((25 - (int.Parse(txtSlvrAvlblSts.Text.ToString()))) + 1) + int.Parse(txtTcktQunSlvr.Text.ToString()); x++)
                StNoSl += x.ToString() + " ";
        }
        string Q = "";
        Q += "INSERT INTO tblTicketBookingMaster VALUES((SELECT MAX(tcktBkId) FROM tblTicketBookingMaster)+1,";
        Q += "'" + ((Label)this.Master.FindControl("lblUser")).ToolTip.ToString()+ "',";
        Q += ""+lblMvNmTcktBook.ToolTip.ToString()+",";
        Q += "'"+ddlShowTcktBook.SelectedItem.ToString()+"',";
        Q += "'"+shTim[1]+"',";
        Q += "'"+System.DateTime.Today.ToShortDateString()+"',";
        Q += "'"+txtdtTcktBook.Text+"',";
        Q += ""+txtTcktQunPltnm.Text+",";
        Q += "" + txtTcktQunGoldn.Text + ",";
        Q += "" + txtTcktQunSlvr.Text + ",";
        Q += "" + arrPlAmnt[1] + ",";
        Q += "" + arrGlAmnt[1] + ",";
        Q += "" + arrSlAmnt[1] + ",";
        Q += "" + lblTtlAmntTcktBook.Text.ToString() + ",";
        Q += "'"+StNoPl+"',";
        Q += "'" + StNoGl + "',";
        Q += "'" + StNoSl + "',";
        Q += "'TRUE')";
        Connection.AddUpdtDltData(Q);
        EnblDsblControls(true);
        BindAvlblSeats();
        ResetControls();
        Response.Write("<script>alert('Tickets Booked Successfully.')</script>");
        BindGrid();
    }
    void BindGrid()
    {
        try
        {
            Response.Write("<script>alert'"+Session["Usr"].ToString()+"')</script>");
            cn = new SqlConnection(Connection.cnstr);
            cn.Open();
            cmd = new SqlCommand("select t.tcktBkId,t.mvId,t.showName,t.showTime,t.tcktUseDt,m.mvName from tblTicketBookingMaster t,tblMovieMaster m where t.tcktBkIsAct='TRUE' AND m.mvIsAct='TRUE' AND t.mvId in(select t.mvId from tblTicketBookingMaster where t.usrNm='"+Session["Usr"].ToString()+"')", cn);
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
        catch (Exception e) { }
    }
    protected void dtGrdTcktInfo_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string Q = "SELECT tb.showName,tb.showTime,tb.tcktUseDt,tb.tcktPltinm,tb.tcktGoldn,tb.tcktSlvr,tb.tcktAmntPltinm,tb.tcktAmntGoldn,";
        Q += "tb.tcktAmntSlvr,tb.tcktTotlAmnt,tb.stNoPltinm,tb.stNoGoldn,tb.stNoSlvr,m.mvName from tblTicketBookingMaster tb,tblMovieMaster m ";
        Q += "where tb.mvId=m.mvId and tb.usrNm='" + Session["Usr"].ToString() + "' and tb.showName='" + dtGrdTcktInfo.Rows[e.RowIndex].Cells[3].Text.ToString() + "' and tb.tcktUseDt='" + dtGrdTcktInfo.Rows[e.RowIndex].Cells[5].Text.ToString() + "' and tb.tcktBkIsAct='true' ";
        Q += "and m.mvIsAct='true'";
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand(Q, cn);
        da = new SqlDataAdapter(cmd);
        ds = new DataSet();
        da.Fill(ds);
        cn.Close();
        ds.WriteXml(Server.MapPath("~/Report" + "/TcktTptFl.xml"));
        Rpt.Load(Server.MapPath("~/CrRptMvTckt.rpt"));
        Rpt.SetDataSource(ds.Tables[0]);
        Rpt.ExportToDisk(ExportFormatType.PortableDocFormat, Server.MapPath("~/Report/") + "MovieTicket.pdf");
        Response.Clear();
        //Response.ContentType = "application/pdf";
        Response.ContentType = "application/octect-stream";
        Response.AppendHeader("content-disposition", "filename="+lblMvNmTcktBook.Text.ToString()+"_"+Session["Usr"].ToString()+".pdf");
        Response.TransmitFile(Server.MapPath("~/Report/") + "MovieTicket.pdf");
        Response.End();
        Response.Write("<script>alert('"+e.RowIndex.ToString()+"')</script>");
    }
    Boolean ChkShowTime(int ch,int sh,int cm,int sm,string cf,string sf)
    {
        Boolean Rslt = false;
        if(cf=="AM" && sf=="AM")
        {
            if (sm == 0)
            {
                if (sh != 12)
                {
                    if ((ch == 12) || (ch < sh))
                        Rslt = true;
                }
            }
            else
            {
                if (sh != 12)
                {
                    if ((ch == 12) || (ch < sh) || (ch == sh && cm < sm))
                        Rslt = true;
                }
            }
        }
        else if (cf == "AM" && sf == "PM")
        {
            Rslt = true;
        }
        else if (cf == "PM" && sf == "AM")
        {
            Rslt = false;
        }
        else
        {
            if (sm == 0)
            {
                if (sh != 12)
                {
                    if ((ch == 12) || (ch < sh))
                        Rslt = true;
                }
            }
            else
            {
                if (sh != 12 || (sh == 12 && sm < 30))
                {
                    if ((ch == 12) || (ch < sh) || (ch == sh && cm < sm))
                        Rslt = true;
                }
            }
        }
        return Rslt;
    }
}
