package com.n3.childrentoyweb.models;

import java.time.LocalDateTime;

public class Order extends BaseModel {
    private Long userId;
    private Double totalPrice;
    private Voucher voucher;
    private String status;


    public Order(Long id, Long userId, Double totalPrice, Voucher voucher, String status,Boolean isActive,LocalDateTime createdAt) {
        super(id, isActive, createdAt);
        this.userId = userId;
        this.totalPrice = totalPrice;
        this.voucher = voucher;
        this.status = status;
    }


    public Order( Long userId, Double totalPrice, Voucher voucher, String status) {
        this.userId = userId;
        this.totalPrice = totalPrice;
        this.voucher = voucher;
        this.status = status;
    }

    public Long getUserId() {
        return userId;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public Voucher getVoucher() {
        return voucher;
    }

    public String getStatus() {
        return status;
    }


}
