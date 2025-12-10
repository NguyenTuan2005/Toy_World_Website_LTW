package com.n3.childrentoyweb.models;


import java.time.LocalDateTime;

public class Brand extends BaseModel {
    private String name;
    private String imgPath;

    public Brand( String name, String imgPath) {
        this.name = name;
        this.imgPath = imgPath;
    }

    public String getName() {
        return name;
    }

    public String getImgPath() {
        return imgPath;
    }
}
