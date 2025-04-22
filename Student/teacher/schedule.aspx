<%@ Page Title="" Language="C#" MasterPageFile="~/teacher/teacher.Master" AutoEventWireup="true" CodeBehind="schedule.aspx.cs" Inherits="Student.teacher.schedule" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="..\teacher\schedule.css" rel="stylesheet" />

    <script type="text/javascript">

        function openAttendancePopup() {
            var panel = document.getElementById('<%= panelAttendance.ClientID %>');
            panel.style.display = 'block';
        }

        function closeAttendancePopup() {
            var panel = document.getElementById('<%= panelAttendance.ClientID %>');
            panel.style.display = 'none';
        }
    </script>

    <style>
        .attendance-panel {
            position: fixed;
            top: 20%;
            left: 40%;
            width: 45%;
            background-color: #bab6b6;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            padding: 20px;
            border-radius: 20px;
            display: none;
            z-index: 1000;
        }

            .attendance-panel .table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 16px;
                margin-left: -2px;
            }

                .attendance-panel .table th, .attendance-panel .table td {
                    padding: 8px;
                    border: 1px solid #ccc;
                }

            .attendance-panel .button-container {
                margin-top: 10px;
                text-align: center;
            }

        .pending-title {
            position: absolute;
            top: 92px;
            left: 10%;
            width: auto;
            background-color: transparent;
            padding: 10px 20px;
            font-size: 24px;
            font-weight: bold;
            z-index: 1000;
        }

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
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Repeater ID="repeaterSchedule" runat="server">
        <HeaderTemplate>
            <h1 class="pending-title">Class Schedule</h1>
            <table class="table">
                <thead>
                    <tr>
                        <th>Subject</th>
                        <th>Class</th>
                        <th>Start Time</th>
                        <th>End Time</th>
                        <th>Total Students</th>
                    </tr>
                </thead>
                <tbody>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td><%# Eval("Subject") %></td>
                <td><%# Eval("Class") %></td>
                <td><%# Eval("StartTime") %></td>
                <td><%# Eval("EndTime") %></td>
                <td>
                    <%# count(Eval("Class").ToString()) %>
                    <asp:Button ID="btnShowStudents" runat="server" Text="Show" CssClass="button" OnClick="btnShowStudents_Click" CommandArgument='<%# Eval("Class") %>' />
                </td>
                <td>
                    <asp:Button ID="btnStartAttendance" runat="server" Text="Start Attendance" CssClass="button"
                        OnClick="btnStartAttendance_Click" CommandArgument='<%# Eval("Class") %>' />
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </tbody>
        </table>
        </FooterTemplate>
    </asp:Repeater>


    <asp:Panel ID="panelStudents" runat="server" CssClass="student-panel" Visible="false">
        <asp:Repeater ID="repeaterStudents" runat="server">
            <HeaderTemplate>
                <table class="table">
                    <thead>
                        <h3>Students in Class:</h3>
                        <tr>
                            <th>Student Id</th>
                            <th>Student Name</th>
                            <th>Email</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("stdid") %></td>
                    <td><%# Eval("StudentName") %></td>
                    <td><%# Eval("EmailId") %></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </tbody>
            </table>
            </FooterTemplate>
        </asp:Repeater>
        <div class="button-container">
            <asp:Button ID="invisible" runat="server" Text="Invisible" OnClick="invisible_Click" CssClass="invisible-button" />
        </div>
    </asp:Panel>


    <asp:ScriptManager runat="server" />
    <asp:UpdatePanel ID="updatePanelAttendance" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Timer ID="timerRefresh" runat="server" Interval="5000" OnTick="timerRefresh_Tick" />

            <asp:Panel ID="panelAttendance" runat="server" CssClass="attendance-panel" Visible="false">
                <h3>Mark Attendance for Class: <span id="classNameSpan"></span></h3>

                <asp:HiddenField ID="hfClassName" runat="server" />

                <asp:Repeater ID="repeaterAttendance" runat="server">
                    <HeaderTemplate>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Student Id</th>
                                    <th>Student Name</th>
                                    <th>Mark Attendance</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("stdid") %></td>
                            <td><%# Eval("StudentName") %></td>
                            <td><%# Eval("status").ToString()=="Present" ?  "<span style='color: green'>Present</span>" : "" %></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
                </table>
                    </FooterTemplate>
                </asp:Repeater>

                <div class="button-container">
                    <asp:Button ID="btnEndAttendance" runat="server" OnClick="btnEndAttendance_Click" Text="End Attendance" CssClass="button" />
                </div>

            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>


</asp:Content>
