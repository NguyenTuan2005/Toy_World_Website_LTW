package com.n3.childrentoyweb.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.time.LocalDateTime;

@Getter
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class Shipping extends BaseModel {
    private Order order;
    private Long partnerId;
    private String trackingCode;
    private Double shippingFee;
    private String shippingStatus;
    private LocalDateTime estimatedDelivery;
    private LocalDateTime startShippedAt;
    private LocalDateTime deliveredAt;
}
