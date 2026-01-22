package com.n3.childrentoyweb.dto;

public class WishlistProductDTO {
    private Long productId;
    private String name;
    private String imgPath;
    private String price;
    private int quantity;

    public WishlistProductDTO() {
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

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "WishlistProductDTO{" +
                "productId=" + productId +
                ", name='" + name + '\'' +
                ", imgPath='" + imgPath + '\'' +
                ", price='" + price + '\'' +
                ", quantity=" + quantity +
                "}\n";
    }
}
