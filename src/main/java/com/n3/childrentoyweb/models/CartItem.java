package com.n3.childrentoyweb.models;

import com.n3.childrentoyweb.dto.CartProductDTO;

import java.io.Serializable;

public class CartItem implements Serializable {
    private CartProductDTO cartProductDTO;
    private Integer quantity;

    public CartItem(CartProductDTO product, Integer quantity) {
        this.cartProductDTO = product;
        this.quantity = quantity;
    }
    public CartProductDTO getCartProductDTO() {
        return cartProductDTO;
    }
    public Integer getQuantity() {
        return quantity;
    }
    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
    public Double getPrice(){
        return cartProductDTO.getPrice() * quantity;
    }

    public Long getProductId(){
        return this.cartProductDTO.getProductId();
    }

    public boolean isHigherOrEqualThan(int quantity) {
        return this.cartProductDTO.isHigherOrEqualThan(quantity);
    }

    public boolean hasPromotion() {
        return this.cartProductDTO.hasPromotion();
    }
}
