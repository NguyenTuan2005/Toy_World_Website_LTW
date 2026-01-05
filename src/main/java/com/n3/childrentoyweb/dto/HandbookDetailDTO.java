package com.n3.childrentoyweb.dto;

import com.n3.childrentoyweb.models.Paragraph;

import java.time.LocalDateTime;
import java.util.List;

public class HandbookDetailDTO {
    private long id;
    private String title;
    private LocalDateTime created;

    private long userId;
    private String fullName;

    private long categoryId;
    private String categoryName;

    private List<Paragraph> paragraphs;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public LocalDateTime getCreated() {
        return created;
    }

    public void setCreated(LocalDateTime created) {
        this.created = created;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(long categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public List<Paragraph> getParagraphs() {
        return paragraphs;
    }

    public void setParagraphs(List<Paragraph> paragraphs) {
        this.paragraphs = paragraphs;
    }

    public HandbookDetailDTO() {
    }

    public HandbookDetailDTO(long id, String title, LocalDateTime created, long userId, String fullName, long categoryId, String categoryName, List<Paragraph> paragraphs) {
        this.id = id;
        this.title = title;
        this.created = created;
        this.userId = userId;
        this.fullName = fullName;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.paragraphs = paragraphs;
    }

    @Override
    public String toString() {
        return "HandbookDetailDTO{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", created=" + created +
                ", userId=" + userId +
                ", fullName='" + fullName + '\'' +
                ", categoryId=" + categoryId +
                ", categoryName='" + categoryName + '\'' +
                ", paragraphs=" + paragraphs +
                '}';
    }
}
