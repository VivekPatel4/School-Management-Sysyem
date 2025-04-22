using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Student.user
{
    public partial class FeePayment : System.Web.UI.Page
    {
        private readonly string connStr = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        private decimal _remainingAmount = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    if (Session["stdlogin"] == null)
                    {
                        Response.Redirect("../user/login.aspx");
                        return;
                    }

                    LoadStudentDetails();
                    LoadPaymentStatus();
                    LoadPaymentHistory();

                    // Only calculate installment if there's no partial payment
                    if (_remainingAmount <= 0)
                    {
                        CalculateInstallmentAmount();
                    }
                }
                catch (Exception ex)
                {
                    ShowError("An error occurred: " + ex.Message);
                }
            }
        }

        private void LoadStudentDetails()
        {
            try
            {
                if (Session["sid"] == null)
                {
                    throw new Exception("Student ID not found in session.");
                }

                string studentId = Session["sid"].ToString();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT FirstName, LastName, Department, EmailId, Phonenumber FROM Students WHERE id = @StudentID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@StudentID", studentId);
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblStudentName.Text = $"{reader["FirstName"]} {reader["LastName"]}";
                                lblClass.Text = reader["Department"].ToString();
                                hdfstudentEmail.Value = reader["EmailId"].ToString();
                                hdfstudentContact.Value = reader["Phonenumber"].ToString();
                            }
                            else
                            {
                                throw new Exception("Student details not found.");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Error loading student details: " + ex.Message);
            }
        }

        protected decimal GetTotalFee()
        {
            if (Session["sid"] == null)
            {
                throw new Exception("Student ID not found in session.");
            }

            string studentId = Session["sid"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT (TuitionFee + AdmissionFee + AnnualCharges) AS TotalFee 
                    FROM FeeStructure 
                    WHERE Class = (SELECT Department FROM Students WHERE id = @StudentID)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@StudentID", studentId);
                    conn.Open();
                    object result = cmd.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        return Convert.ToDecimal(result);
                    }

                    throw new Exception("Total fee not found for this student's department.");
                }
            }
        }

        private void LoadPaymentStatus()
        {
            try
            {
                if (Session["sid"] == null)
                {
                    throw new Exception("Student ID not found in session.");
                }

                string studentId = Session["sid"].ToString();
                decimal totalFee = GetTotalFee();

                // Store total fee in ViewState to access it during payment processing
                ViewState["TotalFee"] = totalFee;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    // Calculate the total amount paid so far across all payments
                    string totalPaidQuery = @"
                        SELECT SUM(AmountPaid) AS TotalPaid
                        FROM Payments 
                        WHERE StudentID = @StudentID AND PaymentStatus IN ('Successful', 'Partial')";

                    using (SqlCommand totalPaidCmd = new SqlCommand(totalPaidQuery, conn))
                    {
                        totalPaidCmd.Parameters.AddWithValue("@StudentID", studentId);
                        conn.Open();
                        object totalPaidResult = totalPaidCmd.ExecuteScalar();
                        decimal totalPaid = totalPaidResult != DBNull.Value ? Convert.ToDecimal(totalPaidResult) : 0;

                        // Calculate remaining amount
                        _remainingAmount = totalFee - totalPaid;
                        ViewState["RemainingAmount"] = _remainingAmount;

                        // Get the most recent payment status
                        string recentStatusQuery = @"
                            SELECT TOP 1 PaymentStatus
                            FROM Payments 
                            WHERE StudentID = @StudentID 
                            ORDER BY PaymentDate DESC";

                        using (SqlCommand recentStatusCmd = new SqlCommand(recentStatusQuery, conn))
                        {
                            recentStatusCmd.Parameters.AddWithValue("@StudentID", studentId);
                            object recentStatusResult = recentStatusCmd.ExecuteScalar();
                            string recentStatus = recentStatusResult != null && recentStatusResult != DBNull.Value ? recentStatusResult.ToString() : "None";


                            // Update UI based on payment status
                            if (_remainingAmount <= 0)
                            {
                                // Full payment completed
                                lblStatus.Text = "<span style='color: green'>Payment completed</span>";
                                btnPay.Enabled = false;
                                lblTotalFee.Text = $"₹{totalFee.ToString("N2")} (Paid)";
                                ddlInstallment.Enabled = false;
                            }
                            else if (totalPaid > 0)
                            {
                                // Partial payment made
                                lblStatus.Text = $"<span style='color: orange'>Partial payment made. Remaining amount: ₹{_remainingAmount.ToString("N2")}</span>";
                                lblTotalFee.Text = $"₹{_remainingAmount.ToString("N2")} (Remaining)";
                                btnPay.Enabled = true;
                                ddlInstallment.Enabled = false;
                            }
                            else if (recentStatus == "Failed")
                            {
                                // Most recent payment failed
                                lblStatus.Text = "<span style='color: red'>Payment failed. Please try again.</span>";
                                lblTotalFee.Text = $"₹{totalFee.ToString("N2")}";
                                btnPay.Enabled = true;
                                ddlInstallment.Enabled = true;
                            }
                            else
                            {
                                // No payment yet
                                lblStatus.Text = "<span style='color: blue'>Pending</span>";
                                lblTotalFee.Text = $"₹{totalFee.ToString("N2")}";
                                btnPay.Enabled = true;
                                ddlInstallment.Enabled = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Error loading payment status: " + ex.Message);
            }
        }

        protected void ddlInstallment_SelectedIndexChanged(object sender, EventArgs e)
        {
            CalculateInstallmentAmount();
        }

        private void CalculateInstallmentAmount()
        {
            try
            {
                // Skip calculation if there's a remaining amount from partial payment
                if (_remainingAmount > 0)
                {
                    return;
                }

                string selectedClass = lblClass.Text;

                if (string.IsNullOrEmpty(selectedClass))
                {
                    throw new Exception("Class/Department information is missing.");
                }

                int months = Convert.ToInt32(ddlInstallment.SelectedValue);

                if (months <= 0)
                {
                    throw new Exception("Invalid installment period selected.");
                }

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = @"
                        SELECT (TuitionFee + AdmissionFee + AnnualCharges) / @Months AS InstallmentAmount 
                        FROM FeeStructure 
                        WHERE Class = @Class";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Class", selectedClass);
                        cmd.Parameters.AddWithValue("@Months", months);
                        conn.Open();
                        object result = cmd.ExecuteScalar();

                        if (result != null && result != DBNull.Value)
                        {
                            decimal installmentAmount = Convert.ToDecimal(result);
                            lblTotalFee.Text = $"₹{installmentAmount.ToString("N2")}";

                            // Store the installment amount in ViewState for payment processing
                            ViewState["InstallmentAmount"] = installmentAmount;
                        }
                        else
                        {
                            throw new Exception("Fee structure not found for " + selectedClass);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Error calculating installment amount: " + ex.Message);
            }
        }

        private void LoadPaymentHistory()
        {
            // Get the student ID
            int studentId = Convert.ToInt32(Session["sid"]);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"SELECT PaymentID, TransactionID, AmountPaid, PaymentDate, 
                                 CASE 
                                    WHEN PaymentStatus = 'Success' THEN 'Success' 
                                    WHEN PaymentStatus = 'Partial' THEN 'Partial' 
                                     ELSE 'Failed' 
                                      END AS Status 
                                       FROM Payments WHERE StudentID = @StudentID ORDER BY PaymentDate DESC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@StudentID", studentId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                con.Open();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    rptPaymentHistory.DataSource = dt;
                    rptPaymentHistory.DataBind();
                }
                else
                {
                    rptPaymentHistory.Visible = false;
                    pnlEmptyData.Visible = true;
                }
            }
        }

        // Helper method for getting status CSS class in the UI
        protected string GetStatusClass(string status)
        {
            switch (status.ToLower())
            {
                case "success":
                    return "status-success";
                case "partial":
                    return "status-partial";
                case "failed":
                    return "status-failed";
                default:
                    return "";
            }
        }
        private void ShowError(string message)
        {
            ErrorPanel.Visible = true;
            ErrorMessage.Text = message;
        }
    }
}