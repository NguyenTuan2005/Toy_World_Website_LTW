package com.n3.childrentoyweb.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Getter
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class Banner extends BaseModel {
    private String title;
    private String imgPath;
    private String groupTag;
    private Integer sortOrder;
    private Event event;
}
