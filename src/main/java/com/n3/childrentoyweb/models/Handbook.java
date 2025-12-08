package com.n3.childrentoyweb.models;

import com.n3.childrentoyweb.enums.CategoryHbs;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.ArrayList;
import java.util.List;

@Getter
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class Handbook extends BaseModel {
    private User user;
    private String title;
    private Long views;
    private String status;
    private CategoryHbs categoryHbs;
    @Builder.Default
    private List<Paragraph> paragraphs = new ArrayList<>();

    public void addParagraph (Paragraph paragraph) {
        this.paragraphs.add(paragraph);
        paragraph.setHandbook(this);
    }

    public void addAllParagraph (List<Paragraph> paragraphs) {
        for (Paragraph paragraph : paragraphs) {
            this.addParagraph(paragraph);
        }
    }
}
