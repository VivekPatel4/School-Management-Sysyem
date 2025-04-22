using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.admin
{
    public partial class AllPayments : System.Web.UI.Page
    {
        private readonly string connStr = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
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
                    LoadClassesDropdown();
                    LoadPaymentStatistics();
                    LoadPaymentRecords();
                }
            }

        }

        private void LoadClassesDropdown()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT DISTINCT Department FROM Students ORDER BY Department";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        ddlClass.DataSource = reader;
                        ddlClass.DataTextField = "Department";
                        ddlClass.DataValueField = "Department";
                        ddlClass.DataBind();
                        ddlClass.Items.Insert(0, new ListItem("All Classes", ""));
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Error loading classes: " + ex.Message);
            }
        }

        private void LoadPaymentStatistics()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    // Total Collections
                    string totalCollectionsQuery = @"
                SELECT ISNULL(SUM(p.AmountPaid), 0) AS TotalCollections 
                FROM Payments p 
                WHERE p.PaymentStatus IN ('Success', 'Partial')";
                    using (SqlCommand cmd = new SqlCommand(totalCollectionsQuery, conn))
                    {
                        object result = cmd.ExecuteScalar();
                        litTotalCollections.Text = (result != null && result != DBNull.Value)
                            ? Convert.ToDecimal(result).ToString("N2")
                            : "0.00";
                    }

                    // Total Paid Students (Fully Paid)
                    string paidStudentsQuery = @"
                SELECT COUNT(DISTINCT s.id) AS PaidStudents
                FROM Students s
                INNER JOIN FeeStructure f ON s.Department = f.Class
                LEFT JOIN Payments p ON s.id = p.StudentID AND p.PaymentStatus IN ('Success', 'Partial')
                GROUP BY s.id, f.TotalAmount
                HAVING ISNULL(SUM(p.AmountPaid), 0) >= f.TotalAmount";
                    using (SqlCommand cmd = new SqlCommand(paidStudentsQuery, conn))
                    {
                        object result = cmd.ExecuteScalar();
                        litPaidStudents.Text = (result != null && result != DBNull.Value)
                            ? result.ToString()
                            : "0";
                    }

                    // Partial Payments (Students with some payment but not fully paid)
                    string partialPaymentsQuery = @"
                SELECT COUNT(DISTINCT s.id) AS PartialPayments
                FROM Students s
                INNER JOIN FeeStructure f ON s.Department = f.Class
                LEFT JOIN Payments p ON s.id = p.StudentID AND p.PaymentStatus IN ('Success', 'Partial')
                GROUP BY s.id, f.TotalAmount
                HAVING ISNULL(SUM(p.AmountPaid), 0) > 0 AND ISNULL(SUM(p.AmountPaid), 0) < f.TotalAmount";
                    using (SqlCommand cmd = new SqlCommand(partialPaymentsQuery, conn))
                    {
                        object result = cmd.ExecuteScalar();
                        litPartialPayments.Text = (result != null && result != DBNull.Value)
                            ? result.ToString()
                            : "0";
                    }

                    // Due Amount (Total remaining fees for students not fully paid)
                    string dueAmountQuery = @"
                SELECT ISNULL(SUM(TotalDue), 0) AS DueAmount
                FROM (
                    SELECT 
                        f.TotalAmount - ISNULL(SUM(p.AmountPaid), 0) AS TotalDue
                    FROM Students s
                    INNER JOIN FeeStructure f ON s.Department = f.Class
                    LEFT JOIN Payments p ON s.id = p.StudentID AND p.PaymentStatus IN ('Success', 'Partial')
                    GROUP BY s.id, f.TotalAmount
                    HAVING f.TotalAmount > ISNULL(SUM(p.AmountPaid), 0)
                ) AS DueAmounts";
                    using (SqlCommand cmd = new SqlCommand(dueAmountQuery, conn))
                    {
                        object result = cmd.ExecuteScalar();
                        litDueAmount.Text = (result != null && result != DBNull.Value)
                            ? Convert.ToDecimal(result).ToString("N2")
                            : "0.00";
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Error loading payment statistics: " + ex.Message);
            }
        }

        private void LoadPaymentRecords(string classFilter = "", string statusFilter = "", DateTime? fromDate = null, DateTime? toDate = null, string searchTerm = "")
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = @"
                        SELECT p.StudentID, s.FirstName + ' ' + s.LastName AS StudentName, s.stdid AS RollNumber, 
                               s.Department AS Class, p.TransactionID, p.AmountPaid, p.PaymentDate, 
                               CASE 
                                   WHEN p.PaymentStatus = 'Success' THEN 'Success' 
                                   WHEN p.PaymentStatus = 'Partial' THEN 'Partial' 
                                   ELSE 'Failed' 
                               END AS Status 
                        FROM Payments p 
                        INNER JOIN Students s ON p.StudentID = s.id 
                        WHERE 1=1";

                    if (!string.IsNullOrEmpty(classFilter) && classFilter != "All Classes")
                    {
                        query += " AND s.Department = @Class";
                    }

                    if (!string.IsNullOrEmpty(statusFilter))
                    {
                        query += " AND p.PaymentStatus = @Status";
                    }

                    if (fromDate.HasValue)
                    {
                        query += " AND p.PaymentDate >= @FromDate";
                    }

                    if (toDate.HasValue)
                    {
                        query += " AND p.PaymentDate <= @ToDate";
                    }

                    if (!string.IsNullOrEmpty(searchTerm))
                    {
                        query += " AND (s.FirstName + ' ' + s.LastName LIKE @SearchTerm OR s.stdid LIKE @SearchTerm OR p.TransactionID LIKE @SearchTerm)";
                    }

                    query += " ORDER BY p.PaymentDate DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        if (!string.IsNullOrEmpty(classFilter) && classFilter != "All Classes")
                        {
                            cmd.Parameters.AddWithValue("@Class", classFilter);
                        }

                        if (!string.IsNullOrEmpty(statusFilter))
                        {
                            cmd.Parameters.AddWithValue("@Status", statusFilter);
                        }

                        if (fromDate.HasValue)
                        {
                            cmd.Parameters.AddWithValue("@FromDate", fromDate.Value);
                        }

                        if (toDate.HasValue)
                        {
                            cmd.Parameters.AddWithValue("@ToDate", toDate.Value.AddDays(1).AddSeconds(-1)); // Include end date
                        }

                        if (!string.IsNullOrEmpty(searchTerm))
                        {
                            cmd.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");
                        }

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        conn.Open();
                        da.Fill(dt);

                        rptPayments.DataSource = dt;
                        rptPayments.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Error loading payment records: " + ex.Message);
            }
        }
        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            try
            {
                string classFilter = ddlClass.SelectedValue;
                string statusFilter = ddlStatus.SelectedValue;
                DateTime? fromDate = string.IsNullOrEmpty(txtFromDate.Text) ? (DateTime?)null : DateTime.Parse(txtFromDate.Text);
                DateTime? toDate = string.IsNullOrEmpty(txtToDate.Text) ? (DateTime?)null : DateTime.Parse(txtToDate.Text);

                LoadPaymentRecords(classFilter, statusFilter, fromDate, toDate, "");
            }
            catch (Exception ex)
            {
                ShowError("Error applying filters: " + ex.Message);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                string searchTerm = txtSearch.Text.Trim();
                LoadPaymentRecords("", "", null, null, searchTerm);
            }
            catch (Exception ex)
            {
                ShowError("Error searching payments: " + ex.Message);
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            try
            {
                ddlClass.SelectedIndex = 0;
                ddlStatus.SelectedIndex = 0;
                txtFromDate.Text = "";
                txtToDate.Text = "";
                txtSearch.Text = "";

                LoadPaymentRecords();
            }
            catch (Exception ex)
            {
                ShowError("Error resetting filters: " + ex.Message);
            }
        }
        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            try
            {
                // Logic to export to Excel (using a library like EPPlus or manual CSV)
                Response.Clear();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment;filename=Payments.xls");
                Response.ContentType = "application/ms-excel";

                using (StringWriter sw = new StringWriter())
                {
                    using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                    {
                        // Render the table
                        //paymentTable.RenderControl(hw);
                        Response.Output.Write(sw.ToString());
                        Response.End();
                    }
                }

                ShowSuccess("Payments exported to Excel successfully.");
            }
            catch (Exception ex)
            {
                ShowError("Error exporting to Excel: " + ex.Message);
            }
        }

        protected void btnExportPDF_Click(object sender, EventArgs e)
        {
            try
            {
                // Logic to export to PDF (using iTextSharp or similar)
                Response.Clear();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment;filename=Payments.pdf");
                Response.ContentType = "application/pdf";

                // Placeholder for PDF generation (you'll need a library like iTextSharp)
                Response.Write("PDF export not implemented yet.");
                Response.End();

                ShowSuccess("Payments exported to PDF successfully.");
            }
            catch (Exception ex)
            {
                ShowError("Error exporting to PDF: " + ex.Message);
            }
        }

        protected void rptPayments_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "ViewReceipt")
                {
                    string transactionId = e.CommandArgument.ToString().Trim();
                    if (!string.IsNullOrEmpty(transactionId) && transactionId != "N/A")
                    {
                        System.Diagnostics.Debug.WriteLine($"Redirecting to AdminPaymentReceipt.aspx?id={transactionId}");
                        Response.Redirect($"AdminPaymentReceipt.aspx?id={transactionId}");
                    }
                    else
                    {
                        ShowError("Invalid transaction ID for viewing receipt.");
                    }
                }
                else if (e.CommandName == "SendReminder")
                {
                    string studentId = e.CommandArgument.ToString();
                    SendPaymentReminder(studentId);
                    ShowSuccess("Reminder sent successfully to student.");
                }
            }
            catch (Exception ex)
            {
                ShowError("Error processing command: " + ex.Message);
            }
        }

        private void SendPaymentReminder(string studentId)
        {
            // Logic to send email or SMS reminder
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT EmailId, Phonenumber, FirstName FROM Students WHERE id = @StudentID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@StudentID", studentId);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        string email = reader["EmailId"].ToString();
                        string phone = reader["Phonenumber"].ToString();
                        string studentName = reader["FirstName"].ToString();

                        // Example: Send email using System.Net.Mail
                        System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();
                        mail.To.Add(email);
                        mail.From = new System.Net.Mail.MailAddress("admin@schoolmanagement.com");
                        mail.Subject = "Payment Reminder";
                        mail.Body = $"Dear {studentName}, please complete your pending payment.";

                        System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient("smtp.gmail.com");
                        smtp.Port = 587;
                        smtp.Credentials = new System.Net.NetworkCredential("swaminarayan099909@gmail.com", "lreu zlae lwoy zzib");
                        smtp.EnableSsl = true;
                        smtp.Send(mail);
                    }
                }
            }
        }

        protected string GetStatusClass(string status)
        {
            switch (status.ToLower())
            {
                case "success":
                    return "success";
                case "partial":
                    return "warning";
                case "failed":
                    return "danger";
                default:
                    return "secondary";
            }
        }

        protected bool NeedsReminder(string status)
        {
            return status.ToLower() == "partial" || status.ToLower() == "failed";
        }

        private void ShowError(string message)
        {
            ErrorPanel.Visible = true;
            ErrorMessage.Text = message;
        }

        private void ShowSuccess(string message)
        {
            SuccessPanel.Visible = true;
            SuccessMessage.Text = message;
        }
    }
}