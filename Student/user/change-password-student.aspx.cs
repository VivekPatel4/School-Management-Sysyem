using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Activities;

namespace Student.user
{
    public partial class change_password_student : System.Web.UI.Page
    {
        string connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["sid"] == null)
                {
                    Response.Redirect("../user/login.aspx");
                }
            }
        }

        protected void btnpassword_Click(object sender, EventArgs e)
        {
            string existPassword=txtExistpass.Text.Trim();
            string newPassword = txtnpassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            string email = Session["stdlogin"].ToString();

            if(!String.IsNullOrEmpty(email))
            {
                using(SqlConnection conn = new SqlConnection(connect))
                {
                    string q = "SELECT Password FROM students WHERE EmailId=@username and Password=@password";
                    using(SqlCommand cmd = new SqlCommand(q, conn))
                    {
                       conn.Open();
                        cmd.Parameters.AddWithValue("@username", email);
                        cmd.Parameters.AddWithValue("@password", existPassword);
                        using (SqlDataReader r = cmd.ExecuteReader())
                        {
                            if(r.HasRows)
                            {
                                r.Close();

                                string q1 = "UPDATE students SET Password = @newpass WHERE EmailId = @username";
                                using (SqlCommand updateCmd = new SqlCommand(q1, conn))
                                {
                                    updateCmd.Parameters.AddWithValue("@username", email);
                                    updateCmd.Parameters.AddWithValue("@newpass", newPassword);

                                    int rowsAffected = updateCmd.ExecuteNonQuery();
                                    if (rowsAffected > 0)
                                    {
                                        lblMessage.Text = "Your password has been updated.";
                                        lblMessage.Visible = true;
                                    }
                                }
                            }
                            else
                            {
                                lblMessage.Text = "Sorry, your current password is wrong!";
                                lblMessage.Visible = true;
                            }
                        }
                    }
                }
            }
        }
    }
}