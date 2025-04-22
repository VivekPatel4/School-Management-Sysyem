<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="add-department.aspx.cs" Inherits="Student.admin.edit_department" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title-area">
        <div class="row align-items-center">
            <div class="col-lg-8 col-md-6 col-sm-12">
                <div class="breadcrumbs-area clearfix">
                    <h4 class="page-title pull-left">Class Section</h4>
                    <ul class="breadcrumbs pull-left">
                        <li><a href="department.aspx">Class</a></li>
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
                        <p class="text-muted font-14 mb-4">Please fill up the form in order to add new Class</p>

                        <div class="form-group">
                            <asp:Label ID="deptname" runat="server" CssClass="col-form-label">Class Name:</asp:Label>
                            <asp:TextBox ID="txtdeptname" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvdeptname" runat="server" ErrorMessage="Department Name is Required" ControlToValidate="txtdeptname"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="shortform" runat="server" CssClass="col-form-label">Shortform:</asp:Label>
                            <asp:TextBox ID="txtshortform" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvshortform" runat="server" ErrorMessage="Shortform is Required" ControlToValidate="txtshortform"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="code" runat="server" CssClass="col-form-label">Code:</asp:Label>
                            <asp:TextBox ID="txtcode" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvcode" runat="server" ErrorMessage="Code is Required" ControlToValidate="txtcode"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                        </div>

                        <asp:Button ID="btndepartment" runat="server" Text="Add" CssClass="btn btn-primary"
                            OnClick="btndepartment_Click" />

                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
