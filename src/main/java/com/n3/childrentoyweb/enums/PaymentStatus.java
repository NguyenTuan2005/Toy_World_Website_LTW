package com.n3.childrentoyweb.enums;

public enum PaymentStatus {
    SUCCESS("DA_THANH_TOAN"),
    UNPAID("CHUA_THANH_TOAN");

    private final String status;

    private PaymentStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return this.status;
    }
}
