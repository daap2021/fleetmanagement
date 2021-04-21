package com.example.chintan.fleet_app;

import com.example.chintan.fleet_app.Model.Delivery;
import com.example.chintan.fleet_app.Model.Document;
import com.example.chintan.fleet_app.Model.RespLogin;
import com.example.chintan.fleet_app.Model.RespMessage;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.Path;


public interface ApiInterface {

    //String Url="http://192.168.0.103/fleet_service/Service1.svc/";
    String Url ="http://demoproject.in/fleet_service/Service1.svc/";

    @GET("login/{email}/{password}")
    Call<RespLogin> login(@Path("email") String email,
                          @Path("password") String password);

    @GET("getDeliveries/{d_id}")
    Call<List<Delivery>> getDeliveries(@Path("d_id") String d_id);

    @POST("upload")
    Call<RespMessage> upload(@Body Document document);

    @GET("updateDelivery/{delv_id}/{v_id}")
    Call<RespMessage> updateDelivery(@Path("delv_id") String delv_id,
                                     @Path("v_id") String v_id);

    @GET("updateLocation/{d_id}/{lat}/{lon}")
    Call<RespMessage> updateLocation(@Path("d_id") String d_id,
                                     @Path("lat") String lat,@Path("lon") String lon);

}
