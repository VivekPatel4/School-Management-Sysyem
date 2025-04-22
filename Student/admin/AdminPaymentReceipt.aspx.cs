using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing.Printing;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Documents;
using System.Xml.Linq;
using System.Net.Mail;

namespace Student.admin
{
    public partial class AdminPaymentReceipt : System.Web.UI.Page
    {
        private readonly string connStr = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    // Check if admin is logged in
                    if (Session["alogin"] == null)
                    {
                        Response.Redirect("../admin/login.aspx");
                        return;
                    }

                    // Load receipt details based on transaction ID
                    if (Request.QueryString["id"] != null)
                    {
                        string transactionId = Request.QueryString["id"].ToString();
                        LoadPaymentDetails(transactionId);
                    }
                    else
                    {
                        ShowError("No transaction ID provided.");
                        Response.Redirect("AllPayments.aspx");
                    }
                }
                catch (Exception ex)
                {
                    ShowError("An error occurred while loading the receipt: " + ex.Message);
                }
            }
        }

        private void LoadPaymentDetails(string transactionId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = @"
                        SELECT 
                            p.TransactionID, 
                            p.AmountPaid, 
                            p.PaymentDate, 
                            CASE 
                                WHEN p.PaymentStatus = 'Success' THEN 'Success' 
                                WHEN p.PaymentStatus = 'Partial' THEN 'Partial' 
                                ELSE 'Failed' 
                            END AS Status,
                            s.FirstName + ' ' + s.LastName AS StudentName, 
                            s.stdid AS RollNumber, 
                            s.Department AS Class, 
                            s.EmailId AS Email, 
                            s.Phonenumber AS Phone,
                            f.TotalAmount AS TotalFee,
                            (SELECT ISNULL(SUM(p2.AmountPaid), 0) 
                             FROM Payments p2 
                             WHERE p2.StudentID = s.id AND p2.PaymentStatus IN ('Success', 'Partial')) AS TotalPaid
                        FROM Payments p
                        INNER JOIN Students s ON p.StudentID = s.id
                        INNER JOIN FeeStructure f ON s.Department = f.Class
                        WHERE p.TransactionID = @TransactionID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@TransactionID", transactionId);
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblStudentName.Text = reader["StudentName"].ToString();
                                lblRollNumber.Text = reader["RollNumber"].ToString();
                                lblClass.Text = reader["Class"].ToString();
                                lblEmail.Text = reader["Email"].ToString();
                                lblPhone.Text = reader["Phone"].ToString();
                                lblTransactionID.Text = reader["TransactionID"].ToString();
                                lblPaymentDate.Text = Convert.ToDateTime(reader["PaymentDate"]).ToString("dd MMM yyyy, hh:mm tt");
                                lblPaymentAmount.Text = Convert.ToDecimal(reader["AmountPaid"]).ToString("₹ #,##0.00");

                                string status = reader["Status"].ToString();
                                lblStatus.Text = status;
                                lblStatus.CssClass = "badge badge-" + GetStatusClass(status);

                                decimal totalFee = Convert.ToDecimal(reader["TotalFee"]);
                                decimal totalPaid = Convert.ToDecimal(reader["TotalPaid"]);
                                decimal remainingAmount = totalFee - totalPaid;

                                lblTotalFee.Text = totalFee.ToString("₹ #,##0.00");
                                lblTotalPaid.Text = totalPaid.ToString("₹ #,##0.00");
                                lblRemainingAmount.Text = remainingAmount.ToString("₹ #,##0.00");
                            }
                            else
                            {
                                ShowError("Payment receipt not found for the provided transaction ID.");
                                Response.Redirect("AllPayments.aspx");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Error loading payment details: " + ex.Message);
            }
        }


        private string GetStatusClass(string status)
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
        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("../admin/login.aspx");
        }

        protected void btnDownload_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    // Generate PDF using iTextSharp
            //    using (MemoryStream ms = new MemoryStream())
            //    {
            //        Document document = new Document(PageSize.A4, 25, 25, 30, 30);
            //        PdfWriter writer = PdfWriter.GetInstance(document, ms);
            //        document.Open();

            //        // Add receipt content (simplified example)
            //        document.Add(new Paragraph("Payment Receipt", FontFactory.GetFont("Arial", 24, Font.BOLD)));
            //        document.Add(new Paragraph("School Management System", FontFactory.GetFont("Arial", 16)));
            //        document.Add(new Paragraph(" "));
            //        document.Add(new Paragraph($"Student Name: {lblStudentName.Text}"));
            //        document.Add(new Paragraph($"Roll Number: {lblRollNumber.Text}"));
            //        document.Add(new Paragraph($"Class: {lblClass.Text}"));
            //        document.Add(new Paragraph($"Email: {lblEmail.Text}"));
            //        document.Add(new Paragraph($"Phone: {lblPhone.Text}"));
            //        document.Add(new Paragraph(" "));
            //        document.Add(new Paragraph($"Transaction ID: {lblTransactionID.Text}"));
            //        document.Add(new Paragraph($"Payment Date: {lblPaymentDate.Text}"));
            //        document.Add(new Paragraph($"Amount Paid: {lblPaymentAmount.Text}"));
            //        document.Add(new Paragraph($"Status: {lblStatus.Text}"));
            //        document.Add(new Paragraph("Payment Method: Online (Razorpay)"));
            //        document.Add(new Paragraph(" "));
            //        document.Add(new Paragraph($"Total Fee: {lblTotalFee.Text}"));
            //        document.Add(new Paragraph($"Total Paid: {lblTotalPaid.Text}"));
            //        document.Add(new Paragraph($"Remaining Amount: {lblRemainingAmount.Text}"));

            //        document.Close();

            //        // Send PDF as response
            //        Response.ContentType = "application/pdf";
            //        Response.AddHeader("content-disposition", $"attachment;filename=Receipt_{lblTransactionID.Text}.pdf");
            //        Response.BinaryWrite(ms.ToArray());
            //        Response.End();
            //    }

            //    ShowSuccess("Receipt downloaded successfully.");
            //}
            //catch (Exception ex)
            //{
            //    ShowError("Error downloading receipt: " + ex.Message);
            //}
        }

        protected void btnEmail_Click(object sender, EventArgs e)
        {
            try
            {
                // Send email with receipt details
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress("admin@schoolmanagement.com");
                mail.To.Add(lblEmail.Text);
                mail.Subject = "Payment Receipt";
                mail.Body = $"Dear {lblStudentName.Text},\n\n" +
                            "Please find your payment receipt details below:\n\n" +
                            $"Transaction ID: {lblTransactionID.Text}\n" +
                            $"Payment Date: {lblPaymentDate.Text}\n" +
                            $"Amount Paid: {lblPaymentAmount.Text}\n" +
                            $"Status: {lblStatus.Text}\n" +
                            $"Total Fee: {lblTotalFee.Text}\n" +
                            $"Total Paid: {lblTotalPaid.Text}\n" +
                            $"Remaining Amount: {lblRemainingAmount.Text}\n\n" +
                            "Thank you for your payment.\n\n" +
                            "Regards,\nSchool Management System";

                SmtpClient smtp = new SmtpClient("smtp.gmail.com");
                smtp.Port = 587;
                smtp.Credentials = new System.Net.NetworkCredential("swaminarayan099909@gmail.com", "lreu zlae lwoy zzib"); // Use App Password if 2FA is enabled
                smtp.EnableSsl = true;
                smtp.Send(mail);

                ShowSuccess("Receipt emailed successfully to " + lblEmail.Text);
            }
            catch (Exception ex)
            {
                ShowError("Error sending email: " + ex.Message);
            }
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
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AllPayments.aspx");
        }
    }
}