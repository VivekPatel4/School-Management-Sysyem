using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

namespace Student.teacher
{
    public partial class LeaveHistory : System.Web.UI.Page
    {
        String connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["tid"] == null)
                {
                    Response.Redirect("../teacher/login.aspx");
                }
                else
                {
                    LoadLeaveData();
                }
            }
        }

        private void LoadLeaveData()
        {
            using (SqlConnection conn = new SqlConnection(connect))
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
                          leaves.Status from leaves join students on leaves.stdid=students.id order by lid desc";
                SqlCommand cmd = new SqlCommand(q, conn);
                cmd.Parameters.AddWithValue("@status", 2);
                conn.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                rptleavehistory.DataSource = dt;
                rptleavehistory.DataBind();
            }
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