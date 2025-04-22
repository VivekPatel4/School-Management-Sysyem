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
    public partial class FeeStructure : System.Web.UI.Page
    {
        string connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
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
                    LoadFeeData();
                }
            }
        }

        private void LoadFeeData()
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                SqlCommand cmd = new SqlCommand("select * from FeeStructure", conn);
                conn.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                FeeStructureRepeater.DataSource = dt;
                FeeStructureRepeater.DataBind();
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void AddFeeStructureButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("add-FeeStructure.aspx");
        }

        protected void PaymentHistoryButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("AllPayments.aspx");
        }

        protected void FeeStructureRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {

                int FeeStructureId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"edit-FeeStructure.aspx?Feesid={FeeStructureId}");
            }
            else if (e.CommandName == "Delete")
            {

                using (SqlConnection conn = new SqlConnection(connect))
                {
                    string query = "DELETE FROM  FeeStructure WHERE id = @id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", e.CommandArgument);
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            SuccessPanel.Visible = true;
                            SuccessMessage.Text = "<script> alert(' FeeStructure deleted successfully.')</script>" + " FeeStructure deleted successfully.";
                        }
                        else
                        {
                            ErrorPanel.Visible = true;
                            ErrorMessage.Text = "Error deleting  FeeStructure.";
                        }

                        LoadFeeData();
                        conn.Close();
                    }
                }
            }
        }
    }
}