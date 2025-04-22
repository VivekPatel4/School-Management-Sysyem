using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.admin
{
    public partial class birthdate : System.Web.UI.Page
    {
        String connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["alogin"] == null)
            {
                Response.Redirect("../admin/login.aspx");
            }
            else
            {
                BindBirthData();
                SendBirthdayEmails();
            }

        }

        private void BindBirthData()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                int currentMonth = DateTime.Now.Month;
                int currentDay = DateTime.Now.Day;
                string q = "SELECT * FROM students WHERE DATEPART(MONTH, Dob) = @CurrentMonth AND DATEPART(DAY, Dob) = @CurrentDay";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@CurrentMonth", currentMonth);
                cmd.Parameters.AddWithValue("@CurrentDay", currentDay);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                BirthDateData.DataSource = dt;
                BirthDateData.DataBind();
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
        public void SendBirthdayEmails()
        {

            DateTime currentDate = DateTime.Now;


            using (SqlConnection con = new SqlConnection(connect))
            {
                string query = "SELECT * FROM students WHERE DATEPART(MONTH, Dob) = @Month AND DATEPART(DAY, Dob) = @Day";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Month", currentDate.Month);
                cmd.Parameters.AddWithValue("@Day", currentDate.Day);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    string email = reader["EmailId"].ToString();
                    string firstName = reader["FirstName"].ToString();
                    string lastName = reader["LastName"].ToString();


                    SendBirthdayEmail(email, firstName, lastName);
                }
            }
        }
        public void SendBirthdayEmail(string email, string firstName, string lastName)
        {
            try
            {

                string subject = "🎉 Happy Birthday Wishes from BAPS Chhatralaya Anand!";
                string body = $"Dear {firstName} {lastName},\n\nHappy Birthday! 🎂🎉\n\nWe hope your special day is filled with joy, laughter, and wonderful memories. Wishing you a\nfantastic year ahead filled with success and happiness!\nBest regards,\nBAPS Chhatralaya Anand";
                
                
                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com")
                {
                    Port = 587,
                    Credentials = new NetworkCredential("swaminarayan099909@gmail.com", "lreu zlae lwoy zzib"),
                    EnableSsl = true
                };


                MailMessage message = new MailMessage
                {
                    From = new MailAddress("swaminarayan099909@gmail.com"),
                    Subject = subject,
                    Body = body
                };
                message.To.Add(email);


                smtpClient.Send(message);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('send email done!');", true);

            }
            catch (Exception)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('send email not error!');", true);

            }
        }

    }
}