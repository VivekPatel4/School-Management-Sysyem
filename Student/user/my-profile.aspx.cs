using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.user
{
    public partial class my_profile : System.Web.UI.Page
    {
        String connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["sid"] == null)
                {
                    Response.Redirect("../user/login.aspx");
                }
                else
                {
                        int sid = Convert.ToInt32(Session["sid"]);
                        Loaddepartment();
                        LoadStudentData(sid);   
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

        private void LoadStudentData(int sid)
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                string q = "select stdid, RoomNo, FirstName, LastName, EmailId, Department, Gender, Dob, Phonenumber, photo, ParentName, Occupation, ParentMobileno, Country, State, District, Pincode, City, Address from students  where id = @id";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@id", sid);
                cmd.Parameters.AddWithValue("@photo", hdnimg.Value);
                con.Open();
                SqlDataReader r = cmd.ExecuteReader();

                if (r.Read())
                {
                    txtstdid.Text = r["stdid"].ToString();
                    txtroomno.Text = r["RoomNo"].ToString();
                    txtfname.Text = r["FirstName"].ToString();
                    txtlname.Text = r["LastName"].ToString();
                    txtemail.Text = r["EmailId"].ToString();
                    ddlDepartment.SelectedValue = r["Department"].ToString();
                    dgender.SelectedValue = r["Gender"].ToString();
                    txtdob.Text = r["Dob"].ToString();
                    txtmobile.Text = r["Phonenumber"].ToString().Trim();


                    string imgPath = r["photo"].ToString();

                    if (!string.IsNullOrEmpty(imgPath))
                    {
                        img.ImageUrl = imgPath;
                        hdnimg.Value = imgPath;
                    }

                    txtparentname.Text = r["ParentName"].ToString();
                    ddlOccupation.SelectedValue = r["Occupation"].ToString();
                    txtpmnumber.Text = r["ParentMobileno"].ToString();
                    txtcountry.Text = r["Country"].ToString();
                    txtstate.Text = r["State"].ToString();
                    txtdistrict.Text = r["District"].ToString();
                    txtpincode.Text = r["Pincode"].ToString();
                    txtcity.Text = r["City"].ToString();
                    txtaddress.Text = r["Address"].ToString();
                    
                }
                else
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "Student Data Not Found.";
                }

                con.Close();
            }

        }
        protected void btnUpdateStudent_Click(object sender, EventArgs e)
        {
            int sid = Convert.ToInt32(Session["sid"]);

            if (sid!=null)
            {
                using (SqlConnection con = new SqlConnection(connect))
                {
                    string imgPath = hdnimg.Value;

                    if (fuStudentImage.HasFile)
                    {
                        string filename = Path.GetFileName(fuStudentImage.FileName);
                        imgPath = "~/admin/images/" + filename;


                        fuStudentImage.SaveAs(Server.MapPath(imgPath));
                    }

                    string updateQuery = "UPDATE students SET stdid = @stdid, RoomNo = @RoomNo, FirstName = @FirstName, LastName = @LastName, EmailId = @EmailId, Department = @Department, Gender = @Gender, Dob = @Dob, Phonenumber = @Phonenumber, photo = @photo, ParentName = @ParentName, Occupation = @Occupation, ParentMobileno = @ParentMobileno, Country = @Country, State = @State, District = @District, Pincode = @Pincode, City = @City, Address = @Address WHERE id=@id";

                    SqlCommand cmd = new SqlCommand(updateQuery, con);

                    cmd.Parameters.AddWithValue("@id", sid);
                    cmd.Parameters.AddWithValue("@stdid", txtstdid.Text);
                    cmd.Parameters.AddWithValue("@RoomNo", txtroomno.Text);
                    cmd.Parameters.AddWithValue("@FirstName", txtfname.Text);
                    cmd.Parameters.AddWithValue("@LastName", txtlname.Text);
                    cmd.Parameters.AddWithValue("@EmailId", txtemail.Text);
                    cmd.Parameters.AddWithValue("@Department", ddlDepartment.SelectedValue);
                    cmd.Parameters.AddWithValue("@Gender", dgender.SelectedValue);
                    cmd.Parameters.AddWithValue("@Dob", txtdob.Text);
                    cmd.Parameters.AddWithValue("@Phonenumber", txtmobile.Text.Trim());
                    cmd.Parameters.AddWithValue("@photo", imgPath);
                    cmd.Parameters.AddWithValue("@ParentName", txtparentname.Text);
                    cmd.Parameters.AddWithValue("@Occupation", ddlOccupation.SelectedValue);
                    cmd.Parameters.AddWithValue("@ParentMobileno", txtpmnumber.Text.Trim());
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
                        SuccessMessage.Text = "Student Record Updated Successfully";
                    }
                    else
                    {
                        ErrorPanel.Visible = true;
                        ErrorMessage.Text = "Error Updating Student Record. Please try again.";
                    }
                    con.Close();
                }


            }
            else
            {
                ErrorPanel.Visible = true;
                ErrorMessage.Text = "Invalid student ID.";
            }
        }
    }
}