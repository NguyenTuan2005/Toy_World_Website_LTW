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

    public Long getPromotionId() {
        return promotionId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public String getName() {
        return name;
    }

    public Map<String, String> getRestInfo() {
        return restInfo;
    }

    public String getDescription() {
        return description;
    }

    public Long getBrandId() {
        return brandId;
    }

    public Long getCategoryId() {
        return categoryId;
    }
}
