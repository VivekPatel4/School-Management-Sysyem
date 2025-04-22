<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VerifyOTP.aspx.cs" Inherits="Student.teacher.VerifyOTP" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .forget-password-container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }

            .forget-password-container h2 {
                margin-bottom: 20px;
            }

            .forget-password-container button, input {
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
            }

        input {
            margin: 7px;
            margin-right: 8px;
            box-shadow: inset 2px 2px 5px #BABECC, inset -5px -5px 10px #FFF;
            width: 100%;
            box-sizing: border-box;
            transition: all 0.2s ease-in-out;
            appearance: none;
            -webkit-appearance: none;
        }

            input:focus {
                box-shadow: inset 1px 1px 2px #BABECC, inset -1px -1px 2px #FFF;
            }

        button {
            color: #61677C;
            font-weight: bold;
            box-shadow: -5px -5px 20px #FFF, 5px 5px 20px #BABECC;
            cursor: pointer;
            font-weight: 600;
            width: auto;
        }

            button:hover {
                box-shadow: -2px -2px 5px #FFF, 2px 2px 5px #BABECC;
            }

            button:active {
                box-shadow: inset 1px 1px 2px #BABECC, inset -1px -1px 2px #FFF;
            }

            button.red {
                display: inline-grid;
                width: 100%;
                color: #AE1100;
            }

        .button.red {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 16px;
            background-color: #EBECF0;
            color: #AE1100;
            font-weight: bold;
            border: none;
            border-radius: 320px;
            box-shadow: -5px -5px 20px #FFF, 5px 5px 20px #BABECC;
            cursor: pointer;
            transition: all 0.2s ease-in-out;
            text-decoration: none;
        }

            .button.red i {
                margin-right: 8px;
            }

            .button.red:hover {
                box-shadow: -2px -2px 5px #FFF, 2px 2px 5px #BABECC;
            }

            .button.red:active {
                box-shadow: inset 1px 1px 2px #BABECC, inset -1px -1px 2px #FFF;
            }

        .forget-password-container button {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

            .forget-password-container button:hover {
                background-color: #218838;
            }

        .message {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="forget-password-container">
            <h2>Verify OTP</h2>
            <asp:TextBox ID="txtotp" runat="server" placeholder="Enter your OTP" CssClass="input" TextMode="Number"></asp:TextBox>
            <asp:Button ID="btnVerifyOTP" runat="server" Text="Verify OTP" CssClass="button red" OnClick="btnVerifyOTP_Click"/>
            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
        </div>
    </form>
</body>
</html>
