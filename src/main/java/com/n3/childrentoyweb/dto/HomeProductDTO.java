package com.n3.childrentoyweb.dto;

import com.n3.childrentoyweb.models.Location;
import com.n3.childrentoyweb.models.User;
import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class HomeProductDTO {
    private int id;

    private String name;

    @ColumnName("original_price")
    private double originalPrice;

    @ColumnName("discount_percent")
    private float discountPercent;

    private double currentPrice;


    @ColumnName("img_url")
    private String imageUrl;

    @ColumnName("brand_name")
    private String brandName;

    public HomeProductDTO(){

    }


    public HomeProductDTO(int id, String name, double originalPrice, float discountPercent, String imageUrl, String brandName) {
        this.id = id;
        this.name = name;
        this.originalPrice = originalPrice;
        this.discountPercent = discountPercent;
        this.imageUrl = imageUrl;
        this.brandName = brandName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(double originalPrice) {
        this.originalPrice = originalPrice;
    }


    public float getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(float discountPercent) {
        this.discountPercent = discountPercent;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    @Override
    public String toString() {
        return "HomeProductDTO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", originalPrice=" + originalPrice +
                ", discountPercent=" + discountPercent +
                ", imageUrl='" + imageUrl + '\'' +
                ", brandName='" + brandName + '\'' +
                '}';
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public void setCurrentPrice(){
        this.currentPrice = this.originalPrice - (this.originalPrice * this.discountPercent )/100;
    }

    public double getCurrentPrice(){
        return this.currentPrice;
    }
}
