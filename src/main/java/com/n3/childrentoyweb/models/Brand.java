package com.n3.childrentoyweb.models;


import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;

public class Brand extends BaseModel {
    @ColumnName("name")
    private String name;

    @ColumnName("img_path")
    private String imgPath;

    public Brand(Long id,  String name, String imgPath, Boolean isActive, LocalDateTime createdAt){
        super(id,isActive,createdAt);
        this.name = name;
        this.imgPath = imgPath;
    }

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
