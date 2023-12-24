using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class MovieTickeBooking : System.Web.UI.MasterPage
{
    SqlConnection cn;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataSet ds;
    Random r = new Random();
    static int[] bnrImgId = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["Usr"] != null && Session["UsrRole"] != null)
            {
                string[] usr = Session["Usr"].ToString().Split('@');
                lblUser.Text = usr[0].ToString();
                lblUser.ToolTip = Session["Usr"].ToString();
                if (Session["UsrRole"].ToString() == "A")
                {
                    mnu.Items[2].Enabled = true;
                }
                else
                {
                    mnu.Items[2].Enabled = false;
                }
                mnu.Items[1].Enabled = true;
                mnu.Items[5].ChildItems[0].Enabled = false;
                mnu.Items[5].ChildItems[2].Enabled = true;
                mnu.Items[5].ChildItems[3].Enabled = true;
            }
            else
            {
                mnu.Items[1].Enabled = false;
                mnu.Items[2].Enabled = false;
                mnu.Items[5].ChildItems[2].Enabled = false;
                mnu.Items[5].ChildItems[3].Enabled = false;
            }
            Date.Text = System.DateTime.Now.Date.ToLongDateString();
            GetBannersImgsId();
            SetMovie();
        }
        
    }
    protected void Timer_Tick(object sender, EventArgs e)
    {
        Timer.Text = System.DateTime.Now.ToLongTimeString();
    }
    protected void timrImg_Tick(object sender, EventArgs e)
    {
        if (bnrImgId != null)
        {
            SetBannerImage(r.Next(0,bnrImgId.Length));
        }
        else
        {
            GetBannersImgsId();
        }
    }
    public void GetBannersImgsId()
    {
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand("SELECT bnrId FROM tblBnrsMngmnt WHERE bnrIsAct='TRUE'",cn);
        da = new SqlDataAdapter(cmd);
        ds = new DataSet();
        da.Fill(ds);
        cn.Close();
        cn.Dispose();
        cmd.Dispose();
        da.Dispose();
        if (ds.Tables[0].Rows.Count >= 1)
        {
            bnrImgId = new int[ds.Tables[0].Rows.Count];
            for (int x = 0; x < ds.Tables[0].Rows.Count; x++)
            {
                bnrImgId[x] = int.Parse(ds.Tables[0].Rows[x][0].ToString());
            }
            SetBannerImage(r.Next(0, bnrImgId.Length));
        }
        ds.Dispose();
    }
    public void SetBannerImage(int bnrId)
    {
        if (bnrImgId.Length >= 1)
        {
            cn = new SqlConnection(Connection.cnstr);
            cn.Open();
            cmd = new SqlCommand("SELECT bnrImg FROM tblBnrsMngmnt WHERE bnrId=" + bnrImgId[bnrId] + " AND bnrIsAct='TRUE'", cn);
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);
            cn.Close();
            cn.Dispose();
            cmd.Dispose();
            da.Dispose();
            if (ds.Tables[0].Rows.Count >= 1)
            {
                byte[] bnr = (byte[])ds.Tables[0].Rows[0][0];
                string b64Img = Convert.ToBase64String(bnr, 0, bnr.Length);
                if (imgBnr == null)
                {
                    imgBnr = new Image();
                }
                imgBnr.ImageUrl = "data:image/jpg;base64," + b64Img;
            }
        }
    }
    protected void mnu_MenuItemClick(object sender, MenuEventArgs e)
    {
        if (e.Item.Text.ToString() == "SIGNOUT")
        {
            Session.Clear();
            mnu.Items[1].Enabled = false;
            mnu.Items[2].Enabled = false;
            mnu.Items[5].ChildItems[0].Enabled = true;
            mnu.Items[5].ChildItems[2].Enabled = false;
            mnu.Items[5].ChildItems[3].Enabled = false;
            lblUser.Text = "";
            Response.Redirect("Home.aspx");
        }
    }
    void SetMovie()
    {
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand("SELECT mvId,mvEndDt FROM tblMovieMaster WHERE mvIsAct='TRUE'", cn);
        ds = new DataSet();
        da = new SqlDataAdapter(cmd);
        da.Fill(ds);
        cn.Close();
        if (ds.Tables[0].Rows.Count > 0)
        {
            if (ds.Tables[0].Rows[0][1].ToString() == System.DateTime.Today.ToShortDateString())
            {
                Connection.AddUpdtDltData("UPDATE tblMovieMaster SET mvIsAct='FALSE' WHERE mvId="+ds.Tables[0].Rows[0][0].ToString()+"");
                Connection.AddUpdtDltData("UPDATE tblTicketBookingMaster SET tcktBkIsAct='FALSE' WHERE mvId=" + ds.Tables[0].Rows[0][0].ToString() + "");
                Connection.AddUpdtDltData("UPDATE tblTicketRateMaster SET tcktIsAct='FALSE' WHERE mvId=" + ds.Tables[0].Rows[0][0].ToString() + "");
                Connection.AddUpdtDltData("UPDATE tblTicketRateMaster SET tcktIsAct='FALSE' WHERE mvId=(SELECT MAX(mvId) FROM tblMovieMaster WHERE mvIsAct='TRUE')+1");
            }
        }
    }
}