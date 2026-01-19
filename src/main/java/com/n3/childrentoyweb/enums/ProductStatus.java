package com.n3.childrentoyweb.enums;

public enum ProductStatus {
    AVAILABLE("Còn hàng"),
    OUT_OF_STOCK("Hết hàng");

    private final String status;

    private ProductStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }
}
