package com.n3.childrentoyweb.dto;

import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;

import java.time.LocalDateTime;
import java.util.List;

public class UserOrderDTO {
    private Long id;
    private String orderStatus;
    private String paymentStatus;
    private LocalDateTime createdAt;
    private long totalPrice;

    private List<OrderItemDTO> items;

    public UserOrderDTO() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public long getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(long totalPrice) {
        this.totalPrice = totalPrice;
    }

    public List<OrderItemDTO> getItems() {
        return items;
    }

    public void setItems(List<OrderItemDTO> items) {
        this.items = items;
    }

    public String getCreatedAtFormatted() {
        if (createdAt == null) return "";

        return LocalDateTimeConverterUtil.convertToString(createdAt);
    }

    @Override
    public String toString() {
        return "UserOrderDTO{" +
                "id=" + id +
                ", orderStatus='" + orderStatus + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", createdAt=" + createdAt +
                ", totalPrice=" + totalPrice +
                ", items=" + items +
                "}\n";
    }
}
