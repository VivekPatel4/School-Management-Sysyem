using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data.SqlClient;

namespace Student.teacher
{
    public partial class Forgot : System.Web.UI.Page
    {
        string connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSendOTP_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();

            if (string.IsNullOrEmpty(email))
            {
                lblMessage.Text = "Please enter Email.";
                return;
            }

            bool teacherExists = false;

            using (SqlConnection conn = new SqlConnection(connect))
            {
                string q = "SELECT id FROM teacher WHERE EmailId=@Email";
                using (SqlCommand cmd = new SqlCommand(q, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);

                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    teacherExists = (result != null);
                }
            }

            if (!teacherExists)
            {
                lblMessage.Text = "No teacher found with the provided Email.";
                return;
            }


            Random random = new Random();
            int otp = random.Next(100000, 999999);

            Session["OTP"] = otp.ToString();
            Session["Email"] = email;

            try
            {
                SendOTPEmail(email, otp);

                lblMessage.Text = "OTP sent to your email. Please check your inbox.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('OTP sent to your email. Please check your inbox.');", true);

                Response.Redirect("VerifyOTP.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Failed to send OTP. Error: " + ex.Message;
            }
        }

        private void SendOTPEmail(string email, int otp)
        {
            string smtpAddress = "smtp.gmail.com";
            int portNumber = 587;
            bool enableSSL = true;

            string emailFrom = "swaminarayan099909@gmail.com";
            string password = "lreu zlae lwoy zzib";

            string subject = "Your OTP for Password Reset";
            string body = $"Your OTP for password reset is: <b>{otp}</b>. Do not share this with anyone.";

            using (MailMessage mail = new MailMessage())
            {
                mail.From = new MailAddress(emailFrom);
                mail.To.Add(email);
                mail.Subject = subject;
                mail.Body = body;
                mail.IsBodyHtml = true;

                using (SmtpClient smtp = new SmtpClient(smtpAddress, portNumber))
                {
                    smtp.Credentials = new NetworkCredential(emailFrom, password);
                    smtp.EnableSsl = enableSSL;
                    smtp.Send(mail);
                }
            }
        }
    }
}