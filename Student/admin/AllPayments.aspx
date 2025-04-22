<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="AllPayments.aspx.cs" Inherits="Student.admin.AllPayments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" />
    <style>
        .payment-badge {
            display: inline-block;
            padding: 0.25em 0.4em;
            font-size: 75%;
            font-weight: 700;
            line-height: 1;
            text-align: center;
            white-space: nowrap;
            vertical-align: baseline;
            border-radius: 0.25rem;
        }

        .badge-success {
            color: #fff;
            background-color: #28a745;
        }

        .badge-warning {
            color: #212529;
            background-color: #ffc107;
        }

        .badge-danger {
            color: #fff;
            background-color: #dc3545;
        }

        .filters-section {
            background-color: #f8f9fc;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        .btn-filter {
            background-color: #4e73df;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            font-weight: 600;
            transition: all 0.3s;
        }

            .btn-filter:hover {
                background-color: #2e59d9;
            }

        .btn-reset {
            background-color: #f8f9fc;
            color: #5a5c69;
            border: 1px solid #ddd;
        }

            .btn-reset:hover {
                background-color: #eaecf4;
            }

        .btn-view-receipt {
            padding: 5px 12px;
            background-color: #4e73df;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 13px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

            .btn-view-receipt:hover {
                background-color: #2e59d9;
                transform: translateY(-2px);
            }

        .report-section {
            margin-top: 20px;
            padding: 15px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        .stat-card {
            background-color: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            transition: transform 0.3s ease;
        }

            .stat-card:hover {
                transform: translateY(-5px);
            }

        .stat-card-title {
            font-size: 0.9rem;
            color: #4e73df;
            text-transform: uppercase;
            font-weight: 600;
        }

        .stat-card-value {
            font-size: 1.5rem;
            font-weight: 700;
            margin-top: 10px;
            margin-bottom: 0;
        }

        .stat-card-icon {
            float: right;
            font-size: 2rem;
            opacity: 0.3;
        }

        .text-primary {
            color: #4e73df !important;
        }

        .text-success {
            color: #1cc88a !important;
        }

        .text-warning {
            color: #f6c23e !important;
        }

        .text-danger {
            color: #e74a3b !important;
        }

        .export-section {
            margin-top: 20px;
            text-align: right;
        }

        .btn-export {
            background-color: #1cc88a;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            font-weight: 600;
            transition: all 0.3s;
            margin-left: 10px;
        }

            .btn-export:hover {
                background-color: #169b6b;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title-area">
        <div class="row align-items-center">
            <div class="col-lg-8 col-md-6 col-sm-12">
                <div class="breadcrumbs-area clearfix">
                    <h4 class="page-title pull-left">Fee Management</h4>
                    <ul class="breadcrumbs pull-left">
                        <li><a href="dashboard.aspx">Home</a></li>
                        <li><span>All Payments</span></li>
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
        <!-- Statistics Row -->
        <div class="row mb-4">
            <!-- Total Collections -->
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="stat-card border-left-primary">
                    <div class="stat-card-title">Total Collections</div>
                    <div class="stat-card-value text-primary">₹<asp:Literal ID="litTotalCollections" runat="server"></asp:Literal></div>
                    <i class="fas fa-money-bill-wave stat-card-icon text-primary"></i>
                </div>
            </div>

            <!-- Total Paid Students -->
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="stat-card border-left-success">
                    <div class="stat-card-title">Paid Students</div>
                    <div class="stat-card-value text-success">
                        <asp:Literal ID="litPaidStudents" runat="server"></asp:Literal>
                    </div>
                    <i class="fas fa-user-check stat-card-icon text-success"></i>
                </div>
            </div>

            <!-- Partially Paid -->
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="stat-card border-left-warning">
                    <div class="stat-card-title">Partial Payments</div>
                    <div class="stat-card-value text-warning">
                        <asp:Literal ID="litPartialPayments" runat="server"></asp:Literal>
                    </div>
                    <i class="fas fa-user-clock stat-card-icon text-warning"></i>
                </div>
            </div>

            <!-- Unpaid Students -->
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="stat-card border-left-danger">
                    <div class="stat-card-title">Due Amount</div>
                    <div class="stat-card-value text-danger">₹<asp:Literal ID="litDueAmount" runat="server"></asp:Literal></div>
                    <i class="fas fa-hand-holding-usd stat-card-icon text-danger"></i>
                </div>
            </div>
        </div>

        <!-- Filters Section -->
        <div class="row">
            <div class="col-12">
                <div class="filters-section">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="ddlClass">Class/Department</label>
                                <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="All Classes" Value=""></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label for="ddlStatus">Payment Status</label>
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Success" Value="Success"></asp:ListItem>
                                    <asp:ListItem Text="Partial" Value="Partial"></asp:ListItem>
                                    <asp:ListItem Text="Failed" Value="Failed"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="txtFromDate">From Date</label>
                                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="txtToDate">To Date</label>
                                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-1 d-flex align-items-end justify-content-end">
                            <div class="form-group">
                                <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btn btn-filter" OnClick="btnFilter_Click" />
                            </div>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtSearch">Search Student</label>
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Enter name, roll number, or transaction ID"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-2 d-flex align-items-end">
                            <div class="form-group">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-filter" OnClick="btnSearch_Click" />
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group text-right">
                                <asp:Button ID="btnReset" runat="server" Text="Reset Filters" CssClass="btn btn-filter btn-reset" OnClick="btnReset_Click" />
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="export-section">
                                <asp:Button ID="btnExportExcel" runat="server" Text="Export Excel" CssClass="btn btn-export" OnClick="btnExportExcel_Click" />
                                <asp:Button ID="btnExportPDF" runat="server" Text="Export PDF" CssClass="btn btn-export" OnClick="btnExportPDF_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Payment Records Table -->
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <asp:Panel ID="ErrorPanel" runat="server" CssClass="alert alert-danger alert-dismissible fade show" Visible="false">
                            <strong>Error: </strong>
                            <asp:Literal ID="ErrorMessage" runat="server" />
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </asp:Panel>
                        <asp:Panel ID="SuccessPanel" runat="server" CssClass="alert alert-success alert-dismissible fade show" Visible="false">
                            <strong>Success: </strong>
                            <asp:Literal ID="SuccessMessage" runat="server" />
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </asp:Panel>

                        <div class="data-tables datatable-dark">
                            <table id="paymentTable" class="table table-hover table-striped text-center">
                                <thead class="text-capitalize">
                                    <tr>
                                        <th>Student Name</th>
                                        <th>Roll No</th>
                                        <th>Class</th>
                                        <th>Transaction ID</th>
                                        <th>Amount</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptPayments" runat="server" OnItemCommand="rptPayments_ItemCommand">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("StudentName") %></td>
                                                <td><%# Eval("RollNumber") %></td>
                                                <td><%# Eval("Class") %></td>
                                                <td><%# Eval("TransactionID") %></td>
                                                <td>₹<%# Eval("AmountPaid", "{0:N2}") %></td>
                                                <td><%# Convert.ToDateTime(Eval("PaymentDate")).ToString("dd MMM yyyy") %></td>
                                                <td>
                                                    <span class="payment-badge badge-<%# GetStatusClass(Eval("Status").ToString()) %>">
                                                        <%# Eval("Status") %>
                                                    </span>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="btnViewReceipt" runat="server"
                                                        CssClass="btn-view-receipt"
                                                        CommandName="ViewReceipt"
                                                        CommandArgument='<%# Eval("TransactionID") %>'
                                                        Visible='<%# !string.IsNullOrEmpty(Eval("TransactionID").ToString()) && Eval("TransactionID").ToString() != "N/A" %>'>
                                                        <i class="fas fa-file-invoice"></i> View
                                                     </asp:LinkButton>
                                                    <asp:LinkButton ID="btnSendReminder" runat="server"
                                                        CssClass="btn-view-receipt" Visible='<%# NeedsReminder(Eval("Status").ToString()) %>'
                                                        CommandName="SendReminder" CommandArgument='<%# Eval("StudentID") %>'>
                                                        <i class="fas fa-bell"></i> Remind
                                                    </asp:LinkButton>
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

    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#paymentTable').DataTable({
                "order": [[5, "desc"]], // Sort by date column descending
                "pageLength": 25,
                "language": {
                    "searchPlaceholder": "Search records"
                }
            });
        });
    </script>
</asp:Content>
