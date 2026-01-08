package com.n3.childrentoyweb.models;


import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;

public class Paragraph extends BaseModel {
    @ColumnName("header")
    private String header;

    @ColumnName("description")
    private String description;

    @ColumnName("img_path")
    private String imagePath;

    @ColumnName("image_description")
    private String imageDescription;

    @ColumnName("display_index")
    private Integer displayIndex;

    @ColumnName("handbook_id")
    private Long handbookId;

    public Paragraph(Long id, String header, String description, String imagePath, String imageDescription, Integer displayIndex, Long handbookId,Boolean isActive,LocalDateTime createdAt) {
        super(id,isActive,createdAt);
        this.header = header;
        this.description = description;
        this.imagePath = imagePath;
        this.imageDescription = imageDescription;
        this.displayIndex = displayIndex;
        this.handbookId = handbookId;
    }

    public Paragraph( String header, String description, String imagePath, String imageDescription, Integer displayIndex, Long handbookId) {
        this.header = header;
        this.description = description;
        this.imagePath = imagePath;
        this.imageDescription = imageDescription;
        this.displayIndex = displayIndex;
        this.handbookId = handbookId;
    }

    public Paragraph() {

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

    public void setHeader(String header) {
        this.header = header;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public void setImageDescription(String imageDescription) {
        this.imageDescription = imageDescription;
    }

    public void setDisplayIndex(Integer displayIndex) {
        this.displayIndex = displayIndex;
    }

    public void setHandbookId(Long handbookId) {
        this.handbookId = handbookId;
    }

    public Long getHandbookId() {
        return handbookId;
    }

    @Override
    public String toString() {
        return "Paragraph{" +
                "header='" + header + '\'' +
                ", description='" + description + '\'' +
                ", imagePath='" + imagePath + '\'' +
                ", imageDescription='" + imageDescription + '\'' +
                ", displayIndex=" + displayIndex +
                ", handbookId=" + handbookId +
                ", id=" + id +
                ", isActive=" + isActive +
                ", createdAt=" + createdAt +
                '}';
    }
}
