using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace Student.admin
{
    public partial class admin : System.Web.UI.MasterPage
    {
        protected int LeaveUnreadCount = 0;
        protected int BirthdayCount = 0;
        protected DataTable LeaveResults = new DataTable();
        protected DataTable BirthdayResults = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

            
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string leaveSql = @"
                SELECT leaves.id as lid, 
                       students.FirstName, 
                       students.LastName, 
                       students.stdid, 
                       leaves.PostingDate 
                FROM leaves 
                JOIN students ON leaves.stdid = students.id 
                WHERE leaves.IsRead = @IsRead";

                using (SqlCommand cmd = new SqlCommand(leaveSql, conn))
                {
                    cmd.Parameters.AddWithValue("@IsRead", 0);
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(LeaveResults);
                        LeaveUnreadCount = LeaveResults.Rows.Count;
                    }
                }

                
                string currentMonthDay = DateTime.Now.ToString("MM-dd");
                string birthdaySql = "SELECT * FROM remainder WHERE FORMAT(wishyear, 'MM-dd') = @CurrentMonthDay";

                using (SqlCommand cmd = new SqlCommand(birthdaySql, conn))
                {
                    cmd.Parameters.AddWithValue("@CurrentMonthDay", currentMonthDay);
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(BirthdayResults);
                        BirthdayCount = BirthdayResults.Rows.Count;
                    }
                }
            }
        }
    }
}
