package com.n3.childrentoyweb.dto;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.util.List;
import java.util.Map;

public class ProductDetailDTO {
    private Long id;
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

    private boolean wishlisted;

    private List<UserCommentDTO> comments;

    public ProductDetailDTO(Long id, Double originalPrice, Double discountPrice, Integer quantity, String name, Map<String, String> restInfo, String description, Long brandId, String brandName, Long categoryId, String categoryName, Long promotionId, Double discountPercent, Double maxDiscountPrice, List<String> imagePaths, List<UserCommentDTO> comments) {
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

    public List<UserCommentDTO> getComments() {
        return comments;
    }

    public void setComments(List<UserCommentDTO> comments) {
        this.comments = comments;
    }

    public boolean isWishlisted() {
        return wishlisted;
    }

    public void setWishlisted(boolean wishlisted) {
        this.wishlisted = wishlisted;
    }
}
