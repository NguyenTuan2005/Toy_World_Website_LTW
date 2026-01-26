package com.n3.childrentoyweb.dto;

public class CartResponseDTO {
    private boolean success;
    private String message;
    private int totalQuantity;
    private double totalCost;
    private double totalPromotion;
    private double totalPrice;

    public CartResponseDTO() {
    }

    public CartResponseDTO(boolean success, String message, int totalQuantity,
                           double totalCost, double totalPromotion, double totalPrice) {
        this.success = success;
        this.message = message;
        this.totalQuantity = totalQuantity;
        this.totalCost = totalCost;
        this.totalPromotion = totalPromotion;
        this.totalPrice = totalPrice;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    public double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }

    public double getTotalPromotion() {
        return totalPromotion;
    }

    public void setTotalPromotion(double totalPromotion) {
        this.totalPromotion = totalPromotion;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Override
    public String toString() {
        return "CartResponseDTO{" +
                "success=" + success +
                ", message='" + message + '\'' +
                ", totalQuantity=" + totalQuantity +
                ", totalCost=" + totalCost +
                ", totalPromotion=" + totalPromotion +
                ", totalPrice=" + totalPrice +
                '}';
    }
}
