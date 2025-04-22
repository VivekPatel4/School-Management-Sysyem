using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.admin
{
    public partial class leave : System.Web.UI.Page
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
                    BindLeavetypeData();
                }
            }
        }

        private void BindLeavetypeData()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM leavetype", con))
                {
                    con.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        LeavetypeRepeater.DataSource = dt;
                        LeavetypeRepeater.DataBind();
                    }
                }
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void AddLeaveTypeButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("add-leavetype.aspx");
        }

        protected void LeavetypeRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                int typeId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"edit-leavetype.aspx?ltypeid={typeId}");
            }
            if(e.CommandName == "Delete")
            {
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    string query = "DELETE FROM leavetype WHERE id = @id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", e.CommandArgument);
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            SuccessPanel.Visible = true;
                            SuccessMessage.Text = "<script> alert('LeaveType deleted successfully.')</script>" + "LeaveType deleted successfully.";
                        }
                        else
                        {
                            ErrorPanel.Visible = true;
                            ErrorMessage.Text = "Error deleting LeaveType.";
                        }

                        BindLeavetypeData();
                        conn.Close();
                    }
                }
            }
        }
    }
}