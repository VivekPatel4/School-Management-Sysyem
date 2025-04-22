using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using Student.admin;
using System.Windows.Controls.Primitives;
using System.Data;
using System.Windows.Media.Animation;

namespace Student.user
{
    public partial class match_face : System.Web.UI.Page
    {
        string connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
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
                    attendancedata();
                    if (Request.QueryString["class"] != null)
                    {
                        Session["class"] = Request.QueryString["class"];
                        
                    }
                    else
                    {
                        btnMarkAttendance.Enabled = false;
                        ErrorPanel.Visible = true;
                        ErrorMessage.Text = "class not found!";
                    }
                  
                }
            }
        }

        private void attendancedata()
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                string q = "SELECT * from attendance where student_id=@id";
                SqlCommand cmd = new SqlCommand(q, conn);
                cmd.Parameters.AddWithValue("@id", Session["sid"]);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                daynamerpt.DataSource = dt;
                daynamerpt.DataBind();
                attendanceRepeater.DataSource = dt;
                attendanceRepeater.DataBind();
            }
        }

        protected string GetDayClass(string dayName, object dataItem, object studentId)
        {
            Dictionary<string, bool> attendanceData = GetStudentAttendance(studentId.ToString());

            if (attendanceData.ContainsKey(dayName) && attendanceData[dayName])
            {
                return "green";
            }
            else
            {
                return "unknown";
            }
        }

        private Dictionary<string, bool> GetStudentAttendance(string studentId)
        {
            Dictionary<string, bool> attendanceData = new Dictionary<string, bool>();

            DateTime today = DateTime.Today;
            DateTime startOfWeek = today.AddDays(-(int)today.DayOfWeek + (int)DayOfWeek.Monday);
            DateTime endOfWeek = startOfWeek.AddDays(6);

            string query = "SELECT dayname, status FROM attendance WHERE student_id = @StudentID AND D BETWEEN @StartOfWeek AND @EndOfWeek";
            using (SqlConnection conn = new SqlConnection(connect))
            {
                using (SqlCommand command = new SqlCommand(query, conn))
                {
                    command.Parameters.AddWithValue("@StudentID", studentId);
                    command.Parameters.AddWithValue("@StartOfWeek", startOfWeek);
                    command.Parameters.AddWithValue("@EndOfWeek", endOfWeek);
                    conn.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        string day = reader["dayname"].ToString();
                        string status = reader["status"].ToString();
                        bool isPresent = status.Equals("Present", StringComparison.OrdinalIgnoreCase);

                        if (!attendanceData.ContainsKey(day))
                        {
                            attendanceData.Add(day, isPresent);
                        }
                    }
                }
            }
            return attendanceData;
        }


        protected void btnMarkAttendance_Click(object sender, EventArgs e)
        {
            string storedImagePath = "";
            ErrorPanel.Visible = false;
            SuccessPanel.Visible = false;
            try
            {
                using (SqlConnection con = new SqlConnection(connect))
                {

                    string checkQuery = @"SELECT COUNT(*) FROM attendance WHERE student_id = @StudentId AND D = CONVERT(DATE, GETDATE())";

                    using (SqlCommand cmd = new SqlCommand(checkQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@StudentId", Session["sid"]);
                        con.Open();
                        int attendanceCount = (int)cmd.ExecuteScalar();
                        if (attendanceCount > 0)
                        {

                            ErrorPanel.Visible = true;
                            ErrorMessage.Text = "Attendance already marked for today.";
                            ScriptManager.RegisterStartupScript(this, GetType(), "AutoCloseError", "autoClosePanel('" + ErrorPanel.ClientID + "');", true);
                            return;
                        }
                    }
                }

                using (SqlConnection con = new SqlConnection(connect))
                {
                    string query = "SELECT capturedPhoto FROM students WHERE id = @StudentId";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@StudentId", Session["sid"]);
                        con.Open();
                        storedImagePath = cmd.ExecuteScalar()?.ToString();
                    }
                }


                if (string.IsNullOrEmpty(storedImagePath))
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "Student not found or image path is missing.";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AutoCloseError", "autoClosePanel('" + ErrorPanel.ClientID + "');", true);
                    return;
                }


                string mappedImagePath = Server.MapPath(storedImagePath);
                if (!File.Exists(mappedImagePath))
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "Stored image file not found.";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AutoCloseError", "autoClosePanel('" + ErrorPanel.ClientID + "');", true);
                    return;
                }


                string pythonScriptPath = Server.MapPath("~/Scripts/face_recognition.py");
                if (!File.Exists(pythonScriptPath))
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "Face recognition script not found.";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AutoCloseError", "autoClosePanel('" + ErrorPanel.ClientID + "');", true);
                    return;
                }


                ProcessStartInfo start = new ProcessStartInfo
                {
                    FileName = "C:\\Program Files\\Python312\\python.exe",
                    Arguments = $"\"{pythonScriptPath}\" \"{mappedImagePath}\"",
                    UseShellExecute = false,
                    RedirectStandardOutput = true,
                    RedirectStandardError = true,
                    CreateNoWindow = true
                };

                using (Process process = Process.Start(start))
                {
                    using (StreamReader reader = process.StandardOutput)
                    {
                        string result = reader.ReadToEnd();
                        if (result.Contains("Face match found!"))
                        {
                            using (SqlConnection con = new SqlConnection(connect))
                            {
                                string query = @"INSERT INTO attendance (student_id, stdid, FirstName, LastName, class, status, date,dayname,D)
                                                  SELECT id, stdid, FirstName, LastName, @ClassName, 'Present', 
                                                    CONVERT(VARCHAR, YEAR(GETDATE()), 4) + '-' + 
                                                    RIGHT('0' + CONVERT(VARCHAR, MONTH(GETDATE())), 2) + 
                                                    '(' + UPPER(DATENAME(MONTH, GETDATE())) + ')' + '-' + 
                                                     CONVERT(VARCHAR, DAY(GETDATE())) + ' (' + DATENAME(WEEKDAY, GETDATE()) + ') ' + 
                                                     FORMAT(GETDATE(), 'hh:mm:ss tt'),UPPER(DATENAME(WEEKDAY, GETDATE())),GETDATE()
                                                     FROM students
                                                     WHERE id = @StudentId";

                                using (SqlCommand cmd = new SqlCommand(query, con))
                                {
                                    cmd.Parameters.AddWithValue("@StudentId", Session["sid"]);
                                    cmd.Parameters.AddWithValue("@ClassName", Session["class"]);
                                    con.Open();
                                    cmd.ExecuteNonQuery();
                                }
                            }

                            SuccessPanel.Visible = true;
                            SuccessMessage.Text = "Attendance marked successfully for student: " + Session["sid"];
                            ScriptManager.RegisterStartupScript(this, GetType(), "AutoCloseSuccess", "autoClosePanel('" + SuccessPanel.ClientID + "');", true);
                            attendancedata();
                        }
                        else
                        {
                            ErrorPanel.Visible = true;
                            ErrorMessage.Text = "Face match not found. Attendance not marked.";
                            ScriptManager.RegisterStartupScript(this, GetType(), "AutoCloseError", "autoClosePanel('" + ErrorPanel.ClientID + "');", true);
                        }
                    }


                    using (StreamReader errorReader = process.StandardError)
                    {
                        string error = errorReader.ReadToEnd();
                        if (!string.IsNullOrEmpty(error))
                        {
                            ErrorPanel.Visible = true;
                            ErrorMessage.Text = "Error in face recognition: " + error;
                            ScriptManager.RegisterStartupScript(this, GetType(), "AutoCloseError", "autoClosePanel('" + ErrorPanel.ClientID + "');", true);
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                ErrorPanel.Visible = true;
                ErrorMessage.Text = "Database error: " + ex.Message;
                ScriptManager.RegisterStartupScript(this, GetType(), "AutoCloseError", "autoClosePanel('" + ErrorPanel.ClientID + "');", true);
            }
            catch (Exception ex)
            {
                ErrorPanel.Visible = true;
                ErrorMessage.Text = "Error: " + ex.Message;
                ScriptManager.RegisterStartupScript(this, GetType(), "AutoCloseError", "autoClosePanel('" + ErrorPanel.ClientID + "');", true);
            }
        }
    }
}