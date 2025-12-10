package com.n3.childrentoyweb.models;


import java.time.LocalDateTime;

public class Promotion extends BaseModel {
    private String name;
    private LocalDateTime expiredAt;
    private Double discountPercent;
    private Double discountPrice;
    private Long eventId;

    public Promotion( String name, LocalDateTime expiredAt, Double discountPercent, Double discountPrice, Long eventId) {
        this.name = name;
        this.expiredAt = expiredAt;
        this.discountPercent = discountPercent;
        this.discountPrice = discountPrice;
        this.eventId = eventId;
    }

    public String getName() {
        return name;
    }

    public LocalDateTime getExpiredAt() {
        return expiredAt;
    }

    public Double getDiscountPercent() {
        return discountPercent;
    }

    public Double getDiscountPrice() {
        return discountPrice;
    }

    public Long getEventId() {
        return eventId;
    }
}
