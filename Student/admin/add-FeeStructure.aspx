<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="add-FeeStructure.aspx.cs" Inherits="Student.admin.add_FeeStructure" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title-area">
        <div class="row align-items-center">
            <div class="col-lg-8 col-md-6 col-sm-12">
                <div class="breadcrumbs-area clearfix">
                    <h4 class="page-title pull-left">FeeStructure Section</h4>
                    <ul class="breadcrumbs pull-left">
                        <li><a href="FeeStructure.aspx">FeeStructure</a></li>
                        <li><span>Add</span></li>
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

                    <div class="card-body">
                        <p class="text-muted font-14 mb-4">Please fill up the form in order to add new FeeStructure</p>

                        <div class="form-group">
                            <asp:Label ID="lblDepartment" runat="server" CssClass="col-form-label">Class:</asp:Label>
                            <asp:DropDownList
                                ID="ddlDepartment"
                                runat="server"
                                CssClass="custom-select"
                                AppendDataBoundItems="True"
                                AutoPostBack="False">
                                <asp:ListItem Text="Choose.." Value="" />
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvdeptname" runat="server" ErrorMessage="Class Name is Required" ControlToValidate="ddlDepartment"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="AdmissionFee" runat="server" CssClass="col-form-label">Admission Fee:</asp:Label>
                            <asp:TextBox ID="txtAdmissionFee" runat="server" CssClass="form-control" oninput="calculateTotal()" />
                            <asp:RequiredFieldValidator ID="rfvshortform" runat="server" ErrorMessage="txtAdmissionFee is Required" ControlToValidate="txtAdmissionFee"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="TuitionFee" runat="server" CssClass="col-form-label">Tuition Fee:</asp:Label>
                            <asp:TextBox ID="txtTuitionFee" runat="server" CssClass="form-control" oninput="calculateTotal()" />
                            <asp:RequiredFieldValidator ID="rfvcode" runat="server" ErrorMessage="Tuition Fee is Required" ControlToValidate="txtTuitionFee"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="AnnualCharges" runat="server" CssClass="col-form-label">Annual Charges:</asp:Label>
                            <asp:TextBox ID="txtAnnualCharges" runat="server" CssClass="form-control" oninput="calculateTotal()" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Annual Charges is Required" ControlToValidate="txtAnnualCharges"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="lblTotalAmount" runat="server" CssClass="col-form-label">Total Amount:</asp:Label>
                            <asp:TextBox ID="txtTotalAmount" runat="server" CssClass="form-control" ReadOnly="true" />
                        </div>

                        <asp:Button ID="btnFeeStructure" runat="server" Text="Add" CssClass="btn btn-primary"
                            OnClick="btnFeeStructure_Click" />

                    </div>
                </div>
            </div>
        </div>
    </div>


    <script>
        function calculateTotal() {
           
            var admissionFee = parseFloat(document.getElementById('<%= txtAdmissionFee.ClientID %>').value) || 0;
            var tuitionFee = parseFloat(document.getElementById('<%= txtTuitionFee.ClientID %>').value) || 0;
            var annualCharges = parseFloat(document.getElementById('<%= txtAnnualCharges.ClientID %>').value) || 0;

            var totalAmount = admissionFee + tuitionFee + annualCharges;
            
            document.getElementById('<%= txtTotalAmount.ClientID %>').value = totalAmount.toFixed(2);
        }
    </script>

</asp:Content>
