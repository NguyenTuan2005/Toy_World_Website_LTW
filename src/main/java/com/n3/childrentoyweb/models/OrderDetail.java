package com.n3.childrentoyweb.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Getter
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class OrderDetail extends BaseModel {
    private Order order;
    private Product product;
    private Integer quantity;

    public void setOrder (Order order) {
        this.order = order;
    }
}
