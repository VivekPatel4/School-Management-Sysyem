<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="AdminPaymentReceipt.aspx.cs" Inherits="Student.admin.AdminPaymentReceipt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        /* [Your existing CSS styles remain unchanged] */
        .receipt-container {
            max-width: 800px;
            margin: 30px auto;
            background-color: white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        .receipt-header {
            background: linear-gradient(to right, #4e73df, #36b9cc);
            padding: 20px;
            color: white;
            text-align: center;
        }

        .receipt-body {
            padding: 30px;
        }

        .receipt-logo {
            text-align: center;
            margin-bottom: 20px;
        }

        .receipt-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .receipt-subtitle {
            font-size: 16px;
            color: rgba(255, 255, 255, 0.8);
        }

        .receipt-section {
            margin-bottom: 25px;
        }

        .receipt-section-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
            padding-bottom: 5px;
            border-bottom: 1px solid #eee;
            color: #4e73df;
        }

        .receipt-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .receipt-label {
            font-weight: 600;
            color: #555;
        }

        .receipt-value {
            text-align: right;
            color: #333;
        }

        .receipt-total {
            background-color: #f8f9fc;
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
        }

            .receipt-total .receipt-row {
                margin-bottom: 8px;
            }

                .receipt-total .receipt-row:last-child {
                    margin-bottom: 0;
                    padding-top: 8px;
                    border-top: 1px dashed #ddd;
                }

            .receipt-total .receipt-label {
                color: #333;
            }

            .receipt-total .receipt-value {
                font-weight: 700;
                color: #28a745;
            }

        .receipt-footer {
            text-align: center;
            padding: 20px;
            background-color: #f8f9fc;
            border-top: 1px solid #eee;
            color: #6c757d;
        }

        .receipt-actions {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
        }

        .btn-receipt {
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-print {
            background-color: #4e73df;
            color: white;
            border: none;
        }

            .btn-print:hover {
                background-color: #2e59d9;
            }

        .btn-download {
            background-color: #1cc88a;
            color: white;
            border: none;
        }

            .btn-download:hover {
                background-color: #17a673;
            }

        .btn-back {
            background-color: #f8f9fc;
            color: #5a5c69;
            border: 1px solid #ddd;
        }

            .btn-back:hover {
                background-color: #eaecf4;
            }

        .btn-email {
            background-color: #36b9cc;
            color: white;
            border: none;
        }

            .btn-email:hover {
                background-color: #2c94a3;
            }

        .badge {
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
            background-color: #28a745;
            color: #fff;
        }

        .badge-warning {
            background-color: #ffc107;
            color: #000;
        }

        .badge-danger {
            background-color: #dc3545;
            color: #fff;
        }

        .school-info {
            text-align: center;
            margin-bottom: 15px;
        }

        .school-name {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 5px;
            color: #4e73df;
        }

        .school-address {
            font-size: 14px;
            color: #6c757d;
        }

        .receipt-watermark {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) rotate(-30deg);
            font-size: 100px;
            color: rgba(78, 115, 223, 0.05);
            font-weight: 900;
            pointer-events: none;
            z-index: 1;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title-area">
        <div class="row align-items-center">
            <div class="col-lg-8 col-md-6 col-sm-12">
                <div class="breadcrumbs-area clearfix">
                    <h4 class="page-title pull-left">Payment Receipt</h4>
                    <ul class="breadcrumbs pull-left">
                        <li><a href="dashboard.aspx">Home</a></li>
                        <li><a href="AllPayments.aspx">Payments</a></li>
                        <li><span>Receipt</span></li>
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
            <div class="col-12">
                <asp:Panel ID="ErrorPanel" runat="server" CssClass="alert alert-danger alert-dismissible fade show" Visible="false">
                    <strong>Error: </strong>
                    <asp:Literal ID="ErrorMessage" runat="server" />
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </asp:Panel>
                <asp:Panel ID="SuccessPanel" runat="server" CssClass="alert alert-success alert-dismissible fade show" Visible="false">
                    <strong>Success: </strong>
                    <asp:Literal ID="SuccessMessage" runat="server" />
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </asp:Panel>
            </div>
        </div>

        <div class="receipt-container position-relative" id="receiptContainer">
            <div class="receipt-watermark">PAID</div>
            <div class="receipt-header">
                <div class="receipt-logo">
                    <i class="fas fa-school fa-3x"></i>
                </div>
                <div class="receipt-title">Payment Receipt</div>
                <div class="receipt-subtitle">School Management System</div>
            </div>
            <div class="receipt-body">
                <div class="school-info">
                    <div class="school-name">School Management System</div>
                    <div class="school-address">123 Education Street, School District, State - 123456</div>
                </div>

                <div class="receipt-section">
                    <div class="receipt-section-title">Student Information</div>
                    <div class="receipt-row">
                        <div class="receipt-label">Student Name:</div>
                        <div class="receipt-value">
                            <asp:Literal ID="lblStudentName" runat="server"></asp:Literal>
                        </div>
                    </div>
                    <div class="receipt-row">
                        <div class="receipt-label">Roll Number:</div>
                        <div class="receipt-value">
                            <asp:Label ID="lblRollNumber" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="receipt-row">
                        <div class="receipt-label">Class:</div>
                        <div class="receipt-value">
                            <asp:Label ID="lblClass" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="receipt-row">
                        <div class="receipt-label">Email:</div>
                        <div class="receipt-value">
                            <asp:Label ID="lblEmail" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="receipt-row">
                        <div class="receipt-label">Phone:</div>
                        <div class="receipt-value">
                            <asp:Label ID="lblPhone" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>

                <div class="receipt-section">
                    <div class="receipt-section-title">Payment Details</div>
                    <div class="receipt-row">
                        <div class="receipt-label">Transaction ID:</div>
                        <div class="receipt-value">
                            <asp:Label ID="lblTransactionID" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="receipt-row">
                        <div class="receipt-label">Payment Date:</div>
                        <div class="receipt-value">
                            <asp:Label ID="lblPaymentDate" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="receipt-row">
                        <div class="receipt-label">Amount Paid:</div>
                        <div class="receipt-value">
                            <asp:Label ID="lblPaymentAmount" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="receipt-row">
                        <div class="receipt-label">Status:</div>
                        <div class="receipt-value">
                            <asp:Label ID="lblStatus" runat="server" CssClass="badge"></asp:Label>
                        </div>
                    </div>
                    <div class="receipt-row">
                        <div class="receipt-label">Payment Method:</div>
                        <div class="receipt-value">
                            Online (Razorpay)
                       
                        </div>
                    </div>
                </div>

                <div class="receipt-total">
                    <div class="receipt-row">
                        <div class="receipt-label">Total Fee:</div>
                        <div class="receipt-value">
                            <asp:Label ID="lblTotalFee" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="receipt-row">
                        <div class="receipt-label">Total Paid:</div>
                        <div class="receipt-value">
                            <asp:Label ID="lblTotalPaid" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="receipt-row">
                        <div class="receipt-label">Remaining Amount:</div>
                        <div class="receipt-value">
                            <asp:Label ID="lblRemainingAmount" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>

                <div class="receipt-actions">
                    <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn-receipt btn-print" OnClientClick="window.print(); return false;" />
                    <asp:Button ID="btnDownload" runat="server" Text="Download" CssClass="btn-receipt btn-download" OnClick="btnDownload_Click" />
                    <asp:Button ID="btnEmail" runat="server" Text="Email" CssClass="btn-receipt btn-email" OnClick="btnEmail_Click" />
                    <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn-receipt btn-back" OnClick="btnBack_Click" CausesValidation="false" />
                </div>
            </div>
            <div class="receipt-footer">
                Thank you for your payment. If you have any questions, please contact us at support@schoolmanagement.com.
           
            </div>
        </div>
    </div>

</asp:Content>
