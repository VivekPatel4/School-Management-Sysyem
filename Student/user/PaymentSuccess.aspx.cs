using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
// Removed Twilio imports
// using Twilio;
// using Twilio.Rest.Api.V2010.Account;

namespace Student.user
{
    public partial class PaymentSuccess : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

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
                    string paymentId = Request.QueryString["payment_id"];
                    string amount = Request.QueryString["amount"];
                    string status = Request.QueryString["status"];

                    if (status == "success")
                    {
                        // Handle successful payment
                        SavePayment(paymentId, Convert.ToDecimal(amount));
                        pnlSuccess.Visible = true;
                        lblTransactionID.Text = paymentId;
                        lblAmountPaid.Text = amount;
                    }
                    else if (status == "partial")
                    {
                        // Handle partial payment
                        SavePartialPayment(paymentId, Convert.ToDecimal(amount));
                        pnlPartial.Visible = true;
                        lblPartialTransactionID.Text = paymentId;
                        lblPartialAmountPaid.Text = amount;

                        // Calculate remaining amount
                        decimal totalFee = GetTotalFee();
                        decimal remainingAmount = totalFee - Convert.ToDecimal(amount);
                        lblRemainingAmount.Text = remainingAmount.ToString("N2");
                    }
                    else if (status == "fail")
                    {
                        // Handle failed payment
                        SaveFailedPayment();
                        pnlFailure.Visible = true;
                    }
                    else
                    {
                        // Invalid status, redirect to FeePayment.aspx
                        Response.Redirect("FeePayment.aspx");
                    }
                }
            }
        }

        private void SavePayment(string transactionId, decimal amount)
        {
            string studentId = Session["sid"].ToString();
            string phoneNumber = GetStudentPhoneNumber(studentId);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "INSERT INTO Payments (StudentID, AmountPaid, TransactionID, PaymentDate, PaymentStatus) " +
                               "VALUES (@StudentID, @AmountPaid, @TransactionID, GETDATE(), 'Successful')";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@StudentID", studentId);
                    cmd.Parameters.AddWithValue("@AmountPaid", amount);
                    cmd.Parameters.AddWithValue("@TransactionID", transactionId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            
            // Removed any Twilio SMS sending code
        }

        private void SaveFailedPayment()
        {
            string studentId = Session["sid"].ToString();
            string phoneNumber = GetStudentPhoneNumber(studentId);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "INSERT INTO Payments (StudentID, AmountPaid, TransactionID, PaymentDate, PaymentStatus) " +
                               "VALUES (@StudentID, 0, 'N/A', GETDATE(), 'Failed')";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@StudentID", studentId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            
            // Removed any Twilio SMS sending code
        }

        private void SavePartialPayment(string transactionId, decimal amount)
        {
            string studentId = Session["sid"].ToString();
            string phoneNumber = GetStudentPhoneNumber(studentId);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "INSERT INTO Payments (StudentID, AmountPaid, TransactionID, PaymentDate, PaymentStatus) " +
                               "VALUES (@StudentID, @AmountPaid, @TransactionID, GETDATE(), 'Partial')";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@StudentID", studentId);
                    cmd.Parameters.AddWithValue("@AmountPaid", amount);
                    cmd.Parameters.AddWithValue("@TransactionID", transactionId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            
            // Removed any Twilio SMS sending code
        }

        private decimal GetTotalFee()
        {
            string studentId = Session["sid"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT (TuitionFee + AdmissionFee + AnnualCharges) AS TotalFee FROM FeeStructure WHERE Class = (SELECT Department FROM Students WHERE id = @StudentID)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@StudentID", studentId);
                    conn.Open();
                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        return Convert.ToDecimal(result);
                    }
                    else
                    {
                        throw new Exception("Total fee not found.");
                    }
                }
            }
        }
        private string GetStudentPhoneNumber(string studentId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT PhoneNumber FROM students WHERE id = @StudentID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@StudentID", studentId);
                    conn.Open();
                    return cmd.ExecuteScalar()?.ToString() ?? "";
                }
            }
        }
       
    }
}