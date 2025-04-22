using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.teacher
{
    public partial class VerifyOTP : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["OTP"]==null)
                {
                    Response.Redirect("../teacher/Forget.aspx");
                }
            }
        }

        protected void btnVerifyOTP_Click(object sender, EventArgs e)
        {
            string enteredOTP = txtotp.Text.Trim();
            string sessionOTP = Session["OTP"] as string;

            if (enteredOTP == sessionOTP)
            {
                Response.Redirect("ResetPassword.aspx"); 
            }
            else
            {
                lblMessage.Text = "Invalid OTP. Please try again.";
            }
        }
    }
}