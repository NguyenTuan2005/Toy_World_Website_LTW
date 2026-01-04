package com.n3.childrentoyweb.dto;

import java.time.LocalDateTime;

public class ManageBrandDTO {
    private long id;
    private String name;
    private int quantity;
    private String status;
    private LocalDateTime createdAt;
    private String logo;
    private boolean isActive;

    public String getStatus() {
        return status;
    }

    public void setStatus(boolean isActive) {
        this.status = isActive ?"Hoạt động":"Tạm khóa";
        this.isActive = isActive;
    }

    public boolean getIsActive() {
        return isActive;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public ManageBrandDTO() {
    }

    @Override
    public String toString() {
        return "ManageBrandDTO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", quantity=" + quantity +
                ", status='" + status + '\'' +
                ", createdAt=" + createdAt +
                ", logo='" + logo + '\'' +
                '}';
    }
}
