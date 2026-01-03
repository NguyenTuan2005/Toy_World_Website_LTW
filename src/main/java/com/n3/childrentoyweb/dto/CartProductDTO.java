package com.n3.childrentoyweb.dto;

import com.n3.childrentoyweb.models.Product;
import com.n3.childrentoyweb.models.ProductAsset;
import com.n3.childrentoyweb.models.Promotion;

public class CartProductDTO {
    private Long productId;
    private String name;
    private String imgPath;
    private Double price;
    private Double discountPercent;
    private Double discountPrice;

    public CartProductDTO(Long productId, String name, String imgPath, Double price, Double discountPercent, Double discountPrice) {
        this.productId = productId;
        this.name = name;
        this.imgPath = imgPath;
        this.price = price;
        this.discountPercent = discountPercent;
        this.discountPrice = discountPrice;
    }

    public CartProductDTO(Product product, ProductAsset asset, Promotion promotion) {
        this.productId = product.getId();
        this.name = product.getName();
        this.imgPath = asset.getImgPath();
        this.price = product.getPrice();
        this.discountPercent = promotion.getDiscountPercent();
        this.discountPrice = promotion.getDiscountPrice();
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
}
