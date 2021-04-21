<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Notification.aspx.cs" Inherits="Admin_Notification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .gv{
            width:100%
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
        <h2 class="text-center"> Notification </h2>       
        <br /><br />
        <h3 class="text-center"> Service Reminder</h3>
        <asp:GridView ID="gvService" runat="server" AutoGenerateColumns="false" CssClass="gv"
            HeaderStyle-HorizontalAlign="Center">
            <Columns>
                <asp:BoundField DataField="v_id" HeaderText="Id" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="v_name" HeaderText="Name" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="v_number" HeaderText="Number" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="v_kms" HeaderText="Kms" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="v_skms" HeaderText="Service Kms" ItemStyle-HorizontalAlign="Center"/>      
            </Columns>
        </asp:GridView>
        <hr />
        <h3 class="text-center"> Insurance Reminder</h3>
         <asp:GridView ID="gvInsurance" runat="server" AutoGenerateColumns="false" CssClass="gv"
            HeaderStyle-HorizontalAlign="Center">
            <Columns>
                <asp:BoundField DataField="v_id" HeaderText="Id" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="v_name" HeaderText="Name" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="v_number" HeaderText="Number" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="v_insurance" HeaderText="Insurance Date" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="days" HeaderText="Days left" ItemStyle-HorizontalAlign="Center"/>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

