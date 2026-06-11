package com.n3.childrentoyweb.models;

import java.time.LocalDateTime;

public class OrderSignature extends BaseModel {
    private Long orderId;
    private Long publicKeyId;
    private String orderSigningPayload;
    private String signatureValue;
    private String algorithm;
    private LocalDateTime signedAt;

    public OrderSignature(Long orderId, Long publicKeyId, String orderSigningPayload, String algorithm) {
        this.orderId = orderId;
        this.publicKeyId = publicKeyId;
        this.orderSigningPayload = orderSigningPayload;
        this.algorithm = algorithm;
    }

    public OrderSignature(){}

    public Long getOrderId() {
        return orderId;
    }

    public Long getPublicKeyId() {
        return publicKeyId;
    }

    public String getOrderSigningPayload() {
        return orderSigningPayload;
    }

    public String getSignatureValue() {
        return signatureValue;
    }

    public String getAlgorithm() {
        return algorithm;
    }

    public LocalDateTime getSignedAt() {
        return signedAt;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public void setPublicKeyId(Long publicKeyId) {
        this.publicKeyId = publicKeyId;
    }

    public void setOrderSigningPayload(String orderSigningPayload) {
        this.orderSigningPayload = orderSigningPayload;
    }

    public void setSignatureValue(String signatureValue) {
        this.signatureValue = signatureValue;
    }

    public void setAlgorithm(String algorithm) {
        this.algorithm = algorithm;
    }

    public void setSignedAt(LocalDateTime signedAt) {
        this.signedAt = signedAt;
    }
}
