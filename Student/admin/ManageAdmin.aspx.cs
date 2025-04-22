using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.admin
{
    public partial class admin1 : System.Web.UI.Page
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
                    BindAdminData();
                }
            }
        }

        private void BindAdminData()
        {
            using(SqlConnection con=new SqlConnection(connect))
            {
                SqlCommand cmd = new SqlCommand("select * from admin",con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                AdminRepeater.DataSource = dt;
                AdminRepeater.DataBind();
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void AddAdminbtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("add-admin.aspx");
        }

        protected void AdminRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                SqlConnection con=new SqlConnection(connect);
                SqlCommand cmd = new SqlCommand("Delete from admin where id=@id", con);
                cmd.Parameters.AddWithValue("@id",e.CommandArgument);
                con.Open();
                int r=cmd.ExecuteNonQuery();
                if(r == 0)
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "Error Deleting Administrator";
                }
                else
                {
                    SuccessPanel.Visible = true;
                    SuccessMessage.Text = "<script> alert('Administrator deleted successfully.')</script>" + "Administrator deleted successfully."; ;
                }
                BindAdminData();
                con.Close();
            }
        }
    }
}