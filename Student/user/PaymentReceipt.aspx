<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.Master" AutoEventWireup="true" CodeBehind="PaymentReceipt.aspx.cs" Inherits="Student.user.PaymentReceipt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
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

        .badge-secondary {
            background-color: #6c757d;
            color: #fff;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="receipt-container">
        <div class="receipt-header">
            <div class="receipt-logo">
                <i class="fas fa-graduation-cap fa-3x"></i>
            </div>
            <div class="receipt-title">Payment Receipt</div>
            <div class="receipt-subtitle">School Management System</div>
        </div>
        <div class="receipt-body">
            <div class="receipt-section">
                <div class="receipt-section-title">Student Information</div>
                <div class="receipt-row">
                    <div class="receipt-label">Student Name:</div>
                    <div class="receipt-value">
                        <asp:Label ID="lblStudentName" runat="server"></asp:Label>
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
                <button type="button" class="btn-receipt btn-print" onclick="window.print();">
                    <i class="fas fa-print"></i>Print Receipt
               
                </button>
                <button type="button" class="btn-receipt btn-download" onclick="downloadPDF();">
                    <i class="fas fa-download"></i>Download PDF
               
                </button>
                <a href="FeePayment.aspx" class="btn-receipt btn-back">
                    <i class="fas fa-arrow-left"></i>Back to Payments
                </a>
            </div>
        </div>
        <div class="receipt-footer">
            <p>© 2025 School Management System. All rights reserved.</p>
        </div>
    </div>


    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>

    <script>
        function downloadPDF() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF('p', 'mm', 'a4');

            // Select the receipt container
            const element = document.querySelector('.receipt-container');

            html2canvas(element, { scale: 2 }).then(canvas => {
                const imgData = canvas.toDataURL('image/png');
                const imgWidth = 190; // PDF width
                const imgHeight = (canvas.height * imgWidth) / canvas.width;

                doc.addImage(imgData, 'PNG', 10, 10, imgWidth, imgHeight);
                doc.save('PaymentReceipt.pdf');
            });
        }
    </script>

</asp:Content>
