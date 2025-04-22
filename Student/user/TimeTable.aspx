<%@ Page Title="" Language="C#" EnableEventValidation="false" MasterPageFile="~/user/user.Master" AutoEventWireup="true" CodeBehind="TimeTable.aspx.cs" Inherits="Student.user.TimeTable" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="main-content-inner">
        <div class="col-12 mt-5">
            <div class="row">
                <h1>Time Table</h1>
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
                            <table id="dataTable" class="table table-hover progress-table text-center">
                                <thead class="bg-light text-capitalize">
                                    <tr>
                                        <th>#</th>
                                        <th>Teacher</th>
                                        <th>Class</th>
                                        <th>Subject</th>
                                        <th>Start Time</th>
                                        <th>End Time</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="StudentScheduleRepeater" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Container.ItemIndex + 1 %></td>
                                                <td><%# Eval("TeacherName") %></td>
                                                <td><%# Eval("Class") %></td>
                                                <td><%# Eval("Subject") %></td>
                                                <td><%# Eval("StartTime") %></td>
                                                <td><%# Eval("EndTime") %></td>
                                                <td>
                                                    <asp:Button ID="btnMarkAttendance" runat="server" Text="Mark Attendance" CssClass="btn btn-primary"
                                                        OnClick="btnMarkAttendance_Click"
                                                        CommandArgument='<%# Eval("Class") %>'
                                                        Enabled='<%# Convert.ToBoolean(Eval("IsAttendanceActive")) %>' />
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
