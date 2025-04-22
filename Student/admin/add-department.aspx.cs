using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.admin
{
    public partial class edit_department : System.Web.UI.Page
    {
        String connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                if (Session["alogin"] == null)
                {
                    Response.Redirect("../admin/login.aspx");
                }
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void btndepartment_Click(object sender, EventArgs e)
        {
            using(SqlConnection con= new SqlConnection(connect))
            {
                String q = "insert into departments(DepartmentName,DepartmentShortName,DepartmentCode,CreationDate) values('"+txtdeptname.Text+"','"+ txtshortform.Text+ "','"+ txtcode.Text+ "',GETDATE())";
                SqlCommand cmd=new SqlCommand(q, con);
                con.Open();
                int r=cmd.ExecuteNonQuery();
                if(r == 0)
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text ="Department Not Insert Please Try again";
                }
                else
                {
                    SuccessPanel.Visible = true;
                    SuccessMessage.Text = "<script> alert('Department Add successfully.')</script>"+"Department Add successfully";
                }
                con.Close();
                Clear();
            }
        }

        private void Clear()
        {
            txtdeptname.Text=string.Empty;
            txtshortform.Text=string.Empty;
            txtcode.Text=string.Empty;
        }
    }
}