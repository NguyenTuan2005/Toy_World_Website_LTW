package com.n3.childrentoyweb.dto;

import java.time.LocalDateTime;
import java.util.List;

public class OrderDetailDTO {
    private Long id;

    private Long customerId;
    private String customerFirstName;
    private String customerLastName;
    private String customerEmail;
    private String customerPhone;

    private Long locationId;
    private String address;
    private String province;

    private LocalDateTime createdAt;
    private String orderStatus;
    private String paymentStatus;
    private long totalPrice;
    private long discountPrice;

    private List<OrderItemDTO> items;

    public OrderDetailDTO(Long id, Long customerId, String customerFirstName, String customerLastName, String customerEmail, String customerPhone, Long locationId, String address, String province, LocalDateTime createdAt, String orderStatus, String paymentStatus, long totalPrice, long discountPrice, List<OrderItemDTO> items) {
        this.id = id;
        this.customerId = customerId;
        this.customerFirstName = customerFirstName;
        this.customerLastName = customerLastName;
        this.customerEmail = customerEmail;
        this.customerPhone = customerPhone;
        this.locationId = locationId;
        this.address = address;
        this.province = province;
        this.createdAt = createdAt;
        this.orderStatus = orderStatus;
        this.paymentStatus = paymentStatus;
        this.totalPrice = totalPrice;
        this.discountPrice = discountPrice;
        this.items = items;
    }

    public OrderDetailDTO() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCustomerFirstName() {
        return customerFirstName;
    }

    public void setCustomerFirstName(String customerFirstName) {
        this.customerFirstName = customerFirstName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
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

    public long getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(long discountPrice) {
        this.discountPrice = discountPrice;
    }

    public List<OrderItemDTO> getItems() {
        return items;
    }

    public void setItems(List<OrderItemDTO> items) {
        this.items = items;
    }

    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }

    public String getCustomerLastName() {
        return customerLastName;
    }

    public void setCustomerLastName(String customerLastName) {
        this.customerLastName = customerLastName;
    }

    public Long getLocationId() {
        return locationId;
    }

    public void setLocationId(Long locationId) {
        this.locationId = locationId;
    }

    @Override
    public String toString() {
        return "OrderDetailDTO{" +
                "id=" + id +
                ", customerId=" + customerId +
                ", customerFirstName='" + customerFirstName + '\'' +
                ", customerLastName='" + customerLastName + '\'' +
                ", customerEmail='" + customerEmail + '\'' +
                ", customerPhone='" + customerPhone + '\'' +
                ", locationId=" + locationId +
                ", address='" + address + '\'' +
                ", province='" + province + '\'' +
                ", createdAt=" + createdAt +
                ", orderStatus='" + orderStatus + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", totalPrice=" + totalPrice +
                ", discountPrice=" + discountPrice +
                ", items=" + items +
                "}\n";
    }

    public long getTotalItemBasePrice() {
        return this.items == null ? 0 : this.items.stream().mapToLong(OrderItemDTO :: getTotalPrice).sum();
    }
}
