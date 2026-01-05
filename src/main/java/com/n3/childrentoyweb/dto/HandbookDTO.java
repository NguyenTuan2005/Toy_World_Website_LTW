package com.n3.childrentoyweb.dto;

import java.util.List;

public class HandbookDTO {
    private String title;
    List<ParagraphDTO> paragraphs;
    private String status;
    private long postedUserId;
    private long categoryId;

    public HandbookDTO() {
    }

    public HandbookDTO(String title, List<ParagraphDTO> paragraphs) {
        this.title = title;
        this.paragraphs = paragraphs;
        this.status ="POSTED";
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    public List<ParagraphDTO> getParagraphs() {
        return paragraphs;
    }

    public void setParagraphs(List<ParagraphDTO> paragraphs) {
        this.paragraphs = paragraphs;
    }

    public void hidden(){
        this.status = "HIDDEN";
    }

    public void posted(){
        this.status = "POSTED";
    }

    public String getStatus(){
        return this.status;
    }

    public void setPostedUserId(long id){
        this.postedUserId = id;
    }

    public long getPostedUserId(){
        return this.postedUserId;
    }

    public long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(long categoryId) {
        this.categoryId = categoryId;
    }

    @Override
    public String toString() {
        return "HandbookDTO{" +
                "title='" + title + '\'' +
                ", paragraphs=" + paragraphs +
                ", status='" + status + '\'' +
                ", postedUserId=" + postedUserId +
                ", categoryId=" + categoryId +
                '}';
    }
}
