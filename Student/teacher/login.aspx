<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Student.teacher.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css" />
    <link href="..\teacher\teacher.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <script src="https://accounts.google.com/gsi/client" async defer></script>
    <style>
        .login-divider {
            position: relative;
            text-align: center;
            margin: 15px auto;
            max-width: 300px;
            width: 100%;
        }

        .login-divider:before,
        .login-divider:after {
            content: "";
            position: absolute;
            top: 50%;
            width: 45%;
            height: 1px;
            background: rgba(255, 255, 255, 0.2);
        }

        .login-divider:before {
            left: 0;
        }

        .login-divider:after {
            right: 0;
        }

        .login-divider span {
            background: transparent;
            padding: 0 10px;
            color: rgba(255, 255, 255, 0.7);
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

        .segment {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 2rem;
            width: 100%;
            max-width: 400px;
        }

        .button.red {
            width: 100%;
            max-width: 300px;
            margin: 0 auto;
        }

        .text-muted {
            margin-top: 20px;
        }
    </style>
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
</head>
<body>


    <form runat="server">
        <div class="cn">
            <div class="content login-s2">
                <div class="img1">
                    <img class="im" src="..\teacher\view-3d-businessman.png" alt="Businessman Image" />
                </div>
                <div class="segment">
                    <h1>Teacher Login Panel</h1>
                    <label>
                        <asp:TextBox ID="txtusername" runat="server" placeholder="Email Address" TextMode="Email" CssClass="input"></asp:TextBox>
                    </label>
                    <label>
                        <asp:TextBox ID="txtpassword" runat="server" placeholder="Password" TextMode="Password" CssClass="input"></asp:TextBox>
                    </label>

                    <div class="col-11 text-right">
                        <a href="Forget.aspx">Forgot Password?</a>
                    </div>

                    <asp:LinkButton ID="btnLogin" runat="server" CssClass="button red" OnClick="btnLogin_Click">
                      <i class="icon ion-md-lock"></i> Log in
                    </asp:LinkButton>

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
                    <p class="text-muted">
                        <a href="../admin/login.aspx"><i class="fas fa-user-shield"></i>Go to Admin Panel</a>
                    </p>
                </div>
            </div>
        </div>
    </form>

</body>
</html>
