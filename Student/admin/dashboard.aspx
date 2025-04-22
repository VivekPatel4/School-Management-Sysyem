<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="Student.admin.dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: #f3f8fb;
        }

        .icon:hover {
            background-color: white;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="main1">
        <div class="page-title-area">
            <div class="row align-items-center">
                <div class="col-sm-6">
                    <div class="breadcrumbs-area clearfix">
                        <h4 class="page-title pull-left">Dashboard</h4>
                        <ul class="breadcrumbs pull-left">
                            <li><a href="dashboard.aspx">Home</a></li>
                            <li><span>Admin's Dashboard</span></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-6 clearfix">
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
            <div class="sales-report-area mt-5 mb-5">
                <div class="row">
                    <div class="col-md-4">
                        <div class="single-report mb-xs-30">
                            <div class="s-report-inner pr--20 pt--30 mb-3">
                                <div class="icon"><a href="student.aspx"><i class="fa fa-users"></i></a></div>
                                <div class="s-report-title d-flex justify-content-between">
                                    <h4 class="header-title mb-0">Registered Students</h4>

                                </div>
                                <div class="d-flex justify-content-between pb-2">
                                    <h1>
                                        <asp:Literal ID="lblStudentCount" runat="server" Text="0"></asp:Literal></h1>
                                    <span>Active Students</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="single-report mb-xs-30">
                            <div class="s-report-inner pr--20 pt--30 mb-3">
                                <div class="icon"><a href="teacher.aspx"><i class="fa fa-chalkboard-user"></i></a></div>
                                <div class="s-report-title d-flex justify-content-between">
                                    <h4 class="header-title mb-0">Registered Teachers</h4>

                                </div>
                                <div class="d-flex justify-content-between pb-2">
                                    <h1>
                                        <asp:Literal runat="server" ID="lblTeacherCount" Text="0"></asp:Literal></h1>
                                    <span>Active Teachers</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="single-report">
                            <div class="s-report-inner pr--20 pt--30 mb-3">
                                <div class="icon"><a href="department.aspx"><i class="fa fa-th-large"></i></a></div>
                                <div class="s-report-title d-flex justify-content-between">
                                    <h4 class="header-title mb-0">Available Class</h4>

                                </div>
                                <div class="d-flex justify-content-between pb-2">
                                     <h1><asp:Literal runat="server" ID="lblClassCount" Text="0"></asp:Literal></h1>
                                    <span>Student Class</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col-md-4">
                        <div class="single-report mb-xs-30">
                            <div class="s-report-inner pr--20 pt--30 mb-3">
                                <div class="icon"><a href="subject.aspx"><i class="fa-solid fa-book"></i></a></div>
                                <div class="s-report-title d-flex justify-content-between">
                                    <h4 class="header-title mb-0">Available Subjects</h4>

                                </div>
                                <div class="d-flex justify-content-between pb-2">
                                     <h1><asp:Literal ID="lblSubjectCount" runat="server" Text="0"></asp:Literal></h1>
                                    <span>Subjects</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="single-report mb-xs-30">
                            <div class="s-report-inner pr--20 pt--30 mb-3">
                                <div class="icon"><a href="Present.aspx"><i class="fa fa-child"></i></a></div>
                                <div class="s-report-title d-flex justify-content-between">
                                    <h4 class="header-title mb-0">Present student</h4>
                                </div>
                                <div class="d-flex justify-content-between pb-2">
                                    <h1>
                                        <asp:Literal runat="server" ID="lblNoLeaveCount" Text="0"></asp:Literal></h1>
                                    <span>School in student</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="single-report mb-xs-30">
                            <div class="s-report-inner pr--20 pt--30 mb-3">
                                <div class="icon"><a href="absent.aspx"><i class="fa fa-sign-out"></i></a></div>
                                <div class="s-report-title d-flex justify-content-between">
                                    <h4 class="header-title mb-0">Absent student</h4>

                                </div>
                                <div class="d-flex justify-content-between pb-2">
                                    <h1>
                                        <asp:Literal runat="server" ID="lblleavecount" Text="0"></asp:Literal></h1>
                                    <span>Going To Home Students</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-4">
                        <div class="single-report mb-xs-30">
                            <div class="s-report-inner pr--20 pt--30 mb-3">
                                <div class="icon"><a href="PendingHistory.aspx"><i class="fa fa-spinner"></i></a></div>
                                <div class="s-report-title d-flex justify-content-between">
                                    <h4 class="header-title mb-0">Pending Application</h4>
                                </div>
                                <div class="d-flex justify-content-between pb-2">
                                     <h1><asp:Literal runat="server" ID="lblPendingCount" Text="0"></asp:Literal></h1>
                                    <span>Pending</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="single-report mb-xs-30">
                            <div class="s-report-inner pr--20 pt--30 mb-3">
                                <div class="icon"><a href="DeclinedHistory.aspx"><i class="fa fa-times"></i></a></div>
                                <div class="s-report-title d-flex justify-content-between">
                                    <h4 class="header-title mb-0">Declined Application</h4>

                                </div>
                                <div class="d-flex justify-content-between pb-2">
                                      <h1><asp:Literal runat="server" ID="lblDeclinedCount" Text="0"></asp:Literal></h1>
                                    <span>Declined</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="single-report">
                            <div class="s-report-inner pr--20 pt--30 mb-3">
                                <div class="icon"><a href="ApprovedHistory.aspx"><i class="fa fa-check-square-o"></i></a></div>
                                <div class="s-report-title d-flex justify-content-between">
                                    <h4 class="header-title mb-0">Approved Application</h4>

                                </div>
                                <div class="d-flex justify-content-between pb-2">
                                     <h1><asp:Literal ID="lblApproveCount" runat="server" Text="0"></asp:Literal></h1>
                                    <span>Approved</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
