<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="view-student.aspx.cs" Inherits="Student.admin.view_student" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .student-card {
            display: flex;
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 10px;
            box-shadow:0px 3px 20px 0px;
            background-color: #f9f9f9;
            margin-bottom: 20px;
        }

        .student-image {
            margin-right: 20px;
        }

        .student-info {
            flex-grow: 1;
            text-align: start;
            margin-left: 200px;
        }

            .student-info h4 {
                font-size: 1.5em;
                margin-bottom: 10px;
            }

            .student-info p {
                font-size: 1em;
                margin: 5px 0;
            }

            .student-info strong {
                font-weight: bold;
            }

        table {
            width: 100%;
            table-layout: fixed;
        }

        td {
            padding: 15px;
            vertical-align: top;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title-area">
        <div class="row align-items-center">
            <div class="col-lg-8 col-md-6 col-sm-12">
                <div class="breadcrumbs-area clearfix">
                    <h4 class="page-title pull-left">Student Section</h4>
                    <ul class="breadcrumbs pull-left">
                        <li><a href="student.aspx">Student</a></li>
                        <li><span>View Student Details</span></li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 col-sm-12 text-right clearfix">
                <div class="user-profile pull-right">
                    <img class="avatar user-thumb" src="../assets/images/admin.png" alt="avatar">
                    <h4 class="user-name dropdown-toggle" data-toggle="dropdown">ADMIN <i class="fa fa-angle-down"></i></h4>
                    <div class="dropdown-menu">
                        <asp:LinkButton ID="LinkButtonLogout" runat="server" CssClass="dropdown-item" OnClick="LinkButtonLogout_Click" CausesValidation="false">Log Out</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="main-content-inner">
        <div class="row">
            <div class="col-12 mt-5">
                <div class="card">

                    <div class="card-body">
                        <div class="data-tables datatable-dark">
                            <table id="dataTable3" class="table table-hover table-striped text-center">
                                <thead class="text-capitalize">
                                    <tr>
                                        <th></th>
                                        <th>Student Details</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="StudentData" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td colspan="2">
                                                   
                                                    <div class="student-card">
                                                        <div class="student-image">
                                                            <asp:Image
                                                                ID="imgstudent"
                                                                runat="server"
                                                                ImageUrl='<%# GetImageUrl(Eval("photo").ToString()) %>'
                                                                Width="120"
                                                                Height="120"
                                                                Style="border-radius: 50%; object-fit: cover;" />
                                                        </div>
                                                        <div class="student-info">
                                                            <h4><%# Eval("FirstName") + " " + Eval("LastName") %></h4>
                                                            <p><strong>Student ID:</strong> <%# Eval("stdid") %></p>
                                                            <p><strong>Room No:</strong> <%# Eval("RoomNo") %></p>
                                                            <p><strong>Email ID:</strong> <%# Eval("EmailId") %></p>
                                                            <p><strong>Gender:</strong> <%# Eval("Gender") %></p>
                                                            <p><strong>Department:</strong> <%# Eval("Department") %></p>
                                                            <p><strong>D.O.B:</strong> <%# Eval("Dob") %></p>
                                                            <p><strong>Contact:</strong> <%# Eval("Phonenumber") %></p>
                                                            <p><strong>Parent Name:</strong> <%# Eval("ParentName") %></p>
                                                            <p><strong>Occupation:</strong> <%# Eval("Occupation") %></p>
                                                            <p><strong>Parent Contact No.:</strong> <%# Eval("ParentMobileno") %></p>
                                                            <p><strong>City:</strong> <%# Eval("City") %></p>
                                                            <p><strong>Address:</strong> <%# Eval("Address") %></p>
                                                            <p><strong>Password:</strong> <%# Eval("Password") %></p>
                                                            <p><strong>Joined On:</strong> <%# Eval("RegDate") %></p>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
