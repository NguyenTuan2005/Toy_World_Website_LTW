package com.n3.childrentoyweb.models;

import java.io.Serializable;

public class CartItem implements Serializable {
    private Product product;
    private Integer quantity;

    public CartItem(Product product, Integer quantity) {
        this.product = product;
        this.quantity = quantity;
    }
    public Product getProduct() {
        return product;
    }
    public Integer getQuantity() {
        return quantity;
    }
    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
    public Double getPrice(){
        return product.getPrice() * quantity;
    }

    public Long getProductId(){
        return this.product.getId();
    }
}
