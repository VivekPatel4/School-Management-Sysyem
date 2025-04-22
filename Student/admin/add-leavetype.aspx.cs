using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Runtime.CompilerServices.RuntimeHelpers;

namespace Student.admin
{
    public partial class add_leavetype : System.Web.UI.Page
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
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void btnleavetype_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                String q = "insert into leavetype(LeaveType,Description,CreationDate) values('" + txtleavetype.Text + "','" + txtdescription.Text + "',GETDATE())";
                SqlCommand cmd = new SqlCommand(q, con);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                if (r == 0)
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "LeaveType Not Insert Please Try again";
                }
                else
                {
                    SuccessPanel.Visible = true;
                    SuccessMessage.Text = "<script> alert('LeaveType Add successfully.')</script>" + "LeaveType Add successfully";
                }
                con.Close();
                Clear();
            }
        }

        private void Clear()
        {
            txtleavetype.Text= string.Empty;
            txtdescription.Text= string.Empty;
        }
    }
}