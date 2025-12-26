package com.n3.childrentoyweb.dto;

import java.util.List;
import java.util.Map;

public class ProductDetailDTO {
    protected Long id;
    private Double originalPrice;
    private Double discountPrice;
    private Integer quantity;
    private String name;

    private Map<String, String> restInfo;
    private String description;
    private Long brandId;
    private String brandName;
    private Long categoryId;
    private String categoryName;
    private Long promotionId;
    private Double discountPercent;
    private Double maxDiscountPrice;
    private List<String> imagePaths;

    public ProductDetailDTO(List<String> imagePaths, Double maxDiscountPrice, Double discountPercent, Long promotionId, String categoryName, Long categoryId, String brandName, Long brandId, String description, Map<String, String> restInfo, String name, Integer quantity, Double discountPrice, Double originalPrice, Long id) {
        this.imagePaths = imagePaths;
        this.maxDiscountPrice = maxDiscountPrice;
        this.discountPercent = discountPercent;
        this.promotionId = promotionId;
        this.categoryName = categoryName;
        this.categoryId = categoryId;
        this.brandName = brandName;
        this.brandId = brandId;
        this.description = description;
        this.restInfo = restInfo;
        this.name = name;
        this.quantity = quantity;
        this.discountPrice = discountPrice;
        this.originalPrice = originalPrice;
        this.id = id;
    }

    public ProductDetailDTO() {
    }


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Double getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(Double originalPrice) {
        this.originalPrice = originalPrice;
    }

    public Double getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(Double discountPrice) {
        this.discountPrice = discountPrice;
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

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public Long getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(Long promotionId) {
        this.promotionId = promotionId;
    }

    public Double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(Double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public Double getMaxDiscountPrice() {
        return maxDiscountPrice;
    }

    public void setMaxDiscountPrice(Double maxDiscountPrice) {
        this.maxDiscountPrice = maxDiscountPrice;
    }

    public List<String> getImagePaths() {
        return imagePaths;
    }

    public void setImagePaths(List<String> imagePaths) {
        this.imagePaths = imagePaths;
    }

    @Override
    public String toString() {
        return "ProductDetailDTO{" +
                "id=" + id +
                ", originalPrice=" + originalPrice +
                ", discountPrice=" + discountPrice +
                ", quantity=" + quantity +
                ", name='" + name + '\'' +
                ", restInfo=" + restInfo +
                ", description='" + description + '\'' +
                ", brandId=" + brandId +
                ", brandName='" + brandName + '\'' +
                ", categoryId=" + categoryId +
                ", categoryName='" + categoryName + '\'' +
                ", promotionId=" + promotionId +
                ", discountPercent=" + discountPercent +
                ", maxDiscountPrice=" + maxDiscountPrice +
                ", imagePaths=" + imagePaths +
                '}';
    }
}
