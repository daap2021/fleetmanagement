<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="AddDelivery.aspx.cs" Inherits="Admin_AddDelivery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
        <div class="card">
            <div class="card-header">
                <asp:Label ID="lblTitle" runat="server" Font-Size="Large">Add Delivery</asp:Label>
            </div>
            <div class="card-body">
                <div class="form-group row">
                    <div class="col-md-6">
                        <label> Driver </label>
                        <asp:DropDownList ID="ddDriver" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-6">
                        <label> Vehicle </label>
                        <asp:DropDownList ID="ddVehicle" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-md-6">
                        <label>Description</label>&nbsp;<asp:RequiredFieldValidator runat="server" ControlToValidate="txtDesc" ErrorMessage="Required" ForeColor="Red" />
                        <asp:TextBox ID="txtDesc" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label>Pickup </label>&nbsp;<asp:RequiredFieldValidator runat="server" ControlToValidate="txtPickup" ErrorMessage="Required" ForeColor="Red" />
                        <asp:TextBox ID="txtPickup" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-md-6">
                        <label> Latitude </label>
                        &nbsp;<asp:RequiredFieldValidator runat="server" ControlToValidate="txtLat" ErrorMessage="Required" ForeColor="Red" />
                        &nbsp;<asp:RegularExpressionValidator runat="server" ControlToValidate="txtLat" ErrorMessage="Invalid" ForeColor="Red" ValidationExpression="^-?[0-9]{1,3}(?:\.[0-9]{1,10})?$" />
                        <asp:TextBox ID="txtLat" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label> Longitude </label>
                        &nbsp;<asp:RequiredFieldValidator runat="server" ControlToValidate="txtLon" ErrorMessage="Required" ForeColor="Red" />
                        &nbsp;<asp:RegularExpressionValidator runat="server" ControlToValidate="txtLon" ErrorMessage="Invalid" ForeColor="Red" ValidationExpression="^-?[0-9]{1,3}(?:\.[0-9]{1,10})?$" />
                        <asp:TextBox ID="txtLon" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row">
                   <div class="col-md-6">
                        <label>Total kms</label>
                        &nbsp;<asp:RequiredFieldValidator runat="server" ControlToValidate="txtKms" ErrorMessage="Required" ForeColor="Red" />
                        &nbsp;<asp:RegularExpressionValidator runat="server" ControlToValidate="txtKms" ErrorMessage="Invalid Kms" ForeColor="Red" ValidationExpression="^[0-9]*" />
                        <asp:TextBox ID="txtKms" runat="server" CssClass="form-control"></asp:TextBox>
                   </div>   
                    <div class="col-md-6">
                        <label>Date</label>
                        &nbsp;<asp:RequiredFieldValidator runat="server" ControlToValidate="txtDate" ErrorMessage="Required" ForeColor="Red" />
                        <div class="row">
                            <div class="col-md-6">
                                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control"/>                 
                            </div>
                            <div class="col-md-6">
                                 <asp:ImageButton ID="imgCal" runat="server" OnClick="imgCal_Click" ImageUrl="~/plugins/images/cal.png" CausesValidation="false"/>
                                 <asp:Calendar ID="cal" runat="server" Visible="false" OnSelectionChanged="cal_SelectionChanged"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label>Address</label>&nbsp;<asp:RequiredFieldValidator runat="server" ControlToValidate="txtAddress" ErrorMessage="Required" ForeColor="Red" />
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="card-footer">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn" BackColor="#2F323E" ForeColor="White" OnClick="btnSubmit_Click" />
            </div>
        </div>
    </div>
</asp:Content>

