using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.teacher
{
    public partial class my_profile : System.Web.UI.Page
    {
        String connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
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
                    int tid = Convert.ToInt32(Session["tid"]);
                    LoadSubject();
                    LoadTeacherData(tid);
                }
            }
        }

        private void LoadTeacherData(int tid)
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                string q = "select FirstName, LastName, EmailId, subject, Gender, Dob, Phonenumber, photo, Country, State, District, Pincode, City, Address, Password from teacher where id = @id";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@id", tid);
                cmd.Parameters.AddWithValue("@photo", hdnimg.Value);
                con.Open();
                SqlDataReader r = cmd.ExecuteReader();

                if (r.Read())
                {

                    txtfname.Text = r["FirstName"].ToString();
                    txtlname.Text = r["LastName"].ToString();
                    txtemail.Text = r["EmailId"].ToString();
                    dgender.SelectedValue = r["Gender"].ToString();
                    txtdob.Text = r["Dob"].ToString();
                    txtmobile.Text = r["Phonenumber"].ToString().Trim();


                    string imgPath = r["photo"].ToString();

                    if (!string.IsNullOrEmpty(imgPath))
                    {
                        img.ImageUrl = imgPath;
                        hdnimg.Value = imgPath;
                    }

                    txtcountry.Text = r["Country"].ToString();
                    txtstate.Text = r["State"].ToString();
                    txtdistrict.Text = r["District"].ToString();
                    txtpincode.Text = r["Pincode"].ToString().Trim();
                    txtcity.Text = r["City"].ToString();
                    txtaddress.Text = r["Address"].ToString();
                    string[] selectedSubjects = r["subject"].ToString().Split(',');
                    foreach (ListItem item in ddlSubjects.Items)
                    {
                        if (selectedSubjects.Contains(item.Value))
                        {
                            item.Selected = true;
                        }
                    }
                }
                else
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "Teacher Data Not Found.";
                }

                con.Close();
            }
        }

        private void LoadSubject()
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

        protected void btnUpdateteacher_Click(object sender, EventArgs e)
        {
            int tid = Convert.ToInt32(Session["tid"]);
            using (SqlConnection con = new SqlConnection(connect))
            {
                string imgPath = hdnimg.Value;

                if (fuTeacherImage.HasFile)
                {
                    string filename = Path.GetFileName(fuTeacherImage.FileName);
                    imgPath = "~/admin/images/teacher/" + filename;


                    fuTeacherImage.SaveAs(Server.MapPath(imgPath));
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

                string updateQuery = "UPDATE teacher SET FirstName = @FirstName, LastName = @LastName, EmailId = @EmailId, subject = @subject, Gender = @Gender, Dob = @Dob, Phonenumber = @Phonenumber, photo = @photo, Country = @Country, State = @State, District = @District, Pincode = @Pincode, City = @City, Address = @Address WHERE id=@id";

                SqlCommand cmd = new SqlCommand(updateQuery, con);

                cmd.Parameters.AddWithValue("@id", tid);
                cmd.Parameters.AddWithValue("@FirstName", txtfname.Text);
                cmd.Parameters.AddWithValue("@LastName", txtlname.Text);
                cmd.Parameters.AddWithValue("@EmailId", txtemail.Text);
                cmd.Parameters.AddWithValue("@subject", selectedSubjects);
                cmd.Parameters.AddWithValue("@Gender", dgender.SelectedValue);
                cmd.Parameters.AddWithValue("@Dob", txtdob.Text);
                cmd.Parameters.AddWithValue("@Phonenumber", txtmobile.Text.Trim());
                cmd.Parameters.AddWithValue("@photo", imgPath);
                cmd.Parameters.AddWithValue("@Country", txtcountry.Text);
                cmd.Parameters.AddWithValue("@State", txtstate.Text);
                cmd.Parameters.AddWithValue("@District", txtdistrict.Text);
                cmd.Parameters.AddWithValue("@Pincode", txtpincode.Text);
                cmd.Parameters.AddWithValue("@City", txtcity.Text);
                cmd.Parameters.AddWithValue("@Address", txtaddress.Text);

                con.Open();
                int result = cmd.ExecuteNonQuery();
                con.Close();

                if (result > 0)
                {
                    SuccessPanel.Visible = true;
                    SuccessMessage.Text = "Teacher Record Updated Successfully";
                }
                else
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "Error Updating Teacher Record. Please try again.";
                }
                con.Close();
            }
        }
    }
}