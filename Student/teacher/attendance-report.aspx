<%@ Page Title="" Language="C#" MasterPageFile="~/teacher/teacher.Master" AutoEventWireup="true" CodeBehind="attendance-report.aspx.cs" Inherits="Student.teacher.attendance_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="..\teacher\schedule.css" rel="stylesheet" />
    <style>
        .container1 {
            width: 40%;
            margin: 40px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .button {
            padding: 1.3em 3em;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 2.5px;
            font-weight: 500;
            color: #000;
            background-color: rgba(255, 255, 255, 0.726);
            border: none;
            border-radius: 45px;
            box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease 0s;
            cursor: pointer;
            outline: none;
        }

            .button:hover {
                background-color: #3323c4;
                box-shadow: 0px 15px 20px rgba(46, 229, 157, 0.4);
                color: #fff;
                transform: translateY(-7px);
            }

            .button:active {
                transform: translateY(-1px);
                background-color: #584bd1;
            }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container1">
        <h2>Student Attendance Report</h2>

        <asp:DropDownList ID="ddlStudents" runat="server" CssClass="select" AppendDataBoundItems="True" AutoPostBack="False">
            <asp:ListItem Text="-- Select Student --" Value="" />
        </asp:DropDownList>

        <asp:DropDownList ID="ddlClass" runat="server" CssClass="select" AppendDataBoundItems="True" AutoPostBack="False">
            <asp:ListItem Text="-- Select Class --" Value="" />
        </asp:DropDownList>

        <asp:Button ID="btnFetch" runat="server" Text="Show Attendance" CssClass="button" OnClick="btnFetch_Click" />
    </div>

    <!-- Table to Show Attendance -->

    <asp:Repeater ID="rptAttendance" runat="server">
        <HeaderTemplate>
            <table class="table">
                <thead>
                    <tr>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Class</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th>Day</th>
                    </tr>
                </thead>
                <tbody>
        </HeaderTemplate>

        <ItemTemplate>
            <tr>
                <td><%# Eval("FirstName") %></td>
                <td><%# Eval("LastName") %></td>
                <td><%# Eval("Class") %></td>
                <td><%# Eval("status") %></td>
                <td><%# Eval("date") %></td>
                <td><%# Eval("dayname") %></td>
            </tr>
        </ItemTemplate>

        <FooterTemplate>
            </tbody>
                        </table>
                   
        </FooterTemplate>
    </asp:Repeater>


</asp:Content>
