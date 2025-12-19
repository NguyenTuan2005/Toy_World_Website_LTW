package com.n3.childrentoyweb.models;


import java.time.LocalDateTime;
import java.util.Map;

public class Product extends BaseModel {
    private Double price;
    private Long promotionId;
    private Integer quantity;
    private String name;


    private Map<String, String> restInfo;
    private String description;
    private Long brandId;
    private Long categoryId;

    public Product() {}

    public Product( Double price, Long promotionId, Integer quantity, String name, Map<String, String> restInfo, String description, Long brandId, Long categoryId) {
        this.price = price;
        this.promotionId = promotionId;
        this.quantity = quantity;
        this.name = name;
        this.restInfo = restInfo;
        this.description = description;
        this.brandId = brandId;
        this.categoryId = categoryId;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Long getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(Long promotionId) {
        this.promotionId = promotionId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Map<String, String> getRestInfo() {
        return restInfo;
    }

    public void setRestInfo(Map<String, String> restInfo) {
        this.restInfo = restInfo;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getBrandId() {
        return brandId;
    }

    public void setBrandId(Long brandId) {
        this.brandId = brandId;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    @Override
    public String toString() {
        return "Product{" +
                "price=" + price +
                ", promotionId=" + promotionId +
                ", quantity=" + quantity +
                ", name='" + name + '\'' +
                ", restInfo=" + restInfo +
                ", description='" + description + '\'' +
                ", brandId=" + brandId +
                ", categoryId=" + categoryId +
                '}';
    }
}
