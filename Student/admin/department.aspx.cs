using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.admin
{
    public partial class department : System.Web.UI.Page
    {
        String connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                if (Session["alogin"] == null)
                {
                    Response.Redirect("../admin/login.aspx");
                }
                else 
                {
                    BindDepartmentData();
                }
            }
            
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        private void BindDepartmentData()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM departments", con))
                {
                    con.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        DepartmentRepeater.DataSource = dt;
                        DepartmentRepeater.DataBind();
                    }
                }
            }
        }        

        protected void DepartmentRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                
                int departmentId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"edit-department.aspx?deptid={departmentId}");
            }
            else if (e.CommandName == "Delete")
            {
               
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    string query = "DELETE FROM departments WHERE id = @id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", e.CommandArgument);
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            SuccessPanel.Visible = true;
                            SuccessMessage.Text = "<script> alert('Department deleted successfully.')</script>"+"Department deleted successfully.";
                        }
                        else
                        {
                            ErrorPanel.Visible = true;
                            ErrorMessage.Text = "Error deleting department.";
                        }

                        BindDepartmentData(); 
                        conn.Close();
                    }
                }
            }
        }
        

        protected void AddDepartmentButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("add-department.aspx");
        }
    }
}