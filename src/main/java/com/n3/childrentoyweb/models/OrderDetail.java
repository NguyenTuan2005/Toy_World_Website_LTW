package com.n3.childrentoyweb.models;


import java.time.LocalDateTime;

public class OrderDetail extends BaseModel {
    private Long  orderId;
    private Long productId;
    private Integer quantity;

    public OrderDetail( Long orderId, Long productId, Integer quantity) {
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
    }

    public Long getOrderId() {
        return orderId;
    }

    public Long getProductId() {
        return productId;
    }

    public Integer getQuantity() {
        return quantity;
    }
}
