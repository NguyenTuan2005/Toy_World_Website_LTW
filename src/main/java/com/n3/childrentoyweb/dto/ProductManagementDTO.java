package com.n3.childrentoyweb.dto;

public class ProductManagementDTO {
    private long productId;
    private String name;
    private String imgPath;
    private double price;
    private String brand;
    private String category;
    private int quantity;
    private String status;

    public ProductManagementDTO() {}

    public ProductManagementDTO(long productId, String name, String imgPath, double price, String brand, String category, int quantity, String status) {
        this.productId = productId;
        this.name = name;
        this.imgPath = imgPath;
        this.price = price;
        this.brand = brand;
        this.category = category;
        this.quantity = quantity;
        this.status = status;
    }

    public long getProductId() {
        return productId;
    }

    public void setProductId(long productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "ProductManagementDTO{" +
                "id=" + productId +
                ", name='" + name + '\'' +
                ", imgPath='" + imgPath + '\'' +
                ", price=" + price +
                ", brand='" + brand + '\'' +
                ", category='" + category + '\'' +
                ", quantity=" + quantity +
                ", status='" + status + '\'' +
                '}';
    }
}
