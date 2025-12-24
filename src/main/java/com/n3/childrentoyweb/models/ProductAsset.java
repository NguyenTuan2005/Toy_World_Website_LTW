package com.n3.childrentoyweb.models;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;

public class ProductAsset extends BaseModel {
    @ColumnName("img_path")
    private String imgPath;

    @ColumnName("product_id")
    private Long productId;
    public ProductAsset(Long id, String imgPath, Long productId,Boolean isActive, LocalDateTime createdAt) {
        super(id,isActive,createdAt);
        this.imgPath = imgPath;
        this.productId = productId;
    }


    public ProductAsset( String imgPath, Long productId) {
        this.imgPath = imgPath;
        this.productId = productId;
    }

    public ProductAsset(){}

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }
}
