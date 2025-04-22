<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="edit-subject.aspx.cs" Inherits="Student.admin.edit_subject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title-area">
        <div class="row align-items-center">
            <div class="col-lg-8 col-md-6 col-sm-12">
                <div class="breadcrumbs-area clearfix">
                    <h4 class="page-title pull-left">Subject Section</h4>
                    <ul class="breadcrumbs pull-left">
                        <li><a href="subject.aspx">Subject</a></li>
                        <li><span>Edit</span></li>
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
                        <p class="text-muted font-14 mb-4">Please fill up the form in order to add new Subject</p>

                        <div class="form-group">
                            <asp:Label ID="subname" runat="server" CssClass="col-form-label">Subject Name:</asp:Label>
                            <asp:TextBox ID="txtsubname" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvsubname" runat="server" ErrorMessage="Subject Name is Required" ControlToValidate="txtsubname"
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

                        <asp:Button ID="btnsubject" runat="server" Text="Update" CssClass="btn btn-primary"
                            OnClick="btnsubject_Click" />

                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
