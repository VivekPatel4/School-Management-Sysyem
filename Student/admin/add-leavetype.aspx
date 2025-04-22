<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="add-leavetype.aspx.cs" Inherits="Student.admin.add_leavetype" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title-area">
        <div class="row align-items-center">
            <div class="col-lg-8 col-md-6 col-sm-12">
                <div class="breadcrumbs-area clearfix">
                    <h4 class="page-title pull-left">LeaveType Section</h4>
                    <ul class="breadcrumbs pull-left">
                        <li><a href="leavetypes.aspx">LeaveType</a></li>
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
                        <p class="text-muted font-14 mb-4">Please fill up the form in order to add new LeaveType</p>

                        <div class="form-group">
                            <asp:Label ID="leavetype" runat="server" CssClass="col-form-label">Leave Type:</asp:Label>
                            <asp:TextBox ID="txtleavetype" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvleavetype" runat="server" ErrorMessage="LeaveType is Required" ControlToValidate="txtleavetype"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="description" runat="server" CssClass="col-form-label">Short Description:</asp:Label>
                            <asp:TextBox ID="txtdescription" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvdescription" runat="server" ErrorMessage="Description is Required" ControlToValidate="txtdescription"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                        </div>

                   
                        <asp:Button ID="btnleavetype" runat="server" Text="Add" CssClass="btn btn-primary"
                            OnClick="btnleavetype_Click" />

                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
