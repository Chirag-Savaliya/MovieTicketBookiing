using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class BnnrsMngmnt : System.Web.UI.Page
{
    SqlConnection cn;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataSet ds;
    Random r = new Random(0);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindGrid();
        }
        ((Menu)this.Master.FindControl("mnu")).Items[2].ChildItems[0].Selected = true;
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (flUpld.HasFile)
        {
            string[] fle = flUpld.FileName.ToString().Split('.');
            if (fle[fle.Length - 1] == "jpg" || fle[fle.Length - 1] == "jpeg")
            {
                byte[] img = flUpld.FileBytes;
                cn = new SqlConnection(Connection.cnstr);
                cn.Open();
                cmd = new SqlCommand("INSERT INTO tblBnrsMngmnt VALUES((SELECT MAX(bnrId) FROM tblBnrsMngmnt)+1,@photo,'TRUE')", cn);
                cmd.Parameters.AddWithValue("@photo", img);
                cmd.ExecuteNonQuery();
                cn.Close();
                Response.Write("<script>alert('Banner Added Successfully.')</script>'");
            }
            else
            {
                lblError.Text = " * Only JPG Or JPEG Image File Can Be Uploaded";
            }
            BindGrid();
            MovieTickeBooking m = new MovieTickeBooking();
            m.GetBannersImgsId();
            //lblError.Text = "";
        }
        else lblError.Text = " * Uploaded Any Image File";
    }
    void BindGrid()
    {
        cn = new SqlConnection(Connection.cnstr);
        cn.Open();
        cmd = new SqlCommand("SELECT bnrId FROM tblBnrsMngmnt WHERE bnrIsAct='TRUE'", cn);
        da = new SqlDataAdapter(cmd);
        ds = new DataSet();
        da.Fill(ds);
        cn.Close();
        cn.Dispose();
        cmd.Dispose();
        da.Dispose();
        if (ds.Tables[0].Rows.Count >= 1)
        {
            dtGrdBnnr.DataSource = ds.Tables[0];
            dtGrdBnnr.DataBind();
            dtGrdBnnr.Visible = true;
        }
        else dtGrdBnnr.Visible = false;
    }
    protected void dtGrdBnnr_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        Connection.AddUpdtDltData("UPDATE tblBnrsMngmnt SET bnrIsAct='FALSE' WHERE bnrId=" + int.Parse(dtGrdBnnr.Rows[e.RowIndex].Cells[1].Text.ToString()) + "");
        BindGrid();
    }
    protected void chbxHdr_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gr in dtGrdBnnr.Rows)
        {
            ((CheckBox)gr.FindControl("chbxClmn")).Checked = ((CheckBox)dtGrdBnnr.HeaderRow.FindControl("chbxHdr")).Checked;
        }
        if (((CheckBox)dtGrdBnnr.HeaderRow.FindControl("chbxHdr")).Checked)
            btnDltAll.Visible = true;
        else
            btnDltAll.Visible = false;
    }
    protected void btnDltAll_Click(object sender, EventArgs e)
    {
        string rowsId = "";
        foreach (GridViewRow gr in dtGrdBnnr.Rows)
        {
            if (((CheckBox)gr.FindControl("chbxClmn")).Checked)
            {
               rowsId+=gr.Cells[1].Text.ToString();
               rowsId += ",";
            }
        }
        rowsId = rowsId.Substring(0, rowsId.Length - 1);
        Connection.AddUpdtDltData("UPDATE tblBnrsMngmnt SET bnrIsAct='FALSE' WHERE bnrId IN("+rowsId+")");
        BindGrid();
    }
    protected void chbxClmn_CheckedChanged(object sender, EventArgs e)
    {
        int x = 0;
        foreach (GridViewRow gr in dtGrdBnnr.Rows)
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
}
