package com.n3.childrentoyweb.dto;

public class PriceRangeFilterDTO {
    private int min;
    private int max;
    private String label;

    public PriceRangeFilterDTO(int min, int max, String label) {
        this.min = min;
        this.max = max;
        this.label = label;
    }

    public PriceRangeFilterDTO() {
    }

    public int getMin() {
        return min;
    }

    public void setMin(int min) {
        this.min = min;
    }

    public int getMax() {
        return max;
    }

    public void setMax(int max) {
        this.max = max;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    @Override
    public String toString() {
        return "PriceRangeFilterDTO{" +
                "min=" + min +
                ", max=" + max +
                ", label='" + label + '\'' +
                "}\n";
    }
}
