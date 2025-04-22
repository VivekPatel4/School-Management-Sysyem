<%@ Page Title="" Language="C#" MasterPageFile="~/teacher/teacher.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="Student.teacher.dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root {
            --blue: #2a2185;
            --white: #fff;
            --gray: #f5f5f5;
            --black1: #222;
            --black2: #999;
        }

        .cardBox {
            position: relative;
            width: 100%;
            padding: 20px;
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            grid-gap: 30px;
            margin: 30px 0px;
        }

            .cardBox .card {
                position: relative;
                background: var(--white);
                padding: 30px;
                border-radius: 20px;
                display: flex;
                justify-content: space-between;
                cursor: pointer;
                box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
            }

                .cardBox .card .numbers {
                    position: relative;
                    font-weight: 500;
                    font-size: 2.5rem;
                    color: var(--blue);
                }

                .cardBox .card .cardName {
                    color: var(--black2);
                    font-size: 1.1rem;
                    margin-top: 5px;
                }

                .cardBox .card .iconBox {
                    font-size: 3.5rem;
                    color: var(--black2);
                }

                .cardBox .card:hover {
                    background: var(--blue);
                }

                    .cardBox .card:hover .numbers,
                    .cardBox .card:hover .cardName,
                    .cardBox .card:hover .iconBox {
                        color: var(--white);
                    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="cardBox">
        <div class="card">
            <div>
                <div class="numbers">
                    <asp:Literal runat="server" ID="lblPendingCount" Text="0"></asp:Literal></div>
                <div class="cardName">Pending</div>
            </div>
            <a href="PendingHistory.aspx" class="iconBox">
                <ion-icon name="hourglass-outline"></ion-icon>
            </a>
        </div>
        <div class="card">
            <div>
                <div class="numbers">
                    <asp:Literal ID="lblApproveCount" runat="server" Text="0"></asp:Literal></div>
                <div class="cardName">Approved</div>
            </div>
            <a href="ApprovedHistory.aspx" class="iconBox">
                <ion-icon name="checkmark-circle-outline"></ion-icon>
            </a>
        </div>
        <div class="card">
            <div>
                <div class="numbers">
                    <asp:Literal runat="server" ID="lblDeclinedCount" Text="0"></asp:Literal></div>
                <div class="cardName">Declined</div>
            </div>
            <a href="DeclinedHistory.aspx" class="iconBox">
                <ion-icon name="close-circle-outline"></ion-icon>
            </a>
        </div>
        <div class="card">
            <div>
                <div class="numbers">
                    <asp:Literal runat="server" ID="lblScheduleCount" Text="0"></asp:Literal></div>
                <div class="cardName">Schedule</div>
            </div>
            <a href="schedule.aspx" class="iconBox">
                <ion-icon name="calendar-outline"></ion-icon>
            </a>
        </div>
    </div>

</asp:Content>
