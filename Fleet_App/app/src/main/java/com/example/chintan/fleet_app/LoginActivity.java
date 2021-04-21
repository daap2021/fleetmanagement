package com.example.chintan.fleet_app;

import android.Manifest;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.example.chintan.fleet_app.Model.RespLogin;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;

public class LoginActivity extends AppCompatActivity {

    Button btnLogin;
    EditText etEmail,etPass;
    ApiInterface apiInterface;
    TextView goToSignup;
    ProgressDialog progressDialog;
    int PERMISSION_ALL = 1;
    String[] PERMISSIONS = {
            Manifest.permission.READ_EXTERNAL_STORAGE,
            Manifest.permission.WRITE_EXTERNAL_STORAGE,
            Manifest.permission.CAMERA,
            Manifest.permission.READ_PHONE_STATE,
            Manifest.permission.ACCESS_NETWORK_STATE,
            Manifest.permission.ACCESS_COARSE_LOCATION,
            Manifest.permission.ACCESS_FINE_LOCATION,
            Manifest.permission.CALL_PHONE
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        etEmail = findViewById(R.id.etLogEmail);
        etPass = findViewById(R.id.etLogPass);
        btnLogin = findViewById(R.id.btnLogin);

        progressDialog = new ProgressDialog(this);
        progressDialog.setTitle("Alert");
        progressDialog.setMessage("Please wait...");

        if (!hasPermissions(this, PERMISSIONS)) {
            ActivityCompat.requestPermissions(this, PERMISSIONS, PERMISSION_ALL);
        }

        btnLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                String email = etEmail.getText().toString().trim();
                String pass = etPass.getText().toString().trim();

                if (!ApiClient.checkNetworkAvailable(LoginActivity.this))
                {
                    Toast.makeText(LoginActivity.this,R.string.con_msg,Toast.LENGTH_LONG).show();
                }
                else if (email.equals("") || pass.equals(""))
                {
                    Toast.makeText(LoginActivity.this,"Please fill all the fields",Toast.LENGTH_LONG).show();
                }
                else
                {
                    login(email,pass);
                }
            }
        });
    }
    private void login(String email, String pass) {
        progressDialog.show();
        Retrofit retrofit = ApiClient.getClient();
        apiInterface = retrofit.create(ApiInterface.class);
        Call<RespLogin> call = apiInterface.login(email,pass);
        call.enqueue(new Callback<RespLogin>() {
            @Override
            public void onResponse(Call<RespLogin> call, Response<RespLogin> response) {
                if (response.isSuccessful()){
                    String message = response.body().getMessage();
                    Toast.makeText(LoginActivity.this,message,Toast.LENGTH_LONG).show();
                    if(message.trim().equalsIgnoreCase("Login successful")) {
                        String d_id = response.body().getD_id();
                        storeDetails(d_id);
                    }
                }
                if (progressDialog.isShowing())
                    progressDialog.dismiss();
            }

            @Override
            public void onFailure(Call<RespLogin> call, Throwable t) {
                if (progressDialog.isShowing())
                    progressDialog.dismiss();
                Toast.makeText(LoginActivity.this,t.toString(),Toast.LENGTH_LONG).show();
            }
        });
    }

    void storeDetails(String d_id)
    {
        SharedPreferences.Editor editor = getSharedPreferences("user", MODE_PRIVATE).edit();
        editor.putString("d_id",d_id);
        editor.apply();
        finish();
        startActivity(new Intent(LoginActivity.this,DashboardActivity.class));
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        finish();
    }

    public static boolean hasPermissions(Context context, String... permissions) {
        if (context != null && permissions != null) {
            for (String permission : permissions) {
                if (ActivityCompat.checkSelfPermission(context, permission) != PackageManager.PERMISSION_GRANTED) {
                    Toast.makeText(context,"Please grant all permissions ",Toast.LENGTH_LONG).show();
                    return false;
                }
            }
        }
        return true;
    }
}
