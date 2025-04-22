<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.Master" AutoEventWireup="true" CodeBehind="LeaveHistory.aspx.cs" Inherits="Student.user.LeaveHistory" %>

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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="main-content-inner">
        <div class="col-12 mt-5">
            <div class="row">
                <h1>Leave History</h1>
                <div class="card">
                    <div class="card-body">
                        <div class="data-tabels">
                            <table id="dataTable" class="table table-hover progress-table text-center">
                                <thead class="bg-light text-capitalize">
                                    <tr>
                                        <th>#</th>
                                        <th width="150">Type</th>
                                        <th>Conditions</th>
                                        <th>To</th>
                                        <th>From</th>
                                        <th width="150">Applied</th>
                                        <th width="120">Admin's Remark</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptLeaveHistory" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Container.ItemIndex + 1 %></td>
                                                <td><%# Eval("LeaveType") %></td>
                                                <td><%# Eval("Description") %></td>
                                                <td><%# Eval("ToDate", "{0:dd-MM-yyyy}") %></td>
                                                <td><%# Eval("FromDate", "{0:dd-MM-yyyy}") %></td>
                                                <td><%# String.Format("{0:dd-MM-yyyy}", Eval("PostingDate")) %></td>
                                                <td>
                                                    <%# String.IsNullOrEmpty(Eval("AdminRemark").ToString()) 
                                                         ? "Pending" 
                                                        : Eval("AdminRemark") + " at " + Eval("AdminRemarkDate") %>
                                               </td>
                                                <td>
                                                    <%# Eval("Status").ToString() == "1" ? "<span style='color: green'>Approved</span>" :
                                                        Eval("Status").ToString() == "2" ? "<span style='color: red'>Not Approved</span>" :
                                                       "<span style='color: blue'>Pending</span>" %>
                                               </td>
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

</asp:Content>
