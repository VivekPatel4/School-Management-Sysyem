using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.user
{
    public partial class PaymentReceipt : System.Web.UI.Page
    {
        String connect = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["stdlogin"] == null)
                {
                    Response.Redirect("../user/login.aspx");
                }
                else
                {
                    if (Request.QueryString["id"] != null)
                    {
                        string transactionId = Request.QueryString["id"].ToString();
                        LoadPaymentDetails(transactionId);
                    }
                    else
                    {
                        // Redirect to payment page if no transaction ID is provided
                        Response.Redirect("FeePayment.aspx");
                    }
                }
            }
        }

        private void LoadPaymentDetails(string transactionId)
        {
            using (SqlConnection con = new SqlConnection(connect))
            {


                string query = @"SELECT p.PaymentID, p.TransactionID, p.AmountPaid, p.PaymentDate, 
                                    CASE 
                                        WHEN p.PaymentStatus = 'Success' THEN 'Success' 
                                        WHEN p.PaymentStatus = 'Partial' THEN 'Partial' 
                                        ELSE 'Failed' 
                                    END AS Status,
                                    s.FirstName + ' ' + s.LastName AS StudentName, s.stdid AS RollNumber, 
                                    f.Class AS ClassName, f.TotalAmount AS TotalFee,
                                    (SELECT ISNULL(SUM(AmountPaid), 0) FROM Payments 
                                         WHERE StudentID = s.id AND PaymentStatus IN ('Success', 'Partial')) AS TotalPaid,
                                         f.TotalAmount - (SELECT ISNULL(SUM(AmountPaid), 0) FROM Payments 
                                           WHERE StudentID = s.id AND PaymentStatus IN ('Success', 'Partial')) AS RemainingAmount FROM Payments p
                                    INNER JOIN students s ON p.StudentID = s.id
                                    INNER JOIN FeeStructure f ON s.Department = f.Class 
                                    WHERE p.TransactionID = @TransactionID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@TransactionID", transactionId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    // Set values to labels in the receipt
                    lblStudentName.Text = reader["StudentName"].ToString();
                    lblClass.Text = reader["ClassName"].ToString();
                    lblRollNumber.Text = reader["RollNumber"].ToString();
                    lblTransactionID.Text = reader["TransactionID"].ToString();
                    lblPaymentDate.Text = Convert.ToDateTime(reader["PaymentDate"]).ToString("dd MMM yyyy, hh:mm tt");
                    lblPaymentAmount.Text = Convert.ToDecimal(reader["AmountPaid"]).ToString("₹ #,##0.00");
                    lblTotalFee.Text = Convert.ToDecimal(reader["TotalFee"]).ToString("₹ #,##0.00");
                    lblTotalPaid.Text = Convert.ToDecimal(reader["TotalPaid"]).ToString("₹ #,##0.00");
                    lblRemainingAmount.Text = Convert.ToDecimal(reader["RemainingAmount"]).ToString("₹ #,##0.00");

                    string status = reader["Status"].ToString();
                    lblStatus.Text = status;

                    // Set status class based on payment status
                    switch (status.ToLower())
                    {
                        case "success":
                            lblStatus.CssClass = "badge badge-success";
                            break;
                        case "partial":
                            lblStatus.CssClass = "badge badge-warning";
                            break;
                        case "failed":
                            lblStatus.CssClass = "badge badge-danger";
                            break;
                    }
                }
                else
                {
                    // Redirect to payment page if transaction ID is not found
                    Response.Redirect("FeePayment.aspx");
                }

                reader.Close();
            }
        }
    }
}