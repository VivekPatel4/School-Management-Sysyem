using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Ajax.Utilities;

namespace Student.admin
{
    public partial class add_FeeStructure : System.Web.UI.Page
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
                    Loaddepartment();
                }
            }
        }

        private void Loaddepartment()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                SqlCommand cmd = new SqlCommand("select * from departments", con);
                con.Open();
                SqlDataReader r = cmd.ExecuteReader();
                ddlDepartment.DataSource = r;
                ddlDepartment.DataTextField = "DepartmentName";
                ddlDepartment.DataBind();
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void btnFeeStructure_Click(object sender, EventArgs e)
        {
            decimal admissionFee, tuitionFee, annualCharges, totalAmount;

            decimal.TryParse(txtAdmissionFee.Text, out admissionFee);
            decimal.TryParse(txtTuitionFee.Text, out tuitionFee);
            decimal.TryParse(txtAnnualCharges.Text, out annualCharges);
            totalAmount = admissionFee + tuitionFee + annualCharges;

            using (SqlConnection conn = new SqlConnection(connect))
            {
                string query = "INSERT INTO FeeStructure (Class, AdmissionFee, TuitionFee, AnnualCharges,TotalAmount) " +
                               "VALUES (@Class, @AdmissionFee, @TuitionFee, @AnnualCharges,@total)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Class", ddlDepartment.SelectedValue);
                    cmd.Parameters.AddWithValue("@AdmissionFee", Convert.ToInt32(txtAdmissionFee.Text));
                    cmd.Parameters.AddWithValue("@TuitionFee", Convert.ToInt32(txtTuitionFee.Text));
                    cmd.Parameters.AddWithValue("@AnnualCharges", Convert.ToInt32(txtAnnualCharges.Text));
                    cmd.Parameters.AddWithValue("@total", totalAmount);
                    conn.Open();

                    int r = cmd.ExecuteNonQuery();
                    if (r == 0)
                    {
                        ErrorPanel.Visible = true;
                        ErrorMessage.Text = "Fee Structure Not Insert Please Try again";
                    }
                    else
                    {
                        SuccessPanel.Visible = true;
                        SuccessMessage.Text = "Fee Structure Added Successfully";
                    }
                    conn.Close();
                    Clear();
                }
            }
        }

        private void Clear()
        {
            ddlDepartment.SelectedIndex = 0;
            txtAdmissionFee.Text = String.Empty;
            txtTuitionFee.Text = String.Empty;
            txtAnnualCharges.Text = String.Empty;
            txtTotalAmount.Text = String.Empty;
        }
    }
}