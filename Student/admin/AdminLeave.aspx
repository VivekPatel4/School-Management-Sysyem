<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="AdminLeave.aspx.cs" Inherits="Student.admin.AdminLeave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title-area">
        <div class="row align-items-center">
            <div class="col-lg-8 col-md-6 col-sm-12">
                <div class="breadcrumbs-area clearfix">
                    <h4 class="page-title pull-left">Student-Leave Section</h4>
                    <ul class="breadcrumbs pull-left">
                        <li><a href="dashboard.aspx">Home</a></li>
                        <li><span>Student-Leave Applyt</span></li>
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
                        <h4 class="header-title">Student Leave Form</h4>
                        <p class="text-muted font-14 mb-4">Please fill up the form below.</p>

                        <div class="form-group">
                            <label class="col-form-label">Student Name</label>
                            <asp:DropDownList ID="ddlStdName" runat="server" CssClass="custom-select" AppendDataBoundItems="true">
                                <asp:ListItem Text="Click here to select any ..." Value="" />
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label for="fromDate" class="col-form-label">From Date</label>
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label for="toDate" class="col-form-label">To Date</label>
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label class="col-form-label">Your Leave Type</label>
                            <asp:DropDownList ID="ddlLeaveType" runat="server" CssClass="custom-select" AppendDataBoundItems="true">
                                <asp:ListItem Text="Click here to select any ..." Value="" />
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label for="description" class="col-form-label">Describe Your Conditions</label>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox>
                        </div>

                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Apply" OnClick="btnSubmit_Click"/>

                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
