using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.user
{
    public partial class LeaveHistory : System.Web.UI.Page
    {
        String connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
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
                    LoadLeaveHistory();
                }
            }
        }

        private void LoadLeaveHistory()
        {
           using(SqlConnection con=new SqlConnection(connect))
            {
                string q = "SELECT LeaveType, ToDate, FromDate, Description, PostingDate, AdminRemarkDate, AdminRemark, Status FROM leaves WHERE stdid = @stdID";
                SqlCommand cmd=new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@stdID", Session["sid"]);
                SqlDataAdapter sda=new SqlDataAdapter(cmd);
                DataTable dt=new DataTable();
                sda.Fill(dt);
                foreach (DataRow dr in dt.Rows)
                {
                    if (DateTime.TryParse(dr["ToDate"].ToString(), out DateTime toDate))
                        dr["ToDate"] = toDate.ToString("dd-MM-yyyy");

                    if (DateTime.TryParse(dr["FromDate"].ToString(), out DateTime fromDate))
                        dr["FromDate"] = fromDate.ToString("dd-MM-yyyy");
                }
                rptLeaveHistory.DataSource = dt;    
                rptLeaveHistory.DataBind();
            }
        }
    }
}