<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="birthdate.aspx.cs" Inherits="Student.admin.birthdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title-area">
        <div class="row align-items-center">
            <div class="col-lg-8 col-md-6 col-sm-12">
                <div class="breadcrumbs-area clearfix">
                    <h4 class="page-title pull-left">Student Section</h4>
                    <ul class="breadcrumbs pull-left">
                        <li><a href="student.aspx">Student</a></li>
                        <li><span>Today Birthday Students List</span></li>
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
                                        <th>#</th>
                                        <th>Photo</th>
                                        <th>RoomNo</th>
                                        <th>Name</th>
                                        <th>Student ID</th>
                                        <th>Department</th>
                                        <th>city/village</th>
                                        <th>D.O.B</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="BirthDateData" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Container.ItemIndex + 1 %></td>
                                                <td>
                                                    <asp:Image
                                                        ID="imgstudent"
                                                        runat="server"
                                                        ImageUrl='<%# GetImageUrl(Eval("photo").ToString()) %>'
                                                        Width="90"
                                                        Height="90"
                                                        Style="background-color: transparent; object-fit: cover;" />
                                                </td>
                                                <td><%# Eval("RoomNo") %></td>
                                                <td><%# Eval("FirstName")+""+Eval("LastName") %></td>
                                                <td><%# Eval("stdid") %></td>
                                                <td><%# Eval("Department") %></td>
                                                <td><%# Eval("City") %></td>
                                                <td><%# Eval("Dob") %></td>
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
