package com.n3.childrentoyweb.dto;

public class PaymentPercentDTO {
    private String name;

    public PaymentPercentDTO(String name, double percent) {
        this.name = name;
        this.percent = percent;
    }

    public double getPercent() {
        return percent;
    }

    public void setPercent(double percent) {
        this.percent = percent;
    }

    private double percent;
}
