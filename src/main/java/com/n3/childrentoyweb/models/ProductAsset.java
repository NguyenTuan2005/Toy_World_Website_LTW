package com.n3.childrentoyweb.models;

import java.time.LocalDateTime;

public class ProductAsset extends BaseModel {
    private String imgPath;
    private Long productId;

    public ProductAsset( String imgPath, Long productId) {
        this.imgPath = imgPath;
        this.productId = productId;
    }

    public String getImgPath() {
        return imgPath;
    }

    public Long getProductId() {
        return productId;
    }
}
