<%@ Page Title="" Language="C#" MasterPageFile="~/teacher/teacher.Master" AutoEventWireup="true" CodeBehind="my-profile.aspx.cs" Inherits="Student.teacher.my_profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script>
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById('<%=img.ClientID %>').src = e.target.result;
                    document.getElementById('<%=img.ClientID %>').style.display = 'block';
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
    <style>
        .main-content-inner {
            padding: 20px;
        }

        .card-body {
            padding: 20px;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .col-form-label {
            font-weight: bold;
            margin-bottom: 0.5rem;
            display: block;
        }

        .custom-select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            background-color: white;
        }

        .alert {
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .alert-danger {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }

        .alert-success {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }

        .close {
            float: right;
            font-size: 20px;
            font-weight: bold;
            line-height: 1;
            color: #000;
            opacity: 0.5;
            background: none;
            border: none;
            cursor: pointer;
        }

            .close:hover {
                opacity: 1;
            }


        .row {
            display: flex;
            flex-wrap: wrap;
            margin-right: -15px;
            margin-left: -15px;
            margin-top: 30px;
        }

        .col-md-6 {
            max-width: 50%;
            padding-right: 15px;
            padding-left: 15px;
        }

        .col-md-12 {
            flex: 0 0 100%;
            max-width: 100%;
            padding-right: 15px;
            padding-left: 15px;
        }


        #fuStudentImage {
            margin-top: 10px;
        }

        #img {
            margin-top: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }


        h3 {
            color: #007bff;
            margin-bottom: 20px;
        }

        .card {
            margin-top: 3%;
            width: 85%;
            margin-left: 100px;
            background: white;
            border-radius: 10px;
            transition: border-radius 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .shadow {
            box-shadow: inset 0 -3em 3em rgba(0,0,0,0.1), 0 0 0 2px rgb(190, 190, 190), 0.3em 0.3em 1em rgba(0,0,0,0.3);
        }

        .input {
            border: none;
            outline: none;
            border-radius: 15px;
            padding: 1em;
            background-color: #ccc;
            box-shadow: inset 2px 5px 10px rgba(0,0,0,0.3);
            transition: 300ms ease-in-out;
        }

            .input:focus {
                background-color: white;
                transform: scale(1.05);
                box-shadow: 13px 13px 100px #969696, -13px -13px 100px #ffffff;
            }

        .button {
            padding: 1.3em 3em;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 2.5px;
            font-weight: 500;
            color: #000;
            background-color: rgba(255, 255, 255, 0.726);
            border: none;
            border-radius: 45px;
            box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease 0s;
            cursor: pointer;
            outline: none;
        }

            .button:hover {
                background-color: #3323c4;
                box-shadow: 0px 15px 20px rgba(46, 229, 157, 0.4);
                color: #fff;
                transform: translateY(-7px);
            }

            .button:active {
                transform: translateY(-1px);
                background-color: #584bd1;
            }

        .dropdown-checkbox {
            display: none;
            position: absolute;
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            z-index: 1000;
            max-height: 200px;
            overflow-y: auto;
        }

        .dropdown-checkbox-container {
            position: relative;
        }

            .dropdown-checkbox-container input {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
                background-color: white;
            }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="main-content-inner">
        <div class="row">
            <div class="col-12 mt-5">
                <div class="card shadow">

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

                    <div class="content">
                        <div class="card-body">
                            <span style="color: blue">
                                <h3>Teacher Details</h3>
                            </span>
                            <div class="row">

                                <div class="form-group col-md-6">
                                    <asp:Label ID="fname" runat="server" CssClass="col-form-label">First Name:</asp:Label>
                                    <asp:TextBox ID="txtfname" runat="server" CssClass="input" />
                                    <asp:RequiredFieldValidator ID="rfvfname" runat="server" ErrorMessage="First Name is Required" ControlToValidate="txtfname"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="lname" runat="server" CssClass="col-form-label">Last Name:</asp:Label>
                                    <asp:TextBox ID="txtlname" runat="server" CssClass="input" />
                                    <asp:RequiredFieldValidator ID="rfvlname" runat="server" ErrorMessage="Last Name is Required" ControlToValidate="txtlname"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="email" runat="server" CssClass="col-form-label">Email ID:</asp:Label>
                                    <asp:TextBox ID="txtemail" runat="server" CssClass="input" ReadOnly="true" />
                                    <asp:RequiredFieldValidator ID="rfvemail" runat="server" ErrorMessage="Email ID is Required" ControlToValidate="txtemail"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revemail" runat="server" ErrorMessage="valid Email Id enter" ControlToValidate="txtemail"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"></asp:RegularExpressionValidator>
                                </div>


                                <div class="form-group col-md-6">
                                    <asp:Label ID="lblsubject" runat="server" CssClass="col-form-label">Subjects:</asp:Label>
                                    <div class="dropdown-checkbox-container">
                                        <input type="text" id="dropdownText" class="dropdown-text" placeholder="Select Subjects" readonly />
                                        <div class="dropdown-checkbox">
                                            <asp:CheckBoxList ID="ddlSubjects" runat="server" CssClass="checkbox-list">
                                            </asp:CheckBoxList>
                                        </div>
                                    </div>
                                </div>


                                <div class="form-group col-md-6">
                                    <asp:Label ID="gender" runat="server" CssClass="col-form-label">Gender:</asp:Label>
                                    <asp:DropDownList
                                        ID="dgender"
                                        runat="server"
                                        CssClass="custom-select"
                                        AppendDataBoundItems="True"
                                        AutoPostBack="False">
                                        <asp:ListItem Text="Choose.." Value="" />
                                        <asp:ListItem Text="Male" Value="Male" />
                                        <asp:ListItem Text="Female" Value="Female" />
                                        <asp:ListItem Text="Other" Value="Other" />
                                    </asp:DropDownList>
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="lbldob" runat="server" CssClass="col-form-label" AssociatedControlID="txtdob">D.O.B</asp:Label>
                                    <asp:TextBox ID="txtdob" runat="server" CssClass="input" TextMode="Date"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvdob" runat="server" ErrorMessage="Date of Birth is Required" ControlToValidate="txtdob"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="mobile" runat="server" CssClass="col-form-label">Contact Number:</asp:Label>
                                    <asp:TextBox ID="txtmobile" runat="server" CssClass="input" />
                                    <asp:RequiredFieldValidator ID="rfvmobile" runat="server" ErrorMessage="Contact Number is Required" ControlToValidate="txtmobile"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revmobile" runat="server" ErrorMessage="Please enter a valid Contact Number" ControlToValidate="txtmobile"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small" ValidationExpression="^[0-9]{10}$"></asp:RegularExpressionValidator>
                                </div>

                                <div class="form-group col-md-12">
                                    <label for="fuTeacherImage">Student Image</label>
                                    <asp:FileUpload ID="fuTeacherImage" runat="server" CssClass="input" onchange="ImagePreview(this);" />
                                    <asp:Image ID="img" runat="server" Width="100px" Height="100px" />
                                    <asp:HiddenField ID="hdnimg" runat="server" />
                                </div>

                            </div>


                            <span style="color: blue">
                                <h3>Address</h3>
                            </span>
                            <div class="row">

                                <div class="form-group col-md-6">
                                    <asp:Label ID="country" runat="server" CssClass="col-form-label">Country:</asp:Label>
                                    <asp:TextBox ID="txtcountry" runat="server" CssClass="input" />
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="state" runat="server" CssClass="col-form-label">State:</asp:Label>
                                    <asp:TextBox ID="txtstate" runat="server" CssClass="input" />
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="district" runat="server" CssClass="col-form-label">District:</asp:Label>
                                    <asp:TextBox ID="txtdistrict" runat="server" CssClass="input" />
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="pincode" runat="server" CssClass="col-form-label"> Pincode:</asp:Label>
                                    <asp:TextBox ID="txtpincode" runat="server" CssClass="input" />
                                    <asp:RegularExpressionValidator ID="revpincode" runat="server" ErrorMessage="Please enter a valid pincode" ControlToValidate="txtpincode"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small" ValidationExpression="^[0-9]{6}$"></asp:RegularExpressionValidator>
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="city" runat="server" CssClass="col-form-label">City/village:</asp:Label>
                                    <asp:TextBox ID="txtcity" runat="server" CssClass="input" />
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="address" runat="server" CssClass="col-form-label">Address:</asp:Label>
                                    <asp:TextBox ID="txtaddress" runat="server" CssClass="input" TextMode="MultiLine" />
                                </div>

                            </div>

                            <asp:Button ID="btnUpdateteacher" runat="server" Text="Update" CssClass="button" OnClick="btnUpdateteacher_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const dropdownText = document.getElementById("dropdownText");
            const checkboxes = document.querySelectorAll("#<%= ddlSubjects.ClientID %> input[type='checkbox']");
            const dropdownCheckbox = document.querySelector(".dropdown-checkbox");

            function updateDropdownText() {
                const selectedItems = Array.from(checkboxes)
                    .filter(cb => cb.checked)
                    .map(cb => cb.parentElement.textContent.trim());
                dropdownText.value = selectedItems.join(", ") || "Select Subjects";
            }

            checkboxes.forEach(checkbox => {
                checkbox.addEventListener("change", updateDropdownText);
            });

            dropdownText.addEventListener("click", (e) => {
                e.stopPropagation();
                dropdownCheckbox.style.display = dropdownCheckbox.style.display === "block" ? "none" : "block";
            });

            document.addEventListener("click", (e) => {
                if (!e.target.closest(".dropdown-checkbox-container")) {
                    dropdownCheckbox.style.display = "none";
                }
            });

            updateDropdownText();
        });
    </script>

</asp:Content>
