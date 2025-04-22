<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.Master" AutoEventWireup="true" CodeBehind="change-password-student.aspx.cs" Inherits="Student.user.change_password_student" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .forget-password-container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
            margin-left: 36%;
            margin-top: 8%;
        }

            .forget-password-container h2 {
                margin-bottom: 20px;
            }

            .forget-password-container input {
                border: 0;
                outline: 0;
                font-size: 16px;
                border-radius: 320px;
                padding: 16px;
                background-color: #EBECF0;
                text-shadow: 1px 1px 0 #FFF;
                transition: all 0.2s ease-in-out;
                box-sizing: border-box;
                width: 100%;
                max-width: 300px;
                margin: 7px 0;
                box-shadow: inset 2px 2px 5px #BABECC, inset -5px -5px 10px #FFF;
                appearance: none;
                -webkit-appearance: none;
            }

                .forget-password-container input:focus {
                    box-shadow: inset 1px 1px 2px #BABECC, inset -1px -1px 2px #FFF;
                }

            .forget-password-container button {
                color: #fff;
                font-weight: bold;
                padding: 12px;
                background-color: #28a745;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                width: 100%;
                transition: all 0.2s ease-in-out;
                box-shadow: -5px -5px 20px #FFF, 5px 5px 20px #BABECC;
            }

                .forget-password-container button:hover {
                    background-color: #218838;
                    box-shadow: -2px -2px 5px #FFF, 2px 2px 5px #BABECC;
                }

                .forget-password-container button:active {
                    box-shadow: inset 1px 1px 2px #BABECC, inset -1px -1px 2px #FFF;
                }

        .button.red {
            background-color: #d9534f !important;
            color: #fff !important;
            font-weight: bold;
            text-align: center;
            padding: 12px;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            box-shadow: -5px -5px 20px #FFF, 5px 5px 20px #BABECC;
        }

            .button.red:hover {
                background-color: #c9302c !important;
                box-shadow: -2px -2px 5px #FFF, 2px 2px 5px #BABECC;
            }

            .button.red:active {
                box-shadow: inset 1px 1px 2px #BABECC, inset -1px -1px 2px #FFF;
            }

        .message {
            color: red;
            margin-top: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="forget-password-container">
        <h2>Change Password</h2>
        <asp:TextBox ID="txtExistpass" runat="server" placeholder="Enter your Existing Password" CssClass="input" TextMode="Password"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvEpass" runat="server" ErrorMessage="Existing Password is Required" ControlToValidate="txtExistpass"
            ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>

        <asp:TextBox ID="txtnpassword" runat="server" placeholder="Enter your New Password" CssClass="input" TextMode="Password"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvNpass" runat="server" ErrorMessage="NEW Password is Required" ControlToValidate="txtnpassword"
            ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>

        <asp:TextBox ID="txtConfirmPassword" runat="server" placeholder="Confirm Password" CssClass="input" TextMode="Password"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvCpass" runat="server" ErrorMessage="Confirm Password is Required" ControlToValidate="txtConfirmPassword"
            ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>

        <asp:CompareValidator ID="cvconfirmpassword" runat="server"
            ErrorMessage="Both Passwords Not Match."
            ControlToValidate="txtConfirmPassword"
            ControlToCompare="txtnpassword"
            ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:CompareValidator>

        <asp:Button ID="btnpassword" runat="server" Text="Update" CssClass="button red" OnClick="btnpassword_Click" />
        <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
    </div>
</asp:Content>

