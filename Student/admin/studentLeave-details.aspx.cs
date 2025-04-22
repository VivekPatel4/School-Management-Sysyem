using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Student.admin
{
    public partial class studentLeave_details : System.Web.UI.Page
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
                    int leaveId = Convert.ToInt32(Request.QueryString["leaveid"]);
                    if (leaveId > 0)
                    {
                        LoadLeaveDetails(leaveId);
                        UpdateIsReadStatus(leaveId);
                    }
                }
            }
        }

        private void UpdateIsReadStatus(int leaveId)
        {
            string query = "UPDATE leaves SET IsRead = @IsRead WHERE id = @LeaveId";

            using (SqlConnection conn = new SqlConnection(connect))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@IsRead", 1);
                    cmd.Parameters.AddWithValue("@LeaveId", leaveId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void LoadLeaveDetails(int leaveId)
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                string query = @"SELECT 
                            leaves.id as lid,
                            students.FirstName,
                            students.LastName,
                            students.stdid,
                            students.Gender,
                            students.Phonenumber,
                            students.EmailId,
                            leaves.LeaveType,
                            leaves.ToDate,
                            leaves.FromDate,
                            leaves.Description,
                            leaves.PostingDate,
                            leaves.Status,
                            leaves.AdminRemark,
                            leaves.AdminRemarkDate
                         FROM leaves 
                         JOIN students ON leaves.stdid = students.id
                         WHERE leaves.id = @LeaveId";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@LeaveId", leaveId);
                conn.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                rptLeaveDetails.DataSource = dt;
                rptLeaveDetails.DataBind(); 
            }
        }




        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void btnUpdateLeave_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int leaveId = Convert.ToInt32(btn.CommandArgument);

            RepeaterItem item = (RepeaterItem)btn.NamingContainer;

            DropDownList ddlStatus = (DropDownList)item.FindControl("ddlStatus");
            TextBox txtDescription = (TextBox)item.FindControl("txtDescription");

            string status = ddlStatus.SelectedValue;  
            string description = txtDescription.Text.Trim(); 

            int statusValue = 2;  
            if (status == "1") statusValue = 1;  
            else if (status == "0") statusValue = 0;  

            using (SqlConnection conn = new SqlConnection(connect))
            {
                string query = "UPDATE leaves SET AdminRemark = @Description, Status = @Status, AdminRemarkDate = @AdmRemarkDate WHERE id = @LeaveId";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@Status", statusValue);  
                    cmd.Parameters.AddWithValue("@AdmRemarkDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@LeaveId", leaveId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
           
            LoadLeaveDetails(leaveId);  
        }


        protected void rptLeaveDetails_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DropDownList ddlStatus = (DropDownList)e.Item.FindControl("ddlStatus");
         
                string status = DataBinder.Eval(e.Item.DataItem, "Status").ToString();
              
                if (ddlStatus != null && status != null)
                {
                    ddlStatus.SelectedValue = status;  
                }
            }
        }

    }

}



