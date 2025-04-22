<%@ Page Title="" Language="C#" MasterPageFile="~/teacher/teacher.Master" AutoEventWireup="true" CodeBehind="PendingHistory.aspx.cs" Inherits="Student.teacher.PendingHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="..\teacher\schedule.css" rel="stylesheet" />
    <style>
        .btn-secondary {
            display: ruby-text;
            text-decoration: none;
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


    <asp:Repeater ID="rptpending" runat="server">
        <HeaderTemplate>
            <h1 class="pending-title">Pending History</h1>
            <table class="table">
                <thead>
                    <tr>
                        <td>S.N</td>
                        <td>Student photo</td>
                        <td>Student ID</td>
                        <td>Full Name</td>
                        <td>Leave Type</td>
                        <td>Applied On</td>
                        <td>Current Status</td>
                        <td></td>
                    </tr>
                </thead>
                <tbody>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td><%# Container.ItemIndex+1 %></td>
                <td>
                    <asp:Image
                        ID="imgstudent"
                        runat="server"
                        ImageUrl='<%# GetImageUrl(Eval("photo").ToString()) %>'
                        Width="90"
                        Height="90"
                        Style="background-color: transparent; object-fit: cover;" />
                </td>
                <td><%# Eval("stdid") %></td>
                <td><%# Eval("FirstName")+""+Eval("LastName") %></td>
                <td><%# Eval("LeaveType") %></td>
                <td><%# Eval("PostingDate") %></td>
                <td>
                    <%# Convert.ToString(Eval("Status")) == "0" ? "<span style='color: blue'>Pending <i class='fa fa-spinner'></i></span>" : "" %>
                </td>
                <td>
                    <asp:HyperLink
                        ID="lnkViewDetails"
                        runat="server"
                        CssClass="btn btn-secondary btn-sm"
                        NavigateUrl='<%# "studentLeave-details.aspx?leaveid=" + Eval("lid") %>'>
                        View Details
                    </asp:HyperLink>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </tbody>
     </table>
        </FooterTemplate>
    </asp:Repeater>

</asp:Content>
