<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="student.aspx.cs" Inherits="Student.admin.student" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title-area">
        <div class="row align-items-center">
            <div class="col-sm-6">
                <div class="breadcrumbs-area clearfix">
                    <h4 class="page-title pull-left">Students Section</h4>
                    <ul class="breadcrumbs pull-left">
                        <li><a href="dashboard.aspx">Home</a></li>
                        <li><span>Students Management</span></li>
                    </ul>
                </div>
            </div>
            <div class="col-sm-6 clearfix">
                <asp:ImageButton ID="ImageButton1" runat="server" src="../assets/images/icon/happy-birthday.png" Width="50" Height="50" Style="margin-left:200px;margin-top:10px;" OnClick="ImageButton1_Click"/>
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

                    <asp:Panel ID="ErrorPanel" runat="server" CssClass="alert alert-danger alert-dismissible fade show" Visible="false">
                        <strong>Info: </strong>
                        <asp:Literal ID="ErrorMessage" runat="server" />
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </asp:Panel>
                    <asp:Panel ID="SuccessPanel" runat="server" CssClass="alert alert-success alert-dismissible fade show" Visible="false">
                        <strong>Info: </strong>
                        <asp:Literal ID="SuccessMessage" runat="server" />
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </asp:Panel>

                    <div class="card-body">
                        <div class="data-tables datatable-dark">
                            <center>
                                <asp:LinkButton ID="AddStudentbtn" runat="server" CssClass="btn btn-sm btn-info" OnClick="AddStudentbtn_Click">
                                    Add New Student
                                </asp:LinkButton>
                            </center>

                            <table id="dataTable3" class="table table-hover table-striped text-center">
                                <thead class="text-capitalize">
                                    <tr>
                                        <th>#</th>
                                        <th>Student Image</th>
                                        <th>RoomNo</th>
                                        <th>Name</th>
                                        <th>Student ID</th>
                                        <th>Department</th>
                                        <th>Joined On</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="StudentRepeater" runat="server" OnItemCommand="StudentRepeater_ItemCommand">
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
                                                <td><%# Eval("FirstName") + " " + Eval("LastName") %></td>
                                                <td><%# Eval("stdid") %></td>
                                                <td><%# Eval("Department") %></td>
                                                <td><%# Eval("RegDate") %></td>
                                                <td>
                                                    <%# 
                                                        Convert.ToBoolean(Eval("Status")) 
                                                        ? "<span class='badge badge-pill badge-success'>Active</span>" 
                                                        : "<span class='badge badge-pill badge-danger'>Inactive</span>" 
                                                    %>
                                                </td>

                                                <td>
                                                    <asp:LinkButton ID="EditButton" runat="server" CssClass="btn btn-sm btn-success"
                                                        CommandName="Edit" CommandArgument='<%# Eval("id") %>'>
                                                        <i class="fa fa-edit"></i>
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="DeleteButton" runat="server" CssClass="btn btn-sm btn-danger"
                                                        CommandName="Delete" CommandArgument='<%# Eval("id") %>' OnClientClick="return confirm('Do you want to delete?');">
                                                        <i class="fa fa-trash"></i>
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="StatusButton" runat="server"
                                                        CssClass='<%# GetStatusButtonCssClass(Eval("Status")) %>'
                                                        CommandName='<%# GetStatusCommandName(Eval("Status")) %>'
                                                        CommandArgument='<%# Eval("id") %>'
                                                        OnClientClick='<%# GetStatusOnClientClick(Eval("Status")) %>'>
                                                        <i class='<%# GetStatusIconClass(Eval("Status")) %>' 
                                                          style='<%# GetStatusIconStyle(Eval("Status")) %>'>
                                                        </i>
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="ViewDetailsButton" runat="server" CssClass="btn btn-sm btn-info"
                                                        CommandName="View" CommandArgument='<%# Eval("id") %>'>
                                                         <i class="fa fa-eye" style="color:blue" title="View Student Details"></i>
                                                    </asp:LinkButton>
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
