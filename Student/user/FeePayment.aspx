<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.Master" AutoEventWireup="true" CodeBehind="FeePayment.aspx.cs" Inherits="Student.user.FeePayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <!-- Add Animate.css for animations -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
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

        /* New Styles for Payment History */
        .payment-history-section {
            margin-top: 30px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .payment-history-header {
            background: linear-gradient(to right, #4e73df, #36b9cc);
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
        }

            .payment-history-header:hover {
                background: linear-gradient(to right, #3a5bc7, #2a9aaa);
            }

            .payment-history-header h3 {
                margin: 0;
                font-size: 18px;
                font-weight: 600;
            }

        .payment-history-icon {
            display: flex;
            align-items: center;
            gap: 10px;
        }

            .payment-history-icon i {
                font-size: 22px;
                transition: all 0.3s ease;
            }

        .rotate-icon {
            transform: rotate(180deg);
        }

        .payment-history-content {
            background-color: white;
            overflow: hidden;
            max-height: 0;
            transition: max-height 0.5s ease;
        }

            .payment-history-content.show {
                max-height: 1000px;
            }

        .payment-record {
            display: flex;
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
            transition: all 0.3s ease;
        }

            .payment-record:hover {
                background-color: #f8f9fc;
            }

            .payment-record:last-child {
                border-bottom: none;
            }

        .payment-date {
            width: 120px;
            color: #5a5c69;
            font-weight: 600;
        }

        .payment-details {
            flex: 1;
        }

        .payment-amount {
            font-weight: 700;
            color: #28a745;
        }

        .payment-status {
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
            margin-left: 10px;
        }

        .status-success {
            background-color: #d4edda;
            color: #155724;
        }

        .status-partial {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-failed {
            background-color: #f8d7da;
            color: #721c24;
        }

        .transaction-id {
            color: #6c757d;
            font-size: 13px;
            margin-top: 5px;
        }

        .payment-badge {
            display: flex;
            align-items: center;
            margin-left: auto;
            padding-left: 20px;
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

        .empty-history {
            padding: 30px;
            text-align: center;
            color: #6c757d;
        }

        .badge-counter {
            position: absolute;
            transform: scale(0.7);
            transform-origin: top right;
            right: -10px;
            top: -5px;
            padding: 2px 4px;
            min-width: 16px;
            height: 16px;
            border-radius: 50%;
            font-size: 10px;
            text-align: center;
            background: #e74a3b;
            color: white;
            font-weight: 700;
        }

        /* Enhanced button styling */
        .btn-pay {
            background: linear-gradient(45deg, #007bff, #00a2ff);
            border: none;
            padding: 10px 20px;
            color: white;
            border-radius: 5px;
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.2);
            transition: all 0.3s ease;
            text-transform: uppercase;
            font-weight: 600;
            letter-spacing: 0.5px;
            font-size: 14px;
        }

            .btn-pay:hover {
                background: linear-gradient(45deg, #0069d9, #0090e6);
                box-shadow: 0 6px 15px rgba(0, 123, 255, 0.3);
                transform: translateY(-2px);
            }

        .pulse-animation {
            animation: pulse-animation 2s infinite;
        }

        @keyframes pulse-animation {
            0% {
                box-shadow: 0 0 0 0 rgba(0, 123, 255, 0.7);
            }

            70% {
                box-shadow: 0 0 0 10px rgba(0, 123, 255, 0);
            }

            100% {
                box-shadow: 0 0 0 0 rgba(0, 123, 255, 0);
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="main-content-inner">
        <div class="col-12 mt-5">
            <div class="row">
                <h1>Fee Payment</h1>
                <div class="card">
                    <div class="card-body">
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

                        <div class="payment-history-section animate__animated animate__fadeIn">
                            <div class="payment-history-header" id="paymentHistoryHeader">
                                <h3>Payment History</h3>
                                <div class="payment-history-icon">
                                    <span>View Transactions</span>
                                    <i class="fas fa-chevron-down" id="historyIcon"></i>
                                </div>
                            </div>
                            <div class="payment-history-content" id="paymentHistoryContent">
                                <!-- This section will be populated from code-behind -->
                                <asp:Repeater ID="rptPaymentHistory" runat="server">
                                    <ItemTemplate>
                                        <div class="payment-record animate__animated animate__fadeInUp">
                                            <div class="payment-date">
                                                <%# Convert.ToDateTime(Eval("PaymentDate")).ToString("MMM dd, yyyy") %>
                                            </div>
                                            <div class="payment-details">
                                                <div>
                                                    <span class="payment-amount">₹<%# Eval("AmountPaid") %></span>
                                                    <span class="payment-status <%# GetStatusClass(Eval("Status").ToString()) %>">
                                                        <%# Eval("Status") %>
                                                    </span>
                                                </div>
                                                <div class="transaction-id">
                                                    <i class="fas fa-receipt"></i>Transaction ID: <%# Eval("TransactionID") %>
                                                </div>
                                            </div>
                                            <div class="payment-badge">
                                                <a href="PaymentReceipt.aspx?id=<%# Eval("TransactionID") %>" class="btn-view-receipt">
                                                    <i class="fas fa-file-invoice"></i>Receipt
                                                </a>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <asp:Panel ID="pnlEmptyData" runat="server" Visible="false">
                                    <div class="empty-history">
                                        <i class="fas fa-receipt fa-3x mb-3" style="color: #d1d3e2;"></i>
                                        <h4>No payment history found</h4>
                                        <p>Once you make a payment, your transaction history will appear here.</p>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>

                        <asp:HiddenField ID="hdfstudentEmail" runat="server" />
                        <asp:HiddenField ID="hdfstudentContact" runat="server" />
                        <div class="data-tabels">
                            <table id="dataTable" class="table table-hover progress-table text-center">
                                <thead class="bg-light text-capitalize">
                                    <tr>

                                        <th width="150">Student Name</th>
                                        <th>Class</th>
                                        <th>Installment</th>
                                        <th>Total Fee</th>
                                        <th width="150">Action</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <tr>

                                        <td>
                                            <asp:Label ID="lblStudentName" runat="server"></asp:Label></td>
                                        <td>
                                            <asp:Label ID="lblClass" runat="server"></asp:Label></td>

                                        <td>
                                            <asp:DropDownList ID="ddlInstallment" runat="server" AutoPostBack="true" CssClass="custom-select form-control" OnSelectedIndexChanged="ddlInstallment_SelectedIndexChanged">
                                                <asp:ListItem Text="1 Year" Value="1" />
                                                <asp:ListItem Text="6 Months" Value="2" />
                                            </asp:DropDownList></td>
                                        <td>
                                            <asp:Label ID="lblTotalFee" runat="server" Text="0.00"></asp:Label>

                                        <td>
                                            <asp:Button ID="btnPay" runat="server" CssClass="btn btn-primary" Text="Pay" OnClientClick="payNow(); return false;" /></td>
                                        <td>
                                            <asp:Label ID="lblStatus" runat="server"></asp:Label>
                                        </td>
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>

        document.addEventListener('DOMContentLoaded', function () {
            const historyHeader = document.getElementById('paymentHistoryHeader');
            const historyContent = document.getElementById('paymentHistoryContent');
            const historyIcon = document.getElementById('historyIcon');

            historyHeader.addEventListener('click', function () {
                historyContent.classList.toggle('show');
                historyIcon.classList.toggle('rotate-icon');
            });
        });

        function payNow() {
            var totalAmountText = document.getElementById('<%= lblTotalFee.ClientID %>').innerText;
            var totalAmount = parseFloat(totalAmountText.replace(/[^0-9.]/g, ''));

            if (isNaN(totalAmount) || totalAmount <= 0) {
                alert("Invalid total fee. Please check the fee calculation.");
                return;
            }

            var amountInPaise = totalAmount * 100;

            var options = {
                "key": "rzp_test_gANofakaK6lhp9",
               
                "amount": amountInPaise,
                "currency": "INR",
                "name": "School Management",
                "description": "Fee Payment",
                "image": "../assets/images/icon/vivek2.png",
                "handler": function (response) {
                    var paidAmount = parseFloat(totalAmountText.replace(/[^0-9.]/g, ''));
                    var totalFee = parseFloat('<%= GetTotalFee() %>'); // Get total fee from server-side

                    if (paidAmount < totalFee) {
                        // Partial payment
                        window.location.href = "PaymentSuccess.aspx?payment_id=" + response.razorpay_payment_id + "&amount=" + paidAmount + "&status=partial";
                    } else {
                        // Full payment
                        window.location.href = "PaymentSuccess.aspx?payment_id=" + response.razorpay_payment_id + "&amount=" + paidAmount + "&status=success";
                    }
                },
                "prefill": {
                    "name": document.getElementById('<%= lblStudentName.ClientID %>').innerText,
                    "email": document.getElementById('<%= hdfstudentEmail.ClientID %>').innerText,
                    "contact": document.getElementById('<%= hdfstudentContact.ClientID %>').innerText
                },
                "theme": { "color": "#007bff" },
                "modal": {
                    "ondismiss": function () {
                        alert("Payment Failed! Please try again.");
                        window.location.href = "PaymentSuccess.aspx?status=fail";
                    }
                }
            };

            var rzp1 = new Razorpay(options);
            rzp1.open(); 
        }
    </script>
</asp:Content>
