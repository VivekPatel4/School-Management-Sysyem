<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="schedule.aspx.cs" Inherits="Student.admin.schedule" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title-area">
        <div class="row align-items-center">
            <div class="col-lg-8 col-md-6 col-sm-12">
                <div class="breadcrumbs-area clearfix">
                    <h4 class="page-title pull-left">schedule Section</h4>
                    <ul class="breadcrumbs pull-left">
                        <li><a href="dashboard.aspx">Home</a></li>
                        <li><span>schedule Management</span></li>
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

                    <div class="content">
                        <div class="card-body">
                            <p class="text-muted font-14 mb-4">Please fill up the form in order to add Schedule records</p>
                            <span style="color: blue">
                                <h3>Schedule Details</h3>
                            </span>
                            <div class="row">

                                <div class="form-group col-md-6">
                                    <asp:Label ID="lblTeacher" runat="server" CssClass="col-form-label">Teacher:</asp:Label>
                                    <asp:DropDownList
                                        ID="ddlTeacher"
                                        runat="server"
                                        CssClass="custom-select"
                                        AppendDataBoundItems="True"
                                        AutoPostBack="True"
                                        OnSelectedIndexChanged="ddlTeacher_SelectedIndexChanged">
                                        <asp:ListItem Text="Choose.." Value="" />
                                    </asp:DropDownList>
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="lblSubject" runat="server" CssClass="col-form-label">Subject:</asp:Label>
                                    <asp:TextBox
                                        ID="txtSubject"
                                        runat="server"
                                        CssClass="form-control"
                                        ReadOnly="True" />
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="lblClass" runat="server" CssClass="col-form-label">Class:</asp:Label>
                                    <asp:DropDownList
                                        ID="ddlClass"
                                        runat="server"
                                        CssClass="custom-select"
                                        AppendDataBoundItems="True"
                                        AutoPostBack="false">
                                        <asp:ListItem Text="Choose.." Value="" />
                                    </asp:DropDownList>
                                </div>

                                <div class="row">
                                    <!-- Start Time -->
                                    <div class="form-group col-md-6">
                                        <asp:Label ID="lblStartTime" runat="server" CssClass="col-form-label">Start Time:</asp:Label>
                                        <div class="d-flex">

                                            <asp:DropDownList
                                                ID="ddlStartHours"
                                                runat="server"
                                                CssClass="custom-select"
                                                AppendDataBoundItems="True">
                                                <asp:ListItem Text="HH" Value="" />
                                            </asp:DropDownList>


                                            <asp:DropDownList
                                                ID="ddlStartMinutes"
                                                runat="server"
                                                CssClass="custom-select mx-2"
                                                AppendDataBoundItems="True">
                                                <asp:ListItem Text="MM" Value="" />
                                            </asp:DropDownList>

                                            <asp:DropDownList
                                                ID="ddlStartAmPm"
                                                runat="server"
                                                CssClass="custom-select-md"
                                                AppendDataBoundItems="True">
                                                <asp:ListItem Text="AM/PM" Value="" />
                                                <asp:ListItem Text="AM" Value="AM" />
                                                <asp:ListItem Text="PM" Value="PM" />
                                            </asp:DropDownList>
                                        </div>
                                    </div>

                                    <!-- End Time -->
                                    <div class="form-group col-md-6">
                                        <asp:Label ID="lblEndTime" runat="server" CssClass="col-form-label">End Time:</asp:Label>
                                        <div class="d-flex">

                                            <asp:DropDownList
                                                ID="ddlEndHours"
                                                runat="server"
                                                CssClass="custom-select"
                                                AppendDataBoundItems="True">
                                                <asp:ListItem Text="HH" Value="" />
                                            </asp:DropDownList>

                                            <asp:DropDownList
                                                ID="ddlEndMinutes"
                                                runat="server"
                                                CssClass="custom-select mx-2"
                                                AppendDataBoundItems="True">
                                                <asp:ListItem Text="MM" Value="" />
                                            </asp:DropDownList>

                                            <asp:DropDownList
                                                ID="ddlEndAmPm"
                                                runat="server"
                                                CssClass="custom-select-md"
                                                AppendDataBoundItems="True">
                                                <asp:ListItem Text="AM/PM" Value="" />
                                                <asp:ListItem Text="AM" Value="AM" />
                                                <asp:ListItem Text="PM" Value="PM" />
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>


                            </div>
                            <asp:Button ID="btnAddSchedule" runat="server" Text="Add" CssClass="btn btn-primary"
                                OnClick="btnAddSchedule_Click" />
                        </div>
                    </div>
                </div>
                <table id="dataTable3" class="table table-hover table-striped text-center">
                    <thead class="text-capitalize">
                        <tr>
                            <th>#</th>
                            <th>Teacher</th>
                            <th>Subjects</th>
                            <th>Class</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="ScheduleRepeater" runat="server" OnItemCommand="ScheduleRepeater_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Container.ItemIndex + 1 %></td>
                                    <td><%# Eval("TeacherName") %></td>
                                    <td><%# Eval("Subject") %></td>
                                    <td><%# Eval("Class") %></td>
                                    <td><%# Eval("StartTime") %></td>
                                    <td><%# Eval("EndTime") %></td>
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

</asp:Content>
