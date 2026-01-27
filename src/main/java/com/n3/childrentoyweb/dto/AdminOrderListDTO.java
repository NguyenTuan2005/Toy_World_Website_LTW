package com.n3.childrentoyweb.dto;

import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;
import java.time.LocalDateTime;

public class AdminOrderListDTO {
    private Long id;
    private String customerName;
    private String customerEmail;
    private String customerPhoneNumber;
    private LocalDateTime createdAt;
    private String orderStatus;
    private String paymentStatus;
    private long totalPrice;

    public AdminOrderListDTO() {
    }

    public AdminOrderListDTO(Long id, String customerName, String customerEmail, String customerPhoneNumber, LocalDateTime createdAt, String orderStatus, String paymentStatus, long totalPrice) {
        this.id = id;
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.customerPhoneNumber = customerPhoneNumber;
        this.createdAt = createdAt;
        this.orderStatus = orderStatus;
        this.paymentStatus = paymentStatus;
        this.totalPrice = totalPrice;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getCustomerPhoneNumber() {
        return customerPhoneNumber;
    }

    public void setCustomerPhoneNumber(String customerPhoneNumber) {
        this.customerPhoneNumber = customerPhoneNumber;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
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

    public long getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(long totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getCreatedAtFormatted() {
        if (createdAt == null) return "";

        return LocalDateTimeConverterUtil.convertToString(createdAt);
    }

    @Override
    public String toString() {
        return "AdminOrderListDTO{" +
                "orderId=" + id +
                ", customerName='" + customerName + '\'' +
                ", customerEmail='" + customerEmail + '\'' +
                ", customerPhoneNumber='" + customerPhoneNumber + '\'' +
                ", createdAt=" + createdAt +
                ", orderStatus='" + orderStatus + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", totalPrice=" + totalPrice +
                "}\n";
    }
}