package com.n3.childrentoyweb.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Getter
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class CartItem {
    private Cart cart;
    private Product product;
    private Integer quantity;

    public void setCart(Cart cart) {
        this.cart = cart;
    }
}
