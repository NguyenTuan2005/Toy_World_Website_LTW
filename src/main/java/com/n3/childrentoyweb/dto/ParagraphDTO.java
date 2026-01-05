package com.n3.childrentoyweb.dto;

public class ParagraphDTO {
    private int index;
    private String title;
    private String content;
    private String imageBase64;

    public ParagraphDTO(int index, String title, String content, String imageBase64) {
        this.index = index;
        this.title = title;
        this.content = content;
        this.imageBase64 = imageBase64;
    }

    public int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImageBase64() {
        return imageBase64;
    }

    public void setImageBase64(String imageBase64) {
        this.imageBase64 = imageBase64;
    }

    public ParagraphDTO() {
    }

    @Override
    public String toString() {
        return "ParagraphDTO{" +
                "index=" + index +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", imageBase64='" + imageBase64.length() + '\'' +
                '}';
    }
}
