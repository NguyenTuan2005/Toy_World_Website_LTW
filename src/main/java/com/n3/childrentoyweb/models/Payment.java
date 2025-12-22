package com.n3.childrentoyweb.models;


import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;

public class Payment extends BaseModel{
    @ColumnName("payment_method_id")
    private Long paymentMethodId;

    @ColumnName("order_id")
    private Long orderId;

    @ColumnName("balance")
    private Double balance;

    @ColumnName("Status")
    private String status;

    public Payment(Long id, Long paymentMethodId, Long orderId, Double balance, String status,Boolean isActive,LocalDateTime createdAt) {
        super(id,isActive,createdAt);
        this.paymentMethodId = paymentMethodId;
        this.orderId = orderId;
        this.balance = balance;
        this.status = status;
    }

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
