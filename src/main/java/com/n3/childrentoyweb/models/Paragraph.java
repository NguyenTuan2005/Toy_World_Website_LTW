package com.n3.childrentoyweb.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Getter
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class Paragraph extends BaseModel {
    private String header;
    private String description;
    private String imagePath;
    private String imageDescription;
    private Integer displayIndex;
    private Handbook handbook;

    public void setHandbook(Handbook handbook) {
        this.handbook = handbook;
    }
}
