<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="ViewDeliveries.aspx.cs" Inherits="Admin_ViewDeliveries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
                .gv{
            width:100%
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
         <h3 class="text-center"> Completed Deliveries</h3>
        <br />
         <asp:GridView ID="gvDelv" runat="server" AutoGenerateColumns="false" CssClass="gv"
            HeaderStyle-HorizontalAlign="Center" OnRowCommand="gvDelv_RowCommand" DataKeyNames="delv_id">
            <Columns>
                <asp:BoundField DataField="d_name" HeaderText="Driver" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="v_name" HeaderText="Vehicle" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="v_number" HeaderText="Vehicle Number" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="delv_date" HeaderText="Date" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="delv_kms" HeaderText="Total Kms" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="delv_address" HeaderText="Address" ItemStyle-HorizontalAlign="Center"/>
                 <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                   <ItemTemplate>
                       <asp:Button ID="btView" runat="server" Text="View" CommandName="ViewTable" CausesValidation="false" CommandArgument='<%# Eval("delv_img") %>' BackColor="#2c92e6" ForeColor="White" CssClass="btn"/>
                   </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

