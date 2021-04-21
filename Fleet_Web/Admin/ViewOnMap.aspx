<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="ViewOnMap.aspx.cs" Inherits="Test_Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
       
        .dd{

        }
        .button{
            background-color:blue;
            color:white;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
   <div style="margin-top:2%">
      
       
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript">

      
                var markers = [
                    <asp:Repeater ID="rptMarkers" runat="server">

                        <ItemTemplate>
                            {
                            "lat": '<%# Eval("d_lat") %>',
                            "lng": '<%# Eval("d_lon") %>'
                            
                            }
                        </ItemTemplate>
                        <SeparatorTemplate>
                            ,
                        </SeparatorTemplate>
                    </asp:Repeater >
                        ];
          
    </script>
    <script type="text/javascript">

        var a;
        function OnGradeChanged(value) {
            a = value;
        }


        window.onload = function () {

             var mapOptions = {
                center: new google.maps.LatLng(markers[0].lat, markers[0].lng),
                zoom: 11,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
            };
            var infoWindow = new google.maps.InfoWindow();
            var map = new google.maps.Map(document.getElementById("dvMap"), mapOptions);
            for (i = 0; i < markers.length; i++) {
                var data = markers[i]
                var myLatlng = new google.maps.LatLng(data.lat, data.lng);

                var iconPath = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png'

                var marker = new google.maps.Marker({
                    position: myLatlng,
                    map: map,
                    icon: iconPath
                });
                (function (marker, data) {
                    google.maps.event.addListener(marker, "click", function (e) {
                        infoWindow.setContent(data.description);
                        infoWindow.open(map, marker);
                    });
                })(marker, data);
            }
        }
    </script>
       <div class="container" style="text-align:center">
           Select Driver <asp:DropDownList ID="ddDriver" runat="server" CssClass="dd" /><br /><br />
           <asp:Button ID="btnView" runat="server" Text="View on Map" CssClass="btn btn-primary" OnClick="btnView_Click" />
       </div>
    
    <br />
    <div id="dvMap" style="width:100%; height:700px">
        
    </div>
  </div>
</asp:Content>

