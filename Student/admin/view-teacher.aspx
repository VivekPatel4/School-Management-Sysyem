<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="view-teacher.aspx.cs" Inherits="Student.admin.view_teacher" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .teacher-card {
            display: flex;
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 3px 20px 0px;
            background-color: #f9f9f9;
            margin-bottom: 20px;
        }

        .teacher-image {
            margin-right: 20px;
        }

        .teacher-info {
            flex-grow: 1;
            text-align: start;
            margin-left: 200px;
        }

            .teacher-info h4 {
                font-size: 1.5em;
                margin-bottom: 10px;
            }

            .teacher-info p {
                font-size: 1em;
                margin: 5px 0;
            }

            .teacher-info strong {
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
                    <h4 class="page-title pull-left">Teacher Section</h4>
                    <ul class="breadcrumbs pull-left">
                        <li><a href="teacher.aspx">Teacher</a></li>
                        <li><span>View Teacher Details</span></li>
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
                                        <th>Teacher Details</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="TeacherData" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td colspan="2">

                                                    <div class="teacher-card">
                                                        <div class="teacher-image">
                                                            <asp:Image
                                                                ID="imgteacher"
                                                                runat="server"
                                                                ImageUrl='<%# GetImageUrl(Eval("photo").ToString()) %>'
                                                                Width="120"
                                                                Height="120"
                                                                Style="border-radius: 50%; object-fit: cover;" />
                                                        </div>
                                                        <div class="teacher-info">
                                                            <h4><%# Eval("FirstName") + " " + Eval("LastName") %></h4>
                                                            <p><strong>Email ID:</strong> <%# Eval("EmailId") %></p>
                                                            <p><strong>Gender:</strong> <%# Eval("Gender") %></p>
                                                            <p><strong>Subjects:</strong> <%# Eval("subject") %></p>
                                                            <p><strong>D.O.B:</strong> <%# Eval("Dob") %></p>
                                                            <p><strong>Contact:</strong> <%# Eval("Phonenumber") %></p>
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
