using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Runtime.CompilerServices.RuntimeHelpers;

namespace Student.admin
{
    public partial class edit_FeeStructure : System.Web.UI.Page
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
                    if (int.TryParse(Request.QueryString["Feesid"], out int FeeStructureId))
                    {
                        LoadFeeStructureData(FeeStructureId);
                        LoadClass();
                    }
                    else
                    {
                        ErrorPanel.Visible = true;
                        ErrorMessage.Text = "Invalid FeeStructure ID.";
                    }
                }
            }
        }

        private void LoadClass()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                string query = "SELECT DepartmentName FROM departments";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                SqlDataAdapter sda=new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                ddlDepartment.DataSource = dt;
                ddlDepartment.DataTextField = "DepartmentName";
                ddlDepartment.DataBind();
                con.Close();
            }
        }

        private void LoadFeeStructureData(int feeStructureId)
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                string query = "SELECT * FROM FeeStructure WHERE id = @id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@id", feeStructureId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    ddlDepartment.SelectedValue = reader["Class"].ToString();
                    txtAdmissionFee.Text = reader["AdmissionFee"].ToString();
                    txtTuitionFee.Text = reader["TuitionFee"].ToString();
                    txtAnnualCharges.Text = reader["AnnualCharges"].ToString();
                    txtTotalAmount.Text = reader["TotalAmount"].ToString();
                }
                else
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "FeeStructure data not found.";
                }
                con.Close();
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void btnFeeStructure_Click(object sender, EventArgs e)
        {
            if (int.TryParse(Request.QueryString["Feesid"], out int FeeStructureId))
            {
                decimal admissionFee, tuitionFee, annualCharges, totalAmount;

                decimal.TryParse(txtAdmissionFee.Text, out admissionFee);
                decimal.TryParse(txtTuitionFee.Text, out tuitionFee);
                decimal.TryParse(txtAnnualCharges.Text, out annualCharges);
                totalAmount = admissionFee + tuitionFee + annualCharges;

                using (SqlConnection con = new SqlConnection(connect))
                {
                    string q = "UPDATE FeeStructure SET Class = @Class, AdmissionFee = @AdmissionFee, TuitionFee = @TuitionFee, AnnualCharges = @AnnualCharges, TotalAmount = @TotalAmount WHERE id = @id";
                    SqlCommand cmd = new SqlCommand(q, con);

                    cmd.Parameters.AddWithValue("@Class", ddlDepartment.SelectedValue.Trim());
                    cmd.Parameters.AddWithValue("@AdmissionFee", txtAdmissionFee.Text.Trim());
                    cmd.Parameters.AddWithValue("@TuitionFee", txtTuitionFee.Text.Trim());
                    cmd.Parameters.AddWithValue("@AnnualCharges", txtAnnualCharges.Text.Trim());
                    cmd.Parameters.AddWithValue("@TotalAmount", totalAmount);
                    cmd.Parameters.AddWithValue("@id", FeeStructureId);

                    con.Open();
                    int r = cmd.ExecuteNonQuery();

                    if (r > 0)
                    {
                        SuccessPanel.Visible = true;
                        SuccessMessage.Text = "<script> alert('FeeStructure updated successfully.')</script>" + "FeeStructure updated successfully.";
                    }
                    else
                    {
                        ErrorPanel.Visible = true;
                        ErrorMessage.Text = "Error updating FeeStructure.";
                    }
                    con.Close();
                }
            }
            else
            {
                ErrorPanel.Visible = true;
                ErrorMessage.Text = "Invalid FeeStructure ID.";
            }
        }
    }
}