package com.n3.childrentoyweb.models;


import java.time.LocalDateTime;

public class Paragraph extends BaseModel {
    private String header;
    private String description;
    private String imagePath;
    private String imageDescription;
    private Integer displayIndex;
    private Long handbookId;

    public Paragraph( String header, String description, String imagePath, String imageDescription, Integer displayIndex, Long handbookId) {
        this.header = header;
        this.description = description;
        this.imagePath = imagePath;
        this.imageDescription = imageDescription;
        this.displayIndex = displayIndex;
        this.handbookId = handbookId;
    }

    public String getHeader() {
        return header;
    }

    public String getDescription() {
        return description;
    }

    public String getImagePath() {
        return imagePath;
    }

    public String getImageDescription() {
        return imageDescription;
    }

    public Integer getDisplayIndex() {
        return displayIndex;
    }

    public Long getHandbookId() {
        return handbookId;
    }
}
