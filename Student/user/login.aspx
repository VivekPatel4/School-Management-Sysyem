<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Student.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>Student Login Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="shortcut icon" type="image/png" href="../assets/images/icon/favicon.ico" />
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
    <script src="https://accounts.google.com/gsi/client" async defer></script>
    <script>
        function handleGoogleCredentialResponse(response) {
            // Create a form and submit it to the same page
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = window.location.href;

            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'credential';
            input.value = response.credential;

            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }
    </script>
    <style>
        .form-gp input {
            width: 100%;
            padding: 10px 15px;
            font-size: 1rem;
            border: none;
            border-radius: 10px;
            box-shadow: inset 8px 8px 16px transparent, inset -8px -8px 16px transparent;
            background-color: #a6998a;
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
            color: black;
        }

        .btn-primary {
            width: 100%;
            max-width: 300px;
            border-radius: 30px;
            background-color: transparent;
            border-color: transparent;
            color: black;
            box-shadow: 0 0 5px;
            margin: 0 auto;
            display: block;
        }

        .login-divider {
            position: relative;
            text-align: center;
            margin: 15px auto;
            max-width: 300px;
        }

        .login-divider:before,
        .login-divider:after {
            content: "";
            position: absolute;
            top: 50%;
            width: 45%;
            height: 1px;
            background: rgba(0, 0, 0, 0.1);
        }

        .login-divider:before {
            left: 0;
        }

        .login-divider:after {
            right: 0;
        }

        .login-divider span {
            background: #fff;
            padding: 0 10px;
            color: #666;
            font-size: 12px;
        }

        .google-btn-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0 auto;
            max-width: 300px;
            width: 100%;
        }

        .g_id_signin {
            border-radius: 30px !important;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1) !important;
            transition: all 0.3s ease !important;
            margin: 0 auto !important;
            width: 100% !important;
        }

        .g_id_signin > div {
            border-radius: 30px !important;
            box-shadow: none !important;
            width: 100% !important;
        }

        .g_id_signin:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.2) !important;
            transform: translateY(-1px) !important;
        }

        #g_id_onload {
            margin: auto;
        }

        .submit-btn-area {
            display: flex;
            flex-direction: column;
            align-items: center;
            max-width: 300px;
            margin: 0 auto;
            width: 100%;
        }

        .form-footer {
            margin-top: 20px !important;
        }
    </style>

</head>

<body>
    <div class="login-area login-s2">
        <div class="container">
            <div class="login-box ptb--100">
                <form id="form1" runat="server">
                    <div class="login-form-head">
                        <h4>Student Login Panel</h4>
                        <p>School Management System</p>
                    </div>

                    <div class="login-form-body">
                        <div class="form-gp">
                            <asp:TextBox ID="txtUsername" runat="server" type="email" CssClass="input" autocomplete="off" required="true" />
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


                        <div class="row mb-4 rmber-area">
                            <div class="col-6">
                                <div class="custom-control custom-checkbox mr-sm-2">
                                    <input type="checkbox" class="custom-control-input" id="customControlAutosizing" />
                                    <label class="custom-control-label" for="customControlAutosizing">Remember Me</label>
                                </div>
                            </div>
                            <div class="col-6 text-right">
                                <a href="Forget.aspx">Forgot Password?</a>
                            </div>
                        </div>

                        <div class="submit-btn-area">
                            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn btn-primary" />
                            
                            <div class="login-divider">
                                <span>OR</span>
                            </div>

                            <div class="google-btn-container">
                                <div id="g_id_onload"
                                    data-client_id="197854560529-i0kb3l6u03hn5vsd3vttdus2nme7ubm7.apps.googleusercontent.com"
                                    data-context="signin"
                                    data-ux_mode="popup"
                                    data-callback="handleGoogleCredentialResponse"
                                    data-auto_prompt="false">
                                </div>
                                <div class="g_id_signin"
                                    data-type="standard"
                                    data-size="large"
                                    data-theme="filled_blue"
                                    data-text="continue_with"
                                    data-shape="pill"
                                    data-logo_alignment="center"
                                    data-width="300">
                                </div>
                            </div>
                        </div>

                        <div class="form-footer text-center mt-5">
                            <p class="text-muted"><a href="../admin/login.aspx">Go to Admin Panel</a></p>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

</body>
</html>
