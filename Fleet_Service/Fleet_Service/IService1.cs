using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace Fleet_Service
{

    [ServiceContract]
    public interface IService1
    {
        [OperationContract]
        [WebGet(UriTemplate = "login/{email}/{password}", ResponseFormat = WebMessageFormat.Json)]
        RespLogin login(string email, string password);

        [OperationContract]
        [WebGet(UriTemplate = "getDeliveries/{d_id}", ResponseFormat = WebMessageFormat.Json)]
        List<Delivery> getDeliveries(string d_id);

        [OperationContract]
        [WebInvoke(Method = "POST", UriTemplate = "upload", BodyStyle = WebMessageBodyStyle.Bare, RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json)]
        RespMessage upload(Document doc);

        [OperationContract]
        [WebGet(UriTemplate = "updateDelivery/{delv_id}/{v_id}", ResponseFormat = WebMessageFormat.Json)]
        RespMessage updateDelivery(string delv_id,string v_id);

        [OperationContract]
        [WebGet(UriTemplate = "updateLocation/{d_id}/{lat}/{lon}", ResponseFormat = WebMessageFormat.Json)]
        RespMessage updateLocation(string d_id, string lat, string lon);
    }

    [DataContract]
    public class RespMessage
    {
        [DataMember]
        public string message { get; set; }
    }

    public class RespLogin
    {
        [DataMember]
        public string d_id { get; set; }

        [DataMember]
        public string message { get; set; }
    }

    public class Delivery
    {
        [DataMember]
        public int delv_id { get; set; }

        [DataMember]
        public int v_id { get; set; }

        [DataMember]
        public string v_name { get; set; }

        [DataMember]
        public string delv_date { get; set; }

        [DataMember]
        public string delv_desc { get; set; }

        [DataMember]
        public double delv_lat { get; set; }

        [DataMember]
        public double delv_lon { get; set; }

        [DataMember]
        public double delv_kms { get; set; }

        [DataMember]
        public string delv_address { get; set; }

        [DataMember]
        public string delv_source { get; set; }
       
        [DataMember]
        public string message { get; set; }
    }

    public class Document
    {
        [DataMember]
        public int delv_id { get; set; }

        [DataMember]
        public string delv_img { get; set; }

        [DataMember]
        public string message { get; set; }
    }

 
}
