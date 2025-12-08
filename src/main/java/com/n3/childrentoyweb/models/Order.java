package com.n3.childrentoyweb.models;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.ArrayList;
import java.util.List;

@Getter
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class Order extends BaseModel {
    private User user;
    private Double totalPrice;
    private Voucher voucher;
    private String status;
    @Builder.Default
    private List<OrderDetail> orderDetails = new ArrayList<>();

    public void addOrderDetail (OrderDetail orderDetail) {
        this.orderDetails.add(orderDetail);
        orderDetail.setOrder(this);
    }

    public void addAllOrderDetail (List<OrderDetail> orderDetails) {
        for (OrderDetail orderDetail : orderDetails) {
            this.addOrderDetail(orderDetail);
        }
    }
}
