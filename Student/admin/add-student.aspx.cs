using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.admin
{
    public partial class add_student : System.Web.UI.Page
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
                    Loaddepartment();
                }

            }
        }

        private void Loaddepartment()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                SqlCommand cmd = new SqlCommand("select * from departments", con);
                con.Open();
                SqlDataReader r = cmd.ExecuteReader();
                ddlDepartment.DataSource = r;
                ddlDepartment.DataTextField = "DepartmentName";
                ddlDepartment.DataBind();
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void btnAddStudent_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                string capturedImgPath = hdnCapturedImg.Value;
                string imgPath = "";
                string query = @"INSERT INTO students 
                    (stdid, RoomNo, FirstName, LastName, EmailId, Department, Gender, Dob, Phonenumber, photo,capturedPhoto, ParentName, Occupation, ParentMobileno, Country, State, District, Pincode, City, Address, Password, Status, RegDate) 
                    VALUES 
                    (@StdId, @RoomNo, @FirstName, @LastName, @EmailId, @Department, @Gender, @Dob, @PhoneNumber, @Photo, @CapturedPhoto, @ParentName, @Occupation, @ParentMobileNo, @Country, @State, @District, @Pincode, @City, @Address, @Password, @Status, GETDATE())";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {

                    if (fuStudentImage.HasFile)
                    {
                        string fileName = Path.GetFileName(fuStudentImage.FileName);
                        imgPath = "~/admin/images/" + fileName;
                        fuStudentImage.SaveAs(Server.MapPath(imgPath));
                        img.ImageUrl = imgPath;
                        hdnimg.Value = imgPath;
                    }
                    string capturedImgPathOnServer = SaveCapturedImage(capturedImgPath);

                    cmd.Parameters.AddWithValue("@StdId", txtstdid.Text);
                    cmd.Parameters.AddWithValue("@RoomNo", txtroomno.Text);
                    cmd.Parameters.AddWithValue("@FirstName", txtfname.Text);
                    cmd.Parameters.AddWithValue("@LastName", txtlname.Text);
                    cmd.Parameters.AddWithValue("@EmailId", txtemail.Text);
                    cmd.Parameters.AddWithValue("@Department", ddlDepartment.SelectedValue);
                    cmd.Parameters.AddWithValue("@Gender", dgender.SelectedValue);
                    cmd.Parameters.AddWithValue("@Dob", txtdob.Text);
                    cmd.Parameters.AddWithValue("@PhoneNumber", txtmobile.Text.Trim());
                    cmd.Parameters.AddWithValue("@Photo", imgPath);
                    cmd.Parameters.AddWithValue("@CapturedPhoto", capturedImgPathOnServer);
                    cmd.Parameters.AddWithValue("@ParentName", txtparentname.Text);
                    cmd.Parameters.AddWithValue("@Occupation", ddlOccupation.SelectedValue);
                    cmd.Parameters.AddWithValue("@ParentMobileNo", txtpmnumber.Text);
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
                        SuccessMessage.Text = "Student record added successfully.";
                    }
                    con.Close();
                    Clear();
                }
            }
        }

        private void Clear()
        {
            txtstdid.Text=String.Empty;
            txtroomno.Text=String.Empty;
            txtfname.Text=String.Empty;
            txtlname.Text=String.Empty;
            txtemail.Text=String.Empty;
            ddlDepartment.SelectedIndex = 0;
            dgender.SelectedIndex = 0;
            txtdob.Text=String.Empty;
            txtmobile.Text=String.Empty;
            txtparentname.Text=String.Empty;
            ddlOccupation.SelectedIndex = 0;
            txtpmnumber.Text=String.Empty;
            txtcountry.Text=String.Empty;
            txtstate.Text=String.Empty;
            txtdistrict.Text=String.Empty;
            txtpincode.Text=String.Empty;
            txtcity.Text=String.Empty;
            txtaddress.Text=String.Empty;
            txtpassword.Text=String.Empty;
            txtconfirmpassword.Text=String.Empty;
            img.ImageUrl=String.Empty;
        }

        private string SaveCapturedImage(string base64Image)
        {
            try
            {
                string base64Data = base64Image.Substring(base64Image.IndexOf(",") + 1);
                byte[] imageData = Convert.FromBase64String(base64Data);
                
                string fileName = Guid.NewGuid().ToString() + ".png";
                string relativePath = "~/admin/images/face/" + fileName;
                string filePath = Server.MapPath(relativePath);
              
                string folderPath = Path.GetDirectoryName(filePath);
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }
              
                File.WriteAllBytes(filePath, imageData);

                return relativePath; 
            }
            catch (Exception ex)
            {
                ErrorPanel.Visible = true;
                ErrorMessage.Text = "An error occurred: " + ex.Message;
                return string.Empty;
            }
        }

    }
}