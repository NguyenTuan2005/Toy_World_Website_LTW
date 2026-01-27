package com.n3.childrentoyweb.models;


import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;
import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;
import java.util.Objects;

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

    public Promotion(){}

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

    public void setName(String name) {
        this.name = name;
    }

    public void setExpiredAt(LocalDateTime expiredAt) {
        this.expiredAt = expiredAt;
    }

    public void setDiscountPercent(Double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public void setDiscountPrice(Double discountPrice) {
        this.discountPrice = discountPrice;
    }

    public void setEventId(Long eventId) {
        this.eventId = eventId;
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

    @Override
    public String toString() {
        return "Promotion{" +
                "super"+super.toString()+
                "name='" + name + '\'' +
                ", expiredAt=" + expiredAt +
                ", discountPercent=" + discountPercent +
                ", discountPrice=" + discountPrice +
                ", eventId=" + eventId +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Promotion promotion = (Promotion) o;
        return Objects.equals(name, promotion.name) && Objects.equals(expiredAt, promotion.expiredAt) && Objects.equals(discountPercent, promotion.discountPercent) && Objects.equals(discountPrice, promotion.discountPrice) && Objects.equals(eventId, promotion.eventId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, expiredAt, discountPercent, discountPrice, eventId);
    }

    private boolean isExpiredAt(){
        return this.expiredAt.isAfter(LocalDateTime.now());
    }

    public String getExpiredAtFormatted() {
        if (expiredAt == null) return "";

        return LocalDateTimeConverterUtil.convertToString(expiredAt);
    }
}
