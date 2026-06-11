package com.n3.childrentoyweb.dto.orderSignature;

public class OrderItemPayload {

    private Long productId;

    private String productName;

    private int quantity;

    private Double unitPrice;

    private Long promotionId;

    public OrderItemPayload(Long productId, String productName, int quantity, Double unitPrice, Long promotionId) {
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.promotionId = promotionId;
    }

    public Long getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public Double getUnitPrice() {
        return unitPrice;
    }

    public Long getPromotionId() {
        return promotionId;
    }
}