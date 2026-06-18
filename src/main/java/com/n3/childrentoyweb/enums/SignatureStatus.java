package com.n3.childrentoyweb.enums;

public enum SignatureStatus {
    SIGNED("DA_CO_CHU_KY_DIEN_TU"),
    UNSIGNED("CHUA_CO_CHU_KY_DIEN_TU"),
    ;
    private final String status;

    SignatureStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return this.status;
    }
}
