package com.n3.childrentoyweb.dto;

public class BrandFilterDTO {
    private Long id;
    private String name;
    private int productCount;

    public BrandFilterDTO(Long id, String name, int productCount) {
        this.id = id;
        this.name = name;
        this.productCount = productCount;
    }

    public BrandFilterDTO() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getProductCount() {
        return productCount;
    }

    public void setProductCount(int productCount) {
        this.productCount = productCount;
    }

    @Override
    public String toString() {
        return "BrandFilterDTO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", productCount=" + productCount +
                '}';
    }


}
