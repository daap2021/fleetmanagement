package com.example.chintan.fleet_app;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import android.util.Base64;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.example.chintan.fleet_app.Model.Document;
import com.example.chintan.fleet_app.Model.RespMessage;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;

public class DeliveryDetailsActivity extends AppCompatActivity {

    private static final int CAMERA_REQUEST = 1888;
    TextView txtName,txtDate,txtDesc,txtKms,txtAddr,txtPickup;
    Button btnLoc,btnUpload,btnComplete;
    String encodedImage=null;
    ProgressDialog progressDialog;
    int delv_id,v_id;
    Retrofit retrofit;
    ApiInterface apiInterface;
    double lat,lon;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_delivery_details);

        txtName = findViewById(R.id.txtDVname);
        txtDate = findViewById(R.id.txtDDate);
        txtDesc = findViewById(R.id.txtDDesc);
        txtKms = findViewById(R.id.txtDKms);
        txtAddr = findViewById(R.id.txtDAddr);
        btnLoc = findViewById(R.id.btnViewLoc);
        btnUpload = findViewById(R.id.btnUpload);
        btnComplete = findViewById(R.id.btnComplete);
        txtPickup = findViewById(R.id.txtPickup);

        progressDialog = new ProgressDialog(this);
        progressDialog.setTitle("Alert");
        progressDialog.setMessage("Please wait...");

        retrofit = ApiClient.getClient();
        apiInterface =  retrofit.create(ApiInterface.class);

        Intent intent = getIntent();

        lat = intent.getDoubleExtra("delv_lat",0);
        lon = intent.getDoubleExtra("delv_lon",0);

        txtName.setText(intent.getStringExtra("v_name"));
        txtDate.setText(intent.getStringExtra("delv_date"));
        txtDesc.setText(intent.getStringExtra("delv_desc"));
        txtKms.setText(String.valueOf(intent.getDoubleExtra("delv_kms",0)));
        txtAddr.setText(intent.getStringExtra("delv_addr"));
        delv_id = intent.getIntExtra("delv_id",0);
        txtPickup.setText(intent.getStringExtra("delv_pickup"));

        //Toast.makeText(getApplicationContext(),String.valueOf(delv_id),Toast.LENGTH_LONG).show();

        btnLoc.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(DeliveryDetailsActivity.this,MapsActivity.class);
                intent.putExtra("lat",lat);
                intent.putExtra("lon",lon);
                startActivity(intent);
            }
        });

        btnUpload.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(
                        Intent.ACTION_PICK, android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
                startActivityForResult(i, CAMERA_REQUEST);
            }
        });

        btnComplete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                progressDialog.show();
                Call<RespMessage> call = apiInterface.updateDelivery(String.valueOf(delv_id),String.valueOf(v_id));
                call.enqueue(new Callback<RespMessage>() {
                    @Override
                    public void onResponse(Call<RespMessage> call, Response<RespMessage> response) {
                        if (response.isSuccessful()){
                            String message = response.body().getMessage();
                            Toast.makeText(DeliveryDetailsActivity.this,message,Toast.LENGTH_LONG).show();
                            if (message.trim().equalsIgnoreCase("Status updated")){
                                finish();
                                startActivity(new Intent(DeliveryDetailsActivity.this,DashboardActivity.class));
                            }
                        }
                        if (progressDialog.isShowing())
                            progressDialog.dismiss();
                    }

                    @Override
                    public void onFailure(Call<RespMessage> call, Throwable t) {
                        Toast.makeText(DeliveryDetailsActivity.this, t.toString(),Toast.LENGTH_LONG).show();
                        if (progressDialog.isShowing())
                            progressDialog.dismiss();
                    }
                });
            }
        });
    }

    @Override
    protected void onActivityResult(final int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK) {
            if (requestCode == CAMERA_REQUEST) {
                try {

                    final Uri imageUri = data.getData();
                    final InputStream imageStream = getContentResolver().openInputStream(imageUri);
                    final Bitmap selectedImage = BitmapFactory.decodeStream(imageStream);
                    encodedImage = encodeImage(selectedImage);
                    Document document = new Document();
                    document.setDelv_id(delv_id);
                    document.setDelv_img(encodedImage);
                    uploadImage(document);
                } catch (Exception ex) {
                    Toast.makeText(DeliveryDetailsActivity.this, ex.toString(), Toast.LENGTH_LONG).show();
                }
            }
        }
    }

    private void uploadImage(Document document) {
        progressDialog.show();

        Call<RespMessage> call = apiInterface.upload(document);
        call.enqueue(new Callback<RespMessage>() {
            @Override
            public void onResponse(Call<RespMessage> call, Response<RespMessage> response) {
                if (response.isSuccessful()){
                    String message = response.body().getMessage();
                    Toast.makeText(DeliveryDetailsActivity.this,message,Toast.LENGTH_LONG).show();
                }
                if (progressDialog.isShowing())
                    progressDialog.dismiss();
            }

            @Override
            public void onFailure(Call<RespMessage> call, Throwable t) {
                Toast.makeText(DeliveryDetailsActivity.this, t.toString(),Toast.LENGTH_LONG).show();
                if (progressDialog.isShowing())
                    progressDialog.dismiss();
            }
        });
    }

    private String encodeImage(Bitmap bm)
    {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        bm.compress(Bitmap.CompressFormat.JPEG,100,baos);
        byte[] b = baos.toByteArray();
        String encImage = Base64.encodeToString(b, Base64.DEFAULT);
        return encImage;
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        finish();
    }
}
