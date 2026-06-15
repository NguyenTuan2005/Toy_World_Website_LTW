package com.n3.childrentoyweb.dto.orderSignature;

import com.n3.childrentoyweb.models.BaseModel;

import java.time.LocalDateTime;

public class OrderSignatureDTO {
    private Long orderId;
    private String publicKey;
    private String orderSigningPayload;
    private String algorithm;


    public OrderSignatureDTO(Long orderId, String publicKey, String orderSigningPayload, String algorithm) {
        this.orderId = orderId;
        this.publicKey = publicKey;
        this.orderSigningPayload = orderSigningPayload;

        this.algorithm = algorithm;

    }

    public OrderSignatureDTO() {
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public String getPublicKey() {
        return publicKey;
    }

    public void setPublicKey(String publicKey) {
        this.publicKey = publicKey;
    }

    public String getOrderSigningPayload() {
        return orderSigningPayload;
    }

    public void setOrderSigningPayload(String orderSigningPayload) {
        this.orderSigningPayload = orderSigningPayload;
    }

    public String getAlgorithm() {
        return algorithm;
    }

    public void setAlgorithm(String algorithm) {
        this.algorithm = algorithm;
    }
}
