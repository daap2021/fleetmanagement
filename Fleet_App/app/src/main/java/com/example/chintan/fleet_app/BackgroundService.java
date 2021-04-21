package com.example.chintan.fleet_app;

import android.Manifest;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.graphics.BitmapFactory;
import android.location.Location;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import android.support.v4.content.ContextCompat;
import android.widget.Toast;

import com.example.chintan.fleet_app.Model.RespMessage;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.location.LocationListener;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationServices;

import java.net.SocketTimeoutException;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;

public class BackgroundService extends Service implements GoogleApiClient.ConnectionCallbacks,
        GoogleApiClient.OnConnectionFailedListener,
        LocationListener {

    private Handler mHandler;
    public static final long INTERVAL = 60 * 1000;          // 60 secs

    private GoogleApiClient googleApiClient;
    private Location lastLocation;
    private LocationRequest locationRequest;

    private final int UPDATE_INTERVAL = 1000;
    private final int FASTEST_INTERVAL = 900;
    private final int REQ_PERMISSION = 999;

    double latitude;
    double longitude;

    ApiInterface apiInterface;
    Retrofit retrofit;
    String d_id;
    int i;

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    private Runnable runnableService = new Runnable() {
        @Override
        public void run() {
            SharedPreferences prefs = getSharedPreferences("user", MODE_PRIVATE);
            d_id = prefs.getString("d_id","");
            retrofit = ApiClient.getClient();
            apiInterface = retrofit.create(ApiInterface.class);
            createGoogleApi();
            syncData();
            // Repeat this runnable code block again every ... min
            mHandler.postDelayed(runnableService,INTERVAL);
        }
    };

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        // Create the Handler object

        mHandler = new Handler();
        // Execute a runnable task as soon as possible
        mHandler.post(runnableService);

        return START_STICKY;
    }

    private synchronized void syncData() {
        i++;
        if (latitude != 0.0 && longitude != 0.0) {
            Call<RespMessage> call = apiInterface.updateLocation(d_id,String.valueOf(latitude),
                    String.valueOf(longitude));
            call.enqueue(new Callback<RespMessage>() {
                @Override
                public void onResponse(Call<RespMessage> call, Response<RespMessage> response) {
                    if (response.isSuccessful()){
                        String message = response.body().getMessage();
                        if (!message.trim().equalsIgnoreCase("Success"))
                            Toast.makeText(BackgroundService.this,message,Toast.LENGTH_LONG).show();
                    }
                }

                @Override
                public void onFailure(Call<RespMessage> call, Throwable t) {
                    if (t instanceof SocketTimeoutException)
                    {}
                    else
                        Toast.makeText(BackgroundService.this,t.toString(),Toast.LENGTH_LONG).show();
                }
            });
        }
    }



    private void createGoogleApi() {
        //Log.d(TAG, "createGoogleApi()");
        if (googleApiClient == null) {
            googleApiClient = new GoogleApiClient.Builder(getApplicationContext())
                    .addConnectionCallbacks(this)
                    .addOnConnectionFailedListener(this)
                    .addApi(LocationServices.API)
                    .build();
        }
        googleApiClient.connect();
    }

    private boolean checkPermission() {
        // Ask for permission if it wasn't granted yet
        return (ContextCompat.checkSelfPermission(getApplicationContext(), Manifest.permission.ACCESS_FINE_LOCATION)
                == PackageManager.PERMISSION_GRANTED);
    }

    @Override
    public void onLocationChanged(Location location) {
        //Log.d(TAG, "onLocationChanged ["+location+"]");
        lastLocation = location;

        latitude = location.getLatitude();
        longitude=location.getLongitude();



        //Toast.makeText(getContext(),String.valueOf(latitude),Toast.LENGTH_LONG).show();
        //writeActualLocation(location);
    }
    @Override
    public void onConnected(@Nullable Bundle bundle) {
        //Log.i(TAG, "onConnected()");
        getLastKnownLocation();
    }
    @Override
    public void onConnectionSuspended(int i) {
        //Log.w(TAG, "onConnectionSuspended()");
    }
    @Override
    public void onConnectionFailed(@NonNull ConnectionResult connectionResult) {
        //Log.w(TAG, "onConnectionFailed()");
    }


    private void getLastKnownLocation() {
        //Log.d(TAG, "getLastKnownLocation()");
        if (checkPermission()) {
            lastLocation = LocationServices.FusedLocationApi.getLastLocation(googleApiClient);
            if (lastLocation != null) {
                //Log.i(TAG, "LasKnown location. " +                        "Long: " + lastLocation.getLongitude() +                        " | Lat: " + lastLocation.getLatitude());
                //writeLastLocation();
                startLocationUpdates();
            } else {
                //Log.w(TAG, "No location retrieved yet");
                startLocationUpdates();
            }
        }
    }


    private void startLocationUpdates() {
        //Log.i(TAG, "startLocationUpdates()");
        locationRequest = LocationRequest.create()
                .setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY)
                .setInterval(UPDATE_INTERVAL)
                .setFastestInterval(FASTEST_INTERVAL);

        if (checkPermission())
            LocationServices.FusedLocationApi.requestLocationUpdates(googleApiClient, locationRequest, this);
    }

}
