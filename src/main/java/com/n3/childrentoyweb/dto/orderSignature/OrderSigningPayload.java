package com.n3.childrentoyweb.dto.orderSignature;

import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.Signature;
import java.util.List;

public class OrderSigningPayload {

    private Long orderId;

    private Long userId;

    private Double totalPrice;

    private List<OrderItemPayload> items;

    public OrderSigningPayload(Long orderId, Long userId, Double totalPrice, List<OrderItemPayload> items) {
        this.orderId = orderId;
        this.userId = userId;
        this.totalPrice = totalPrice;
        this.items = items;
    }

    public OrderSigningPayload() {
    }

    public Long getOrderId() {
        return orderId;
    }

    public Long getUserId() {
        return userId;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public List<OrderItemPayload> getItems() {
        return items;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public void setItems(List<OrderItemPayload> items) {
        this.items = items;
    }

}