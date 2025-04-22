using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.teacher
{
    public partial class dashboard : System.Web.UI.Page
    {
        string connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["tid"] == null)
                {
                    Response.Redirect("../teacher/login.aspx");
                }
                else
                {
                    int PendingCount = GetPendingCount();
                    int DeclinedCount = GetDeclinedCount();
                    int ApproveCount = GetApproveCount();
                    int SchedulCount =GetScheduleCount();

                    lblPendingCount.Text = PendingCount.ToString();
                    lblDeclinedCount.Text = DeclinedCount.ToString();
                    lblApproveCount.Text = ApproveCount.ToString();
                    lblScheduleCount.Text = SchedulCount.ToString();
                }
            }
        }

        private int GetApproveCount()
        {
            int ApproveCount = 0;
            using (SqlConnection con = new SqlConnection(connect))
            {
                string q = @"select COUNT(id) from leaves where Status=1";
                using (SqlCommand cmd = new SqlCommand(q, con))
                {
                    con.Open();
                    ApproveCount = Convert.ToInt32(cmd.ExecuteScalar());
                }
                return ApproveCount;
            }
        }

        private int GetDeclinedCount()
        {
            int DeclinedCount = 0;
            using (SqlConnection con = new SqlConnection(connect))
            {
                string q = @"select COUNT(id) from leaves where Status=2";
                using (SqlCommand cmd = new SqlCommand(q, con))
                {
                    con.Open();
                    DeclinedCount = Convert.ToInt32(cmd.ExecuteScalar());
                }
                return DeclinedCount;
            }
        }

        private int GetPendingCount()
        {
            int PendingCount = 0;
            using (SqlConnection con = new SqlConnection(connect))
            {
                string q = @"select COUNT(id) from leaves where Status=0";
                using (SqlCommand cmd = new SqlCommand(q, con))
                {
                    con.Open();
                    PendingCount = Convert.ToInt32(cmd.ExecuteScalar());
                }
                return PendingCount;
            }
        }

        private int GetScheduleCount()
        {
            int SchedulCount = 0;
            using (SqlConnection con = new SqlConnection(connect))
            {
                string q = @"select COUNT(id) from Schedule where TeacherID=@id";
                using (SqlCommand cmd = new SqlCommand(q, con))
                {
                    cmd.Parameters.AddWithValue("@id", Session["tid"]);
                    con.Open();
                    SchedulCount = Convert.ToInt32(cmd.ExecuteScalar());
                }
                return SchedulCount;
            }
        }
    }
}