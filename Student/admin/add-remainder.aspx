 <%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="add-remainder.aspx.cs" Inherits="Student.admin.add_remainder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title-area">
        <div class="row align-items-center">
            <div class="col-lg-8 col-md-6 col-sm-12">
                <div class="breadcrumbs-area clearfix">
                    <h4 class="page-title pull-left">Remainder Section</h4>
                    <ul class="breadcrumbs pull-left">
                        <li><a href="Remainder.aspx">Remainder</a></li>
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

                        <div class="form-group col-md-6">
                            <asp:Label ID="name" runat="server" CssClass="col-form-label">Name:</asp:Label>
                            <asp:TextBox ID="txtname" runat="server" CssClass="form-control" />
                        </div>

                        <div class="form-group col-md-6">
                            <asp:Label ID="mobile" runat="server" CssClass="col-form-label">Mobile No:</asp:Label>
                            <asp:TextBox ID="txtmobile" TextMode="Number" runat="server" CssClass="form-control" />
                            <asp:RegularExpressionValidator ID="revmobile" runat="server" ErrorMessage="Please enter a valid Contact Number" ControlToValidate="txtmobile"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small" ValidationExpression="^[0-9]{10}$"></asp:RegularExpressionValidator>
                        </div>


                        <div class="form-group col-md-6">
                            <asp:Label ID="remark" runat="server" CssClass="col-form-label">Remark:</asp:Label>
                            <asp:TextBox ID="txtremark" runat="server" CssClass="form-control" />
                        </div>

                        <div class="form-group col-md-6">
                            <asp:Label ID="date" runat="server" CssClass="col-form-label">Date:</asp:Label>
                            <asp:TextBox ID="txtdate" runat="server" TextMode="Date" CssClass="form-control" />
                        </div>

                        <asp:Button ID="btnAddRemainder" runat="server" Text="Add" CssClass="btn btn-primary"
                            OnClick="btnAddRemainder_Click"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
