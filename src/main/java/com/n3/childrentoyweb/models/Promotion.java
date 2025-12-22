package com.n3.childrentoyweb.models;


import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;

public class Promotion extends BaseModel {
    @ColumnName("name")
    private String name;

    @ColumnName("expired_at")
    private LocalDateTime expiredAt;

    @ColumnName("discount_percent")
    private Double discountPercent;

    @ColumnName("discount_price")
    private Double discountPrice;

    @ColumnName("event_id")
    private Long eventId;

    public Promotion(Long id, String name, LocalDateTime expiredAt, Double discountPercent, Double discountPrice, Long eventId,Boolean isActive,LocalDateTime createdAt) {
        super(id,isActive,createdAt);
        this.name = name;
        this.expiredAt = expiredAt;
        this.discountPercent = discountPercent;
        this.discountPrice = discountPrice;
        this.eventId = eventId;
    }


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
