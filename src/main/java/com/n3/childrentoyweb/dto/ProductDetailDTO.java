package com.n3.childrentoyweb.dto;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.util.List;
import java.util.Map;

public class ProductDetailDTO {
    private Long id;
    private double originalPrice;
    private double discountPrice;
    private int quantity;
    private String name;

    private Map<String, String> restInfo;
    private String description;
    private Long brandId;
    private String brandName;
    private Long categoryId;
    private String categoryName;
    private Long promotionId;
    private double discountPercent;
    private Double maxDiscountPrice;
    private List<String> imagePaths;

    private boolean wishlisted;

    private List<UserCommentDTO> comments;

    public ProductDetailDTO(Long id, double originalPrice, double discountPrice, int quantity, String name, Map<String, String> restInfo, String description, Long brandId, String brandName, Long categoryId, String categoryName, Long promotionId, double discountPercent, Double maxDiscountPrice, List<String> imagePaths, boolean wishlisted, List<UserCommentDTO> comments) {
        this.id = id;
        this.originalPrice = originalPrice;
        this.discountPrice = discountPrice;
        this.quantity = quantity;
        this.name = name;
        this.restInfo = restInfo;
        this.description = description;
        this.brandId = brandId;
        this.brandName = brandName;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.promotionId = promotionId;
        this.discountPercent = discountPercent;
        this.maxDiscountPrice = maxDiscountPrice;
        this.imagePaths = imagePaths;
        this.wishlisted = wishlisted;
        this.comments = comments;
    }

    public ProductDetailDTO() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public double getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(double originalPrice) {
        this.originalPrice = originalPrice;
    }

    public double getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(double discountPrice) {
        this.discountPrice = discountPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
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

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountPercent) {
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

    public boolean isWishlisted() {
        return wishlisted;
    }

    public List<UserCommentDTO> getComments() {
        return comments;
    }

    public void setComments(List<UserCommentDTO> comments) {
        this.comments = comments;
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
                ", wishlisted=" + wishlisted +
                ", comments=" + comments +
                '}';
    }

    public void setWishlisted(boolean wishlisted) {
        this.wishlisted = wishlisted;
    }
}
