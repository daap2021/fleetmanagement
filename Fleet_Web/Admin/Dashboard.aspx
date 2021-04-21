<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Admin_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
                    <div class="row justify-content-center">
                    <div class="col-lg-4 col-sm-6 col-xs-12">
                        <div class="white-box analytics-info">
                            <h3 class="box-title">Total Vehicle</h3>
                            <ul class="list-inline two-part d-flex align-items-center mb-0">
                                <li>
                                     <a href="ManageVehicle.aspx"> &nbsp;&nbsp;View </a>
                                </li>
                                <li class="ml-auto">
                                    <span class="counter text-success">
                                        <asp:Label ID="lblVehicle" runat="server" />
                                    </span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6 col-xs-12">
                        <div class="white-box analytics-info">
                            <h3 class="box-title">Total Driver</h3>
                            <ul class="list-inline two-part d-flex align-items-center mb-0">
                                <li>
                                    <a href="ManageDriver.aspx"> &nbsp;&nbsp;View </a>
                                </li>
                                <li class="ml-auto">
                                    <span class="counter text-purple">
                                        <asp:Label ID="lblDriver" runat="server" />
                                    </span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6 col-xs-12">
                        <div class="white-box analytics-info">
                            <h3 class="box-title">Total Delivery</h3>
                            <ul class="list-inline two-part d-flex align-items-center mb-0">
                                <li>
                                    <a href="ManageDelivery.aspx"> &nbsp;&nbsp;View </a>
                                </li>
                                <li class="ml-auto">
                                    <span class="counter text-info">
                                        <asp:Label ID="lblDeliveries" runat="server" />
                                    </span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
</asp:Content>

