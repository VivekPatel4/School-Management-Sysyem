using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace Student.user
{
    public partial class leave : System.Web.UI.Page
    {
        String connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (Session["stdlogin"] == null)
                {
                    Response.Redirect("../user/login.aspx");
                }
                else
                {
                    Loadleavetype();
                }
            }
        }

        private void Loadleavetype()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                SqlCommand cmd = new SqlCommand("SELECT LeaveType FROM leavetype", con);
                con.Open();
                SqlDataReader r = cmd.ExecuteReader();
                ddlLeaveType.DataSource = r;
                ddlLeaveType.DataTextField = "LeaveType";
                ddlLeaveType.DataBind();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string stdid = Session["sid"].ToString();
            string leavetype = ddlLeaveType.SelectedValue; 
            string fromdate = txtFromDate.Text; 
            string todate = txtToDate.Text;
            string description = txtConditions.Text; 
            int status = 0;
            int isread = 0;
            if (DateTime.Parse(fromdate) > DateTime.Parse(todate))
            {
                ErrorPanel.Visible = true;
                ErrorMessage.Text = "Please enter correct details: End Date should be ahead of Starting Date!";
                return;
            }
            using(SqlConnection con = new SqlConnection(connect))
            {
                string q = "INSERT INTO leaves (LeaveType, ToDate, FromDate, Description, Status, IsRead, stdid) " +
                           "VALUES (@LeaveType, @ToDate, @FromDate, @Description, @Status, @IsRead, @stdId)";
                SqlCommand cmd=new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@LeaveType", leavetype);
                cmd.Parameters.AddWithValue("@ToDate", todate);
                cmd.Parameters.AddWithValue("@FromDate", fromdate);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@IsRead", isread);
                cmd.Parameters.AddWithValue("@stdId", stdid);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                if (r == 0)
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "Sorry, could not process at this time. Please try again later.";
                }
                else
                {
                    SuccessPanel.Visible = true;
                    SuccessMessage.Text = "Your leave application has been applied. Thank you.";
                }
                con.Close();
                Clear();

            }
        }

        private void Clear()
        {
            txtFromDate.Text = string.Empty;
            txtToDate.Text = string.Empty;
            ddlLeaveType.SelectedIndex = 0;
            txtConditions.Text = string.Empty;
        }
    }
}