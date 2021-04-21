package com.example.chintan.fleet_app.Adapter;

import android.content.Context;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.example.chintan.fleet_app.DeliveryDetailsActivity;
import com.example.chintan.fleet_app.Model.Delivery;
import com.example.chintan.fleet_app.R;
import java.util.List;

public class DeliveryAdapter extends RecyclerView.Adapter<DeliveryAdapter.DeliveryViewHolder> {

    private Context context;
    private List<Delivery> mDeliveryList;

    public static class DeliveryViewHolder extends RecyclerView.ViewHolder{

        TextView txtDate,txtAddr;

        public DeliveryViewHolder(@NonNull View itemView) {
            super(itemView);
            txtDate = itemView.findViewById(R.id.txtDate);
            txtAddr = itemView.findViewById(R.id.txtAddr);
        }
    }

    public DeliveryAdapter(Context context, List<Delivery> mDeliveryList) {
        this.context = context;
        this.mDeliveryList = mDeliveryList;
    }

    @NonNull
    @Override
    public DeliveryViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
        View v = LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.delivery_item,viewGroup,false);
        DeliveryViewHolder dvh = new DeliveryViewHolder(v);
        return dvh;
    }

    @Override
    public void onBindViewHolder(@NonNull DeliveryViewHolder holder, final int i) {
        final Delivery d = mDeliveryList.get(i);
        holder.txtDate.setText(d.getDelv_date());
        holder.txtAddr.setText(d.getDelv_address());

        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(context,DeliveryDetailsActivity.class);
                intent.putExtra("delv_id",d.getDelv_id());
                intent.putExtra("v_id",d.getV_id());
                intent.putExtra("v_name",d.getV_name());
                intent.putExtra("delv_date",d.getDelv_date());
                intent.putExtra("delv_desc",d.getDelv_desc());
                intent.putExtra("delv_lat",d.getDelv_lat());
                intent.putExtra("delv_lon",d.getDelv_lon());
                intent.putExtra("delv_kms",d.getDelv_kms());
                intent.putExtra("delv_addr",d.getDelv_address());
                intent.putExtra("delv_pickup",d.getDelv_source());
                context.startActivity(intent);
            }
        });
    }

    @Override
    public int getItemCount() {
        return mDeliveryList.size();
    }
}
