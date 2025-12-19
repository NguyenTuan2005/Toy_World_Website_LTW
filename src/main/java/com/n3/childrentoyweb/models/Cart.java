package com.n3.childrentoyweb.models;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Cart implements Serializable {
    private Map<Long,CartItem> items;
    private User user;

    public Cart() {
        this.items = new HashMap<>();
        this.user = null;
    }

    public Integer getTotalQuantity(){
        return this.items.entrySet().stream().mapToInt(quantityAndCartItemEntry -> quantityAndCartItemEntry.getValue().getQuantity()).sum();
    }

    public Double getTotalPrice(){
        return this.items.entrySet().stream().mapToDouble(quantityAndCartItemEntry -> quantityAndCartItemEntry.getValue().getPrice()).sum();
    }

    public void addItem(CartItem item){
        this.items.put(item.getProductId(), item);
    }

    public void removeItem(long productId){
        this.items.remove(productId);
    }

    public void updateQuantity(long productId, int quantity){
        if(this.items.containsKey(productId))
            this.items.get(productId).setQuantity(quantity);
    }

    public List<CartItem> getCartItems(){
        return  new ArrayList<>(this.items.values());
    }

}
