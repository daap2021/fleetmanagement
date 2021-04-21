<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="ManageDelivery.aspx.cs" Inherits="Admin_ManageDelivery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <style>
        .gv{
            width:100%
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
        <h2 class="text-center"> Delivery Details</h2>
        <br />
        <a href="AddDelivery.aspx?action=add" style="font-size:larger"> <u>Add Delivery</u></a>
        <br /><br />
        <asp:GridView ID="gvDelivery" runat="server" AutoGenerateColumns="false" DataKeyNames="delv_id" CssClass="gv"
            HeaderStyle-HorizontalAlign="Center" OnRowCommand="gvDelivery_RowCommand">
            <Columns>
                <asp:BoundField DataField="delv_id" HeaderText="Id" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="d_name" HeaderText="Mobile no" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="v_name" HeaderText="Mobile no" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="delv_date" HeaderText="Date" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="delv_desc" HeaderText="Description" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="delv_source" HeaderText="Pickup" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="delv_lat" HeaderText="Latitude" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="delv_lon" HeaderText="Longitude" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="delv_kms" HeaderText="Kms" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="delv_address" HeaderText="Address" ItemStyle-HorizontalAlign="Center"/>
               <%-- <asp:BoundField DataField="delv_img" HeaderText="Email" ItemStyle-HorizontalAlign="Center"/>--%> 
                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                   <ItemTemplate>
                       <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteTable" CausesValidation="false" CommandArgument='<%# Eval("delv_id") %>' BackColor="Red" ForeColor="White" CssClass="btn"/>
                   </ItemTemplate>
               </asp:TemplateField> 
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

