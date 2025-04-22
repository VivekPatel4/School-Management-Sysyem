using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.Optimization;
using System.Web.UI;

namespace Student.admin
{
    public partial class edit_department1 : System.Web.UI.Page
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
                    if (int.TryParse(Request.QueryString["deptid"], out int departmentId))
                    {
                        LoadDepartmentData(departmentId);
                    }
                    else
                    {
                        ErrorPanel.Visible = true;
                        ErrorMessage.Text = "Invalid department ID.";
                    }
                }
            }
        }

        private void LoadDepartmentData(int departmentId)
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                string query = "SELECT DepartmentName, DepartmentShortName, DepartmentCode FROM departments WHERE id = @id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@id", departmentId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtdeptname.Text = reader["DepartmentName"].ToString();
                    txtshortform.Text = reader["DepartmentShortName"].ToString();
                    txtcode.Text = reader["DepartmentCode"].ToString();
                }
                else
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "Department data not found.";
                }
                con.Close();
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void btndepartment_Click(object sender, EventArgs e)
        {
            if (int.TryParse(Request.QueryString["deptid"], out int departmentId))
            {
                using (SqlConnection con = new SqlConnection(connect))
                {
                    string q = "UPDATE departments SET DepartmentName = @DepartmentName, DepartmentShortName = @DepartmentShortName, DepartmentCode = @DepartmentCode WHERE id = @id";
                    SqlCommand cmd = new SqlCommand(q, con);

                    cmd.Parameters.AddWithValue("@DepartmentName", txtdeptname.Text.Trim());
                    cmd.Parameters.AddWithValue("@DepartmentShortName", txtshortform.Text.Trim());
                    cmd.Parameters.AddWithValue("@DepartmentCode", txtcode.Text.Trim());
                    cmd.Parameters.AddWithValue("@id", departmentId);

                    con.Open();
                    int r = cmd.ExecuteNonQuery();

                    if (r > 0)
                    {
                        SuccessPanel.Visible = true;
                        SuccessMessage.Text = "<script> alert('Department updated successfully.')</script>"+ "Department updated successfully.";
                    }
                    else
                    {
                        ErrorPanel.Visible = true;
                        ErrorMessage.Text = "Error updating department.";
                    }
                    con.Close();
                }
            }
            else
            {
                ErrorPanel.Visible = true;
                ErrorMessage.Text = "Invalid department ID.";
            }
        }
    }
}
