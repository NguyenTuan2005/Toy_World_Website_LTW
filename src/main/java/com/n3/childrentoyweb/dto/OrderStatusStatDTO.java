package com.n3.childrentoyweb.dto;

public class OrderStatusStatDTO {
    private String label;
    private String status;
    private long total;

    public OrderStatusStatDTO(String label, String status, long total) {
        this.label = label;
        this.status = status;
        this.total = total;
    }

    public OrderStatusStatDTO() {
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    @Override
    public String toString() {
        return "OrderStatusStatDTO{" +
                "label='" + label + '\'' +
                ", status='" + status + '\'' +
                ", total=" + total +
                '}';
    }
}