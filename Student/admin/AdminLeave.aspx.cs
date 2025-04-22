using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Activities;

namespace Student.admin
{
    public partial class AdminLeave : System.Web.UI.Page
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
                else
                {
                    LoadStudentName();
                    LoadLeaveTypes();
                }
            }
        }

        private void LoadLeaveTypes()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM leavetype ", con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                ddlLeaveType.DataSource = dt;
                ddlLeaveType.DataTextField = "LeaveType";
                ddlLeaveType.DataValueField = "LeaveType";
                ddlLeaveType.DataBind();
            }
        }

        private void LoadStudentName()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                string query = "SELECT stdid, FirstName, LastName,id FROM students";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dataTable = new DataTable();
                sda.Fill(dataTable);

                dataTable.Columns.Add("FullName", typeof(string), "stdid + ' ' + FirstName + ' ' + LastName");
               
                ddlStdName.DataSource = dataTable;
                ddlStdName.DataTextField = "FullName";
                ddlStdName.DataValueField = "id";
                ddlStdName.DataBind();
               
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string stdid = ddlStdName.SelectedValue;
            string leavetype = ddlLeaveType.SelectedValue;
            string fromdate = txtFromDate.Text;
            string todate = txtToDate.Text;
            string description = txtDescription.Text;
            int status = 1;
            int isread = 0;


           
            if (Convert.ToDateTime(fromdate) > Convert.ToDateTime(todate))
            {
                ErrorPanel.Visible = true;
                ErrorMessage.Text = "Please enter correct details: End Date should be ahead of Starting Date in order to be valid!";
            }
            else
            {
                using (SqlConnection con = new SqlConnection(connect))
                {
                    string q = "INSERT INTO leaves (LeaveType, FromDate, ToDate,AdminRemark,AdminRemarkDate, Description, Status, IsRead, stdid) " +
                                  "VALUES (@leavetype, @fromdate, @todate,@adminremark,@AdminRemarkDate, @description, @status, @isread, @stdid)";
                    SqlCommand cmd = new SqlCommand(q, con);
                    cmd.Parameters.AddWithValue("@leavetype", leavetype);
                    cmd.Parameters.AddWithValue("@fromdate", fromdate);
                    cmd.Parameters.AddWithValue("@todate", todate);
                    cmd.Parameters.AddWithValue("@adminremark", "Leave approved by Admin");
                    cmd.Parameters.AddWithValue("@AdminRemarkDate",DateTime.Now);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@status", status);
                    cmd.Parameters.AddWithValue("@isread", isread);
                    cmd.Parameters.AddWithValue("@stdid", stdid);
                    con.Open();
                    int r = cmd.ExecuteNonQuery();
                    if (r > 0)
                    {
                        SuccessPanel.Visible = true;
                        SuccessMessage.Text = "leave application has been applied. Thank you.";
                    }
                    else
                    {
                        ErrorPanel.Visible = true;
                        ErrorMessage.Text = "Sorry, could not process this time. Please try again later.";
                    }

                }
            }
        }
    }
}