package com.n3.childrentoyweb.dto;

import java.util.List;

public class HandbookDTO {
    private String title;
    private String category;
    List<ParagraphDTO> paragraphs;

    public HandbookDTO() {
    }

    public HandbookDTO(String title, String category, List<ParagraphDTO> paragraphs) {
        this.title = title;
        this.category = category;
        this.paragraphs = paragraphs;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public List<ParagraphDTO> getParagraphs() {
        return paragraphs;
    }

    public void setParagraphs(List<ParagraphDTO> paragraphs) {
        this.paragraphs = paragraphs;
    }
}
