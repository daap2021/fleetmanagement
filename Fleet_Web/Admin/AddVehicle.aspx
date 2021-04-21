<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="AddVehicle.aspx.cs" Inherits="Admin_AddVehicle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
        <div class="card">
            <div class="card-header">
                <asp:Label ID="lblTitle" runat="server" CssClass="card-title" Text="Add Vehicle" Font-Size="Large" />
            </div>
            <div class="card-body">
                <div class="form-group">
                    <label>Name</label>&nbsp;<asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" ErrorMessage="Required" ForeColor="Red" />
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control"/>
                </div>
                <div class="form-group">
                    <label>Number</label>
                    &nbsp;<asp:RequiredFieldValidator runat="server" ControlToValidate="txtNumber" ErrorMessage="Required" ForeColor="Red" />
                    &nbsp;<asp:RegularExpressionValidator runat="server" ControlToValidate="txtNumber" ErrorMessage="Invalid number" ForeColor="Red" ValidationExpression="^[A-Z]{2}[ -][0-9]{1,2}(?: [A-Z])?(?: [A-Z]*)? [0-9]{4}$" />
                    <asp:TextBox ID="txtNumber" runat="server" CssClass="form-control"/>
                </div>
                <div class="form-group row">
                    <div class="col-md-6">
                        <label>Kms</label>
                        &nbsp;<asp:RequiredFieldValidator runat="server" ControlToValidate="txtKms" ErrorMessage="Required" ForeColor="Red" />
                        &nbsp;<asp:RegularExpressionValidator runat="server" ControlToValidate="txtKms" ErrorMessage="Invalid Kms" ForeColor="Red" ValidationExpression="^[0-9]*" />
                        <asp:TextBox ID="txtKms" runat="server" CssClass="form-control"/>
                    </div>
                    <div class="col-md-6">
                        <label>Service kms</label>
                         &nbsp;<asp:RequiredFieldValidator runat="server" ControlToValidate="txtSkms" ErrorMessage="Required" ForeColor="Red" />
                         &nbsp;<asp:RegularExpressionValidator runat="server" ControlToValidate="txtSkms" ErrorMessage="Invalid Kms" ForeColor="Red" ValidationExpression="^[0-9]*" />
                        <asp:TextBox ID="txtSkms" runat="server" CssClass="form-control"/>
                    </div>
                </div>
                <div class="form-group">
                    <label>Insurance Expiry Date</label>
                    &nbsp;<asp:RequiredFieldValidator runat="server" ControlToValidate="txtDate" ErrorMessage="Required" ForeColor="Red" />
                    <div class="row">
                        <div class="col-md-4">
                            <asp:TextBox ID="txtDate" runat="server" CssClass="form-control"/>                 
                        </div>
                        <div class="col-md-4">
                             <asp:ImageButton ID="imgCal" runat="server" OnClick="imgCal_Click" ImageUrl="~/plugins/images/cal.png" CausesValidation="false"/>
                             <asp:Calendar ID="cal" runat="server" Visible="false" OnSelectionChanged="cal_SelectionChanged"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-footer">
                <asp:Button ID="btnSumbit" runat="server" Text="Submit" CssClass="btn" BackColor="#2F323E" ForeColor="White" OnClick="btnSumbit_Click"/>
            </div>
        </div>
    </div>

</asp:Content>

