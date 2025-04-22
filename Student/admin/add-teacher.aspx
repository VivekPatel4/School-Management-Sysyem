<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="add-teacher.aspx.cs" Inherits="Student.admin.add_teacher" %>

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
        /* Dropdown container styling */
        .dropdown-checkbox-container {
            position: relative;
            width: 100%;
        }

        .dropdown-text {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            cursor: pointer;
            background-color: white;
        }

        .dropdown-checkbox {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            width: 100%;
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            padding: 13px 20px;
        }

        .dropdown-checkbox-container:hover .dropdown-checkbox {
            display: block;
        }

        .checkbox-list {
            margin: 0;
            padding: 0;
            list-style: none;
        }

            .checkbox-list input[type="checkbox"] {
                margin-right: 8px;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title-area">
        <div class="row align-items-center">
            <div class="col-lg-8 col-md-6 col-sm-12">
                <div class="breadcrumbs-area clearfix">
                    <h4 class="page-title pull-left">Add teacher Section</h4>
                    <ul class="breadcrumbs pull-left">
                        <li><a href="teacher.aspx">Teacher</a></li>
                        <li><span>Add</span></li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 col-sm-12 text-right clearfix">
                <div class="user-profile pull-right">
                    <img class="avatar user-thumb" src="../assets/images/admin.png" alt="avatar">
                    <h4 class="user-name dropdown-toggle" data-toggle="dropdown">ADMIN <i class="fa fa-angle-down"></i></h4>
                    <div class="dropdown-menu">
                        <asp:LinkButton ID="LinkButtonLogout" runat="server" CssClass="dropdown-item" OnClick="LinkButtonLogout_Click" CausesValidation="false">Log Out</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="main-content-inner">
        <div class="row">
            <div class="col-12 mt-5">
                <div class="card">

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
                            <p class="text-muted font-14 mb-4">Please fill up the form in order to add Student records</p>
                            <span style="color: blue">
                                <h3>Teacher Details</h3>
                            </span>
                            <div class="row">

                                <div class="form-group col-md-6">
                                    <asp:Label ID="fname" runat="server" CssClass="col-form-label">First Name:</asp:Label>
                                    <asp:TextBox ID="txtfname" runat="server" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ID="rfvfname" runat="server" ErrorMessage="First Name is Required" ControlToValidate="txtfname"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="lname" runat="server" CssClass="col-form-label">Last Name:</asp:Label>
                                    <asp:TextBox ID="txtlname" runat="server" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ID="rfvlname" runat="server" ErrorMessage="Last Name is Required" ControlToValidate="txtlname"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="email" runat="server" CssClass="col-form-label">Email ID:</asp:Label>
                                    <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" />
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
                                    <asp:TextBox ID="txtdob" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvdob" runat="server" ErrorMessage="Date of Birth is Required" ControlToValidate="txtdob"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="mobile" runat="server" CssClass="col-form-label">Contact Number:</asp:Label>
                                    <asp:TextBox ID="txtmobile" runat="server" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ID="rfvmobile" runat="server" ErrorMessage="Contact Number is Required" ControlToValidate="txtmobile"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revmobile" runat="server" ErrorMessage="Please enter a valid Contact Number" ControlToValidate="txtmobile"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small" ValidationExpression="^[0-9]{10}$"></asp:RegularExpressionValidator>
                                </div>

                                <div class="form-group col-md-12">
                                    <label for="fuTeacherImage">Student Image</label>
                                    <asp:FileUpload ID="fuTeacherImage" runat="server" CssClass="form-control" onchange="ImagePreview(this);" />
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
                                    <asp:TextBox ID="txtcountry" runat="server" CssClass="form-control" />
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="state" runat="server" CssClass="col-form-label">State:</asp:Label>
                                    <asp:TextBox ID="txtstate" runat="server" CssClass="form-control" />
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="district" runat="server" CssClass="col-form-label">District:</asp:Label>
                                    <asp:TextBox ID="txtdistrict" runat="server" CssClass="form-control" />
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="pincode" runat="server" CssClass="col-form-label"> Pincode:</asp:Label>
                                    <asp:TextBox ID="txtpincode" runat="server" CssClass="form-control" />
                                    <asp:RegularExpressionValidator ID="revpincode" runat="server" ErrorMessage="Please enter a valid pincode" ControlToValidate="txtpincode"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small" ValidationExpression="^[0-9]{6}$"></asp:RegularExpressionValidator>
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="city" runat="server" CssClass="col-form-label">City/village:</asp:Label>
                                    <asp:TextBox ID="txtcity" runat="server" CssClass="form-control" />
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="address" runat="server" CssClass="col-form-label">Address:</asp:Label>
                                    <asp:TextBox ID="txtaddress" runat="server" CssClass="form-control" TextMode="MultiLine" />
                                </div>

                            </div>
                            <span style="color: blue">
                                <h3>Set Password for Teacher Login</h3>
                            </span>
                            <div class="row">

                                <div class="form-group col-md-6">
                                    <asp:Label ID="password" runat="server" CssClass="col-form-label">Password:</asp:Label>
                                    <asp:TextBox ID="txtpassword" runat="server" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ID="rfvpassword" runat="server" ErrorMessage="Password is Required" ControlToValidate="txtpassword"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                                </div>

                                <div class="form-group col-md-6">
                                    <asp:Label ID="confirmPassword" runat="server" CssClass="col-form-label">Confirmation Password:</asp:Label>
                                    <asp:TextBox ID="txtconfirmpassword" runat="server" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ID="rfvconfirmpassword" runat="server" ErrorMessage="Confirmation Password is Required" ControlToValidate="txtconfirmpassword"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="cvconfirmpassword" runat="server" ErrorMessage="Password Must Be Same Enter" ControlToValidate="txtconfirmpassword"
                                        ControlToCompare="txtpassword" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:CompareValidator>
                                </div>

                            </div>
                            <asp:Button ID="btnAddTeacher" runat="server" Text="Add" CssClass="btn btn-primary"
                                OnClick="btnAddTeacher_Click" />
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

           
            checkboxes.forEach(checkbox => {
                checkbox.addEventListener("change", () => {
                    const selectedItems = Array.from(checkboxes)
                        .filter(cb => cb.checked)
                        .map(cb => cb.parentElement.textContent.trim());
                    dropdownText.value = selectedItems.join(", ") || "Select Subjects";
                });
            });

            
            document.addEventListener("click", (e) => {
                const container = document.querySelector(".dropdown-checkbox-container");
                if (!container.contains(e.target)) {
                    container.querySelector(".dropdown-checkbox").style.display = "none";
                } else {
                    container.querySelector(".dropdown-checkbox").style.display = "block";
                }
            });
        });
    </script>

</asp:Content>
