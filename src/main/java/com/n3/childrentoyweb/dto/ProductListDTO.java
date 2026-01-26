package com.n3.childrentoyweb.dto;

import java.util.List;

public class ProductListDTO {
    private Long id;
    private String name;
    private String imgPath;
    private int quantity;
    private String category;
    private String brand;

    private double originPrice;
    private double finalPrice;
    private Double maxDiscountPrice;
    private double discountPercent;

    private boolean wishlisted;

    public ProductListDTO(Long id, String name, String imgPath, int quantity, String category, String brand, double originPrice, double finalPrice, Double maxDiscountPrice, double discountPercent, boolean wishlisted) {
        this.id = id;
        this.name = name;
        this.imgPath = imgPath;
        this.quantity = quantity;
        this.category = category;
        this.brand = brand;
        this.originPrice = originPrice;
        this.finalPrice = finalPrice;
        this.maxDiscountPrice = maxDiscountPrice;
        this.discountPercent = discountPercent;
        this.wishlisted = wishlisted;
    }

    public ProductListDTO() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public double getOriginPrice() {
        return originPrice;
    }

    public void setOriginPrice(double originPrice) {
        this.originPrice = originPrice;
    }

    public double getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(double finalPrice) {
        this.finalPrice = finalPrice;
    }

    public Double getMaxDiscountPrice() {
        return maxDiscountPrice;
    }

    public void setMaxDiscountPrice(Double maxDiscountPrice) {
        this.maxDiscountPrice = maxDiscountPrice;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public boolean isWishlisted() {
        return wishlisted;
    }

    public void setWishlisted(boolean wishlisted) {
        this.wishlisted = wishlisted;
    }

    @Override
    public String toString() {
        return "ProductListDTO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", imgPath='" + imgPath + '\'' +
                ", quantity=" + quantity +
                ", category='" + category + '\'' +
                ", brand='" + brand + '\'' +
                ", originPrice=" + originPrice +
                ", finalPrice=" + finalPrice +
                ", maxDiscountPrice=" + maxDiscountPrice +
                ", discountPercent=" + discountPercent +
                ", wishlisted=" + wishlisted +
                '}';
    }
}
