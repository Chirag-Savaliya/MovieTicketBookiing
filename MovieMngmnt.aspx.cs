using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class MovieMngmnt : System.Web.UI.Page
{
    SqlConnection cn;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataSet ds;
    string[] asd;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ((Menu)this.Master.FindControl("mnu")).Items[2].ChildItems[1].Selected = true;
            txtStrtDt.Text = System.DateTime.Today.ToShortDateString();
            BindGrid("SELECT mvId,mvName,mvStrtDt,mvEndDt FROM tblMovieMaster WHERE mvId=(SELECT MAX(mvId) FROM tblMovieMaster WHERE mvIsAct='TRUE')");
        }
    }
    protected void btnClndrMvStrtDt_Click(object sender, EventArgs e)
    {
        if (clndr.Visible == true) clndr.Visible = false;
        else clndr.Visible = true;
    }
    protected void clndr_SelectionChanged(object sender, EventArgs e)
    {
        txtStrtDt.Text = ((Calendar)sender).SelectedDate.ToShortDateString();
        SetEndDate();
        clndr.Visible = false;
    }
    protected void btnAddMv_Click(object sender, EventArgs e)
    {
        /*
            if(System.DateTime.Today.CompareTo(sd) == 0) => Both Date Are Equals
         * if(System.DateTime.Today.CompareTo(sd) == -1) => First Date (Here Current Date) Is Smaller Than Second Date (Here Movie Start Date)
         * if(System.DateTime.Today.CompareTo(sd) == 1) => First Date (Here Current Date) Is Larger Than Second Date (Here Movie Start Date)
         */
        asd = txtStrtDt.Text.ToString().Split('/');
        DateTime sd = new DateTime(int.Parse(asd[2]), int.Parse(asd[0]), int.Parse(asd[1]));
        if (System.DateTime.Today.CompareTo(sd) == 1)
        {
            lblError.Text = "Select Valid Start Date.Start Date Must Be Greater Than Or Equal To Current Date.";
        }
        else if (flUpldMvBnr.FileName.ToString().Length < 1)
        {
            lblError.Text = "Upload File";
        }
        else if(!Connection.ChkFileExtension(flUpldMvBnr.FileName.ToString()))
        {
            lblError.Text = "Upload Valid File.File Must Be Either JPG Or PNG";
        }
        else
        {
            lblError.Text = "";
            if (txtStrtDt.Text.ToString() == System.DateTime.Today.ToShortDateString())
            {
                if (!ChkCurrentMovie())
                {
                    AddData("INSERT INTO tblMovieMaster VALUES((SELECT MAX(mvId) FROM tblMovieMaster)+1,'" + txtMoviName.Text + "','" + txtStrtDt.Text + "','" + txtEndDt.Text + "',@Photo,'TRUE')");
                    ResetControls();
                }
                else lblError.Text = "Already One Movie Running Currently.Change Start Date Of Movie.";
            }
            else
            {
                if (!ChkStrtEndDt())
                {
                    lblError.Text = "Select Valid Start Date.Start Date Must Be Greater Than Or Equal To End Date Of Last Added Movie.";
                }
                else
                {
                    AddData("INSERT INTO tblMovieMaster VALUES((SELECT MAX(mvId) FROM tblMovieMaster)+1,'" + txtMoviName.Text + "','" + txtStrtDt.Text + "','" + txtEndDt.Text + "',@Photo,'FALSE')");
                    ResetControls();
                }
            }
            BindGrid("SELECT mvId,mvName,mvStrtDt,mvEndDt FROM tblMovieMaster WHERE mvId=(SELECT MAX(mvId) FROM tblMovieMaster WHERE mvIsAct='TRUE')");
        }
    }
    void SetEndDate()
    {
        if (txtMvDays.Text.Length < 1)
        {
            lblError.Text = "Movie Days Must Not Be Empty.";
        }
        else
        {
            try
            {
                if (int.Parse(txtMvDays.Text.ToString()) >= 1 && int.Parse(txtMvDays.Text.ToString()) <= 15)
                {
                    asd = txtStrtDt.Text.ToString().Split('/');
                    DateTime ed = new DateTime(int.Parse(asd[2]), int.Parse(asd[0]), int.Parse(asd[1]));
                    ed = ed.AddDays(int.Parse(txtMvDays.Text.ToString()));
                    txtEndDt.Text = ed.ToShortDateString();
                    lblError.Text = "";
                }
                else
                {
                    lblError.Text = "Value Of Movie Days Must Be Greater Than Or Equal To 1 And Less Than Or Equal To 15.";
                }
            }
            catch (Exception mvdys)
            {
                lblError.Text = "Enter Valid Value Of Movie Days.";
            }
        }
    }
    protected void txtMvDays_TextChanged(object sender, EventArgs e)
    {
        SetEndDate();
    }
    void ResetControls()
    {
        txtMoviName.Text = "";
        txtMvDays.Text = "";
        txtStrtDt.Text = System.DateTime.Today.ToShortDateString();
        txtEndDt.Text = "";
        lblError.Text = "";
    }
    void BindGrid(string Qry)
    {
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand(Qry, cn);
        da = new SqlDataAdapter(cmd);
        ds = new DataSet();
        da.Fill(ds);
        cn.Close();
        cn.Dispose();
        cmd.Dispose();
        da.Dispose();
        if (ds.Tables[0].Rows.Count >= 1)
        {
            dtGrdMv.DataSource = ds.Tables[0];
            dtGrdMv.DataBind();
            dtGrdMv.Visible = true;
        }
        else dtGrdMv.Visible = false;
    }
    protected void Select_Movies(object sender, EventArgs e)
    {
        if (((RadioButton)sender).Text.ToString() == "Current Movie")
            BindGrid("SELECT mvId,mvName,mvStrtDt,mvEndDt FROM tblMovieMaster WHERE mvId=(SELECT MAX(mvId) FROM tblMovieMaster WHERE mvIsAct='TRUE')");
        else BindGrid("SELECT mvId,mvName,mvStrtDt,mvEndDt FROM tblMovieMaster WHERE mvId>0 AND mvIsAct='FALSE'");
    }
    void AddData(string Q)
    {
        Byte[] img = flUpldMvBnr.FileBytes;
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand(Q, cn);
        cmd.Parameters.AddWithValue("@Photo", img);
        cmd.ExecuteNonQuery();
        cn.Close();
        Response.Write("<script>alert('Movie Added Successfully.')</script>");
    }
    Boolean ChkCurrentMovie()
    {
        Boolean r=false;
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand("SELECT * FROM tblMovieMaster WHERE mvStrtDt='"+txtStrtDt.Text+"' AND mvIsAct='TRUE'", cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            if (dr.HasRows) r = true;
        }
        cn.Close();
        return r;
    }
    Boolean ChkStrtEndDt()
    {
        Boolean rs = false;
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand("SELECT mvEndDt FROM tblMovieMaster WHERE mvId=(SELECT MAX(mvId) FROM tblMovieMaster WHERE mvId>0)", cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            if (dr.HasRows)
            {
                string[] sdt=txtStrtDt.Text.ToString().Split('/');
                string[] edt = dr[0].ToString().Split('/');
                DateTime sd = new DateTime(int.Parse(sdt[2]),int.Parse(sdt[0]),int.Parse(sdt[1]));
                DateTime ed = new DateTime(int.Parse(edt[2]),int.Parse(edt[0]),int.Parse(edt[1]));
                if (sd.CompareTo(ed) == -1)
                    rs = false;
                else rs = true;
            }
        }
        cn.Close();
        return rs;
    }
    protected void btnCnclMv_Click(object sender, EventArgs e)
    {
        ResetControls();
    }
}