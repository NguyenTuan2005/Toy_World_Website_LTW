package com.n3.childrentoyweb.enums;

public enum OrderStatus {
    COMPLETED("DA_GIAO"),
    SIGNED("DA_CO_CHU_KY_DIEN_TU"),
    PENDING_SIGNATURE("CHUA_CO_CHU_KY_DIEN_TU"),
    IN_PROCESS("DANG_GIAO"),
    CANCELED("DA_HUY"),
    IN_PREPARE("CHUAN_BI_HANG")
    ;

    private final String status;

    OrderStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return this.status;
    }
}
