package com.n3.childrentoyweb.dto;


public class ProductChartDTO implements Comparable<ProductChartDTO> {
    private String name;
    private Double totalPrice;

    public ProductChartDTO( String name, Double totalPrice) {
        this.name = name;
        this.totalPrice = totalPrice;
    }

    public ProductChartDTO() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Override
    public int compareTo(ProductChartDTO o) {
        return this.totalPrice.compareTo(o.totalPrice);
    }
}
