using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.admin
{
    public partial class view_teacher : System.Web.UI.Page
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
                    if (int.TryParse(Request.QueryString["teacherid"], out int tid))
                    {
                        BindViewTeacherData(tid);
                    }

                }
            }
        }

        private void BindViewTeacherData(int tid)
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                String q = "SELECT * FROM teacher WHERE id=@id";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@id", tid);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                TeacherData.DataSource = dt;
                TeacherData.DataBind();
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