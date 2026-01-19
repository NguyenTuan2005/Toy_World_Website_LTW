package com.n3.childrentoyweb.models;

import com.n3.childrentoyweb.dto.CartProductDTO;
import com.n3.childrentoyweb.exception.DataInvalidException;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Cart implements Serializable {
    public static final String CART = "cart";
    private Map<Long, CartItem> items;

    public Cart() {
        this.items = new HashMap<>();
    }

    public Integer getTotalQuantity(){
        return this.items.entrySet().stream().mapToInt(quantityAndCartItemEntry -> quantityAndCartItemEntry.getValue().getQuantity()).sum();
    }

    public Double getTotalPrice() {
        return this.getTotalCost() - this.getTotalPromotion();
    }

    public Double getTotalCost(){
        return this.items.entrySet().stream().mapToDouble(quantityAndCartItemEntry -> quantityAndCartItemEntry.getValue().getPrice()).sum();
    }

    public Double getTotalPromotion(){
        return this.items.values().stream()
                .filter(CartItem::hasPromotion)
                .mapToDouble(item -> {
                    CartProductDTO productDTO = item.getCartProductDTO();
                    Double result = productDTO.getDiscountPrice();
                    if (result == null) {
                        result = (productDTO.getDiscountPercent() * productDTO.getPrice()) / 100;
                    }
                    return result * item.getQuantity();
                })
                .sum();
    }

    public void addItem(CartItem item) throws DataInvalidException{
        if(contain(item.getProductId())){

            int currentQuantity = this.items.get(item.getProductId()).getQuantity();
            int quantity = currentQuantity +  item.getQuantity();
            updateQuantity(item.getProductId(), quantity);

        }else
            this.items.put(item.getProductId(), item);
    }

    public void removeItem(long productId){
        this.items.remove(productId);
    }

    public void updateQuantity(long productId, int quantity) throws DataInvalidException {
        if (quantity < 1) {
            throw new DataInvalidException("Số lượng phải lớn hơn hoặc bằng 1");
        }
        if (!this.items.get(productId).isHigherOrEqualThan(quantity)) {
            throw new DataInvalidException("Số lượng phải nhỏ hơn trong kho cho sản phẩm: " + this.items.get(productId).getCartProductDTO().getName());
        }

        if(this.items.containsKey(productId))
            this.items.get(productId).setQuantity(quantity);
    }

    public List<CartItem> getCartItems(){
        return  new ArrayList<>(this.items.values());
    }

    public boolean contain(long productId){
        return this.items.containsKey(productId);
    }

}
