package com.n3.childrentoyweb.models;


import java.time.LocalDateTime;

public class Payment extends BaseModel{
    private Long paymentMethodId;
    private Long orderId;
    private Double balance;
    private String status;

    public Payment( Long paymentMethodId, Long orderId, Double balance, String status) {
        this.paymentMethodId = paymentMethodId;
        this.orderId = orderId;
        this.balance = balance;
        this.status = status;
    }

    public Long getPaymentMethodId() {
        return paymentMethodId;
    }

    public Long getOrderId() {
        return orderId;
    }

    public Double getBalance() {
        return balance;
    }

    public String getStatus() {
        return status;
    }
}
