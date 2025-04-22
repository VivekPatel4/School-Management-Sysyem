<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="today-hostel.aspx.cs" Inherits="Student.admin.today_hostel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title-area">
        <div class="row align-items-center">
            <div class="col-lg-8 col-md-6 col-sm-12">
                <div class="breadcrumbs-area clearfix">
                    <h4 class="page-title pull-left">Back Today 📅🏠 | Student Section</h4>
                    <ul class="breadcrumbs pull-left">
                        <li><a href="dashboard.aspx">Home</a></li>
                        <li><span>Today Back in Hostel📅🏠-Student List</span></li>
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
                        <div class="single-table">
                            <div class="table-responsive">
                                <table class="table table-hover table-striped table-bordered progress-table text-center">
                                    <thead class="text-capitalize">
                                        <tr>
                                            <th>S.N</th>
                                            <th>Student photo</th>
                                            <th>Student ID</th>
                                            <th>Student Name</th>
                                            <th>Leave Type</th>
                                            <th>Applied On</th>
                                            <th>Current Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater runat="server" ID="rpttoday">
                                            <ItemTemplate>
                                                <tr>
                                                    <td><%# Container.ItemIndex+1 %></td>
                                                    <td>
                                                        <asp:Image
                                                            ID="imgstudent"
                                                            runat="server"
                                                            ImageUrl='<%# GetImageUrl(Eval("photo").ToString()) %>'
                                                            Width="90"
                                                            Height="90"
                                                            Style="background-color: transparent; object-fit: cover;" />
                                                    </td>
                                                    <td><%# Eval("stdid") %></td>
                                                    <td><%# Eval("FirstName")+""+Eval("LastName") %></td>
                                                    <td><%# Eval("LeaveType") %></td>
                                                    <td><%# Eval("PostingDate") %></td>
                                                    <td><%# Convert.ToString(Eval("Status"))=="1"? "<span style='color: green'>Approved <i class='fa fa-thumbs-o-up'></i></span>" : "" %></td>
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
    </div>

</asp:Content>
