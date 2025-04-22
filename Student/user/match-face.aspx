<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.Master" AutoEventWireup="true" CodeBehind="match-face.aspx.cs" Inherits="Student.user.match_face" EnableSessionState="True" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        h1 {
            animation: text-shadow 1.5s ease-in-out infinite;
            font-size: 2em;
            font-weight: 900;
            line-height: 1;
        }

            h1:hover {
                animation-play-state: paused;
            }

        @keyframes text-shadow {
            0% {
                transform: translateY(0);
                text-shadow: 0 0 0 #0c2ffb, 0 0 0 #2cfcfd, 0 0 0 #fb203b, 0 0 0 #fefc4b;
            }

            20% {
                transform: translateY(-1em);
                text-shadow: 0 0.125em 0 #0c2ffb, 0 0.25em 0 #2cfcfd, 0 -0.125em 0 #fb203b, 0 -0.25em 0 #fefc4b;
            }

            40% {
                transform: translateY(0.5em);
                text-shadow: 0 -0.0625em 0 #0c2ffb, 0 -0.125em 0 #2cfcfd, 0 0.0625em 0 #fb203b, 0 0.125em 0 #fefc4b;
            }

            60% {
                transform: translateY(-0.25em);
                text-shadow: 0 0.03125em 0 #0c2ffb, 0 0.0625em 0 #2cfcfd, 0 -0.03125em 0 #fb203b, 0 -0.0625em 0 #fefc4b;
            }

            80% {
                transform: translateY(0);
                text-shadow: 0 0 0 #0c2ffb, 0 0 0 #2cfcfd, 0 0 0 #fb203b, 0 0 0 #fefc4b;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            * {
                animation: none !important;
                transition: none !important;
            }
        }

        .day-icons {
            display: flex;
            justify-content: end;
            gap: 10px;
            margin-top: -31px;
        }

        .day-icon {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.0em;
            color: #fff;
            box-shadow: rgba(0, 0, 0, 0.15) 0px 15px 25px, rgba(0, 0, 0, 0.05) 0px 5px 10px;
        }

        .green {
            background-color: green;
        }

        .red {
            background-color: red;
        }

        .unknown {
            background-color: gray;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="main-content-inner">
        <div class="col-12 mt-5">
            <div class="row">
                <h1>Attendance</h1>
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
                        <div class="data-tabels">
                            <center class="at">
                                <asp:Button ID="btnMarkAttendance" runat="server" Text="Mark Attendance" CssClass="btn btn-primary" OnClick="btnMarkAttendance_Click" />
                                <asp:Repeater ID="daynamerpt" runat="server">
                                    <ItemTemplate>
                                        <div class="day-icons">
                                            <div class="day-icon <%# GetDayClass("MONDAY", Container.DataItem, Eval("student_id")) %>">
                                                M
                                            </div>
                                            <div class="day-icon <%# GetDayClass("TUESDAY", Container.DataItem, Eval("student_id")) %>">
                                                T
                                            </div>
                                            <div class="day-icon <%# GetDayClass("WEDNESDAY", Container.DataItem, Eval("student_id")) %>">
                                                W
                                            </div>
                                            <div class="day-icon <%# GetDayClass("THURSDAY", Container.DataItem, Eval("student_id")) %>">
                                                T
                                            </div>
                                            <div class="day-icon <%# GetDayClass("FRIDAY", Container.DataItem, Eval("student_id")) %>">
                                                F
                                            </div>
                                            <div class="day-icon <%# GetDayClass("SATURDAY", Container.DataItem, Eval("student_id")) %>">
                                                S
                                            </div>
                                            <div class="day-icon red">
                                                S
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </center>

                            <table id="dataTable" class="table table-hover progress-table text-center">
                                <thead class="bg-light text-capitalize">
                                    <tr>
                                        <th>#</th>
                                        <th>Student ID</th>
                                        <th>Name</th>
                                        <th>Class</th>
                                        <th>Status</th>
                                        <th>Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="attendanceRepeater" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Container.ItemIndex + 1 %></td>
                                                <td><%# Eval("stdid") %></td>
                                                <td><%# Eval("FirstName") + " " + Eval("LastName") %></td>
                                                <td><%# Eval("Class") %></td>
                                                <td><%# Eval("status").ToString()=="Present" ?  "<span style='color: green'>Present</span>" : "" %></td>
                                                <td><%# Eval("date") %></td>
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
    <script type="text/javascript">
        function autoClosePanel(panelId) {
            var panel = document.getElementById(panelId);
            if (panel) {
                setTimeout(function () {
                    panel.style.display = 'none';
                }, 2000);
            }
        }
    </script>
</asp:Content>
