<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.Master" AutoEventWireup="true" CodeBehind="leave.aspx.cs" Inherits="Student.user.leave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card{
            width: 50%;
            margin : 0 auto;
            
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="card">
        <div class="card-body">
            <h1>Apply for Leave</h1>
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

            <div class="form-group">
                <label for="fromDate">From Date:</label>
                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvfromdate" runat="server" ErrorMessage="FromDate is Required" ControlToValidate="txtFromDate"
                    ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="toDate">To Date:</label>
                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvtodate" runat="server" ErrorMessage="ToDate is Required" ControlToValidate="txtToDate"
                    ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="leaveType">Your Leave Type:</label>
                <asp:DropDownList
                    ID="ddlLeaveType"
                    runat="server"
                    CssClass="custom-select form-control"
                    AppendDataBoundItems="True"
                    AutoPostBack="False">
                    <asp:ListItem Text="Choose.." Value="" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvleavetype" runat="server" ErrorMessage="LeaveType is Required" ControlToValidate="ddlLeaveType"
                    ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="conditions">Describe Your Conditions:</label>
                <asp:TextBox ID="txtConditions" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvcondition" runat="server" ErrorMessage="Describe Your Conditions is Required" ControlToValidate="txtConditions"
                    ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Submit Leave" OnClick="btnSubmit_Click" CausesValidation="false" />
            </div>
        </div>
    </div>


    <script type="text/javascript">

        function autoHidePanels() {
            setTimeout(function () {
                var errorPanel = document.getElementById('<%= ErrorPanel.ClientID %>');
                var successPanel = document.getElementById('<%= SuccessPanel.ClientID %>');

                if (errorPanel) {
                    errorPanel.style.display = 'none';
                }
                if (successPanel) {
                    successPanel.style.display = 'none';
                }
            }, 5000);
        }

        window.onload = autoHidePanels;
    </script>

</asp:Content>
