<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="add-admin.aspx.cs" Inherits="Student.admin.add_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title-area">
        <div class="row align-items-center">
            <div class="col-lg-8 col-md-6 col-sm-12">
                <div class="breadcrumbs-area clearfix">
                    <h4 class="page-title pull-left">Add Admin Section</h4>
                    <ul class="breadcrumbs pull-left">
                        <li><a href="ManageAdmin.aspx">Manage Admin</a></li>
                        <li><span>Add</span></li>
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
                        <p class="text-muted font-14 mb-4">Please fill up the form in order to add new system administrator</p>

                        <div class="form-group">
                            <asp:Label ID="fullname" runat="server" CssClass="col-form-label">FullName:</asp:Label>
                            <asp:TextBox ID="txtfullname" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvfullname" runat="server" ErrorMessage="FullName is Required" ControlToValidate="txtfullname"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="email" runat="server" CssClass="col-form-label">Email ID:</asp:Label>
                            <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvemail" runat="server" ErrorMessage="Email ID is Required" ControlToValidate="txtemail"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revemail" runat="server" ErrorMessage="valid Email Id enter" ControlToValidate="txtemail"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"></asp:RegularExpressionValidator>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="username" runat="server" CssClass="col-form-label">UserName:</asp:Label>
                            <asp:TextBox ID="txtusername" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvusername" runat="server" ErrorMessage="UserName is Required" ControlToValidate="txtusername"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                        </div>
                        <h4>Set Password</h4>

                        <div class="form-group">
                            <asp:Label ID="password" runat="server" CssClass="col-form-label">Password:</asp:Label>
                            <asp:TextBox ID="txtpassword" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvpassword" runat="server" ErrorMessage="Password is Required" ControlToValidate="txtpassword"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="confirmPassword" runat="server" CssClass="col-form-label">Confirmation Password:</asp:Label>
                            <asp:TextBox ID="txtconfirmpassword" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvconfirmpassword" runat="server" ErrorMessage="Confirmation Password is Required" ControlToValidate="txtconfirmpassword"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="cvconfirmpassword" runat="server" ErrorMessage="Password Must Be Same Enter" ControlToValidate="txtconfirmpassword"
                                ControlToCompare="txtpassword" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:CompareValidator>
                        </div>

                        <asp:Button ID="btnAddAdmin" runat="server" Text="Add" CssClass="btn btn-primary"
                            OnClick="btnAddAdmin_Click" />
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
