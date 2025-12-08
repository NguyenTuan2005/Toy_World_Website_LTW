package com.n3.childrentoyweb.models;

import com.n3.childrentoyweb.enums.PaymentMethod;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Getter
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class Payment {
    private PaymentMethod paymentMethod;
    private Order order;
    private Double balance;
    private String status;
}
