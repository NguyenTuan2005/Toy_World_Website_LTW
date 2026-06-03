package com.n3.childrentoyweb.dto.payload;

import java.math.BigDecimal;
import java.util.List;

public class OrderSigningPayload {

    private Long orderId;

    private Long userId;

    private BigDecimal totalAmount;

    private String promotionCode;

    private List<OrderItemPayload> items;
}