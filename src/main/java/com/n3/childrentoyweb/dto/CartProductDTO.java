package com.n3.childrentoyweb.dto;

import com.n3.childrentoyweb.models.Product;
import com.n3.childrentoyweb.models.ProductAsset;
import com.n3.childrentoyweb.models.Promotion;

public class CartProductDTO {
    private Long productId;
    private Integer quantity;
    private String name;
    private String imgPath;
    private Double price;
    private Double discountPercent;
    private Double discountPrice;

    public CartProductDTO(Long productId,Integer quantity, String name, String imgPath, Double price, Double discountPercent, Double discountPrice) {
        this.productId = productId;
        this.quantity = quantity;
        this.name = name;
        this.imgPath = imgPath;
        this.price = price;
        this.discountPercent = discountPercent;
        this.discountPrice = discountPrice;
    }

    public CartProductDTO(Product product, ProductAsset asset, Promotion promotion) {
        this.productId = product.getId();
        this.quantity = product.getQuantity();
        this.name = product.getName();
        this.imgPath = asset.getImgPath();
        this.price = product.getPrice();
        this.discountPercent = promotion.getDiscountPercent();
        this.discountPrice = promotion.getDiscountPrice();
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
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

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(Double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public Double getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(Double discountPrice) {
        this.discountPrice = discountPrice;
    }

    public boolean checkQuantity(int quantity) {
        return this.quantity >= quantity;
    }
}
