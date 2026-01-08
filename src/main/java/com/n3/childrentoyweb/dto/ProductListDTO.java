package com.n3.childrentoyweb.dto;

import java.util.List;

public class ProductListDTO {
    private Long id;
    private String name;
    private List<String> imgPaths;
    private Integer quantity;
    private String category;
    private String brand;

    private long originPrice;
    private long finalPrice;
    private long maxDiscountPrice;
    private double discountPercent;

    public ProductListDTO(Long id, String name, List<String> imgPaths, Integer quantity, String category, String brand, long originPrice, long finalPrice, long maxDiscountPrice, double discountPercent) {
        this.id = id;
        this.name = name;
        this.imgPaths = imgPaths;
        this.quantity = quantity;
        this.category = category;
        this.brand = brand;
        this.originPrice = originPrice;
        this.finalPrice = finalPrice;
        this.maxDiscountPrice = maxDiscountPrice;
        this.discountPercent = discountPercent;
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

    public List<String> getImgPaths() {
        return imgPaths;
    }

    public void setImgPaths(List<String> imgPaths) {
        this.imgPaths = imgPaths;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public String getCategory() {
        return category;
    }

    public long getMaxDiscountPrice() {
        return maxDiscountPrice;
    }

    public void setMaxDiscountPrice(long maxDiscountPrice) {
        this.maxDiscountPrice = maxDiscountPrice;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public long getOriginPrice() {
        return originPrice;
    }

    public void setOriginPrice(long originPrice) {
        this.originPrice = originPrice;
    }

    public long getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(long finalPrice) {
        this.finalPrice = finalPrice;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    @Override
    public String toString() {
        return "ProductListDTO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", imgPaths=" + imgPaths +
                ", quantity=" + quantity +
                ", category='" + category + '\'' +
                ", brand='" + brand + '\'' +
                ", originPrice=" + originPrice +
                ", finalPrice=" + finalPrice +
                ", maxDiscountPrice=" + maxDiscountPrice +
                ", discountPercent=" + discountPercent +
                "}\n";
    }
}
