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
    public partial class add_remainder : System.Web.UI.Page
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

        protected void btnAddRemainder_Click(object sender, EventArgs e)
        {
            using(SqlConnection con=new SqlConnection(connect))
            {
                String q = "INSERT INTO remainder(Name,MOBILENO,remark,wishyear,IsRead) VALUES(@name,@mobileno,@remark,@wishyear,@isread)";
                SqlCommand cmd=new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@name", txtname.Text);
                cmd.Parameters.AddWithValue("@mobileno", txtmobile.Text);
                cmd.Parameters.AddWithValue("@remark", txtremark.Text);
                cmd.Parameters.AddWithValue("@wishyear", txtdate.Text);
                cmd.Parameters.AddWithValue("@isread", 0);
                con.Open();
                int r=cmd.ExecuteNonQuery();    
                if(r == 0)
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "Error: Please try again.";
                }
                else
                {
                    SuccessPanel.Visible = true;
                    SuccessMessage.Text = "Remainder record added successfully.";
                }
                con.Close();
                Clear();
            }
        }

        private void Clear()
        {
            txtname.Text=String.Empty;
            txtmobile.Text=String.Empty;
            txtremark.Text=String.Empty;
            txtdate.Text=String.Empty;
        }
    }
}