package com.n3.childrentoyweb.dto.orderSignature;

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
}