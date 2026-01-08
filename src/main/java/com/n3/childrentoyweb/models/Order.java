package com.n3.childrentoyweb.models;

import java.time.LocalDateTime;

public class Order extends BaseModel {
    private Long userId;
    private Double totalPrice;
    private String status;


    public Order(Long id, Long userId, Double totalPrice, String status,Boolean isActive,LocalDateTime createdAt) {
        super(id, isActive, createdAt);
        this.userId = userId;
        this.totalPrice = totalPrice;
        this.status = status;
    }


    public Order( Long userId, Double totalPrice, String status) {
        this.userId = userId;
        this.totalPrice = totalPrice;
        this.status = status;
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


}
