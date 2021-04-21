package com.example.chintan.fleet_app;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.SharedPreferences;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.widget.Toast;

import com.example.chintan.fleet_app.Adapter.DeliveryAdapter;
import com.example.chintan.fleet_app.Model.Delivery;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;

public class DeliveryActivity extends AppCompatActivity {

    RecyclerView recyclerView;
    ApiInterface apiInterface;
    Retrofit retrofit;
    AlertDialog alertDialog;
    ProgressDialog progressDialog;
    DeliveryAdapter deliveryAdapter;
    LinearLayoutManager layoutManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_delivery);

        progressDialog = new ProgressDialog(this);
        progressDialog.setTitle("Alert");
        progressDialog.setMessage("Please wait...");

        alertDialog = new AlertDialog.Builder(this).create();
        alertDialog.setTitle("Alert");

        SharedPreferences prefs = getSharedPreferences("user", MODE_PRIVATE);
        String d_id = prefs.getString("d_id","");

        if(ApiClient.checkNetworkAvailable(this))
            getDeliveryList(d_id);
        else
            Toast.makeText(this,R.string.con_msg,Toast.LENGTH_LONG).show();
    }

    private void getDeliveryList(String d_id) {
        progressDialog.show();
        retrofit = ApiClient.getClient();
        apiInterface = retrofit.create(ApiInterface.class);
        Call<List<Delivery>> call = apiInterface.getDeliveries(d_id);
        call.enqueue(new Callback<List<Delivery>>() {
            @Override
            public void onResponse(Call<List<Delivery>> call, Response<List<Delivery>> response) {
                if (response.isSuccessful()){
                    List<Delivery> mDeliveryList = response.body();
                    if (!mDeliveryList.isEmpty())
                        fillRecyclerView(mDeliveryList);
                    else{
                        alertDialog.setMessage("No data found");
                        alertDialog.show();
                    }
                }
                if (progressDialog.isShowing())
                    progressDialog.dismiss();
            }

            @Override
            public void onFailure(Call<List<Delivery>> call, Throwable t) {
                Toast.makeText(DeliveryActivity.this,t.toString(),Toast.LENGTH_LONG).show();
                if (progressDialog.isShowing())
                    progressDialog.dismiss();
            }
        });
    }

    private void fillRecyclerView(List<Delivery> mDeliveryList) {
        recyclerView = findViewById(R.id.rvDelivery);
        deliveryAdapter = new DeliveryAdapter(DeliveryActivity.this,mDeliveryList);
        layoutManager = new LinearLayoutManager(DeliveryActivity.this);
        recyclerView.setLayoutManager(layoutManager);
        recyclerView.setAdapter(deliveryAdapter);
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        finish();
    }
}
