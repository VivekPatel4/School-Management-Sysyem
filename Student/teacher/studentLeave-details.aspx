<%@ Page Title="" Language="C#" MasterPageFile="~/teacher/teacher.Master" AutoEventWireup="true" CodeBehind="studentLeave-details.aspx.cs" Inherits="Student.teacher.studentLeave_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="main-content-inner">
        <div class="row">

            <div class="col-lg-12 mt-5">
                <div class="card">
                    <div class="card-body">
                        <div class="single-table">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover text-center">
                                    <tbody>
                                        <asp:Repeater ID="rptLeaveDetails" runat="server" OnItemCommand="rptLeaveDetails_ItemCommand">
                                            <ItemTemplate>

                                                <tr>
                                                    <td><b>Student ID:</b></td>
                                                    <td><%# Eval("stdid") %></td>
                                                    <td><b>Student Name:</b></td>
                                                    <td><a href="update-employee.aspx?stdid=<%# Eval("stdid") %>" target="_blank">
                                                        <%# Eval("FirstName") + " " + Eval("LastName") %></a></td>
                                                    <td><b>Gender:</b></td>
                                                    <td><%# Eval("Gender") %></td>
                                                </tr>
                                                <tr>
                                                    <td><b>Student Email:</b></td>
                                                    <td><%# Eval("EmailId") %></td>
                                                    <td><b>Student Contact:</b></td>
                                                    <td><%# Eval("Phonenumber") %></td>
                                                    <td><b>Leave Type:</b></td>
                                                    <td><%# Eval("LeaveType") %></td>
                                                </tr>

                                                <tr>
                                                    <td><b>Leave From:</b></td>
                                                    <td><%# Eval("FromDate", "{0:dd-MM-yyyy}") %></td>
                                                    <td><b>Leave Upto:</b></td>
                                                    <td><%# Eval("ToDate", "{0:dd-MM-yyyy}") %></td>
                                                </tr>

                                                <tr>
                                                    <td><b>Leave Conditions:</b></td>
                                                    <td colspan="5"><%# Eval("Description") %></td>
                                                </tr>

                                                <tr>
                                                    <td><b>Admin Remark:</b></td>
                                                    <td colspan="5"><%# Eval("AdminRemark") ?? "Waiting for Action" %></td>
                                                </tr>

                                                <tr>
                                                    <td><b>Status:</b></td>
                                                    <td colspan="5">
                                                        <%# Convert.ToString(Eval("Status")) == "1" ? "<span style='color: green'>Approved</span>" : Convert.ToString(Eval("Status")) == "2" ? "<span style='color: red'>Declined</span>" : "<span style='color: blue'>Pending</span>" %>
                                                    </td>
                                                </tr>


                                                <tr>
                                                    <td colspan="6">
                                                        <button type="button" class="btn btn-success" data-toggle="modal" data-target="#actionModal<%# Eval("lid") %>">Set Action</button>
                                                        <div class="modal fade" id="actionModal<%# Eval("lid") %>" tabindex="-1" role="dialog">
                                                            <div class="modal-dialog" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title">Set Action</h5>
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">

                                                                        <asp:DropDownList ID="ddlStatus" runat="server" class="form-control" required>
                                                                            <asp:ListItem Value="0" Text="Pending"></asp:ListItem>
                                                                            <asp:ListItem Value="1" Text="Approved"></asp:ListItem>
                                                                            <asp:ListItem Value="2" Text="Declined"></asp:ListItem>
                                                                        </asp:DropDownList>

                                                                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" class="form-control" placeholder="Description" required></asp:TextBox>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                        <asp:Button ID="Button1" runat="server" Text="Apply" CssClass="btn btn-success" OnClick="btnUpdateLeave_Click" CommandArgument='<%# Eval("lid") %>' />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
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
    </div>
</asp:Content>
