package com.n3.childrentoyweb.enums;

public enum OrderStatus {
    PENDING("CHO_XU_LY"),
    IN_PREPARE("CHUAN_BI_HANG"),
    IN_PROCESS("DANG_GIAO"),
    COMPLETED("DA_GIAO"),
    CANCELED("DA_HUY"),
    ;

    private final String status;

    OrderStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return this.status;
    }
}
