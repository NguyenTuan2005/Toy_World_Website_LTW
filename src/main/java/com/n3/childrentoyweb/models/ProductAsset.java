package com.n3.childrentoyweb.models;

import java.time.LocalDateTime;

public class ProductAsset extends BaseModel {
    private String imgPath;
    private Long productId;

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
