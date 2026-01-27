package com.n3.childrentoyweb.dto;

public class ProductPromotionDTO {
    private Long id;
    private Double originalPrice;
    private Double discountPrice;
    private String name;
    private String firstImg;

    @Override
    public String toString() {
        return "ProductPromotionDTO{" +
                "id=" + id +
                ", originalPrice=" + originalPrice +
                ", discountPrice=" + discountPrice +
                ", name='" + name + '\'' +
                ", firstImg='" + firstImg + '\'' +
                '}';
    }
    public ProductPromotionDTO(){}

    public ProductPromotionDTO(Long id, Double originalPrice, Double discountPrice, String name, String firstImg) {
        this.id = id;
        this.originalPrice = originalPrice;
        this.discountPrice = discountPrice;
        this.name = name;
        this.firstImg = firstImg;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Double getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(Double originalPrice) {
        this.originalPrice = originalPrice;
    }

    public Double getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(Double discountPrice) {
        this.discountPrice = discountPrice;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFirstImg() {
        return firstImg;
    }

    public void setFirstImg(String firstImg) {
        this.firstImg = firstImg;
    }


}
