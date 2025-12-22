package com.n3.childrentoyweb.models;


import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;

public class OrderDetail extends BaseModel {
    @ColumnName("order_id")
    private Long  orderId;

    @ColumnName("product_id")
    private Long productId;

    @ColumnName("quantity")
    private Integer quantity;

    public OrderDetail(Long id, Long orderId, Long productId, Integer quantity, Boolean isActive, LocalDateTime createdAt) {
        super(id,isActive,createdAt);
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
    }

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
