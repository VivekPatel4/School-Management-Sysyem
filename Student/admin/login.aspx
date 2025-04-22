<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Student.admin.login" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>Admin Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../assets/css/font-awesome.min.css" />
    <link rel="stylesheet" href="../assets/css/themify-icons.css" />
    <link rel="stylesheet" href="../assets/css/metisMenu.css" />
    <link rel="stylesheet" href="../assets/css/owl.carousel.min.css" />
    <link rel="stylesheet" href="../assets/css/slicknav.min.css" />
    <link rel="stylesheet" href="../assets/css/typography.css" />
    <link rel="stylesheet" href="../assets/css/default-css.css" />
    <link rel="stylesheet" href="../assets/css/styles.css" />
    <link rel="stylesheet" href="../assets/css/responsive.css" />
    <style>
        .form-gp input {
            width: 100%;
            padding: 10px 15px;
            font-size: 1rem;
            border: none;
            border-radius: 10px;
            box-shadow: inset 8px 8px 16px transparent, inset -8px -8px 16px transparent;
            color: black;
            outline: none;
            transition: all 0.3s ease;
            border-bottom: 1px solid #e6e6e6;
        }

        .form-gp label {
            position: absolute;
            top: 50%;
            left: 15px;
            transform: translateY(-90%);
            text-transform: capitalize;
            pointer-events: none;
            transition: all 0.3s ease;
            color: #b3b2b2;
        }

        .form-gp input:focus + label,
        .form-gp input:valid + label {
            top: 7px;
            font-size: 0.7rem;
            color: #8655fc;
        }

        #form1 {
            box-shadow: 5px 5px 3px 3px;
        }

        .btn-primary {
            width: 300px;
            border-radius: 30px;
            background-color: transparent;
            border-color: transparent;
            color: black;
            box-shadow:0 0 5px;
        }
    </style>
</head>
<body>

    <div class="login-area">
        <div class="container">
            <div class="login-box ptb--100">
                <form id="form1" runat="server">
                    <div class="login-form-head">
                        <h4>ADMIN PANEL</h4>
                        <p>School Management System</p>

                    </div>

                    <div class="login-form-body">
                        <div class="form-gp">
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="input" autocomplete="off" required="true" />
                            <label for="txtUsername">Email Address:</label>
                            <i class="ti-email"></i>
                            <div class="text-danger"></div>
                        </div>

                        <div class="form-gp">
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input" autocomplete="off" required="true" />
                            <label for="txtPassword">Password:</label>
                            <i class="ti-lock"></i>
                            <div class="text-danger"></div>
                        </div>


                        <div class="submit-btn-area">
                            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn btn-primary" />
                        </div>

                        <div class="form-footer text-center mt-5">
                            <p class="text-muted">
                                <a href="../user/login.aspx"><i class="ti-user"></i>Student Login</a> | 
                                <a href="../teacher/login.aspx"><i class="ti-briefcase"></i>Teacher Login</a>
                            </p>
                        </div>

                    </div>
                </form>
            </div>
        </div>
    </div>

</body>
</html>
