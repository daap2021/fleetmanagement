<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Signup.aspx.cs" Inherits="Signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
          .card{
            margin:0 auto;
            width:31em;
            box-shadow: 0 19px 38px rgba(0,0,0,0.30), 0 15px 12px rgba(0,0,0,0.22);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
         
            <div style="background-color:#2F323E;height:50px">
                   <p style="line-height:40px;font-family:'Arial Rounded MT';font-size:x-large;color:white">
                        &nbsp;&nbsp;IOT Dashboard
                    </p>
               </div>
        <br />
            <div class="card">
                 <div class="card-header">
                             <h5 class="card-title" style="font-family:'Arial Rounded MT';line-height:10px">
                     <svg width="1.5em" height="1.5em" viewBox="0 0 16 16" class="bi bi-person" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                      <path fill-rule="evenodd" d="M10 5a2 2 0 1 1-4 0 2 2 0 0 1 4 0zM8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm6 5c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
                     </svg>&nbsp;&nbsp;Sign Up
                                 </h5>
                 </div>
                 <div class="card-body">
                      <div class="form-group">
                         <label class="control-label"><b>First Name</b></label>&nbsp;&nbsp;<asp:RequiredFieldValidator runat="server" ControlToValidate="txtFname" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator> 
                         <asp:TextBox CssClass="form-control" runat="server" ID="txtFname"></asp:TextBox>
                      </div>
                      <div class="form-group">
                         <label class="control-label"><b>Email</b></label>&nbsp;&nbsp;
                         <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator> 
                         <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" ErrorMessage="Invalid email id " ForeColor="Red"></asp:RegularExpressionValidator>
                         <asp:TextBox CssClass="form-control" runat="server" ID="txtEmail"></asp:TextBox>
                     </div>
                     <div class="row">
                         <div class="col-md-6">
                            <div class="form-group">
                                <label class="control-label"><b>Password</b></label>&nbsp;&nbsp;<asp:RequiredFieldValidator runat="server" ControlToValidate="txtPass" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator> 
                                <asp:TextBox CssClass="form-control" runat="server" ID="txtPass" TextMode="Password"></asp:TextBox>
                            </div>
                         </div>
                         <div class="col-md-6">
                             <div class="form-group">
                                 <label class="control-label"><b>Confirm Password</b></label>&nbsp;&nbsp;<asp:CompareValidator runat="server" ControlToValidate="txtCPass"  ControlToCompare="txtPass" ErrorMessage="Invalid" ForeColor="Red"></asp:CompareValidator> 
                                 <asp:TextBox CssClass="form-control" runat="server" ID="txtCPass" TextMode="Password"></asp:TextBox>
                             </div>
                         </div>
                     </div>
                     <div class="form-group">
                         <label class="control-label"><b>Mobile No</b></label>&nbsp;&nbsp;
                         <asp:RequiredFieldValidator runat="server" ControlToValidate="txtContact" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator> 
                         <asp:RegularExpressionValidator runat="server" ControlToValidate="txtContact" ValidationExpression="^[6-9]\d{9}$" ErrorMessage="Invalid mobile no " ForeColor="Red"></asp:RegularExpressionValidator>
                         <asp:TextBox CssClass="form-control" runat="server" ID="txtContact"></asp:TextBox>
                     </div>
                 </div>
                 <div class="card-footer">
                    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn" BackColor="#2F323E" ForeColor="White" OnClick="btnRegister_Click" />
                    <a href="Login.aspx" class="float-right" style="margin-top:5px">Already Registered ? Login Here </a>
                 </div>   
            </div>
        
    </form>
</body>
</html>
