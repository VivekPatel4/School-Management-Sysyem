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
    public partial class Remainder : System.Web.UI.Page
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
                    LoadRemainderdata();
                    
                    
                }
            }
        }

       

        private void LoadRemainderdata()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                String q = "select *  from remainder";
                SqlCommand cmd = new SqlCommand(q, con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                RemainderRepeater.DataSource = dt;
                RemainderRepeater.DataBind();
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void AddRemainderButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("add-remainder.aspx");
        }

        protected void RemainderRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    string query = "DELETE FROM remainder WHERE id = @id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", e.CommandArgument);
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {

                            SuccessPanel.Visible = true;
                            SuccessMessage.Text = "<script> alert('Remainder deleted successfully.')</script>" + "Remainder deleted successfully.";
                        }
                        else
                        {
                            ErrorPanel.Visible = true;
                            ErrorMessage.Text = "Error deleting Remainder.";
                        }
                        LoadRemainderdata();
                        conn.Close();
                    }           
                }
            }
        }

    }
}
