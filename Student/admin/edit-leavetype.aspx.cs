using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Runtime.CompilerServices.RuntimeHelpers;

namespace Student.admin
{
    public partial class edit_leavetype : System.Web.UI.Page
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
                    if (int.TryParse(Request.QueryString["ltypeid"], out int typeId))
                    {
                        LoadLeaveTypeData(typeId);
                    }
                    else
                    {
                        ErrorPanel.Visible = true;
                        ErrorMessage.Text = "Invalid LeaveType ID.";
                    }
                }
            }
        }

        private void LoadLeaveTypeData(int typeId)
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                string q = "SELECT LeaveType, Description FROM leavetype WHERE id = @id";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@id", typeId);

                con.Open();
                SqlDataReader r = cmd.ExecuteReader();
                if (r.Read())
                {
                    txtleavetype.Text = r["LeaveType"].ToString();
                    txtdescription.Text = r["Description"].ToString();
                }
                else
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "LeaveType data not found.";
                }
                con.Close();
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void btnleavetype_Click(object sender, EventArgs e)
        {
            if (int.TryParse(Request.QueryString["ltypeid"], out int typeId))
            {
                using (SqlConnection con = new SqlConnection(connect))
                {
                    string q = "UPDATE leavetype SET LeaveType = @LeaveType, Description = @Description WHERE id = @id";
                    SqlCommand cmd = new SqlCommand(q, con);

                    cmd.Parameters.AddWithValue("@LeaveType", txtleavetype.Text.Trim());
                    cmd.Parameters.AddWithValue("@Description", txtdescription.Text.Trim());
                    cmd.Parameters.AddWithValue("@id",typeId );

                    con.Open();
                    int r = cmd.ExecuteNonQuery();

                    if (r > 0)
                    {
                        SuccessPanel.Visible = true;
                        SuccessMessage.Text = "<script> alert('LeaveType updated successfully.')</script>" + "LeaveType updated successfully.";
                    }
                    else
                    {
                        ErrorPanel.Visible = true;
                        ErrorMessage.Text = "Error updating LeaveType.";
                    }
                    con.Close();
                }
            }
            else
            {
                ErrorPanel.Visible = true;
                ErrorMessage.Text = "Invalid LeaveType ID.";
            }
        }
    }
}