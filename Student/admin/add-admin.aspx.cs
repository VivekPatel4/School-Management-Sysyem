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
    public partial class add_admin : System.Web.UI.Page
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

        protected void btnAddAdmin_Click(object sender, EventArgs e)
        {
            using(SqlConnection con=new SqlConnection(connect))
            {
                String q = "insert into admin(fullname,email,UserName,Password,updationDate) values('"+txtfullname.Text+"','"+txtemail.Text+"','"+txtusername.Text+"','"+txtpassword.Text +"',GETDATE())";
                SqlCommand cmd = new SqlCommand(q,con);
                con.Open();
                int r=cmd.ExecuteNonQuery();
                if (r == 0)
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "Administrator Not Insert Please TRy Again";
                }
                else
                {
                    SuccessPanel.Visible = true;
                    SuccessMessage.Text = "<script> alert('Administrator Add successfully.')</script>" + "Administrator Add successfully";
                }
                con.Close();
                clearform();
            }
        }

        private void clearform()
        {
            txtfullname.Text=String.Empty;
            txtemail.Text=String.Empty;
            txtusername.Text=String.Empty;
            txtpassword.Text=String.Empty;
            txtconfirmpassword.Text=String.Empty;
        }
    }
}