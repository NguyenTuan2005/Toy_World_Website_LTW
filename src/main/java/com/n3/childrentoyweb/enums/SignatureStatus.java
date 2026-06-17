package com.n3.childrentoyweb.enums;

public enum SignatureStatus {
    SIGNED("DA_CO_CHU_KY_DIEN_TU"),
    PENDING_SIGNATURE("CHUA_CO_CHU_KY_DIEN_TU"),
    OLD_ORDER_NO_SIGNED("DON_CU_KHI_HE_THONG_CHUA_CAP_NHAT")
    ;
    private final String status;

    SignatureStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return this.status;
    }
}
