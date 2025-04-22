using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.user
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        string connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["OTP"] == null)
                {
                    Response.Redirect("../user/Forget.aspx");
                }
            }
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            string newPassword = txtNewPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            string email = Session["Email"] as string;
            if (!string.IsNullOrEmpty(email))
            {
                
                UpdatePasswordInDatabase(email, newPassword);
                lblMessage.Text = "Password reset successfully!";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Password reset successfully!');", true);
                Session.Clear();
                Response.Redirect("../user/login.aspx");
            }
            else
            {
                lblMessage.Text = "Invalid request.";
            }
        }

        private void UpdatePasswordInDatabase(string email, string newPassword)
        {
           using(SqlConnection conn = new SqlConnection(connect))
            {
                string q = "update students set Password=@pass where EmailId=@email";
                using(SqlCommand cmd=new SqlCommand(q, conn))
                {
                    cmd.Parameters.AddWithValue("@pass", newPassword);
                    cmd.Parameters.AddWithValue("@email",email);
                    conn.Open();
                    cmd.ExecuteScalar();
                }
            }
        }
    }
}