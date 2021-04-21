<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="AddDriver.aspx.cs" Inherits="Admin_AddDriver" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
        <br />
        <div class="card">
            <div class="card-header">
                <asp:Label ID="lblTitle" runat="server" Font-Size="Large">Add Driver</asp:Label>
            </div>
            <div class="card-body">
                 <div class="form-group row">
                     <div class="col-md-6">
                         <label> First Name</label>&nbsp;<asp:RequiredFieldValidator runat="server" ControlToValidate="txtFname" ErrorMessage="Required" ForeColor="Red" />
                         <asp:TextBox ID="txtFname" runat="server" CssClass="form-control" />
                     </div>
                     <div class="col-md-6">
                         <label>Last Name</label>&nbsp;<asp:RequiredFieldValidator runat="server" ControlToValidate="txtLname" ErrorMessage="Required" ForeColor="Red" />
                         <asp:TextBox ID="txtLname" runat="server" CssClass="form-control" />
                     </div>
                 </div>
                 <div class="form-group">
                     <label> Email </label>
                     <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="Required" ForeColor="Red" />
                     <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid email id" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                     <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                 </div>
                 <div class="form-group">
                     <label> Mobile No </label>
                     <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMobile" ErrorMessage="Required" ForeColor="Red" />
                     <asp:RegularExpressionValidator runat="server" ControlToValidate="txtMobile" ErrorMessage="Invalid mobile no" ForeColor="Red" ValidationExpression="^[789]\d{9}$" />
                     <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" />
                 </div>
            </div>
            <div class="card-footer">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn" BackColor="#2F323E" ForeColor="White" OnClick="btnSubmit_Click" />
            </div>
        </div>
    </div>
</asp:Content>

