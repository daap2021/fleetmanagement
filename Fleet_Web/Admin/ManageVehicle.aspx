<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="ManageVehicle.aspx.cs" Inherits="Admin_ManageVehicle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
      .gv{
            width:100%
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
        <h2 class="text-center"> Vehicle Details</h2>
        <br />
        <a href="AddVehicle.aspx?action=add" style="font-size:larger"> <u>Add Vehicle</u></a>
        <br /><br />
        <asp:GridView ID="gvVehicle" runat="server" AutoGenerateColumns="false" DataKeyNames="v_id" CssClass="gv" 
            HeaderStyle-HorizontalAlign="Center" OnRowCommand="gvVehicle_RowCommand">
            <Columns>
                <asp:BoundField DataField="v_id" HeaderText="Id" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="v_name" HeaderText="Name" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="v_number" HeaderText="Number" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="v_kms" HeaderText="Kms" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="v_skms" HeaderText="Next Service" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="v_insurance" HeaderText="Insurance Expiry" ItemStyle-HorizontalAlign="Center"/>
                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                   <ItemTemplate>
                       <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="EditTable" CausesValidation="false" CommandArgument='<%# Eval("v_id") %>' BackColor="#2c92e6" ForeColor="White" CssClass="btn"/>
                   </ItemTemplate>
                </asp:TemplateField>   
                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                   <ItemTemplate>
                       <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteTable" CausesValidation="false" CommandArgument='<%# Eval("v_id") %>' BackColor="Red" ForeColor="White" CssClass="btn"/>
                   </ItemTemplate>
               </asp:TemplateField> 
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

