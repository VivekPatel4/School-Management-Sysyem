using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.admin
{
    public partial class add_teacher : System.Web.UI.Page
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
                    Loadsubjects();
                }
            }
        }

        private void Loadsubjects()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                SqlCommand cmd = new SqlCommand("select * from subject", con);
                con.Open();
                SqlDataReader r = cmd.ExecuteReader();
                ddlSubjects.DataSource = r;
                ddlSubjects.DataTextField = "SubjectName";
                ddlSubjects.DataBind();
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void btnAddTeacher_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                string imgPath = "";
                string query = @"INSERT INTO teacher 
                    (FirstName, LastName, EmailId, subject, Gender, Dob, Phonenumber, photo, Country, State, District, Pincode, City, Address, Password, Status, RegDate) 
                    VALUES 
                    (@FirstName, @LastName, @EmailId, @subject, @Gender, @Dob, @PhoneNumber, @Photo, @Country, @State, @District, @Pincode, @City, @Address, @Password, @Status, GETDATE())";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (fuTeacherImage.HasFile)
                    {
                        string fileName = Path.GetFileName(fuTeacherImage.FileName);
                        imgPath = "~/admin/images/teacher/" + fileName;
                        fuTeacherImage.SaveAs(Server.MapPath(imgPath));
                        img.ImageUrl = imgPath;
                        hdnimg.Value = imgPath;
                    }

                    string selectedSubjects = "";
                    for (int i = 0; i < ddlSubjects.Items.Count; i++)
                    {
                        if (ddlSubjects.Items[i].Selected == true)
                        {
                            if (selectedSubjects.Length > 0)
                            {
                                selectedSubjects += "," + ddlSubjects.Items[i].Value;
                            }
                            else
                            {
                                selectedSubjects = ddlSubjects.Items[i].Value;
                            }
                        }
                    }

                    cmd.Parameters.AddWithValue("@FirstName", txtfname.Text);
                    cmd.Parameters.AddWithValue("@LastName", txtlname.Text);
                    cmd.Parameters.AddWithValue("@EmailId", txtemail.Text);
                    cmd.Parameters.AddWithValue("@subject", selectedSubjects);
                    cmd.Parameters.AddWithValue("@Gender", dgender.SelectedValue);
                    cmd.Parameters.AddWithValue("@Dob", txtdob.Text);
                    cmd.Parameters.AddWithValue("@PhoneNumber", txtmobile.Text.Trim());
                    cmd.Parameters.AddWithValue("@Photo", imgPath);
                    cmd.Parameters.AddWithValue("@Country", txtcountry.Text);
                    cmd.Parameters.AddWithValue("@State", txtstate.Text);
                    cmd.Parameters.AddWithValue("@District", txtdistrict.Text);
                    cmd.Parameters.AddWithValue("@Pincode", txtpincode.Text);
                    cmd.Parameters.AddWithValue("@City", txtcity.Text);
                    cmd.Parameters.AddWithValue("@Address", txtaddress.Text);
                    cmd.Parameters.AddWithValue("@Password", txtpassword.Text);
                    cmd.Parameters.AddWithValue("@Status", 1);


                    con.Open();
                    int result = cmd.ExecuteNonQuery();

                    if (result == 0)
                    {
                        ErrorPanel.Visible = true;
                        ErrorMessage.Text = "Error: Please try again.";
                    }
                    else
                    {
                        SuccessPanel.Visible = true;
                        SuccessMessage.Text = "Teacher record added successfully.";
                    }
                    con.Close();
                    Clear();
                }
            }
        }

        private void Clear()
        {
            txtfname.Text = string.Empty;
            txtlname.Text = string.Empty;
            txtemail.Text = string.Empty;
            ddlSubjects.SelectedIndex = 0;
            dgender.SelectedIndex = 0;
            txtdob.Text = string.Empty;
            txtmobile.Text = string.Empty;
            txtcountry.Text = string.Empty;
            txtstate.Text = string.Empty;
            txtdistrict.Text = string.Empty;
            txtpincode.Text = string.Empty;
            txtcity.Text = string.Empty;
            txtaddress.Text = string.Empty;
            txtpassword.Text = string.Empty;
            txtconfirmpassword.Text = string.Empty;
            txtcountry.Text = string.Empty;
            img.ImageUrl = string.Empty;
        }
    }
}