package com.n3.childrentoyweb.models;


import java.time.LocalDateTime;

public class Shipping extends BaseModel {
    private Long orderId;
    private Long partnerId;
    private String trackingCode;
    private Double shippingFee;
    private String shippingStatus;
    private LocalDateTime estimatedDelivery;
    private LocalDateTime startShippedAt;
    private LocalDateTime deliveredAt;

    public Long getOrderId() {
        return orderId;
    }

    public Long getPartnerId() {
        return partnerId;
    }

    public String getTrackingCode() {
        return trackingCode;
    }

    public Double getShippingFee() {
        return shippingFee;
    }

    public String getShippingStatus() {
        return shippingStatus;
    }

    public LocalDateTime getEstimatedDelivery() {
        return estimatedDelivery;
    }

    public LocalDateTime getStartShippedAt() {
        return startShippedAt;
    }

    public LocalDateTime getDeliveredAt() {
        return deliveredAt;
    }

    public Shipping( Long orderId, Long partnerId, String trackingCode, Double shippingFee, String shippingStatus, LocalDateTime estimatedDelivery, LocalDateTime startShippedAt, LocalDateTime deliveredAt) {
        this.orderId = orderId;
        this.partnerId = partnerId;
        this.trackingCode = trackingCode;
        this.shippingFee = shippingFee;
        this.shippingStatus = shippingStatus;
        this.estimatedDelivery = estimatedDelivery;
        this.startShippedAt = startShippedAt;
        this.deliveredAt = deliveredAt;
    }
}
