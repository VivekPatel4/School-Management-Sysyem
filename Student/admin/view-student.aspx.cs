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
    public partial class view_student : System.Web.UI.Page
    {
        String connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (Session["alogin"] == null)
                {
                    Response.Redirect("../admin/login.aspx");
                }
                else
                {
                    if (int.TryParse(Request.QueryString["studentid"],out int sid))
                    {
                        BindViewStudentData(sid);
                    }
                    
                }
            }
        }

        private void BindViewStudentData(int sid)
        {
            using(SqlConnection con=new SqlConnection(connect))
            {
                String q = "SELECT * FROM students WHERE id=@id";
                SqlCommand cmd =new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@id",sid);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt=new DataTable();
                sda.Fill(dt);
                StudentData.DataSource= dt;
                StudentData.DataBind();
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