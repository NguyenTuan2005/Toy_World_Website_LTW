package com.n3.childrentoyweb.models;

import java.time.LocalDateTime;

public class Order extends BaseModel {
    private Long userId;
    private Double totalPrice;
    private Double discountPrice;
    private String status;
    private String signatureStatus;

    public Order(Long id, Long userId, Double totalPrice, String status, Boolean isActive,LocalDateTime createdAt) {
        super(id, isActive, createdAt);
        this.userId = userId;
        this.totalPrice = totalPrice;
        this.status = status;
    }

    public String getSignatureStatus() {
        return signatureStatus;
    }


    public Order(Long userId, Double totalPrice, Double discountPrice, String status) {
        this.userId = userId;
        this.totalPrice = totalPrice;
        this.discountPrice = discountPrice;
        this.status = status;
    }

    public Order(Long userId, Double totalPrice, Double discountPrice, String status, String signatureStatus) {
        this.userId = userId;
        this.totalPrice = totalPrice;
        this.discountPrice = discountPrice;
        this.status = status;
        this.signatureStatus = signatureStatus;
    }

    public Order() {
    }

    public Long getUserId() {
        return userId;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Double getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(Double discountPrice) {
        this.discountPrice = discountPrice;
    }
}
