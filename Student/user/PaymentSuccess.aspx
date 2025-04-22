<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.Master" AutoEventWireup="true" CodeBehind="PaymentSuccess.aspx.cs" Inherits="Student.user.PaymentSuccess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Add Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <!-- Add Animate.css for animations -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <style>
        .status-card {
            padding: 30px;
            margin: 20px 0;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            font-size: 16px;
            text-align: center;
            transition: all 0.3s ease;
        }

            .status-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            }

        .success {
            background-color: #d4edda;
            color: #155724;
            border-left: 5px solid #28a745;
        }

        .failed {
            background-color: #f8d7da;
            color: #721c24;
            border-left: 5px solid #dc3545;
        }

        .partial {
            background-color: #fff3cd;
            color: #856404;
            border-left: 5px solid #ffc107;
        }

        .already-paid {
            background-color: #d1ecf1;
            color: #0c5460;
            border-left: 5px solid #17a2b8;
        }

        .icon-container {
            font-size: 60px;
            margin-bottom: 20px;
        }

        .transaction-details {
            background-color: rgba(255, 255, 255, 0.5);
            border-radius: 8px;
            padding: 15px;
            margin: 20px 0;
        }

            .transaction-details p {
                margin: 8px 0;
                font-size: 16px;
            }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            margin-top: 20px;
            background-color: #007bff;
            color: white;
            border-radius: 30px;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

            .btn:hover {
                background-color: #0056b3;
                transform: translateY(-2px);
                box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
            }

        .btn-success {
            background-color: #28a745;
        }

            .btn-success:hover {
                background-color: #218838;
            }

        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }

            .btn-warning:hover {
                background-color: #e0a800;
            }

        .btn-danger {
            background-color: #dc3545;
        }

            .btn-danger:hover {
                background-color: #c82333;
            }

        .page-title {
            color: #333;
            font-size: 28px;
            margin-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 10px;
        }

        .status-title {
            font-size: 22px;
            margin-bottom: 25px;
            color: #555;
        }

        strong {
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="main-content-inner">
        <div class="col-12 mt-5">
            <div class="row">
                <h1 class="page-title">Fee Payment Status</h1>
                <div class="card">
                    <div class="card-body">
                        <h2 class="status-title">Transaction Details</h2>

                        <!-- Success Message -->
                        <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
                            <div class="status-card success animate__animated animate__fadeIn">
                                <div class="icon-container animate__animated animate__bounceIn">
                                    <i class="fas fa-check-circle"></i>
                                </div>
                                <h3 class="animate__animated animate__fadeInUp">Payment Successful!</h3>
                                <div class="transaction-details animate__animated animate__fadeInUp animate__delay-1s">
                                    <p>
                                        <strong>Transaction ID:</strong>
                                        <asp:Label ID="lblTransactionID" runat="server"></asp:Label>
                                    </p>
                                    <p><strong>Amount Paid:</strong> ₹<asp:Label ID="lblAmountPaid" runat="server"></asp:Label></p>
                                    <p><strong>Status:</strong> <span class="badge bg-success">Completed</span></p>
                                </div>
                                <a href="FeePayment.aspx" class="btn btn-success animate__animated animate__fadeInUp animate__delay-1s">
                                    <i class="fas fa-home"></i>Go to Dashboard
                                </a>
                            </div>
                        </asp:Panel>

                        <!-- Failure Message -->
                        <asp:Panel ID="pnlFailure" runat="server" Visible="false">
                            <div class="status-card failed animate__animated animate__fadeIn">
                                <div class="icon-container animate__animated animate__shakeX">
                                    <i class="fas fa-times-circle"></i>
                                </div>
                                <h3 class="animate__animated animate__fadeInUp">Payment Failed!</h3>
                                <p class="animate__animated animate__fadeInUp animate__delay-1s">
                                    We couldn't process your payment. Please try again or contact support.
                                </p>
                                <a href="FeePayment.aspx" class="btn btn-danger animate__animated animate__fadeInUp animate__delay-1s">
                                    <i class="fas fa-redo"></i>Retry Payment
                                </a>
                            </div>
                        </asp:Panel>

                        <!-- Partial Payment Message -->
                        <asp:Panel ID="pnlPartial" runat="server" Visible="false">
                            <div class="status-card partial animate__animated animate__fadeIn">
                                <div class="icon-container animate__animated animate__pulse">
                                    <i class="fas fa-exclamation-circle"></i>
                                </div>
                                <h3 class="animate__animated animate__fadeInUp">Partial Payment Successful!</h3>
                                <div class="transaction-details animate__animated animate__fadeInUp animate__delay-1s">
                                    <p>
                                        <strong>Transaction ID:</strong>
                                        <asp:Label ID="lblPartialTransactionID" runat="server"></asp:Label>
                                    </p>
                                    <p><strong>Amount Paid:</strong> ₹<asp:Label ID="lblPartialAmountPaid" runat="server"></asp:Label></p>
                                    <p><strong>Remaining Amount:</strong> ₹<asp:Label ID="lblRemainingAmount" runat="server"></asp:Label></p>
                                    <p><strong>Status:</strong> <span class="badge bg-warning">Partial</span></p>
                                </div>
                                <a href="FeePayment.aspx" class="btn btn-warning animate__animated animate__fadeInUp animate__delay-1s">
                                    <i class="fas fa-credit-card"></i>Pay Remaining Amount
                                </a>
                            </div>
                        </asp:Panel>

                        <!-- Already Paid Message -->
                        <asp:Panel ID="pnlAlreadyPaid" runat="server" Visible="false">
                            <div class="status-card already-paid animate__animated animate__fadeIn">
                                <div class="icon-container animate__animated animate__rubberBand">
                                    <i class="fas fa-info-circle"></i>
                                </div>
                                <h3 class="animate__animated animate__fadeInUp">Payment Already Completed!</h3>
                                <div class="transaction-details animate__animated animate__fadeInUp animate__delay-1s">
                                    <p>
                                        <strong>Transaction ID:</strong>
                                        <asp:Label ID="lblAlreadyPaidTransactionID" runat="server"></asp:Label>
                                    </p>
                                    <p><strong>Total Amount Paid:</strong> ₹<asp:Label ID="lblAlreadyPaidAmount" runat="server"></asp:Label></p>
                                    <p><strong>Status:</strong> <span class="badge bg-info">Completed</span></p>
                                </div>
                                <a href="FeePayment.aspx" class="btn animate__animated animate__fadeInUp animate__delay-1s">
                                    <i class="fas fa-home"></i>Go to Dashboard
                                </a>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
