using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.admin
{
    public partial class PendingHistory : System.Web.UI.Page
    {
        String connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["alogin"] == null)
                {
                    Response.Redirect("../admin/login.aspx");
                }
                else
                {
                    Loadpendingdata();
                }
            }
        }

        private void Loadpendingdata()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                string q = @"SELECT 
                          leaves.id as lid,
                          students.photo,
                          students.FirstName,
                          students.LastName,
                          students.stdid,
                          students.id,
                          leaves.LeaveType,
                          leaves.PostingDate,
                          leaves.Status from leaves join students on leaves.stdid=students.id where leaves.Status=@status order by lid desc";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@status", 0);
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt=new DataTable();
                sda.Fill(dt);
                rptpending.DataSource = dt;
                rptpending.DataBind();
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }
        protected string GetImageUrl(string photo)
        {
            if (!string.IsNullOrEmpty(photo))
            {
                return ResolveUrl(photo);
            }
            return ResolveUrl("~/admin/images/no_image.png");
        }

      
    }
}