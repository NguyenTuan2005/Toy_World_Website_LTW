package com.n3.childrentoyweb.models;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.ArrayList;
import java.util.List;

@Getter
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class Cart extends BaseModel {
    private User user;
    @Builder.Default
    private List<CartItem> cartItems = new ArrayList<>();

    public void addCartItem (CartItem item) {
        this.cartItems.add(item);
        item.setCart(this);
    }

    public void addAllCartItem (List<CartItem> items) {
        for (CartItem item : items) {
            this.addCartItem(item);
        }
    }
}
