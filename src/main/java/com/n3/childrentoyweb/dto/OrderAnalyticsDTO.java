package com.n3.childrentoyweb.dto;

import java.util.Objects;

/**
    This class is used for revenue, order Charts in Dashboard
 */
public class OrderAnalyticsDTO {
    private String label;
    private long value;

    public OrderAnalyticsDTO(String label, long value) {
        this.label = label;
        this.value = value;
    }

    public OrderAnalyticsDTO() {
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public long getValue() {
        return value;
    }

    public void setValue(long value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "RevenueStat{" +
                "label='" + label + '\'' +
                ", value=" + value +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        OrderAnalyticsDTO that = (OrderAnalyticsDTO) o;
        return value == that.value && Objects.equals(label, that.label);
    }

    @Override
    public int hashCode() {
        return Objects.hash(label, value);
    }
}
