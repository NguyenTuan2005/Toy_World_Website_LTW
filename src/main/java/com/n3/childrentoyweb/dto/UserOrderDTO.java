package com.n3.childrentoyweb.dto;

import com.n3.childrentoyweb.enums.OrderStatus;
import com.n3.childrentoyweb.enums.PaymentStatus;
import com.n3.childrentoyweb.enums.SignatureStatus;
import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;

import java.time.LocalDateTime;
import java.util.List;

public class UserOrderDTO {
    private Long id;
    private String orderStatus;
    private String paymentStatus;
    private String signatureStatus;
    private LocalDateTime createdAt;
    private long totalPrice;

    private List<OrderItemDTO> items;

    public UserOrderDTO() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public long getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(long totalPrice) {
        this.totalPrice = totalPrice;
    }

    public List<OrderItemDTO> getItems() {
        return items;
    }

    public void setItems(List<OrderItemDTO> items) {
        this.items = items;
    }

    public String getCreatedAtFormatted() {
        if (createdAt == null) return "";

        return LocalDateTimeConverterUtil.convertToString(createdAt);
    }

    public String getSignatureStatus() {
        return signatureStatus;
    }

    public void setSignatureStatus(String signatureStatus) {
        this.signatureStatus = signatureStatus;
    }

    @Override
    public String toString() {
        return "UserOrderDTO{" +
                "id=" + id +
                ", orderStatus='" + orderStatus + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", signatureStatus='" + signatureStatus + '\'' +
                ", createdAt=" + createdAt +
                ", totalPrice=" + totalPrice +
                ", items=" + items +
                "/n";
    }

    public boolean isNotPaid(){
        return PaymentStatus.UNPAID.getStatus().equals(this.paymentStatus) || this.paymentStatus == null;
    }

    public boolean isPaid() {
        return PaymentStatus.SUCCESS.getStatus().equals(this.paymentStatus);
    }

    public boolean isRefunded() {
        return PaymentStatus.REFUND.getStatus().equals(this.paymentStatus);
    }

    public boolean isPendingSignature(){
        return OrderStatus.PENDING.getStatus().equals(this.orderStatus);
    }

    public boolean isSigned(){
        return SignatureStatus.SIGNED.getStatus().equals(this.signatureStatus);
    }

}
