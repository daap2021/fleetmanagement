<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="ManageDriver.aspx.cs" Inherits="Admin_ManageDriver" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .gv{
            width:100%
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
        <h2 class="text-center"> Driver Details</h2>
        <br />
        <a href="AddDriver.aspx?action=add" style="font-size:larger"> <u>Add Driver</u></a>
        <br /><br />
        <asp:GridView ID="gvDriver" runat="server" AutoGenerateColumns="false" DataKeyNames="d_id" CssClass="gv"
            HeaderStyle-HorizontalAlign="Center" OnRowCommand="gvDriver_RowCommand">
            <Columns>
                <asp:BoundField DataField="d_id" HeaderText="Id" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="d_fname" HeaderText="First Name" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="d_lname" HeaderText="Last Name" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="d_email" HeaderText="Email" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="d_contact" HeaderText="Mobile no" ItemStyle-HorizontalAlign="Center"/>
                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                   <ItemTemplate>
                       <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="EditTable" CausesValidation="false" CommandArgument='<%# Eval("d_id") %>' BackColor="#2c92e6" ForeColor="White" CssClass="btn"/>
                   </ItemTemplate>
                </asp:TemplateField>   
                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                   <ItemTemplate>
                       <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteTable" CausesValidation="false" CommandArgument='<%# Eval("d_id") %>' BackColor="Red" ForeColor="White" CssClass="btn"/>
                   </ItemTemplate>
               </asp:TemplateField> 
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

