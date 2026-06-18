package com.n3.childrentoyweb.enums;

public enum PaymentStatus {
    SUCCESS("DA_THANH_TOAN"),
    UNPAID("CHUA_THANH_TOAN"),
    REFUND("HOAN_TIEN"),
    ;

    private final String status;

    private PaymentStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return this.status;
    }
}
