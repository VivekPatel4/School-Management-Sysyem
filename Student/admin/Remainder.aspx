<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="Remainder.aspx.cs" Inherits="Student.admin.Remainder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title-area">
        <div class="row align-items-center">
            <div class="col-lg-8 col-md-6 col-sm-12">
                <div class="breadcrumbs-area clearfix">
                    <h4 class="page-title pull-left">Remainder Section</h4>
                    <ul class="breadcrumbs pull-left">
                        <li><a href="dashboard.aspx">Home</a></li>
                        <li><span>Remainder Management</span></li>
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
                            <asp:LinkButton ID="AddRemainderButton" runat="server" CssClass="btn btn-sm btn-info" OnClick="AddRemainderButton_Click">
                                Add New Remainder
                            </asp:LinkButton>
                        </center>
                        <table id="dataTable3" class="table table-hover table-striped text-center">
                            <thead class="text-capitalize">
                                <tr>
                                    <th>#</th>
                                    <th>name</th>
                                    <th>MOBILENO</th>
                                    <th>remark</th>
                                    <th>Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="RemainderRepeater" runat="server" OnItemCommand="RemainderRepeater_ItemCommand">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# Container.ItemIndex + 1 %></td>
                                            <td><%# Eval("Name") %></td>
                                            <td><%# Eval("MOBILENO") %></td>
                                            <td><%# Eval("remark") %></td>
                                            <td><%# String.Format("{0:yyyy-MM-dd}", Eval("wishyear")) %></td>
                                            <td>

                                                <asp:LinkButton ID="DeleteButton" runat="server" CssClass="btn btn-sm btn-danger" 
                                                    CommandName="Delete" CommandArgument='<%# Eval("id") %>' OnClientClick="return confirm('Do you want to delete?');">
                                               <i class="fa fa-trash"></i>
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

</asp:Content>
