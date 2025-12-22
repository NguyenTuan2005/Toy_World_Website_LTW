package com.n3.childrentoyweb.models;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;

public class Voucher extends BaseModel {

    @ColumnName("name")
    private String name;

    @ColumnName("expired_at")
    private LocalDateTime expiredAt;

    @ColumnName("discount_percent")
    private Double discountPercent;

    @ColumnName("max_price")
    private Double maxPrice;

    @ColumnName("used")
    private Integer used;

    @ColumnName("volumes")
    private Integer volumes;

    @ColumnName("category_id")
    private Long categoryId;

    @ColumnName("brand_id")
    private Long brandId;

    public String getName() {
        return name;
    }

    public LocalDateTime getExpiredAt() {
        return expiredAt;
    }

    public Double getDiscountPercent() {
        return discountPercent;
    }

    public Double getMaxPrice() {
        return maxPrice;
    }

    public Integer getUsed() {
        return used;
    }

    public Integer getVolumes() {
        return volumes;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public Long getBrandId() {
        return brandId;
    }

    public Voucher(Long id, Boolean isActive, LocalDateTime createdAt, String name, LocalDateTime expiredAt, Double discountPercent, Double maxPrice, Integer used, Integer volumes, Long categoryId, Long brandId) {
        super(id, isActive, createdAt);
        this.name = name;
        this.expiredAt = expiredAt;
        this.discountPercent = discountPercent;
        this.maxPrice = maxPrice;
        this.used = used;
        this.volumes = volumes;
        this.categoryId = categoryId;
        this.brandId = brandId;
    }

    public Voucher(String name, LocalDateTime expiredAt, Double discountPercent, Double maxPrice, Integer used, Integer volumes, Long categoryId, Long brandId) {
        this.name = name;
        this.expiredAt = expiredAt;
        this.discountPercent = discountPercent;
        this.maxPrice = maxPrice;
        this.used = used;
        this.volumes = volumes;
        this.categoryId = categoryId;
        this.brandId = brandId;
    }
}
